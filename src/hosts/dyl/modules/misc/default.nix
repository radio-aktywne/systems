# Options that don't fit in any other category
{
  # Disable unnecessary documentation
  documentation = {
    doc = {
      enable = false;
    };

    info = {
      enable = false;
    };

    nixos = {
      enable = false;
    };
  };

  programs = {
    command-not-found = {
      # Don't give users hints about how to install missing commands
      enable = false;
    };
  };

  services = {
    logrotate = {
      # Disable logrotate
      enable = false;
    };
  };
}
