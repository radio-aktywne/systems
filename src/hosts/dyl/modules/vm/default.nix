# Virtual machine configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation = {
    vmVariant = {
      boot = {
        initrd = {
          postDeviceCommands = lib.mkForce (
            # pkgs.substituteAll returns a path to a file, so we need to read it
            builtins.readFile (
              # This is used to provide data to the script by replacing some strings
              pkgs.substituteAll {
                src = ./prepare.sh;

                disk = config.virtualisation.vmVariant.constants.vm.disk.path;
                main = config.virtualisation.vmVariant.constants.vm.disk.partitions.main.label;
                mkfsext4 = "${pkgs.e2fsprogs}/bin/mkfs.ext4";
                parted = "${pkgs.parted}/bin/parted";
                swap = config.virtualisation.vmVariant.constants.vm.disk.partitions.swap.label;
                swapSize = (toString config.virtualisation.vmVariant.constants.vm.disk.partitions.swap.size) + "MB";
              }
            )
          );
        };
      };

      constants = {
        # Use different name for the virtual machine
        name = "dyl-vm";

        network = {
          # Use different host ID for the virtual machine
          hostId = "cc4e8be2";
        };
      };

      services = {
        timesyncd = {
          # Force systemd-timesyncd to be enabled in the virtual machine
          enable = lib.mkForce true;
        };
      };

      swapDevices = lib.mkForce [
        # One swap device on separate partition
        {
          # We need to use partlabel here, because regular label can change with encryption
          device = "/dev/disk/by-partlabel/${config.virtualisation.vmVariant.constants.vm.disk.partitions.swap.label}";

          randomEncryption = {
            # Allow TRIM requests to be sent to the swap device
            allowDiscards = true;

            # Enable encryption of swap
            enable = true;
          };
        }
      ];

      virtualisation = {
        cores = config.virtualisation.vmVariant.constants.vm.cpu.cores;

        # This file will be created on your development machine
        diskImage = "./bin/${config.virtualisation.vmVariant.system.name}.qcow2";

        diskSize = config.virtualisation.vmVariant.constants.vm.disk.size;

        # Filesystems need to be defined separately for virtual machines
        # But it's the same as in the real system
        # With the exception of boot partition
        fileSystems = {
          "/" = {
            device = "/dev/disk/by-label/${config.virtualisation.vmVariant.constants.vm.disk.partitions.main.label}";

            # use ext4 for root
            fsType = "ext4";
          };
        };

        memorySize = config.virtualisation.vmVariant.constants.vm.memory.size;

        # Shared directories between the virtual machine and your development machine
        sharedDirectories = {
          # This is needed to transmit your age private key to the virtual machine
          age-key = {
            # The private key should be stored at this path on your development machine
            source = "\${SOPS_AGE_KEY_DIR:-\${XDG_CONFIG_HOME:-$HOME/.config}/sops/age}";

            # And will be mounted in the virtual machine at this path
            target = "/var/lib/sops/age";
          };
        };

        # Use our custom filesystems instead of the default ones
        useDefaultFilesystems = false;
      };
    };
  };
}
