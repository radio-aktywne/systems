# Things related to security
{
  networking = {
    firewall = {
      # Enable the firewall
      enable = true;

      # Limit the number of pings allowed to prevent ping flooding
      pingLimit = "--limit 10/s --limit-burst 100";

      # Reject bad packets instead of dropping them
      rejectPackets = true;
    };
  };

  security = {
    # Disable modifiying kernel image after boot
    protectKernelImage = true;

    rtkit = {
      # Enable permissions for realtime scheduling
      enable = true;
    };

    sudo = {
      # Only users in wheel group can use sudo
      execWheelOnly = true;

      # But they don't need to enter a password
      wheelNeedsPassword = false;
    };
  };
}
