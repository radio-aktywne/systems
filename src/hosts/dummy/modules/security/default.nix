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
}
