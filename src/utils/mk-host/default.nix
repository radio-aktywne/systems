# Create NixOS configuration for given host
# Additionally, create a virtual machine configuration and an install script
{
  directory,
  host,
  inputs,
  ...
}: {
  nixosConfigurations = inputs.utils.mkNixosConfig {inherit directory host inputs;};
  packages = inputs.nixpkgs.lib.recursiveUpdate (inputs.utils.mkVirtualMachine {inherit host inputs;}) (inputs.utils.mkInstallScript {inherit host inputs;});
}
