# Nix, NixOS and nixpkgs configuration
{config, ...}: {
  nix = {
    gc = {
      # Enable automatic garbage collection
      automatic = true;

      # Run the garbage collector every day at midnight
      dates = "daily";

      # Delete only generations older than 7 days
      options = "--delete-older-than 7d";
    };

    optimise = {
      # Enable automatic optimisation
      automatic = true;

      dates = [
        # Run every day at midnight
        "daily"
      ];
    };

    settings = {
      allowed-users = [
        # Allow all normal users
        "@users"

        # Allow the wheel group (basically, all users with sudo access)
        "@wheel"
      ];

      # Enable automatic optimisation
      auto-optimise-store = true;

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
      # Allow packages with unfree licenses
      allowUnfree = true;
    };

    # Specify the architecture of the system
    hostPlatform = config.constants.platform;
  };

  system = {
    autoUpgrade = {
      # Check for updates every day at night
      dates = "04:00";

      # Enable automatic updates
      enable = true;

      # Point to the GitHub repository as the source of truth
      flake = "github:radio-aktywne/systems#${config.constants.name}";

      # Don't persist run times
      persistent = false;

      # Introduce some randomness to avoid regular network traffic spikes
      # This means that the update will be checked at a random time between 04:00 and 05:00
      randomizedDelaySec = "1h";
    };

    # Keep this value as the NixOS version used during first installation
    stateVersion = "23.11";
  };
}
