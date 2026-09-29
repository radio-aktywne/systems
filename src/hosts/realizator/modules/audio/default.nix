# Audio configuration
{
  services = {
    pipewire = {
      # Enable PipeWire
      enable = true;

      alsa = {
        # Enable ALSA support
        enable = true;
      };

      pulse = {
        # Enable PulseAudio support
        enable = true;
      };

      jack = {
        # Enable JACK support
        enable = true;
      };
    };
  };
}
