# Hardware configuration
{
  config,
  pkgs,
  ...
}: {
  environment = {
    sessionVariables = {
      # Specify the VA-API driver
      LIBVA_DRIVER_NAME = "nvidia";

      # Specify the VDPAU driver
      VDPAU_DRIVER = "nvidia";
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

    nvidia = {
      modesetting = {
        # Enable kernel mode setting for the NVIDIA driver
        enable = true;
      };

      # Use the proprietary kernel module because the open module does not support GTX 660
      open = false;

      # Use the legacy driver branch supporting the GTX 660
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
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

  nixpkgs = {
    config = {
      nvidia = {
        # Accept the NVIDIA Software license required by the proprietary driver
        acceptLicense = true;
      };
    };
  };

  services = {
    fwupd = {
      # Include a tool for updating the firmware of devices
      enable = true;
    };

    xserver = {
      videoDrivers = [
        # Use the proprietary NVIDIA driver
        "nvidia"
      ];
    };
  };
}
