# Things that impact performance
{
  services = {
    earlyoom = {
      # Enable earlyoom as the user-space OOM killer
      # Compared to systemd-oomd, earlyoom can kill individual processes instead of the whole cgroup
      # Compared to nohang, earlyoom is more lightweight
      enable = true;
    };

    logind = {
      # Kill user processes when the user logs out
      # This is useful for reducing unnecessary memory usage
      # However, sometimes you need to keep some processes running even after logging out
      # For example, when using screen or tmux
      # In this case, you need to run them with systemd-run --user
      killUserProcesses = true;
    };
  };

  systemd = {
    oomd = {
      # Disable systemd-oomd
      enable = false;
    };
  };
}
