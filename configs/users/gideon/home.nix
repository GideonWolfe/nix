{ lib, config, ... }:

{

  imports = [

    # Imports a list of all user based secrets
    # only the ones readable by this user will be generated
    ../../secrets/user_secrets.nix

    ############
    # PACKAGES #
    ############

    #Theming
    #./packages/theming.nix
    ../../modules/packages/user/theming.nix

    # Productivity packages
    #./packages/productivity/productivity.nix
    ../../modules/packages/user/productivity/productivity.nix

    # Web
    #./packages/productivity/web.nix
    ../../modules/packages/user/productivity/web.nix

    # Audio
    #./packages/productivity/audio.nix
    ../../modules/packages/user/productivity/audio.nix

    # Video
    #./packages/productivity/video.nix
    ../../modules/packages/user/productivity/video.nix

    # Art
    #./packages/productivity/art.nix
    ../../modules/packages/user/productivity/art.nix

    # Comms
    #./packages/productivity/comms.nix
    ../../modules/packages/user/productivity/comms.nix

    # Gaming
    #./packages/gaming.nix
    ../../modules/packages/user/gaming.nix

    # STEM
    # ./packages/science/astronomy.nix
    # ./packages/science/biology.nix
    # ./packages/science/chemistry.nix
    # ./packages/science/data.nix
    # ./packages/science/education.nix
    # ./packages/science/geography.nix
    # ./packages/science/math.nix
    #./user/packages/science/medecine.nix
    # ./packages/science/utilities.nix
    # ./packages/science/engineering.nix

    ../../modules/packages/user/science/astronomy.nix
    ../../modules/packages/user/science/biology.nix
    ../../modules/packages/user/science/chemistry.nix
    ../../modules/packages/user/science/data.nix
    ../../modules/packages/user/science/education.nix
    ../../modules/packages/user/science/geography.nix
    ../../modules/packages/user/science/math.nix
    #../../modules/packages/user/science/medecine.nix
    ../../modules/packages/user/science/utilities.nix
    ../../modules/packages/user/science/engineering.nix

    # Development
    # ./packages/development/rust.nix
    # ./packages/development/js.nix
    # ./packages/development/utils.nix

    ../../modules/packages/user/development/rust.nix
    ../../modules/packages/user/development/js.nix
    ../../modules/packages/user/development/utils.nix

    # Random fun packages
        #./packages/fun.nix
    ../../modules/packages/user/fun.nix

    ###########
    # CONFIGS #
    ###########

    # Session/env variables
    ./configs/session-variables.nix

    # Configs for calendar settings and sync
    ./configs/calendar/calendar.nix
    ./configs/calendar/khal.nix
    ./configs/calendar/calcure.nix

    # Configs for contacts settings and sync
    ./configs/contacts/contacts.nix
    ./configs/contacts/khard.nix

    # Hyprland
    # Enable when ready for it
    ./configs/hyprland.nix
    ./configs/hyprpaper.nix
    ./configs/hypridle.nix
    ./configs/hyprlock.nix
    ./configs/sway.nix
    ./configs/swaylock.nix
    #./configs/swayidle.nix

    # Cursor settings
    ./configs/cursor.nix

    # Neovim
    ./configs/nixvim/nixvim.nix

    # Display configs
    #./configs/kanshi.nix

    # Kitty
    ./configs/kitty.nix

    # Waybar
    ./configs/waybar.nix

    # Wofi
    ./configs/wofi/wofi.nix

    # imv
    ./configs/imv.nix

    # Firefox
    ./configs/firefox/firefox.nix

    # Chromium
    ./configs/chromium.nix

    # Zathura
    ./configs/zathura.nix

    # foliate
    ./configs/foliate.nix

    # btop
    ./configs/btop.nix

    # GTK settings/theming
    ./configs/gtk.nix

    # Qt settings/theming
    ./configs/qt.nix

    # Custom user directories
    ./configs/xdg-user-dirs.nix

    # Custom default applications
    ./configs/mimetypes.nix

    # Better CD
    ./configs/zoxide.nix

    # Better LS
    ./configs/eza.nix

    # Better Cat
    ./configs/bat.nix

    # quick finder
    ./configs/fzf.nix

    # 3D image viewer
    ./configs/f3d.nix

    # Graph utility
    ./configs/gnuplot.nix

    # Screenshotting tool
    ./configs/flameshot.nix
    ./configs/swappy.nix

    # Cava
    ./configs/cava.nix
    ./configs/glava/shaders.nix
    ./configs/glava/rc.nix

    # Git
    ./configs/git.nix
    ./configs/gh.nix

    # KDE Connect
    ./configs/kdeconnect.nix

    # SSH
    ./configs/ssh/ssh.nix

    # Neomutt
    ./configs/email/neomutt/neomutt.nix
    ./configs/email/thunderbird/thunderbird.nix # uses lots of storage
    ./configs/email/email.nix
    ./configs/email/mbsync.nix

    # Weechat
    ./configs/weechat/buflist.nix
    ./configs/weechat/weechat.nix

    # Newsboat
    ./configs/newsboat/newsboat.nix
    #./configs/newsboat/urls.nix

    # Bluetooth (enabling applet)
    ./configs/bluetooth.nix

    # Shell config
    ./configs/fish.nix

    # TTY config
    ./configs/zellij.nix

    # Notification client
    # Disabling because hyprpanel handles it
    #./configs/mako.nix

    # Nix theming framwork
    ./configs/stylix.nix

    # Spotify theming tool
    ./configs/spicetify.nix

    # Custom startpage
    ./configs/startpage/style.nix
    ./configs/startpage/service.nix

    # These configs have to be generated manually
    ./configs/darkreader.nix

    # These configs have to be generated manually
    ./configs/vdirsyncer.nix

    ./configs/fastfetch.nix

    # custom style for plantuml server
    ./configs/plantuml.nix

    # VS Code
    ./configs/vscode.nix

    # Projects
        #./configs/projects/zeroday.nix
    ./configs/projects/forgetter.nix
    ./configs/projects/science.nix
    ./configs/projects/art.nix
    ./configs/projects/photography.nix
    ./configs/projects/tech.nix
    ./configs/projects/music.nix

    #TODO: enable when config done
    #./configs/ags/ags.nix
    #./configs/ags/style.nix

    ../../modules/keys/ssh.nix
  ];

  # enable unfree package use with home manager (ie stylix referencing symbola font which is unfree)
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

  home.activation = {
    # Screenshots, screen recordings, etc.
    createScreenshotsDir = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/pictures/screenshots/\n";
    createScreenRecordings = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/videos/screen_recordings/\n";
    createCalendarGmail = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/calendars/gmail/\n";
    createContactsGmail = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/contacts/gmail/\n";
    # Test folder for experimenting
    createTest = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/test/\n";
    # Project folder
    createProjects = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/\n";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Silence home manager news
  news.display = "silent";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
