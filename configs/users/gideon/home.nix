{ lib, config, pkgs, ... }:

with config.lib.stylix.colors.withHashtag;

{

  imports = [

    ./secrets/secret_defs.nix

    ############
    # PACKAGES #
    ############

    #Theming
    ./packages/theming.nix

    # Productivity packages
    ./packages/productivity/productivity.nix

    # Web
    ./packages/productivity/web.nix

    # Audio
    ./packages/productivity/audio.nix

    # Video
    ./packages/productivity/video.nix

    # Art
    ./packages/productivity/art.nix

    # Comms
    ./packages/productivity/comms.nix

    # Gaming
    #./user/packages/gaming.nix

    # STEM
    ./packages/science/astronomy.nix
    ./packages/science/biology.nix
    ./packages/science/chemistry.nix
    ./packages/science/data.nix
    #./user/packages/science/education.nix
    ./packages/science/geography.nix
    ./packages/science/math.nix
    #./user/packages/science/medecine.nix
    ./packages/science/utilities.nix
    ./packages/science/engineering.nix

    # Development
    ./packages/development/rust.nix
    ./packages/development/utils.nix

    # Random fun packages
    ./packages/fun.nix

    ###########
    # CONFIGS #
    ###########

    # Hyprland
    # Enable when ready for it
    ./configs/hyprland.nix
    ./configs/sway.nix
    ./configs/swaylock.nix
    ./configs/swayidle.nix

    # Neovim
    ./configs/nixvim/nixvim.nix

    # Display configs
    ./configs/kanshi.nix

    # Kitty
    ./configs/kitty.nix

    # Waybar
    ./configs/waybar.nix
    #./user/configs/waybar_new.nix

    # Wofi
    ./configs/wofi/wofi.nix

    # Firefox
    ./configs/firefox/firefox.nix
    #./user/configs/firefox/userChrome.nix

    # Zathura
    ./configs/zathura.nix

    # Zathura
    ./configs/btop.nix

    # GTK settings/theming
    ./configs/gtk.nix

    # Qt settings/theming
    ./configs/qt.nix

    # Custom user directories
    ./configs/xdg-user-dirs.nix

    # Custom user directories
    ./configs/mimetypes.nix

    # Better CD
    ./configs/zoxide.nix

    # Better LS
    ./configs/eza.nix

    # Better Cat
    ./configs/bat.nix

    # Screenshotting tool
    ./configs/flameshot.nix

    # Cava
    ./configs/cava.nix

    # Git
    ./configs/git.nix

    # SSH
    ./configs/ssh/ssh.nix

    # Neomutt
    ./configs/neomutt/neomuttrc.nix
    ./configs/neomutt/settings.nix
    ./configs/neomutt/mailcap.nix
    ./configs/neomutt/mappings.nix
    ./configs/neomutt/colors.nix

    # Newsboat
    ./configs/newsboat/newsboat.nix
    ./configs/newsboat/urls.nix

    # Bluetooth (enabling applet)
    ./configs/bluetooth.nix

    # Shell config
    ./configs/fish.nix

    # Notification client
    ./configs/mako.nix

    # Nix theming framwork
    ./configs/stylix.nix

    # Nix theming framwork
    ./configs/spicetify.nix

    # Custom startpage
    ./configs/startpage/style.nix
    ./configs/startpage/service.nix
  ];

  # enable unfree package use with home manager (ie stylix referencing symbola font which is unfree)
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

  home.activation = {
    createScreenshotsDir = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/pictures/screenshots/\n";
    createScreenRecordings = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/videos/screen_recordings/\n";
  };

  # Specify cursor theme
  home.pointerCursor = lib.mkForce {
    # name = "phinger-cursors-light";
    # package = pkgs.phinger-cursors;
    #HACK: the capitilization may or may not be needed in the future: https://github.com/NixOS/nixpkgs/issues/321781
    # name = "catppuccin-mocha-dark-cursors";
    name = "Catppuccin-Mocha-Dark-Cursors"; #this creates a working symlink
    # name = "Catppuccin-Mocha-Dark"; #this creates a working symlink
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 32;
    gtk.enable = true;
  };

  xdg = {
    configFile = {

      # Creates a config for DarkReader
      # TODO, need to make this auto update?
      darkreader = {
        enable = true;
        #onChange = manually tell darkreader to refresh somehow?
        target = "darkreader/config.json";
        text = ''

          {
              "schemeVersion": 2,
              "enabled": true,
              "fetchNews": true,
              "theme": {
          	"mode": 1,
          	"brightness": 100,
          	"contrast": 100,
          	"grayscale": 0,
          	"sepia": 0,
          	"useFont": false,
          	"fontFamily": "Open Sans",
          	"textStroke": 0,
          	"engine": "dynamicTheme",
          	"stylesheet": "",
          	"darkSchemeBackgroundColor": "${base00}",
          	"darkSchemeTextColor": "${base05}",
          	"lightSchemeBackgroundColor": "${base05}",
          	"lightSchemeTextColor": "${base00}",
          	"scrollbarColor": "auto",
          	"selectionColor": "auto",
          	"styleSystemControls": false,
          	"lightColorScheme": "Default",
          	"darkColorScheme": "Default",
          	"immediateModify": false
              },
              "presets": [],
              "customThemes": [],
              "enabledByDefault": true,
              "enabledFor": [],
              "disabledFor": [],
              "changeBrowserTheme": false,
              "syncSettings": false,
              "syncSitesFixes": true,
              "automation": {
          	"enabled": false,
          	"mode": "",
          	"behavior": "OnOff"
              },
              "time": {
          	"activation": "18:00",
          	"deactivation": "9:00"
              },
              "location": {
          	"latitude": null,
          	"longitude": null
              },
              "previewNewDesign": true,
              "enableForPDF": true,
              "enableForProtectedPages": true,
              "enableContextMenus": false,
              "detectDarkTheme": false,
              "displayedNews": [
          	"thanks-2023"
              ]
          }

        '';
      };
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  #home.packages = [
  # # Adds the 'hello' command to your environment. It prints a friendly
  # # "Hello, world!" when run.
  # pkgs.hello

  # # It is sometimes useful to fine-tune packages, for example, by applying
  # # overrides. You can do that directly here, just don't forget the
  # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  # # fonts?
  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  # # You can also create simple shell scripts directly inside your
  # # configuration. For example, this adds a command 'my-hello' to your
  # # environment:
  # (pkgs.writeShellScriptBin "my-hello" ''
  #   echo "Hello, ${config.home.username}!"
  # '')
  #];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gideon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "kitty";
    BROWSER = "firefox";
    PAGER = "ov";
    RULES =
      "${config.home.homeDirectory}/nix/configs/users/gideon/secrets/secrets.nix";
    XCURSOR_THEME = "Catppuccin-Mocha-Dark-Cursors";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
