# SSH server configuration
{
  lib,
  pkgs,
  ...
}: {
  services = {
    openssh = {
      # Enable SSH server
      enable = true;

      settings = {
        # Accept environment variables from the client
        # COLORTERM is used to demonstrate color support of client terminal
        AcceptEnv = "COLORTERM";

        # No one can login with password
        # This means only public key authentication is allowed
        PasswordAuthentication = false;

        # Root can't login with SSH
        PermitRootLogin = "no";

        # Remove existing socket before creating a new one
        # Needed for GPG agent forwarding
        StreamLocalBindUnlink = "yes";
      };

      # Save resources by only starting the service when needed
      startWhenNeeded = true;
    };

    sshguard = {
      # Prevents brute force attacks
      enable = true;
    };
  };

  users = {
    users = {
      spietras = {
        openssh = {
          authorizedKeys = {
            # Take public keys from GitHub
            keys = lib.strings.splitString "\n" (
              builtins.readFile (
                pkgs.fetchurl {
                  sha256 = "sha256-gtXwzFGet2t8scHAP8lAZqFx2FjfYxAc+zqLecv+8Ik=";
                  url = "https://github.com/spietras.keys";
                }
              )
            );
          };
        };
      };
    };
  };
}
