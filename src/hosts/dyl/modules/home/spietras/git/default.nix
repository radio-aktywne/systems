# Git configuration
{config, ...}: {
  programs = {
    git = {
      difftastic = {
        # Enable difftastic for better diffs
        enable = true;
      };

      enable = true;

      signing = {
        # Use the configured gpg binary, because by default the one from pkgs is used
        gpgPath = "${config.programs.gpg.package}/bin/gpg";

        # Find gpg key by email address
        key = config.programs.git.userEmail;

        # Sign commits and tags by default
        signByDefault = true;
      };

      userEmail = "me@spietras.dev";
      userName = "spietras";
    };

    lazygit = {
      # Enable git TUI
      enable = true;
    };
  };
}
