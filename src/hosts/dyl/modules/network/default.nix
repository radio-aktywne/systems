# Network configuration
{config, ...}: {
  networking = {
    # Set the default gateway statically
    defaultGateway = config.constants.network.gateway;

    dhcpcd = {
      # Disable dhcpcd, we use NetworkManager which has its own DHCP client
      enable = false;
    };

    hostId = config.constants.network.hostId;
    hostName = config.constants.name;

    # Set interfaces configuration statically
    interfaces = builtins.listToAttrs (
      builtins.map
      (
        cfg: {
          name = cfg.name;
          value = {
            ipv4 = {
              addresses = [
                {
                  address = cfg.address;
                  prefixLength = cfg.netmask;
                }
              ];
            };
          };
        }
      )
      config.constants.network.interfaces
    );

    # Set DNS servers statically
    nameservers = config.constants.network.nameservers;

    networkmanager = {
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
