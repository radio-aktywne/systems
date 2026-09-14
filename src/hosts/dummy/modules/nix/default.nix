# Nix, NixOS and nixpkgs configuration
{
  config,
  inputs,
  ...
}: {
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
    config = {
      # Allow packages with non-free licenses
      allowUnfree = true;
    };

    overlays = [
      # Use default overlay
      inputs.self.overlays.default
    ];

    # Specify the architecture of the system
    hostPlatform = config.constants.platform;
  };

  system = {
    # Keep this value as the NixOS version used during first installation
    stateVersion = "26.05";
  };
}
