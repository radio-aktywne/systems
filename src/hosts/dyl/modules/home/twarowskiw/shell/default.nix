# Shell configuration
{
  config,
  lib,
  ...
}: {
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      autosuggestion = {
        enable = true;
      };

      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;

      history = {
        # Don't store duplicates in history
        ignoreDups = true;
      };

      historySubstringSearch = {
        enable = true;

        # All of these mean the same thing, but are sent by different terminals
        searchDownKey = [
          "^[[B"
          "\\eOB"
          "^[OB"
        ];

        # All of these mean the same thing, but are sent by different terminals
        searchUpKey = [
          "^[[A"
          "\\eOA"
          "^[OA"
        ];
      };

      initContent = lib.mkBefore ''
        # Create history file if it doesn't exist, because McFly crashes otherwise
        touch "${config.programs.zsh.history.path}"
      '';

      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
