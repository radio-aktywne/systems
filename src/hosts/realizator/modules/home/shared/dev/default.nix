# Development related stuff
{
  lib,
  pkgs,
  ...
}: {
  programs = {
    # Visual Studio Code
    vscode = {
      # Use the FHS-wrapped package so extensions with pre-built binaries can be used
      package = pkgs.vscode.fhs;
    };
  };
}
