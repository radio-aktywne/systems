# Configuration related to visual appearance of the system
{pkgs, ...}: {
  fonts = {
    fontconfig = {
      defaultFonts = {
        emoji = [
          "Noto Color Emoji"
        ];

        monospace = [
          "RobotoMono Nerd Font"

          # Unpatched font as fallback
          "Roboto Mono"
        ];

        sansSerif = [
          "Roboto"
        ];

        serif = [
          "Roboto"
        ];
      };
    };

    packages = [
      # Emoji font from Google
      pkgs.noto-fonts-emoji

      # Roboto font from Google
      pkgs.roboto

      # Roboto Mono font patched with Nerd Font
      pkgs.nerd-fonts.roboto-mono
    ];
  };

  services = {
    kmscon = {
      # Use alternative virtual console
      enable = true;

      # Enable hardware rendering
      hwRender = true;
    };
  };
}
