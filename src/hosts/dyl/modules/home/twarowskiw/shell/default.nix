# Shell configuration
{config, ...}: {
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      autosuggestion = {
        enable = true;
      };

      dotDir = "${config.xdg.configHome}/zsh";
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

      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
