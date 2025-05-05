# Boot configuration
{pkgs, ...}: {
  boot = {
    # Disable console messages
    consoleLogLevel = 0;

    initrd = {
      # Kernel modules needed for booting
      availableKernelModules = [
        # These were autodetected by nixos-generate-config
        "ata_piix"
        "ehci_pci"
        "megaraid_sas"
        "sd_mod"
        "sr_mod"
        "uhci_hcd"
        "usbhid"
        "usb_storage"
      ];

      # Disable log messages
      verbose = false;
    };

    kernel = {
      sysctl = {
        # Increase file watcher limits
        "fs.inotify.max_user_watches" = 524288;
        "fs.inotify.max_user_instances" = 1024;
        "fs.inotify.max_queued_events" = 65536;

        # Enable SysRq
        # But only for logging level, keyboard, sync, remount, signals and reboot
        "kernel.sysrq" = 244;

        # Increase socket buffer size
        "net.core.rmem_max" = 2500000;
        "net.core.wmem_max" = 2500000;

        # Ignore incoming ICMP redirects to prevent MITM attacks
        "net.ipv4.conf.all.accept_redirects" = false;
        "net.ipv4.conf.all.secure_redirects" = false;
        "net.ipv4.conf.default.accept_redirects" = false;
        "net.ipv4.conf.default.secure_redirects" = false;
        "net.ipv6.conf.all.accept_redirects" = false;
        "net.ipv6.conf.default.accept_redirects" = false;

        # Ignore outgoing ICMP redirects to prevent MITM attacks
        "net.ipv4.conf.all.send_redirects" = false;
        "net.ipv4.conf.default.send_redirects" = false;
      };
    };

    # Other kernel modules to load
    kernelModules = [
      # These were autodetected by nixos-generate-config
      "kvm-intel"
    ];

    kernelParams = [
      # Panic on failure
      "boot.panic_on_fail"

      # Reboot after 10 seconds on panic
      "kernel.panic=10"

      # Enable splash screen
      "splash"

      # Disable log messages
      "quiet"
      "udev.log_level=3"
    ];

    loader = {
      systemd-boot = {
        # Keep maximum 5 previous generations
        configurationLimit = 5;

        # Try to autodetect the best resolution
        consoleMode = "auto";

        # Disable editing kernel parameters
        editor = false;

        # Use systemd-boot as bootloader
        enable = true;

        memtest86 = {
          # Enable memtest86 to be able to test RAM
          enable = true;

          # This is needed for correct ordering of boot entries
          sortKey = "z1_memtest86";
        };

        netbootxyz = {
          # Enable netboot.xyz to be able to boot any OS from network
          enable = true;

          # This is needed for correct ordering of boot entries
          sortKey = "z0_netbootxyz";
        };
      };
    };

    plymouth = {
      # Enable splash screen
      enable = true;

      theme = "angular";

      themePackages = [
        # See https://github.com/adi1090x/plymouth-themes for more themes
        (pkgs.adi1090x-plymouth-themes.override {selected_themes = ["angular"];})
      ];
    };
  };
}
