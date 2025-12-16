# Secrets configuration
{
  config,
  inputs,
  ...
}: {
  imports = [
    # Import sops modules
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age = {
      # age private keys should be stored at this path on the host
      keyFile = config.constants.secrets.sops.age.file;

      # This is needed so that ssh keys are not unnecessarily picked up
      sshKeyPaths = [];
    };

    # Store encrypted secrets in this file in the repository
    defaultSopsFile = ./secrets.yaml;

    gnupg = {
      # This is needed so that ssh keys are not unnecessarily picked up
      sshKeyPaths = [];
    };

    # You need to explicitly list here all secrets you want to use
    secrets = {
    };
  };
}
