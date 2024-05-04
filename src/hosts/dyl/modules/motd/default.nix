# Message of the Day
{
  config,
  pkgs,
  ...
}: let
  script = pkgs.writeShellApplication {
    # Name of the script
    name = "motd";

    # Packages available in the script
    runtimeInputs = [pkgs.coreutils pkgs.lolcat];

    # Load the script with substituted values
    text = builtins.readFile (
      # Substitute values in the script
      pkgs.substituteAll {
        # Use this file as source
        src = ./motd.sh;

        # Provide values to substitute
        logo = pkgs.writeText "logo.txt" (builtins.readFile ./logo.txt);
        motdfile = config.users.motdFile;
      }
    );
  };
in {
  systemd = {
    services = {
      # Create a service for changing the MOTD
      motd = {
        description = "Change the MOTD";

        requires = [
          # Require network to be online
          "network-online.target"
        ];

        script = "${script}/bin/motd";

        serviceConfig = {
          # This is needed to format the output correctly
          StandardOutput = "tty";

          # Restart on failure
          Restart = "on-failure";
        };

        # Run every day at midnight
        startAt = "00:00";

        unitConfig = {
          # Limit the number of restarts
          StartLimitIntervalSec = 60;
          StartLimitBurst = 10;
        };
      };
    };
  };

  users = {
    # Store MOTD in this file
    motdFile = "/etc/motd";
  };
}
