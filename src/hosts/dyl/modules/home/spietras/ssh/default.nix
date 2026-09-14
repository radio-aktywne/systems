# SSH client configuration
{
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        "*" = {
          # Send environment variables to remote host
          # COLORTERM is used to demonstrate color support of client terminal
          sendEnv = ["COLORTERM"];
        };
      };
    };
  };
}
