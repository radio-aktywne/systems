# Development related stuff
{pkgs, ...}: {
  home = {
    packages = [
      # Sandboxing tool
      pkgs.bubblewrap

      # Containers TUI
      pkgs.ctop

      # Docker image inspector
      pkgs.dive

      # Dockerfile linter
      pkgs.hadolint

      # Nix language server
      pkgs.nil

      # NodeJS
      pkgs.nodejs

      # Python
      pkgs.python3

      # Multipurpose relay
      pkgs.socat
    ];
  };

  programs = {
    # Bun
    bun = {
      enable = true;
    };

    # Kubernetes TUI
    k9s = {
      enable = true;
    };

    # kubectl colorful output
    kubecolor = {
      enable = true;
    };

    # Kubernetes context switching
    kubeswitch = {
      enable = true;
    };

    # uv
    uv = {
      enable = true;
    };
  };
}
