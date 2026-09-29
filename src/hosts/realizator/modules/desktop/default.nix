# Desktop environment configuration
{
  config,
  lib,
  pkgs,
  ...
}: {
  environment = {
    gnome = {
      # Remove default GNOME packages that we don't need
      excludePackages = [
        pkgs.devhelp
        pkgs.gnome-builder
        pkgs.gnome-calculator
        pkgs.gnome-calendar
        pkgs.gnome-characters
        pkgs.gnome-clocks
        pkgs.gnome-contacts
        pkgs.gnome-maps
        pkgs.gnome-music
        pkgs.gnome-tour
        pkgs.gnome-user-docs
        pkgs.gnome-weather
        pkgs.orca
        pkgs.yelp
      ];
    };

    systemPackages = [
      # Include GNOME extensions that we want to use
      pkgs.gnomeExtensions.alphabetical-app-grid
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.app-hider
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.just-perfection
      pkgs.gnomeExtensions.tiling-shell
    ];
  };

  programs = {
    dconf = {
      profiles = {
        user = {
          databases = [
            {
              # Allow changing settings
              lockAll = false;

              settings = {
                "apps/seahorse" = {
                  # Automatically synchronize keys with key servers
                  server-auto-publish = lib.gvariant.mkBoolean true;

                  # Automatically retrieve keys from key servers
                  server-auto-retrieve = lib.gvariant.mkBoolean true;
                };

                "org/gnome/desktop/app-folders" = {
                  # Remove default app folders
                  folder-children = lib.gvariant.mkArray [(lib.gvariant.mkString "")];
                };

                "org/gnome/desktop/datetime" = {
                  # Detect time zone automatically
                  automatic-timezone = lib.gvariant.mkBoolean true;
                };

                "org/gnome/desktop/input-sources" = {
                  # Set the default input source to Polish
                  sources = lib.gvariant.mkArray [
                    (lib.gvariant.mkTuple [
                      (lib.gvariant.mkString "xkb")
                      (lib.gvariant.mkString "pl")
                    ])
                  ];
                };

                "org/gnome/desktop/interface" = {
                  # Show seconds in the clock
                  clock-show-seconds = lib.gvariant.mkBoolean true;

                  # Disable hot corners
                  enable-hot-corners = lib.gvariant.mkBoolean false;
                };

                "org/gnome/desktop/notifications" = {
                  # Hide notifications on the lock screen
                  show-in-lock-screen = lib.gvariant.mkBoolean false;
                };

                "org/gnome/desktop/session" = {
                  # Set the idle delay to 15 minutes
                  idle-delay = lib.gvariant.mkUint32 900;
                };

                "org/gnome/desktop/wm/preferences" = {
                  # Use minimize, maximize, and close buttons in the title bar
                  button-layout = lib.gvariant.mkString ":minimize,maximize,close";

                  # Use only one workspace
                  num-workspaces = lib.gvariant.mkInt32 1;
                };

                "org/gnome/epiphany" = {
                  # Use Google as the default search engine
                  default-search-engine = lib.gvariant.mkString "Google";

                  # Use Google as the incognito search engine
                  incognito-search-engine = lib.gvariant.mkString "Google";
                };

                "org/gnome/epiphany/web" = {
                  # Always show the full URL in the address bar
                  always-show-full-url = lib.gvariant.mkBoolean true;
                };

                "org/gnome/mutter" = {
                  # Disable dynamic workspaces
                  dynamic-workspaces = lib.gvariant.mkBoolean false;
                };

                "org/gnome/nautilus/preferences" = {
                  # Show the option to permanently delete items
                  show-delete-permanently = lib.gvariant.mkBoolean true;
                };

                "org/gnome/shell" = {
                  # Enable GNOME extensions that we want to use
                  enabled-extensions = lib.gvariant.mkArray [
                    (lib.gvariant.mkString pkgs.gnomeExtensions.alphabetical-app-grid.extensionUuid)
                    (lib.gvariant.mkString pkgs.gnomeExtensions.appindicator.extensionUuid)
                    (lib.gvariant.mkString pkgs.gnomeExtensions.app-hider.extensionUuid)
                    (lib.gvariant.mkString pkgs.gnomeExtensions.dash-to-dock.extensionUuid)
                    (lib.gvariant.mkString pkgs.gnomeExtensions.just-perfection.extensionUuid)
                    (lib.gvariant.mkString pkgs.gnomeExtensions.tiling-shell.extensionUuid)
                  ];

                  # Remove default favorite apps
                  favorite-apps = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
                };

                "org/gnome/shell/extensions/alphabetical-app-grid" = {
                  # Place folders before apps
                  folder-order-position = lib.gvariant.mkString "start";
                };

                "org/gnome/shell/extensions/app-hider" = {
                  # Hide some apps
                  hidden-apps = lib.gvariant.mkArray [
                    (lib.gvariant.mkString "cups.desktop")
                    (lib.gvariant.mkString "kvantummanager.desktop")
                    (lib.gvariant.mkString "qt5ct.desktop")
                    (lib.gvariant.mkString "qt6ct.desktop")
                  ];
                };

                "org/gnome/shell/extensions/dash-to-dock" = {
                  # Set the animation time for the dock
                  animation-time = lib.gvariant.mkDouble 0.1;

                  # Apply custom theme
                  apply-custom-theme = lib.gvariant.mkBoolean true;

                  # Focus, minimize, or show previews when clicking on an app
                  click-action = lib.gvariant.mkString "focus-minimize-or-previews";

                  # Disable showing the overview on startup
                  disable-overview-on-startup = lib.gvariant.mkBoolean true;

                  # Set the hide delay for the dock
                  hide-delay = lib.gvariant.mkDouble 1.0;

                  # Show the dock on all monitors
                  multi-monitor = lib.gvariant.mkBoolean true;

                  # Disable requiring pressure to show the dock
                  require-pressure-to-show = lib.gvariant.mkBoolean false;

                  # Cycle through windows when scrolling on an app
                  scroll-action = lib.gvariant.mkString "cycle-windows";

                  # Disable the show delay for the dock
                  show-delay = lib.gvariant.mkDouble 0.0;

                  # Hide mounted drives
                  show-mounts = lib.gvariant.mkBoolean false;
                };

                "org/gnome/shell/extensions/just-perfection" = {
                  # Hide events in clock menu
                  events-button = lib.gvariant.mkBoolean false;

                  # Disable showing the overview on startup
                  startup-status = lib.gvariant.mkInt32 0;

                  # Disable support notifications
                  support-notifier-type = lib.gvariant.mkInt32 0;

                  # Disable showing workspaces in app grid
                  workspaces-in-app-grid = lib.gvariant.mkBoolean false;
                };

                "org/gnome/shell/extensions/tilingshell" = {
                  # Disable snap assistant
                  enable-snap-assist = lib.gvariant.mkBoolean false;

                  # Remove inner gaps
                  inner-gaps = lib.gvariant.mkUint32 0;

                  # Remove outer gaps
                  outer-gaps = lib.gvariant.mkUint32 0;

                  # Set the quarter tiling threshold to 25%
                  quarter-tiling-threshold = lib.gvariant.mkUint32 25;

                  # Maximize windows when dragged to the top edge
                  top-edge-maximize = lib.gvariant.mkBoolean true;
                };

                "org/gtk/gtk4/settings/file-chooser" = {
                  # Show hidden files
                  show-hidden = lib.gvariant.mkBoolean true;
                };

                "system/locale" = {
                  # Set the system locale to Polish
                  region = lib.gvariant.mkString "pl_PL.UTF-8";
                };
              };
            }
          ];
        };
      };
    };
  };

  security = {
    pam = {
      services = {
        login = {
          # Disable showing MOTD on login
          showMotd = lib.mkForce false;
        };
      };
    };
  };

  services = {
    desktopManager = {
      gnome = {
        # Enable GNOME
        enable = true;
      };
    };

    displayManager = {
      autoLogin = {
        # Enable automatic login
        enable = true;

        # Set the user for automatic login
        user = config.users.users.realizator.name;
      };

      gdm = {
        # Enable GDM
        enable = true;
      };
    };

    gnome = {
      gcr-ssh-agent = {
        # Disable GNOME's SSH agent
        enable = false;
      };

      gnome-browser-connector = {
        # Disable GNOME extensions integration in web browsers
        enable = false;
      };

      gnome-initial-setup = {
        # Disable GNOME's initial setup wizard
        enable = false;
      };

      gnome-online-accounts = {
        # Disable GNOME's online accounts integration
        enable = false;
      };

      gnome-user-share = {
        # Disable GNOME's file sharing service
        enable = false;
      };
    };
  };
}
