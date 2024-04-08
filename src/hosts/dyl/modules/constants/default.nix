# Reusable constants are defined here
# All options have default values
# You can use them in other modules
{lib, ...}: {
  options = {
    constants = {
      disks = {
        a = {
          partitions = {
            boot = {
              label = lib.mkOption {
                default = "boot";
                description = "Label for the boot partition";
                type = lib.types.str;
              };
            };

            main = {
              label = lib.mkOption {
                default = "main";
                description = "Label for the main partition";
                type = lib.types.str;
              };
            };
          };

          path = lib.mkOption {
            default = "/dev/sda";
            description = "Path to the disk";
            type = lib.types.path;
          };
        };

        b = {
          partitions = {
            swap = {
              label = lib.mkOption {
                default = "swap";
                description = "Label for the swap partition";
                type = lib.types.str;
              };
            };
          };

          path = lib.mkOption {
            default = "/dev/sdb";
            description = "Path to the disk";
            type = lib.types.path;
          };
        };
      };

      name = lib.mkOption {
        default = "dyl";
        description = "Name of the machine";
        type = lib.types.str;
      };

      network = {
        gateway = lib.mkOption {
          default = "10.91.0.254";
          description = "IP address of the default gateway";
          type = lib.types.nullOr lib.types.str;
        };

        hostId = lib.mkOption {
          default = "d2010ee8";
          description = "Unique identifier for the machine";
          type = lib.types.str;
        };

        interfaces = lib.mkOption {
          default = [
            {
              name = "eno1";
              address = "10.91.0.10";
              netmask = 24;
            }
          ];
          description = "List of network interfaces configuration";
          type = lib.types.listOf (
            lib.types.submodule {
              options = {
                name = lib.mkOption {
                  description = "Name of the network interface";
                  type = lib.types.str;
                };

                address = lib.mkOption {
                  description = "IP address of the network interface";
                  type = lib.types.str;
                };

                netmask = lib.mkOption {
                  description = "Netmask of the network interface";
                  type = lib.types.int;
                };
              };
            }
          );
        };

        nameservers = lib.mkOption {
          default = [
            "194.29.128.1"
            "194.29.128.2"
          ];
          description = "List of DNS servers to use";
          type = lib.types.listOf lib.types.str;
        };
      };

      platform = lib.mkOption {
        default = "x86_64-linux";
        description = "Platform of the machine";
        type = lib.types.str;
      };

      secrets = {
        sops = {
          keyFile = lib.mkOption {
            default = "/var/lib/sops/age/keys.txt";
            description = "Path to the age key file for SOPS";
            type = lib.types.path;
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
          partitions = {
            main = {
              label = lib.mkOption {
                default = "main";
                description = "Label for the main partition";
                type = lib.types.str;
              };
            };

            swap = {
              label = lib.mkOption {
                default = "swap";
                description = "Label for the swap partition";
                type = lib.types.str;
              };

              size = lib.mkOption {
                default = 1024;
                description = "Size of the swap partition in MB";
                type = lib.types.int;
              };
            };
          };

          path = lib.mkOption {
            default = "/dev/vda";
            description = "Path to the disk in the virtual machine";
            type = lib.types.path;
          };

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
      };
    };
  };
}
