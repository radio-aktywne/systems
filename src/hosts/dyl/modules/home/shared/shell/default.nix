# Shell configuration
{
  config,
  lib,
  ...
}: {
  programs = {
    zsh = {
      autosuggestion = {
        enable = lib.mkDefault true;
      };

      dotDir = "${config.xdg.configHome}/zsh";
      enable = lib.mkDefault true;
      enableCompletion = lib.mkDefault true;
      enableVteIntegration = lib.mkDefault true;

      history = {
        # Don't store duplicates in history
        ignoreDups = lib.mkDefault true;
      };

      historySubstringSearch = {
        enable = lib.mkDefault true;

        # All of these mean the same thing, but are sent by different terminals
        searchDownKey = lib.mkDefault [
          "^[[B"
          "\\eOB"
          "^[OB"
        ];

        # All of these mean the same thing, but are sent by different terminals
        searchUpKey = lib.mkDefault [
          "^[[A"
          "\\eOA"
          "^[OA"
        ];
      };

      syntaxHighlighting = {
        enable = lib.mkDefault true;
      };
    };
  };
}
