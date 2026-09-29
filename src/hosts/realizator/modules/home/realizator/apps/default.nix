# Applications
{pkgs, ...}: {
  home = {
    packages = [
      # Displaying CPU information
      pkgs.cpufetch

      # Display disk usage
      pkgs.duf

      # Just ffmpeg
      pkgs.ffmpeg

      # Disk usage analyzer
      pkgs.gdu

      # Network utilities
      pkgs.inetutils

      # YAML processor
      pkgs.yq-go
    ];

    sessionVariables = {
      # Use micro as default text editor
      EDITOR = "micro";
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

    # Firefox web browser
    firefox = {
      enable = true;
    };

    # Fuzzy finder
    fzf = {
      enable = true;
    };

    # Terminal emulator
    ghostty = {
      enable = true;
    };

    # JSON processor
    jq = {
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

    # Network diagnostic tool
    trippy = {
      enable = true;
    };

    # Terminal file manager
    yazi = {
      enable = true;
    };
  };
}
