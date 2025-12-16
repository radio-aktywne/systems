# Boot configuration
{
  boot = {
    initrd = {
      # Kernel modules needed for booting
      availableKernelModules = [
        # These were autodetected by nixos-generate-config
        "ahci"
        "sr_mod"
        "virtio_pci"
        "virtio_blk"
        "xhci_pci"
      ];
    };

    # Other kernel modules to load
    kernelModules = [
      # These were autodetected by nixos-generate-config
      "kvm-intel"
    ];

    loader = {
      systemd-boot = {
        # Use systemd-boot as bootloader
        enable = true;
      };
    };
  };
}
