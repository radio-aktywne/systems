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
                  # Format the partition as ext4
                  format = "ext4";

                  # Mount the partition at /
                  mountpoint = "/";

                  # This partition contains a filesystem
                  type = "filesystem";
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
}
