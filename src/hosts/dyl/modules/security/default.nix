# Things related to security
{config, ...}: {
  environment = {
    sessionVariables = {
      # Point tools to the system CA bundle
      AWS_CA_BUNDLE = config.security.pki.caBundle;
      CARGO_HTTP_CAINFO = config.security.pki.caBundle;
      CURL_CA_BUNDLE = config.security.pki.caBundle;
      GIT_SSL_CAINFO = config.security.pki.caBundle;
      HEX_CACERTS_PATH = config.security.pki.caBundle;
      PERL_LWP_SSL_CA_FILE = config.security.pki.caBundle;
      SSL_CERT_FILE = config.security.pki.caBundle;
    };
  };

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
    pki = {
      certificateFiles = [
        # Add self-signed root certificate
        ./ca.crt
      ];
    };

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
