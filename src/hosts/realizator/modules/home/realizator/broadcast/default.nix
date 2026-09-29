# Stuff needed for broadcasting
{pkgs, ...}: {
  home = {
    packages = [
      # Mixing software
      pkgs.mixxx

      # PipeWire graph management
      pkgs.qpwgraph

      # Digital audio workstation
      pkgs.reaper
    ];
  };
}
