# Configuration related to styling
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  tinted-gowall = pkgs.fetchFromGitHub {
    owner = "tinted-theming";
    repo = "tinted-gowall";
    rev = "080d8f7";
    hash = "sha256-IPZGIPhdRcRqxafO7DMv4Cf3389u/r67Y+p87Dim9KE=";
  };
  wallpaper = ./wallpaper.png;
in {
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
        (
          (
            pkgs.adi1090x-plymouth-themes.override {
              selected_themes = ["angular"];
            }
          ).overrideAttrs
          (old: {
            patches =
              (old.patches or [])
              ++ [
                # Patch to center the animation on multiple monitors
                ./angular-center.patch
              ];
          })
        )
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

    cursor = {
      # Use Bibata cursors matching the configured polarity
      name =
        if config.stylix.polarity == "light"
        then "Bibata-Modern-Ice"
        else "Bibata-Modern-Classic";

      # Use Bibata cursors
      package = pkgs.bibata-cursors;

      # Set typical cursor size
      size = 24;
    };

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

    icons = {
      # Use Papirus Dark for dark icons
      dark = "Papirus-Dark";

      # Enable icons styling
      enable = true;

      # Use Papirus Light for light icons
      light = "Papirus-Light";

      # Use Papirus icons with Catppuccin theme
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };

    # Convert wallpaper to Catppuccin theme
    image = pkgs.runCommand "wallpaper.png" {} ''
      HOME="''${TMPDIR}" ${pkgs.gowall}/bin/gowall convert ${wallpaper} --format png --output "''${out}" --theme ${tinted-gowall}/themes/base16-catppuccin-mocha.json
    '';

    # Use dark theme
    polarity = "dark";

    targets = {
      plymouth = {
        # Disable Plymouth styling
        enable = false;
      };

      qt = {
        # Use QT Configutation Utility
        platform = lib.mkForce "qtct";
      };
    };
  };
}
