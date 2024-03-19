# Configuration related to visual appearance of the system
{pkgs, ...}: {
  fonts = {
    packages = [
      # Roboto font from Google
      pkgs.roboto

      # Roboto Mono font patched with Nerd Font
      (pkgs.nerdfonts.override {fonts = ["RobotoMono"];})

      # Emoji font from Google
      pkgs.noto-fonts-emoji
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Roboto"
        ];

        serif = [
          "Roboto"
        ];

        monospace = [
          "RobotoMono Nerd Font"

          # Unpatched font as fallback
          "Roboto Mono"
        ];

        emoji = [
          "Noto Color Emoji"
        ];
      };
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
}
