# Development related stuff
{
  lib,
  pkgs,
  ...
}: {
  home = {
    sessionVariables = {
      # Disable GitHub CLI extension update notices
      GH_NO_EXTENSION_UPDATE_NOTIFIER = lib.mkDefault "1";

      # Disable GitHub CLI update notices
      GH_NO_UPDATE_NOTIFIER = lib.mkDefault "1";
    };
  };

  programs = {
    # Visual Studio Code
    vscode = {
      # Use the FHS-wrapped package so extensions with pre-built binaries can be used
      package = pkgs.vscode.fhs;
    };
  };
}
