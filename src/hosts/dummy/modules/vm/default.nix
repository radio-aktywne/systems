# Virtual machine configuration
{config, ...}: {
  virtualisation = {
    vmVariant = {
      constants = {
        # Use a different name for the virtual machine
        name = config.virtualisation.vmVariant.constants.vm.name;

        network = {
          # Use a different host ID for the virtual machine
          hostId = config.virtualisation.vmVariant.constants.vm.network.hostId;
        };
      };

      virtualisation = {
        # CPU cores for the virtual machine
        cores = config.virtualisation.vmVariant.constants.vm.cpu.cores;

        # Path to the disk image
        diskImage = "./bin/${config.virtualisation.vmVariant.constants.vm.name}.qcow2";

        # Size of the disk image
        diskSize = config.virtualisation.vmVariant.constants.vm.disk.size;

        # Memory size for the virtual machine
        memorySize = config.virtualisation.vmVariant.constants.vm.memory.size;

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
