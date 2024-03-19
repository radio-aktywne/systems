# Storage configuration
{config, ...}: {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/${config.constants.disks.a.partitions.main.label}";

      # use ext4 for root
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/${config.constants.disks.a.partitions.boot.label}";

      # /boot uses FAT32, but mount only recognizes vfat type
      fsType = "vfat";

      # Obviously
      neededForBoot = true;
    };
  };

  services = {
    smartd = {
      # Enable smartmontools daemon
      enable = true;

      extraOptions = [
        # This prevents smartd from failing if no SMART capable devices are found (like in a VM)
        "-q never"
      ];
    };
  };

  swapDevices = [
    # One swap device on separate partition
    {
      # We need to use partlabel here, because regular label can change with encryption
      device = "/dev/disk/by-partlabel/${config.constants.disks.b.partitions.swap.label}";

      randomEncryption = {
        # Allow TRIM requests to be sent to the swap device
        allowDiscards = true;

        # Enable encryption of swap
        enable = true;
      };
    }
  ];
}
