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
      realizator = {
        description = "Realizator";

        extraGroups = [
          # Can use docker
          config.users.groups.docker.name

          # Can manage printing
          config.users.groups.lpadmin.name
        ];

        isNormalUser = true;

        # Use zsh as default shell
        shell = pkgs.zsh;

        # Make the UID static so it can be used in other places in the configuration
        uid = 1000;
      };

      root = {
        hashedPasswordFile = config.sops.secrets."passwords/root".path;
      };

      spietras = {
        description = "Sebastian Pietras";

        extraGroups = [
          # Can use docker
          config.users.groups.docker.name

          # Can manage printing
          config.users.groups.lpadmin.name

          # Can use sudo
          config.users.groups.wheel.name

          # Can use wireshark
          config.users.groups.wireshark.name
        ];

        isNormalUser = true;

        # Use zsh as default shell
        shell = pkgs.zsh;

        # Make the UID static so it can be used in other places in the configuration
        uid = 1001;
      };

      twarowskiw = {
        description = "Wojciech Twarowski";

        extraGroups = [
          # Can use docker
          config.users.groups.docker.name

          # Can manage printing
          config.users.groups.lpadmin.name

          # Can use sudo
          config.users.groups.wheel.name

          # Can use wireshark
          config.users.groups.wireshark.name
        ];

        isNormalUser = true;

        # Use zsh as default shell
        shell = pkgs.zsh;

        # Make the UID static so it can be used in other places in the configuration
        uid = 1002;
      };
    };
  };
}
