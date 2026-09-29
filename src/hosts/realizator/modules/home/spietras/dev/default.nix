# Development related stuff
{
  lib,
  pkgs,
  ...
}: {
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

    # uv
    uv = {
      enable = true;
    };

    # Visual Studio Code
    vscode = {
      enable = true;

      # Use latest VS Code
      package = lib.mkForce pkgs.multiverse.latest.vscode.fhs;
    };
  };
}
