# Install script
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  script = pkgs.writeShellApplication {
    # Name of the script
    name = "install";

    # Packages available in the script
    runtimeInputs = [pkgs.coreutils pkgs.disko];

    # Load the script with substituted values
    text = builtins.readFile (
      # Substitute values in the script
      pkgs.substituteAll {
        # Use this file as source
        src = ./install.sh;

        # Provide values to substitute
        flake = inputs.self;
        host = config.constants.name;
        keysFile = config.constants.secrets.sops.age.file;
        mainDiskDevice = config.constants.storage.disks.main.device;
        dataDiskDevice = config.constants.storage.disks.data.device;
      }
    );
  };
in {
  options = {
    installScript = lib.mkOption {
      default = script;
    };
  };
}
