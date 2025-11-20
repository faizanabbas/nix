{ pkgs, user, ... }:

{
  system.stateVersion = 6;

  # Disable nix-darwin's management of the nix-daemon so strict
  # conflicts don't occur with the Determinate Systems installer.
  nix.enable = false;

  users.users.${user} = {
    name = user;
    home = "/Users/${user}";
  };

  #---------------------------------------------------------------------
  # Homebrew
  #---------------------------------------------------------------------

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = user;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;

    onActivation.cleanup = "zap";

    casks = [
      "1password"
      "discord"
      "figma"
      "firefox"
      "ghostty"
      "google-chrome"
      "localsend"
      "microsoft-teams"
      "netnewswire"
      "notion"
      "obsidian"
      "protonvpn"
      "slack"
      "spotify"
      "whatsapp"
      "zed"
    ];
  };

  #---------------------------------------------------------------------
  # macOS system configuration
  #---------------------------------------------------------------------

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = user;
  system.startup.chime = false;
  system.defaults = {
    trackpad.TrackpadThreeFingerDrag = true;
    CustomUserPreferences = {
      NSGlobalDomain = {
        AppleActionOnDoubleClick = "Fill";
        AppleIconAppearanceTheme = "RegularAutomatic";
        AppleInterfaceStyleSwitchesAutomatically = true;
        AppleShowAllExtensions = true;
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
      };
    };
    dock = {
      autohide = true;
      orientation = "left";
      show-recents = false;
      tilesize = 42;
      showhidden = true;
      persistent-apps = [
        {
          app = "/System/Cryptexes/App/System/Applications/Safari.app";
        }
        {
          app = "/Applications/Google Chrome.app";
        }
        {
          app = "/System/Applications/Mail.app";
        }
        {
          app = "/Applications/Microsoft Outlook.app";
        }
        {
          app = "/Applications/Discord.app";
        }
        {
          app = "/Applications/Obsidian.app";
        }
        {
          app = "/Applications/Zed.app";
        }
        {
          app = "/Applications/Ghostty.app";
        }
        {
          app = "/Applications/Microsoft Teams.app";
        }
        {
          app = "/Applications/Slack.app";
        }
        {
          app = "/Applications/Notion.app";
        }
        {
          app = "/System/Applications/System Settings.app";
        }
      ];
    };
  };
}
