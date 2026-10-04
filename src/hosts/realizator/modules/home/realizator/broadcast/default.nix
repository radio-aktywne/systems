# Stuff needed for broadcasting
{pkgs, ...}: {
  home = {
    packages = [
      # Audio metering
      pkgs.meters-lv2

      # Mixing software
      pkgs.mixxx

      # PipeWire graph management
      pkgs.qpwgraph

      # Digital audio workstation
      pkgs.reaper
    ];
  };
}
