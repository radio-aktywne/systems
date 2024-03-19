# Secrets configuration
{
  inputs,
  config,
  ...
}: {
  imports = [
    # Import sops module
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age = {
      # age private keys should be stored at this path on the host
      keyFile = config.constants.secrets.sops.keyFile;

      # This is needed so that ssh keys are not unnecessarily picked up
      sshKeyPaths = [];
    };

    defaultSopsFile = ./secrets.yaml;

    gnupg = {
      # This is needed so that ssh keys are not unnecessarily picked up
      sshKeyPaths = [];
    };

    # You need to explicitly list here all secrets you want to use
    secrets = {
      "passwords/root" = {
        # This is needed to make the secret available early enough
        neededForUsers = true;
      };
    };
  };
}
