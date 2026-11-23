# Git configuration
{
  config,
  lib,
  ...
}: {
  home = {
    sessionVariables = {
      # Use the Home Manager Git config
      GIT_CONFIG_GLOBAL = lib.mkDefault "${config.xdg.configHome}/git/config";
    };
  };

  programs = {
    difftastic = {
      git = {
        # Enable integration with git for better diffs
        enable = lib.mkDefault true;
      };
    };

    git = {
      settings = {
        branch = {
          # List recent branches first
          sort = lib.mkDefault "-committerdate";
        };

        diff = {
          # Produce readable diffs
          algorithm = lib.mkDefault "histogram";
        };

        fetch = {
          # Prune deleted remote branches
          prune = lib.mkDefault true;
        };

        init = {
          # Default to main
          defaultBranch = lib.mkDefault "main";
        };

        merge = {
          # Show the common ancestor in conflicts
          conflictStyle = lib.mkDefault "zdiff3";
        };

        pull = {
          # Rebase when pulling
          rebase = lib.mkDefault true;
        };

        push = {
          # Set upstream on first push
          autoSetupRemote = lib.mkDefault true;
        };

        rebase = {
          # Apply fixup! and squash! commits in interactive rebases
          autoSquash = lib.mkDefault true;

          # Stash changes while rebasing
          autoStash = lib.mkDefault true;

          # Update stacked branches
          updateRefs = lib.mkDefault true;
        };

        rerere = {
          # Stage reused conflict resolutions
          autoUpdate = lib.mkDefault true;

          # Record and reuse conflict resolutions
          enabled = lib.mkDefault true;
        };

        tag = {
          # Sort tags by version
          sort = lib.mkDefault "version:refname";
        };
      };
    };
  };
}
