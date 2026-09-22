# Applications
{pkgs, ...}: {
  home = {
    packages = [
      # Bandwidth usage TUI
      pkgs.bandwhich

      # Terminal graphics
      pkgs.chafa

      # Displaying CPU information
      pkgs.cpufetch

      # Send files to other devices
      pkgs.croc

      # curl with httpie syntax
      pkgs.curlie

      # Data manipulation
      pkgs.dasel

      # Display disk usage
      pkgs.duf

      # Just ffmpeg
      pkgs.ffmpeg

      # Disk usage analyzer
      pkgs.gdu

      # ImageMagick alternative
      pkgs.graphicsmagick

      # HTTP client
      pkgs.httpie

      # Benchmarking tool
      pkgs.hyperfine

      # Network utilities
      pkgs.inetutils

      # Data manipulation
      pkgs.miller

      # Serve files
      pkgs.serve

      # Colors helper
      pkgs.pastel

      # Speedtest CLI
      pkgs.speedtest-go

      # sysctl on steroids
      pkgs.systeroid

      # Terminal screenshots
      pkgs.termshot

      # Share the terminal over the web
      pkgs.ttyd

      # Interactive pipe playground
      pkgs.up

      # Secure terminal sharing
      pkgs.upterm

      # Universal SQL client
      pkgs.usql

      # Record terminal sessions as GIFs
      pkgs.vhs

      # HTTPie alternative
      pkgs.xh

      # YAML processor
      pkgs.yq-go
    ];

    sessionVariables = {
      # Use micro as default text editor
      EDITOR = "micro";
    };

    shellAliases = {
      # Run zellij as a systemd service so it's not killed when the terminal is closed
      zj = "systemd-run --user --scope --quiet -- zellij";
    };
  };

  programs = {
    # Better cat
    bat = {
      enable = true;
    };

    # Navigate directory trees
    broot = {
      enable = true;
    };

    # Excellent resource monitor
    btop = {
      enable = true;
    };

    # Change shell configuration on the fly
    direnv = {
      enable = true;
    };

    # Better ls
    eza = {
      enable = true;
    };

    # Display system information
    fastfetch = {
      enable = true;
    };

    # Better find
    fd = {
      enable = true;
    };

    # Fuzzy finder
    fzf = {
      enable = true;
    };

    # JSON processor
    jq = {
      enable = true;
    };

    # Interactive jq playground
    jqp = {
      enable = true;
    };

    # Manual
    man = {
      enable = true;
    };

    # Minimal text editor
    micro = {
      enable = true;
    };

    # Better grep
    ripgrep = {
      enable = true;
    };

    # TLDR
    tealdeer = {
      enable = true;
    };

    # Network diagnostic tool
    trippy = {
      enable = true;
    };

    # Terminal file manager
    yazi = {
      enable = true;
    };

    # YouTube downloader
    yt-dlp = {
      enable = true;
    };

    # Modern terminal multiplexer
    zellij = {
      enable = true;
    };

    # Smart cd
    zoxide = {
      enable = true;
    };
  };

  services = {
    # Task scheduler
    pueue = {
      enable = true;
    };
  };
}
