# Development related stuff
{lib, ...}: {
  programs = {
    # kubectl colorful output
    kubecolor = {
      # Use kubecolor as the default kubectl client
      enableAlias = lib.mkDefault true;
    };
  };
}
