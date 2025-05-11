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

        script = "${script}/bin/motd";

        serviceConfig = {
          # This is needed to format the output correctly
          StandardOutput = "tty";

          # Restart on failure
          Restart = "on-failure";
        };

        unitConfig = {
          # Limit the number of restarts
          StartLimitIntervalSec = 60;
          StartLimitBurst = 10;
        };
      };
    };

    timers = {
      # Create a timer for the MOTD service
      motd = {
        description = "Change the MOTD";

        timerConfig = {
          # Run every day at midnight
          OnCalendar = "00:00";

          # Run on startup if last time was missed
          Persistent = true;
        };

        wantedBy = [
          # Enable the timer
          "timers.target"
        ];
      };
    };
  };

  users = {
    # Store MOTD in this file
    motdFile = "/etc/motd";
  };
}
