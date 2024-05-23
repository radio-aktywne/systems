# SSH client configuration
{
  programs = {
    ssh = {
      enable = true;

      extraConfig = ''
        # Send environment variables to remote host
        # COLORTERM is used to demonstrate color support of client terminal
        SendEnv COLORTERM
      '';
    };
  };
}
