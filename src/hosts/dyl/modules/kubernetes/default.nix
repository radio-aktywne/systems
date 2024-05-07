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

        # Create kubeconfig file for local access
        "--write-kubeconfig ${config.constants.kubernetes.files.kubeconfig}"
      ];

      # Use this device as the k3s server
      role = "server";

      # Shared secret used by all nodes to join the cluster
      tokenFile = config.sops.secrets."k3s/token".path;
    };
  };
}