# Applications
{
  lib,
  pkgs,
  ...
}: {
  programs = {
    # Better cat
    bat = {
      # Enable integration with other programs
      extraPackages = lib.mkDefault [
        pkgs.bat-extras.batdiff
        pkgs.bat-extras.batgrep
        pkgs.bat-extras.batman
        pkgs.bat-extras.batpipe
        pkgs.bat-extras.batwatch
      ];
    };

    # Change shell configuration on the fly
    direnv = {
      enable = lib.mkDefault true;

      nix-direnv = {
        # Enable better integration with Nix
        enable = lib.mkDefault true;
      };
    };

    # Manual
    man = {
      # Generate page index cache
      generateCaches = lib.mkDefault true;
    };

    # TLDR
    tealdeer = {
      settings = {
        updates = {
          # Enable automatic updates
          auto_update = lib.mkDefault true;
        };
      };
    };

    # Network diagnostic tool
    trippy = {
      # Do not force the generated configuration file
      forceUserConfig = lib.mkDefault false;
    };

    # Terminal file manager
    yazi = {
      # Use the new default shell wrapper name
      shellWrapperName = lib.mkDefault "y";
    };
  };
}
