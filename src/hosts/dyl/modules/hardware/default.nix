# Hardware configuration
{
  hardware = {
    cpu = {
      intel = {
        # Enable updates of the microcode for Intel CPUs
        updateMicrocode = true;
      };
    };

    # Make all firmware available
    enableAllFirmware = true;

    mcelog = {
      # Enable additional logging capabilities for hardware
      enable = true;
    };

    uinput = {
      # Enable emulated devices
      enable = true;
    };

    usb-modeswitch = {
      # Enable usage for USB modems
      enable = true;
    };

    # This contains especially the allowed frequencies for WiFI in different countries
    wirelessRegulatoryDatabase = true;
  };

  services = {
    fwupd = {
      # Include a tool for updating the firmware of devices
      enable = true;
    };
  };
}
