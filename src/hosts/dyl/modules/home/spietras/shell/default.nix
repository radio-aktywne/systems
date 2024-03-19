# Shell configuration
{config, ...}: {
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
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

      initExtraFirst = ''
        # Create history file if it doesn't exist, because McFly crashes otherwise
        touch "${config.programs.zsh.history.path}"
      '';

      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
