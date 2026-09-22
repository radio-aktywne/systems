# Virtual machine configuration
{
  config,
  lib,
  ...
}: {
  virtualisation = {
    vmVariantWithBootLoader = {
      boot = {
        # Automatically grow the root partition on boot
        growPartition = true;
      };

      constants = {
        kubernetes = {
          cluster = {
            # Use different cluster in the virtual machine
            name = config.virtualisation.vmVariantWithBootLoader.constants.vm.kubernetes.cluster.name;
          };

          network = {
            addresses = {
              # Use different cluster and service CIDR in the virtual machine
              cluster = config.virtualisation.vmVariantWithBootLoader.constants.vm.kubernetes.network.addresses.cluster;
              service = config.virtualisation.vmVariantWithBootLoader.constants.vm.kubernetes.network.addresses.service;
            };
          };

          resources = {
            reserved = {
              # Override reserved resources to adjust them for the virtual machine
              system = {
                cpu = config.virtualisation.vmVariantWithBootLoader.constants.vm.kubernetes.resources.reserved.system.cpu;
                memory = config.virtualisation.vmVariantWithBootLoader.constants.vm.kubernetes.resources.reserved.system.memory;
                pid = config.virtualisation.vmVariantWithBootLoader.constants.vm.kubernetes.resources.reserved.system.pid;
                storage = config.virtualisation.vmVariantWithBootLoader.constants.vm.kubernetes.resources.reserved.system.storage;
              };
            };
          };
        };

        # Use a different name for the virtual machine
        name = config.virtualisation.vmVariantWithBootLoader.constants.vm.name;

        network = {
          # Use a different host ID for the virtual machine
          hostId = config.virtualisation.vmVariantWithBootLoader.constants.vm.network.hostId;
        };
      };

      services = {
        timesyncd = {
          # Force systemd-timesyncd to be enabled in the virtual machine
          enable = lib.mkForce true;
        };
      };

      virtualisation = {
        # CPU cores for the virtual machine
        cores = config.virtualisation.vmVariantWithBootLoader.constants.vm.resources.cpu.cores;

        # Size of the disk image
        diskSize = config.virtualisation.vmVariantWithBootLoader.constants.vm.resources.disk.size;

        fileSystems = {
          "/" = {
            # Automatically resize the root filesystem on boot
            autoResize = true;
          };
        };

        # Memory size for the virtual machine
        memorySize = config.virtualisation.vmVariantWithBootLoader.constants.vm.resources.memory.size;

        # Shared directories between the virtual machine and your development machine
        sharedDirectories = {
          # This is needed to transmit your age private keys to the virtual machine
          sops-age-keys = {
            # The private keys should be stored at this path on your development machine
            source = "\${SOPS_AGE_KEY_DIR:-\${XDG_CONFIG_HOME:-$HOME/.config/}/sops/age/}";

            # And will be mounted in the virtual machine at this path
            target = builtins.dirOf config.constants.secrets.sops.age.file;
          };
        };
      };
    };
  };
}
