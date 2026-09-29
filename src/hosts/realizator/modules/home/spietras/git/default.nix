# Git configuration
{config, ...}: {
  programs = {
    difftastic = {
      # Enable difftastic
      enable = true;
    };

    git = {
      enable = true;

      settings = {
        user = {
          email = "me@spietras.dev";
          name = "spietras";
        };
      };

      signing = {
        # Find gpg key by email address
        key = config.programs.git.settings.user.email;

        # Sign commits and tags by default
        signByDefault = true;
      };
    };

    lazygit = {
      # Enable git TUI
      enable = true;
    };
  };
}
