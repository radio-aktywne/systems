# Configuration related to styling
{lib, ...}: {
  programs = {
    firefox = {
      profiles = {
        default = {
          extensions = {
            settings = {
              "FirefoxColor@mozilla.com" = {
                # Override any existing Firefox Color settings
                force = true;
              };
            };
          };
        };
      };
    };
  };

  stylix = {
    targets = {
      firefox = {
        colorTheme = {
          # Enable Firefox Color
          enable = lib.mkDefault true;
        };

        # Apply styling to default profile
        profileNames = lib.mkDefault ["default"];
      };

      vscode = {
        # Disable VS Code integration as it would create read-only settings
        # Remove later after this will be available: https://github.com/nix-community/home-manager/pull/9854
        enable = lib.mkForce false;
      };
    };
  };
}
