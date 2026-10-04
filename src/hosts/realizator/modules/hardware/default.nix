# Hardware configuration
{pkgs, ...}: {
  environment = {
    sessionVariables = {
      # Specify the VA-API driver
      LIBVA_DRIVER_NAME = "nouveau";

      # Specify the VDPAU driver
      VDPAU_DRIVER = "va_gl";
    };
  };

  hardware = {
    cpu = {
      amd = {
        # Enable updates of the microcode for AMD CPUs
        updateMicrocode = true;
      };
    };

    # Make all firmware available
    enableAllFirmware = true;

    graphics = {
      # Enable hardware-accelerated rendering
      enable = true;

      extraPackages = [
        # VDPAU to VA-API translation layer
        pkgs.libvdpau-va-gl
      ];
    };

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
