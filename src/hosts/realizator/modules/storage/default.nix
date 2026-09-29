# Storage configuration
{
  config,
  inputs,
  ...
}: {
  imports = [
    # Import Disko modules
    inputs.disko.nixosModules.disko
  ];

  disko = {
    devices = {
      disk = {
        main = {
          content = {
            partitions = {
              boot = {
                content = {
                  # Format the partition as FAT
                  format = "vfat";

                  # Mount the partition at /boot
                  mountpoint = "/boot";

                  # This partition contains a filesystem
                  type = "filesystem";
                };

                # Size of the boot partition
                size = "1G";

                # EFI system partition
                type = "EF00";
              };

              main = {
                content = {
                  # This partition contains an LVM physical volume
                  type = "lvm_pv";

                  # Attach the partition to this volume group
                  vg = "main";
                };

                # Use the rest of the disk for the main partition
                size = "100%";

                # Linux filesystem partition
                type = "8300";
              };
            };

            # Use GPT partition table
            type = "gpt";
          };

          device = config.constants.storage.disks.main.device;
          type = "disk";
        };
      };

      lvm_vg = {
        main = {
          lvs = {
            main = {
              content = {
                # Format the volume as ext4
                format = "ext4";

                # Mount the volume at /
                mountpoint = "/";

                # This volume contains a filesystem
                type = "filesystem";
              };

              # Take all the space in the volume group
              size = "100%FREE";
            };

            swap = {
              content = {
                # Enable encryption
                randomEncryption = true;

                # This volume contains a swap partition
                type = "swap";
              };

              # Use 8 GB for swap
              size = "8G";
            };
          };

          type = "lvm_vg";
        };
      };
    };
  };

  fileSystems = {
    "/boot" = {
      # Obviously
      neededForBoot = true;
    };

    "/" = {
      # Contains data needed for booting
      neededForBoot = true;
    };
  };

  services = {
    fstrim = {
      # Enable automatic periodic TRIM
      enable = true;

      # TRIM once a week on Sunday at 3 AM
      interval = "Sun, 03:00";
    };

    smartd = {
      # Enable smartmontools daemon
      enable = true;

      extraOptions = [
        # This prevents smartd from failing if no SMART capable devices are found (like in a VM)
        "-q never"
      ];
    };
  };
}
