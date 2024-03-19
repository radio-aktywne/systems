# Users configuration
{
  config,
  pkgs,
  ...
}: {
  users = {
    # Don't allow changing users configuration during runtime
    mutableUsers = false;

    users = {
      root = {
        hashedPasswordFile = config.sops.secrets."passwords/root".path;
      };

      spietras = {
        description = "Sebastian Pietras";

        extraGroups = [
          # Can use docker
          "docker"

          # Can use sudo
          "wheel"
        ];

        isNormalUser = true;

        # Use zsh as default shell
        shell = pkgs.zsh;

        # Make the UID static so it can be used in other places in the configuration
        uid = 1000;
      };
    };
  };
}
