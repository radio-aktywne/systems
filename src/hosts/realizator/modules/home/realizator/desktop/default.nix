# Desktop environment configuration
{lib, ...}: {
  dconf = {
    settings = {
      "org/gnome/desktop/lockdown" = {
        # Disable locking the screen manually
        disable-lock-screen = lib.gvariant.mkBoolean true;
      };

      "org/gnome/desktop/screensaver" = {
        # Disable locking the screen automatically
        lock-enabled = lib.gvariant.mkBoolean false;
      };

      "org/gnome/shell/extensions/app-hider" = {
        # Hide some apps
        hidden-apps = lib.gvariant.mkArray [
          (lib.gvariant.mkString "btop.desktop")
          (lib.gvariant.mkString "cups.desktop")
          (lib.gvariant.mkString "epiphany.desktop")
          (lib.gvariant.mkString "kvantummanager.desktop")
          (lib.gvariant.mkString "micro.desktop")
          (lib.gvariant.mkString "org.gnome.Console.desktop")
          (lib.gvariant.mkString "org.gnome.Epiphany.desktop")
          (lib.gvariant.mkString "org.wireshark.Wireshark.desktop")
          (lib.gvariant.mkString "qt5ct.desktop")
          (lib.gvariant.mkString "qt6ct.desktop")
          (lib.gvariant.mkString "yazi.desktop")
        ];
      };
    };
  };
}
