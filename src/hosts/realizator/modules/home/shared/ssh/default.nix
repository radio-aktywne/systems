# SSH client configuration
{lib, ...}: {
  programs = {
    ssh = {
      enableDefaultConfig = false;

      settings = {
        "*" = {
          # Send environment variables to remote host
          SendEnv = lib.mkDefault [
            # Demonstrate color support of client terminal
            "COLORTERM"
          ];

          # Set environment variables on remote host
          SetEnv = {
            # Use a widely supported terminal type
            TERM = lib.mkDefault "xterm-256color";
          };
        };
      };
    };
  };
}
