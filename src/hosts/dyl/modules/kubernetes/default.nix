# Kubernetes
{
  config,
  lib,
  pkgs,
  ...
}: let
  jsonFormat = pkgs.formats.json {};
  yamlFormat = pkgs.formats.yaml {};
  flannelCniConfig = jsonFormat.generate "flannel-cni.json" {
    cniVersion = "1.0.0";

    # This was the default
    name = "cbr0";

    plugins = [
      {
        delegate = {
          # Setting the bridge name explicitly
          bridge = config.constants.kubernetes.network.interfaces.cni;

          # These were the defaults
          forceAddress = true;
          hairpinMode = true;
          isDefaultGateway = true;
        };

        type = "flannel";
      }
    ];
  };
  fluxScript = pkgs.writeShellApplication {
    # Name of the script
    name = "flux";

    # Packages available in the script
    runtimeInputs = [pkgs.coreutils pkgs.fluxcd pkgs.k3s];

    # Load the script with substituted values
    text = builtins.readFile (
      # Substitute values in the script
      pkgs.substituteAll {
        # Use this file as source
        src = ./flux.sh;

        # Provide values to substitute
        keysFile = config.constants.secrets.sops.age.file;
        kubeconfig = config.constants.kubernetes.files.kubeconfig;
        node = config.constants.name;
        sourceBranch = config.constants.kubernetes.flux.source.branch;
        sourceIgnore = config.constants.kubernetes.flux.source.ignore;
        sourcePath = config.constants.kubernetes.flux.source.path;
        sourceUrl = config.constants.kubernetes.flux.source.url;
      }
    );
  };
  kubeletConfig = yamlFormat.generate "kubelet.yaml" {
    apiVersion = "kubelet.config.k8s.io/v1beta1";
    kind = "KubeletConfiguration";
    systemReserved = {
      # Reserved CPU for system
      cpu = "${config.constants.kubernetes.resources.reserved.system.cpu}";

      # Reserved storage for system
      ephemeral-storage = "${config.constants.kubernetes.resources.reserved.system.storage}";

      # Reserved memory for system
      memory = "${config.constants.kubernetes.resources.reserved.system.memory}";

      # Reserved number of process IDs for system
      pid = "${toString config.constants.kubernetes.resources.reserved.system.pid}";
    };
  };
  reversedDomain = lib.strings.concatStringsSep "." (lib.lists.reverseList (lib.strings.splitString "." config.constants.network.domain.root));
in {
  boot = {
    kernelModules = [
      # Enable kernel module for WireGuard
      "wireguard"
    ];
  };

  environment = {
    systemPackages = [
      # Install flux CLI
      pkgs.fluxcd

      # Install kubectl
      pkgs.kubectl

      # Packages needed by Longhorn
      pkgs.bash
      pkgs.curl
      pkgs.gawk
      pkgs.gnugrep
      pkgs.nfs-utils
      pkgs.util-linux
    ];
  };

  networking = {
    firewall = {
      allowedTCPPorts = [
        # Allow Kubernetes API server
        config.constants.kubernetes.network.ports.api
      ];

      allowedUDPPorts = [
        # Allow WireGuard (IPv4)
        51820

        # Allow WireGuard (IPv6)
        51821
      ];

      trustedInterfaces = [
        # Allow all traffic on CNI interface
        config.constants.kubernetes.network.interfaces.cni
      ];
    };
  };

  services = {
    k3s = {
      # Enable k3s
      enable = true;

      extraFlags = lib.strings.concatStringsSep " " [
        # Specify IP address allocation range for pods
        "--cluster-cidr ${config.constants.kubernetes.network.addresses.cluster}"

        # Specify directory for storing state
        "--data-dir ${config.constants.kubernetes.directories.state}"

        # Disable local storage
        "--disable local-storage"

        # Disable metrics server
        "--disable metrics-server"

        # Disable ServiceLB
        "--disable servicelb"

        # Disable Traefik
        "--disable traefik"

        # Disable cloud controller manager
        "--disable-cloud-controller"

        # Disable Helm controller
        "--disable-helm-controller"

        # Disable network policy
        "--disable-network-policy"

        # Use WireGuard for Container Network Interface
        "--flannel-backend wireguard-native"

        # Use custom CNI configuration
        "--flannel-cni-conf ${flannelCniConfig}"

        # Specify port for the API server
        "--https-listen-port ${toString config.constants.kubernetes.network.ports.api}"

        # Pass configuration to kubelet
        "--kubelet-arg '--config=${kubeletConfig}'"

        # Set node name explicitly
        "--node-name ${config.constants.name}"

        # Enable secret encryption
        "--secrets-encryption"

        # Specify IP address allocation range for services
        "--service-cidr ${config.constants.kubernetes.network.addresses.service}"

        # Add alternative names to the TLS certificate
        "--tls-san ${config.constants.name}"
        "--tls-san ${config.constants.name}.${config.constants.network.domain.subdomains.network}.${config.constants.network.domain.root}"

        # Create kubeconfig file for local access
        "--write-kubeconfig ${config.constants.kubernetes.files.kubeconfig}"
      ];

      # Use this device as the k3s server
      role = "server";

      # Shared secret used by all nodes to join the cluster
      tokenFile = config.sops.secrets."k3s/token".path;
    };

    openiscsi = {
      # Enable iSCSI daemon needed by Longhorn
      enable = true;

      # This doesn't matter, but is required
      name = "iqn.1998-03.${reversedDomain}:${config.constants.name}";
    };
  };

  systemd = {
    services = {
      flux = {
        after = [
          # Run after k3s is running
          "k3s.service"
        ];

        description = "Setup Flux";

        requires = [
          # Require k3s to be running
          "k3s.service"
        ];

        serviceConfig = {
          # Run only once at startup
          Type = "oneshot";
        };

        script = "${fluxScript}/bin/flux";

        wantedBy = [
          # Run at startup
          "multi-user.target"
        ];
      };
    };

    tmpfiles = {
      rules = [
        # Create symlink to system binaries
        # This is needed for Longhorn, because it uses a different PATH
        # It's harmless, because there is no /usr/local/bin in NixOS
        "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
      ];
    };
  };
}
