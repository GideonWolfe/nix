{ lib, config, ... }:

{

  imports = [

    #./secrets/secret_defs.nix
    # ./secrets/secrets/test/test.nix # test accessing them

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

    # Random fun packages
    #./packages/fun.nix

    ###########
    # CONFIGS #
    ###########

    # Session/env variables
    #./configs/session-variables.nix

    # Hyprland
    # Enable when ready for it
    #./configs/hyprland.nix
    #./configs/sway.nix
    #./configs/swaylock.nix
    #./configs/swayidle.nix

    # Cursor settings
    ./configs/cursor.nix

    # Neovim
    ../gideon/configs/nixvim/nixvim.nix

    # Display configs
    #./configs/kanshi.nix

    # Kitty
    ./configs/kitty.nix

    # Waybar
    ./configs/waybar.nix
    #./user/configs/waybar_new.nix

    # Wofi
    #./configs/wofi/wofi.nix

    # Firefox
    #./configs/firefox/firefox.nix

    # chromium
    #./configs/chromium.nix

    # Btop
    #./configs/btop.nix

    # GTK settings/theming
    #./configs/gtk.nix

    # Qt settings/theming
    #./configs/qt.nix

    # Custom user directories
    ./configs/xdg-user-dirs.nix

    # Custom user directories
    ./configs/mimetypes.nix

    # Better CD
    #./configs/zoxide.nix

    # Better LS
    #./configs/eza.nix

    # Better Cat
    #./configs/bat.nix


    # Git
    #./configs/git.nix

    # SSH
    #./configs/ssh/ssh.nix

    # Bluetooth (enabling applet)
    ./configs/bluetooth.nix

    # Shell config
    ./configs/fish.nix

    # Notification client
    #./configs/mako.nix

    # Nix theming framwork
    ./configs/stylix.nix

    # Nix theming framwork
    #./configs/spicetify.nix

    # Custom startpage
    #./configs/startpage/style.nix
    #./configs/startpage/service.nix



    #TODO: enable when config done
    #./configs/eww/eww.nix
  ];

  # enable unfree package use with home manager (ie stylix referencing symbola font which is unfree)
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "overseer";
  home.homeDirectory = "/home/overseer";

  home.activation = {
    # Screenshots, screen recordings, etc.
    createScreenshotsDir = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/pictures/screenshots/\n";
    createScreenRecordings = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/videos/screen_recordings/\n";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Silence home manager news
  news.display = "silent";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
