# Reusable constants are defined here
# All options have default values
# You can use these options in other modules
{lib, ...}: {
  options = {
    constants = {
      name = lib.mkOption {
        default = "realizator";
        description = "Name of the machine";
        type = lib.types.str;
      };

      network = {
        domain = {
          root = lib.mkOption {
            default = "radioaktywne.pl";
            description = "Our root domain";
            type = lib.types.str;
          };

          subdomains = {
            network = lib.mkOption {
              default = "network";
              description = "Subdomain for network";
              type = lib.types.str;
            };
          };
        };

        hostId = lib.mkOption {
          default = "ed6d9369";
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
              default = "/dev/disk/by-id/ata-PH6-CE120_511171201178012578";
              description = "Device path of the main disk";
              type = lib.types.str;
            };
          };
        };
      };

      vm = {
        name = lib.mkOption {
          default = "realizator-vm";
          description = "Name of the virtual machine";
          type = lib.types.str;
        };

        network = {
          hostId = lib.mkOption {
            default = "baea9453";
            description = "Unique identifier for the virtual machine";
            type = lib.types.str;
          };
        };

        resources = {
          cpu = {
            cores = lib.mkOption {
              default = 4;
              description = "Number of CPU cores";
              type = lib.types.int;
            };
          };

          disk = {
            size = lib.mkOption {
              default = 32768;
              description = "Size of the disk in MB";
              type = lib.types.int;
            };
          };

          memory = {
            size = lib.mkOption {
              default = 8192;
              description = "Size of the memory in MB";
              type = lib.types.int;
            };
          };
        };
      };
    };
  };
}
