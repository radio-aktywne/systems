# Message of the Day
{
  config,
  pkgs,
  ...
}: {
  systemd = {
    services = {
      # Create a service for changing the MOTD
      motd = {
        description = "Change the MOTD";

        script = builtins.readFile (
          pkgs.substituteAll {
            src = ./motd.sh;

            cat = "${pkgs.coreutils}/bin/cat";
            logo = pkgs.writeText "logo.txt" (builtins.readFile ./logo.txt);
            lolcat = "${pkgs.lolcat}/bin/lolcat";
            mktemp = "${pkgs.coreutils}/bin/mktemp";
            motdfile = config.users.motdFile;
            rm = "${pkgs.coreutils}/bin/rm";
          }
        );

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
    motdFile = "/etc/motd";
  };
}
