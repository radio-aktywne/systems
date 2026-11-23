# Development related stuff
{
  config,
  lib,
  pkgs,
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

    # Visual Studio Code
    vscode = {
      # Use the FHS-wrapped package so extensions with pre-built binaries can be used
      package = pkgs.vscode.fhs;
    };
  };
}
