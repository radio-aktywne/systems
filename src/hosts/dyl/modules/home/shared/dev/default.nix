# Development related stuff
{
  config,
  lib,
  ...
}: {
  home = {
    file = {
      # Let Docker manage its config
      "${config.programs.docker-cli.configDir}/config.json" = {
        enable = false;
      };
    };

    sessionVariables = {
      # Disable GitHub CLI extension update notices
      GH_NO_EXTENSION_UPDATE_NOTIFIER = lib.mkDefault "1";

      # Disable GitHub CLI update notices
      GH_NO_UPDATE_NOTIFIER = lib.mkDefault "1";
    };
  };

  programs = {
    # Docker CLI config
    docker-cli = {
      configDir = lib.mkDefault "${config.xdg.configHome}/docker";
    };

    # GitHub CLI
    gh = {
      settings = {
        # Disable telemetry
        telemetry = lib.mkDefault "disabled";
      };
    };

    # kubectl colorful output
    kubecolor = {
      # Use kubecolor as the default kubectl client
      enableAlias = lib.mkDefault true;
    };
  };
}
