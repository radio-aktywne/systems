# Network configuration
{config, ...}: {
  networking = {
    # The identifier of the machine
    hostId = config.constants.network.hostId;

    # The hostname of the machine
    hostName = config.constants.name;
  };
}
