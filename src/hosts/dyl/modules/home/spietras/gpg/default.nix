# GPG configuration
{
  config,
  pkgs,
  ...
}: {
  programs = {
    gpg = {
      enable = true;

      # Don't allow to edit keys manually
      mutableKeys = false;

      # Don't allow to edit trust manually
      mutableTrust = false;

      publicKeys = [
        {
          # Take the public key from GitHub
          source = pkgs.fetchurl {
            url = "https://github.com/spietras.gpg";
            sha256 = "sha256-axZSBDWxJC6Xm9Q51Mctd9FihOHPQH1PnylwhS5SR30=";
          };

          # This is my key so I trust it fully
          trust = "ultimate";
        }
      ];

      settings = {
        # Disable automatically starting the gpg-agent
        # This ensures that we only use the forwarded agent
        no-autostart = true;
      };
    };

    zsh = {
      # We need to setup the GPG agent sockets
      # When connecting to the server, use the sockets at /home/spietras/.gnupg/S.gpg-agent and /home/spietras/.gnupg/S.gpg-agent.ssh
      initExtra = let
        gpgconf = "${config.programs.gpg.package}/bin/gpgconf";
        agentSocket = "${config.programs.gpg.homedir}/S.gpg-agent";
        sshSocket = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
        ln = "${pkgs.coreutils}/bin/ln";
      in ''
        # Create the socket directory
        ${gpgconf} --create-socketdir

        # Create symbolic link to the agent socket
        # Run in a subshell to avoid polluting the environment
        (
          TARGET='${agentSocket}'
          LINKNAME="$(${gpgconf} --list-dirs agent-socket)"
          if [ ! -L "$LINKNAME" ]; then
            ${ln} --symbolic "$TARGET" "$LINKNAME"
          elif [ "$(readlink --canonicalize "$LINKNAME")" != "$TARGET" ]; then
            ${ln} --symbolic --force --no-dereference "$TARGET" "$LINKNAME"
          fi
        )

        # Create symbolic link to the SSH agent socket
        # Run in a subshell to avoid polluting the environment
        (
          TARGET='${sshSocket}'
          LINKNAME="$(${gpgconf} --list-dirs agent-ssh-socket)"
          if [ ! -L "$LINKNAME" ]; then
            ${ln} --symbolic "$TARGET" "$LINKNAME"
          elif [ "$(readlink --canonicalize "$LINKNAME")" != "$TARGET" ]; then
            ${ln} --symbolic --force --no-dereference "$TARGET" "$LINKNAME"
          fi
        )

        # Set the SSH_AUTH_SOCK environment variable so that SSH uses the forwarded GPG agent
        # But don't override it if it's set, because it means that the user is forwarding the SSH agent
        [ -z "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK="$(${gpgconf} --list-dirs agent-ssh-socket)"
      '';
    };
  };
}
