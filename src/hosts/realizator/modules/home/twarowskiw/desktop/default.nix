# Desktop environment configuration
{lib, ...}: {
  dconf = {
    settings = {
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
          (lib.gvariant.mkString "qt5ct.desktop")
          (lib.gvariant.mkString "qt6ct.desktop")
          (lib.gvariant.mkString "yazi.desktop")
        ];
      };
    };
  };
}
