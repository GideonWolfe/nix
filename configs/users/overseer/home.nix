{ lib, config, ... }:

{

  imports = [

    ############
    # PACKAGES #
    ############

    #Theming
    #./packages/theming.nix

    ###########
    # CONFIGS #
    ###########

    # Session/env variables
    ./configs/session-variables.nix

    # Hyprland
    # Enable when ready for it
    # ../gideon/configs/hyprland.nix
    # ../gideon/configs/hyprpaper.nix
    # ../gideon/configs/hypridle.nix
    # ../gideon/configs/hyprlock.nix

    ../../modules/configs/user/hypr/hyprland.nix
    ../../modules/configs/user/hypr/hyprpaper.nix
    ../../modules/configs/user/hypr/hypridle.nix
    ../../modules/configs/user/hypr/hyprlock.nix

    # Cursor settings
    #../gideon/configs/cursor.nix
    ../../modules/configs/user/cursor.nix

    # Neovim
    #../gideon/configs/nixvim/nixvim.nix
    ../../modules/configs/user/nixvim/nixvim.nix

    # Display configs
    #./configs/kanshi.nix

    # Kitty
    #../gideon/configs/kitty.nix
    ../../modules/configs/user/kitty.nix

    # Waybar
    #../gideon/configs/waybar.nix
    ../../modules/configs/user/waybar

    # Wofi
    # ../gideon/configs/wofi/wofi.nix
    ../../modules/configs/user/wofi/wofi.nix

    # imv
    # ../gideon/configs/imv.nix
    ../../modules/configs/user/imv.nix

    # Firefox
    #./configs/firefox/firefox.nix
    # ../gideon/configs/firefox/firefox.nix
    ../../modules/configs/user/firefox/firefox.nix

    # Chromium
    # ../gideon/configs/chromium.nix
    ../../modules/configs/user/chromium.nix

    # Zathura
    # ../gideon/configs/zathura.nix
    ../../modules/configs/user/zathura.nix

    # foliate
    # ../gideon/configs/foliate.nix
    ../../modules/configs/user/foliate.nix

    # btop
    # ../gideon/configs/btop.nix
    ../../modules/configs/user/btop.nix

    # GTK settings/theming
    # ../gideon/configs/gtk.nix
    ../../modules/configs/user/gtk.nix

    # Qt settings/theming
    # ../gideon/configs/qt.nix
    ../../modules/configs/user/qt.nix

    # Custom user directories
    # ../gideon/configs/xdg-user-dirs.nix
    ../../modules/configs/user/xdg-user-dirs.nix

    # Custom default applications
    #./configs/mimetypes.nix
    # ../gideon/configs/mimetypes.nix
    ../../modules/configs/user/mimetypes.nix

    # Better CD
    # ../gideon/configs/zoxide.nix
    ../../modules/configs/user/zoxide.nix

    # Better LS
    # ../gideon/configs/eza.nix
    ../../modules/configs/user/eza.nix

    # Better Cat
    # ../gideon/configs/bat.nix
    ../../modules/configs/user/bat.nix

    # quick finder
    # ../gideon/configs/fzf.nix
    ../../modules/configs/user/fzf.nix

    # 3D image viewer
    # ../gideon/configs/f3d.nix
    ../../modules/configs/user/f3d.nix

    # Graph utility
    # ../gideon/configs/gnuplot.nix
    ../../modules/configs/user/gnuplot.nix

    # Screenshotting tool
    #./configs/flameshot.nix
    # ../gideon/configs/swappy.nix
    ../../modules/configs/user/swappy.nix

    # Cava
    # ../gideon/configs/cava.nix
    ../../modules/configs/user/cava.nix

    # Git
    ./configs/git.nix

    # SSH
    ./configs/ssh/ssh.nix

    # Neomutt
    #./configs/email/neomutt/neomutt.nix
    #./configs/email/email.nix
    #./configs/email/mbsync.nix

    # Bluetooth (enabling applet)
    #../gideon/configs/bluetooth.nix
    ../../modules/configs/user/bluetooth.nix

    # Shell config
    # Inherit main user shell config
    # ../gideon/configs/fish.nix
    ../../modules/configs/user/shell/fish.nix

    # Notification client
    #./configs/mako.nix

    # Nix theming framwork
    ./configs/stylix.nix

    # Spotify theming tool
    # ../gideon/configs/spicetify.nix
    ../../modules/configs/user/spicetify.nix

    # Custom startpage
    # ../gideon/configs/startpage/style.nix
    # ../gideon/configs/startpage/service.nix
    ../../modules/configs/user/startpage/style.nix
    ../../modules/configs/user/startpage/service.nix

    # These configs have to be generated manually
    # ../gideon/configs/darkreader.nix
    ../../modules/configs/user/darkreader.nix

    # VS Code
    # ../gideon/configs/vscode.nix
    ../../modules/configs/user/vscode.nix

    ./configs/server/directories.nix

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
