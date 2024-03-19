# Containerisation
{
  virtualisation = {
    docker = {
      autoPrune = {
        dates = "Sun, 02:00";

        # Enable automatic pruning of old Docker resources
        enable = true;

        flags = [
          # All resources
          "--all"

          # Older than 7 days
          "--filter until=168h"

          # Don't ask for confirmation
          "--force"

          # Include volumes
          "--volumes"
        ];
      };

      daemon = {
        settings = {
          features = {
            # Enable buildkit
            buildkit = true;
          };
        };
      };

      # Enable Docker daemon
      enable = true;
    };
  };
}
