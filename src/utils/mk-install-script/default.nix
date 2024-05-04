# Create configuration for installer script
# It can be used to install the system on a target machine
# It's defined only for the host system as you should only run it on the host
{
  host,
  inputs,
  ...
}: {
  "${inputs.self.nixosConfigurations.${host}.config.nixpkgs.buildPlatform.system}" = {
    # The package will have "-install-script" suffix
    "${host}-install-script" = inputs.self.nixosConfigurations.${host}.config.installScript;
  };
}
