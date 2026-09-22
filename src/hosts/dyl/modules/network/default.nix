# Network configuration
{
  config,
  pkgs,
  ...
}: {
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

      plugins = [
        # Add Iodine VPN support
        pkgs.networkmanager-iodine

        # Add L2TP VPN support
        pkgs.networkmanager-l2tp

        # Add OpenConnect VPN support
        pkgs.networkmanager-openconnect

        # Add OpenVPN VPN support
        pkgs.networkmanager-openvpn

        # Add SSH VPN support
        pkgs.networkmanager-ssh

        # Add StrongSwan VPN support
        pkgs.networkmanager-strongswan
      ];
    };

    # Disable default NTP servers
    timeServers = [
      # ntp.org is probably the most reliable NTP server
      "pool.ntp.org"

      # Cloudflare is also great
      "time.cloudflare.com"
    ];
  };

  programs = {
    wireshark = {
      dumpcap = {
        # Allow capturing network traffic
        enable = true;
      };

      # Enable Wireshark
      enable = true;

      # Use the CLI version
      package = pkgs.wireshark-cli;

      usbmon = {
        # Allow capturing USB traffic
        enable = true;
      };
    };
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
