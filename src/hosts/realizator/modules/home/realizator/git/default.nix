# Git configuration
{config, ...}: {
  programs = {
    difftastic = {
      # Enable difftastic
      enable = true;
    };

    git = {
      enable = true;
    };

    lazygit = {
      # Enable git TUI
      enable = true;
    };
  };
}
