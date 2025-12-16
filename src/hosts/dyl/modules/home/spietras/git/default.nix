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
