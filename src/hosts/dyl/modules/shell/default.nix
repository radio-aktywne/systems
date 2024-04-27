# Enable shells
{
  environment = {
    pathsToLink = [
      # Needed for completions for system packages to work
      "/share/zsh/"
    ];
  };

  programs = {
    zsh = {
      # Enable Z shell
      enable = true;
    };
  };
}
