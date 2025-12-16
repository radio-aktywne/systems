# Nix, NixOS and nixpkgs configuration
{config, ...}: {
  nix = {
    settings = {
      experimental-features = [
        # Enable flakes
        "flakes"

        # Enable commands
        "nix-command"
      ];
    };
  };

  nixpkgs = {
    # Specify the architecture of the system
    hostPlatform = config.constants.platform;
  };

  system = {
    # Keep this value as the NixOS version used during first installation
    stateVersion = "25.05";
  };
}
