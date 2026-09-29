# Options that don't fit in any other category
{lib, ...}: {
  home = {
    language = {
      # Use English as the default language
      base = lib.mkDefault "en_US.UTF-8";

      # Use Polish as the locale for formatting specific things
      address = lib.mkDefault "pl_PL.UTF-8";
      collate = lib.mkDefault "pl_PL.UTF-8";
      ctype = lib.mkDefault "pl_PL.UTF-8";
      measurement = lib.mkDefault "pl_PL.UTF-8";
      monetary = lib.mkDefault "pl_PL.UTF-8";
      name = lib.mkDefault "pl_PL.UTF-8";
      numeric = lib.mkDefault "pl_PL.UTF-8";
      paper = lib.mkDefault "pl_PL.UTF-8";
      telephone = lib.mkDefault "pl_PL.UTF-8";
      time = lib.mkDefault "pl_PL.UTF-8";
    };

    # Make programs use XDG directories whenever supported
    preferXdgDirectories = true;
  };

  manual = {
    manpages = {
      enable = lib.mkDefault false;
    };
  };

  xdg = {
    # Enable XDG base directories
    enable = true;
  };
}
