# Development related stuff
{lib, ...}: {
  home = {
    sessionVariables = {
      # Disable GitHub CLI extension update notices
      GH_NO_EXTENSION_UPDATE_NOTIFIER = lib.mkDefault "1";

      # Disable GitHub CLI update notices
      GH_NO_UPDATE_NOTIFIER = lib.mkDefault "1";
    };
  };

  programs = {
    # kubectl colorful output
    kubecolor = {
      # Use kubecolor as the default kubectl client
      enableAlias = lib.mkDefault true;
    };
  };
}
