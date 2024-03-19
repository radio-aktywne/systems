# Options that don't fit in any other category
{
  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  home = {
    language = {
      # Use English as the default language
      base = "en_US.UTF-8";

      # Use Polish as the locale for formatting specific things
      address = "pl_PL.UTF-8";
      collate = "pl_PL.UTF-8";
      ctype = "pl_PL.UTF-8";
      measurement = "pl_PL.UTF-8";
      monetary = "pl_PL.UTF-8";
      name = "pl_PL.UTF-8";
      numeric = "pl_PL.UTF-8";
      paper = "pl_PL.UTF-8";
      telephone = "pl_PL.UTF-8";
      time = "pl_PL.UTF-8";
    };

    # This should just stay as is
    stateVersion = "22.11";
  };

  manual = {
    manpages = {
      enable = false;
    };
  };

  xdg = {
    # Enable XDG base directories
    enable = true;
  };
}
