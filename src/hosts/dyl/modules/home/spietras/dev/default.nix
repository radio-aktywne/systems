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

      # Helm CLI
      (pkgs.wrapHelm pkgs.kubernetes-helm {
        plugins = [
          # Preview release changes
          pkgs.kubernetes-helmPlugins.helm-diff
        ];
      })

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

    # Docker CLI config
    docker-cli = {
      enable = true;
    };

    # GitHub CLI
    gh = {
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

    # Docker TUI
    lazydocker = {
      enable = true;
    };

    # uv
    uv = {
      enable = true;
    };
  };
}
