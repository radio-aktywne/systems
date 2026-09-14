# Development related stuff
{pkgs, ...}: {
  home = {
    packages = [
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
      enableAlias = true;
      enableZshIntegration = true;
    };

    # Kubernetes context switching
    kubeswitch = {
      enable = true;
      enableZshIntegration = true;
    };

    # uv
    uv = {
      enable = true;
    };
  };
}
