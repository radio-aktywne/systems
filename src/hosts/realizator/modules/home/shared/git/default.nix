# Git configuration
{lib, ...}: {
  programs = {
    difftastic = {
      git = {
        # Enable integration with git for better diffs
        enable = lib.mkDefault true;
      };
    };
  };
}
