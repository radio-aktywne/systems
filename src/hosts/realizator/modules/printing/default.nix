# Printing configuration
{pkgs, ...}: {
  services = {
    avahi = {
      # Enable Avahi
      enable = true;

      # Resolve mDNS hostnames on IPv4
      nssmdns4 = true;
    };

    ipp-usb = {
      # Enable IPP-over-USB support
      enable = true;
    };

    printing = {
      # Enable CUPS
      enable = true;

      extraConf = ''
        # Disable HTTPS for CUPS web interface
        DefaultEncryption Never
      '';

      # Install additional drivers
      drivers = [
        pkgs.gutenprint
        pkgs.gutenprintBin
      ];
    };
  };
}
