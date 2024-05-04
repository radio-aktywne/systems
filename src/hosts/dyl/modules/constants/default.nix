# Reusable constants are defined here
# All options have default values
# You can use these options in other modules
{lib, ...}: {
  options = {
    constants = {
      name = lib.mkOption {
        default = "dyl";
        description = "Name of the machine";
        type = lib.types.str;
      };

      network = {
        hostId = lib.mkOption {
          default = "d2010ee8";
          description = "Unique identifier for the machine";
          type = lib.types.str;
        };
      };

      platform = lib.mkOption {
        default = "x86_64-linux";
        description = "Platform of the machine";
        type = lib.types.str;
      };

      secrets = {
        sops = {
          age = {
            file = lib.mkOption {
              default = "/var/lib/sops/age/keys.txt";
              description = "Path to the file with private age keys";
              type = lib.types.str;
            };
          };
        };
      };

      storage = {
        disks = {
          main = {
            device = lib.mkOption {
              default = "/dev/disk/by-id/wwn-0x6782bcb0067906002db969310e5584c6";
              description = "Device path of the main disk";
              type = lib.types.str;
            };
          };

          data = {
            device = lib.mkOption {
              default = "/dev/disk/by-id/wwn-0x6782bcb0067906002db9694b0fdbd555";
              description = "Device path of the data disk";
              type = lib.types.str;
            };
          };
        };
      };

      vm = {
        cpu = {
          cores = lib.mkOption {
            default = 4;
            description = "Number of CPU cores";
            type = lib.types.int;
          };
        };

        disk = {
          size = lib.mkOption {
            default = 8192;
            description = "Size of the disk in MB";
            type = lib.types.int;
          };
        };

        memory = {
          size = lib.mkOption {
            default = 4096;
            description = "Size of the memory in MB";
            type = lib.types.int;
          };
        };

        name = lib.mkOption {
          default = "dyl-vm";
          description = "Name of the virtual machine";
          type = lib.types.str;
        };

        network = {
          hostId = lib.mkOption {
            default = "9827df51";
            description = "Unique identifier for the virtual machine";
            type = lib.types.str;
          };
        };
      };
    };
  };
}
