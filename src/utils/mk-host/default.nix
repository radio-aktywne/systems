# Create NixOS configuration for given host
# Additionally, configrations for virtual machine and install script are created
{
  directory,
  host,
  inputs,
  ...
}: {
  nixosConfigurations = inputs.utils.mkNixosConfig {inherit directory host inputs;};
  packages = inputs.nixpkgs.lib.recursiveUpdate (inputs.utils.mkVirtualMachine {inherit host inputs;}) (inputs.utils.mkInstallScript {inherit host inputs;});
}
