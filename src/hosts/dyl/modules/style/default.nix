# Configuration related to styling
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # Import stylix modules
    inputs.stylix.nixosModules.stylix
  ];

  boot = {
    kernelParams = [
      # Enable splash screen
      "splash"
    ];

    plymouth = {
      # Enable splash screen
      enable = true;

      # Use angular theme
      theme = "angular";

      themePackages = [
        # Install adi1090x Plymouth themes
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = ["angular"];
        })
      ];
    };
  };

  services = {
    kmscon = {
      # Use alternative virtual console
      enable = true;

      # Enable hardware rendering
      hwRender = true;
    };
  };

  stylix = {
    # Use Catppuccin Mocha color scheme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # Enable stylix
    enable = true;

    fonts = {
      emoji = {
        # Use Noto Color Emoji font for emoji support
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };

      monospace = {
        # Use Roboto Mono Nerd Font for monospace text
        name = "RobotoMono Nerd Font";
        package = pkgs.nerd-fonts.roboto-mono;
      };

      sansSerif = {
        # Use Roboto font for sans-serif text
        name = "Roboto";
        package = pkgs.roboto;
      };

      serif = {
        # Use Roboto font for serif text
        name = "Roboto";
        package = pkgs.roboto;
      };
    };

    # Use dark theme
    polarity = "dark";

    targets = {
      plymouth = {
        # Disable Plymouth styling
        enable = false;
      };
    };
  };
}
