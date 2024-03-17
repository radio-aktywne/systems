# Create NixOS configuration for given host
{
  directory,
  host,
  inputs,
  ...
}: {
  "${host}" = inputs.nixpkgs.lib.nixosSystem {
    # This is kinda unintuitive, but the path should be relative to this file
    modules = [
      (./. + "/../../${directory}/${host}")
    ];

    specialArgs = {
      inherit inputs;
    };
  };
}
