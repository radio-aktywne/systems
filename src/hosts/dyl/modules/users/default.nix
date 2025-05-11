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
          config.users.groups.docker.name

          # Can use kubernetes
          config.users.groups.kubernetes.name

          # Can use sudo
          "wheel"
        ];

        isNormalUser = true;

        # Use zsh as default shell
        shell = pkgs.zsh;

        # Make the UID static so it can be used in other places in the configuration
        uid = 1000;
      };

      twarowskiw = {
        description = "Wojciech Twarowski";

        extraGroups = [
          # Can use docker
          config.users.groups.docker.name

          # Can use kubernetes
          config.users.groups.kubernetes.name

          # Can use sudo
          "wheel"
        ];

        isNormalUser = true;

        # Use zsh as default shell
        shell = pkgs.zsh;

        # Make the UID static so it can be used in other places in the configuration
        uid = 1001;
      };
    };
  };
}
