# Create configuration for virtual machine
# You can use this to run the virtual machine to test the configuration of the host
# Note: you can only run the virtual machine on the same architecture as the host
{
  host,
  inputs,
  ...
}: {
  "${inputs.self.nixosConfigurations.${host}.config.nixpkgs.buildPlatform.system}" = {
    # The package will have "-virtual-machine" suffix, for example "nixos-virtual-machine"
    "${host}-virtual-machine" = inputs.self.nixosConfigurations.${host}.config.system.build.vm;
  };
}
