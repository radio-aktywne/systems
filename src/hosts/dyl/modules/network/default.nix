# Network configuration
{config, ...}: {
  networking = {
    dhcpcd = {
      # Disable dhcpcd, we use NetworkManager which has its own DHCP client
      enable = false;
    };

    # The identifier of the machine
    hostId = config.constants.network.hostId;

    # The hostname of the machine
    hostName = config.constants.name;

    networkmanager = {
      # Push DNS configuration to systemd-resolved
      dns = "systemd-resolved";

      # Use NetworkManager to manage network connections
      enable = true;
    };

    # Disable default NTP servers
    timeServers = [
      # ntp.org is probably the most reliable NTP server
      "pool.ntp.org"

      # Cloudflare is also great
      "time.cloudflare.com"
    ];
  };

  services = {
    resolved = {
      # Use systemd-resolved as the system DNS resolver
      enable = true;
    };

    timesyncd = {
      # Enable systemd-timesyncd as the system NTP client
      enable = true;
    };
  };
}
