# Home Manager configuration
{inputs, ...}: {
  imports = [
    # Import home-manager modules
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {
      # Make inputs available to home-manager modules
      inherit inputs;
    };

    # Use global nixpkgs for consistency
    useGlobalPkgs = true;

    # Install user packages to /etc/profiles/
    useUserPackages = true;

    users = {
      spietras = import ./spietras;
    };
  };
}
