# Nix, NixOS and nixpkgs configuration
{
  config,
  inputs,
  ...
}: {
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
        "@${config.users.groups.users.name}"

        # Allow the wheel group (basically, all users with sudo access)
        "@${config.users.groups.wheel.name}"
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

  programs = {
    command-not-found = {
      # Don't give users hints about how to install missing commands
      enable = false;
    };

    nh = {
      # Enable Nix CLI helper
      enable = true;

      # Point to the GitHub repository as the source of truth
      flake = "github:radio-aktywne/systems#${config.constants.name}";
    };

    nix-ld = {
      # Enable Nix dynamic linker
      enable = true;
    };
  };

  system = {
    autoUpgrade = {
      # Check for updates every day at night
      dates = "04:00";

      # Enable automatic updates
      enable = true;

      # Point to the GitHub repository as the source of truth
      flake = "github:radio-aktywne/systems#${config.constants.name}";

      # Make new version available for next boot
      operation = "boot";

      # Don't persist run times
      persistent = false;

      # Introduce some random delay to avoid regular network traffic spikes
      randomizedDelaySec = "1h";
    };

    # Keep this value as the NixOS version used during first installation
    stateVersion = "23.11";
  };
}
