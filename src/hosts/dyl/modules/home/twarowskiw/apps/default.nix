# Applications
{pkgs, ...}: {
  home = {
    packages = [
      # Bandwidth usage TUI
      pkgs.bandwhich

      # Displaying CPU information
      pkgs.cpufetch

      # Containers TUI
      pkgs.ctop

      # curl with httpie syntax
      pkgs.curlie

      # Data manipulation
      pkgs.dasel

      # Display disk usage
      pkgs.duf

      # Better ls
      pkgs.eza

      # Display system information
      pkgs.fastfetch

      # Better find
      pkgs.fd

      # Just ffmpeg
      pkgs.ffmpeg

      # Disk usage analyzer
      pkgs.gdu

      # Interactive jq playground
      pkgs.jqp

      # Docker TUI
      pkgs.lazydocker

      # Minimal text editor
      pkgs.micro

      # Data manipulation
      pkgs.miller

      # sysctl on steroids
      pkgs.systeroid

      # Universal SQL client
      pkgs.usql

      # HTTPie alternative
      pkgs.xh
    ];

    shellAliases = {
      # Enable icons in eza
      ez = "eza --icons";

      # Run zellij as a systemd service so it's not killed when the terminal is closed
      zj = "systemd-run --user --scope --quiet -- zellij";
    };
  };

  programs = {
    # Better cat
    bat = {
      config = {
        theme = "Visual Studio Dark+";
      };

      enable = true;

      # Enable integration with other programs
      extraPackages = [
        pkgs.bat-extras.batdiff
        pkgs.bat-extras.batgrep
        pkgs.bat-extras.batman
        pkgs.bat-extras.batpipe
        pkgs.bat-extras.batwatch
      ];
    };

    # Navigate directory trees
    broot = {
      enable = true;
      enableZshIntegration = true;
    };

    # Excellent resource monitor
    btop = {
      enable = true;
    };

    # Change shell configuration on the fly
    direnv = {
      enable = true;
      enableZshIntegration = true;

      nix-direnv = {
        # Enable better integration with Nix
        enable = true;
      };
    };

    # Fuzzy finder
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # JSON processor
    jq = {
      enable = true;
    };

    # Manual
    man = {
      enable = true;

      # Generate page index cache
      generateCaches = true;
    };

    # Smart shell history
    mcfly = {
      enable = true;
      enableZshIntegration = true;
    };

    # Better grep
    ripgrep = {
      enable = true;
    };

    # Modern terminal multiplexer
    zellij = {
      enable = true;
    };
  };
}
