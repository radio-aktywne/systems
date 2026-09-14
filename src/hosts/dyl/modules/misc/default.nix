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

  services = {
    logrotate = {
      # Disable logrotate
      enable = false;
    };
  };
}
