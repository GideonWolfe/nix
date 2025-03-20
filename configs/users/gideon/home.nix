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
    ../../modules/packages/user/theming.nix

    # Productivity packages
    ../../modules/packages/user/productivity/productivity.nix

    # Web
    ../../modules/packages/user/productivity/web.nix

    # Audio
    ../../modules/packages/user/productivity/audio.nix

    # Video
    ../../modules/packages/user/productivity/video.nix

    # Art
    ../../modules/packages/user/productivity/art.nix

    # Comms
    ../../modules/packages/user/productivity/comms.nix

    # Gaming
    ../../modules/packages/user/gaming.nix

    # STEM
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
    ../../modules/packages/user/development/rust.nix
    ../../modules/packages/user/development/js.nix
    ../../modules/packages/user/development/utils.nix

    # Random fun packages
    ../../modules/packages/user/fun.nix

    ###########
    # CONFIGS #
    ###########

    # Session/env variables
    ../../modules/configs/user/session-variables.nix
    #./configs/session-variables.nix

    # Configs for calendar settings and sync
    ./configs/calendar/calendar.nix
    ./configs/calendar/khal.nix
    ./configs/calendar/calcure.nix

    # Configs for contacts settings and sync
    ./configs/contacts/contacts.nix
    ./configs/contacts/khard.nix

    # Hyprland
    ../../modules/configs/user/hyprland.nix
    ../../modules/configs/user/hyprpaper.nix
    ../../modules/configs/user/hypridle.nix
    ../../modules/configs/user/hyprlock.nix
    ../../modules/configs/user/sway.nix
    ../../modules/configs/user/swaylock.nix

    # Cursor settings
    ../../modules/configs/user/cursor.nix

    # Neovim
    ../../modules/configs/user/nixvim/nixvim.nix

    # Kitty
    ../../modules/configs/user/kitty.nix

    # Waybar
    ../../modules/configs/user/waybar.nix

    # Wofi
    ../../modules/configs/user/wofi/wofi.nix

    # imv
    ../../modules/configs/user/imv.nix

    # Firefox
    ../../modules/configs/user/firefox/firefox.nix

    # Chromium
    ../../modules/configs/user/chromium.nix

    # Zathura
    ../../modules/configs/user/zathura.nix

    # foliate
    ../../modules/configs/user/foliate.nix

    # btop
    ../../modules/configs/user/btop.nix

    # GTK settings/theming
    ../../modules/configs/user/gtk.nix

    # Qt settings/theming
    ../../modules/configs/user/qt.nix

    # Custom user directories
    ../../modules/configs/user/xdg-user-dirs.nix

    # Custom default applications
    ../../modules/configs/user/mimetypes.nix

    # Better CD
    ../../modules/configs/user/zoxide.nix

    # Better LS
    ../../modules/configs/user/eza.nix

    # Better Cat
    ../../modules/configs/user/bat.nix

    # quick finder
    ../../modules/configs/user/fzf.nix

    # 3D image viewer
    ../../modules/configs/user/f3d.nix

    # Graph utility
    ../../modules/configs/user/gnuplot.nix

    # Screenshotting tool
    ../../modules/configs/user/flameshot.nix
    ../../modules/configs/user/swappy.nix

    # Cava
    ../../modules/configs/user/cava.nix
    ../../modules/configs/user/glava/shaders.nix
    ../../modules/configs/user/glava/rc.nix

    # Git
    ../../modules/configs/user/git.nix
    ../../modules/configs/user/gh.nix

    # KDE Connect
    ../../modules/configs/user/kdeconnect.nix

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
    ../../modules/configs/user/newsboat/newsboat.nix

    # Bluetooth (enabling applet)
    ../../modules/configs/user/bluetooth.nix

    # Shell config
    ../../modules/configs/user/fish.nix

    # TTY config
    ../../modules/configs/user/zellij.nix

    # Notification client
    # Disabling because hyprpanel handles it
    #./configs/mako.nix

    # Nix theming framwork
    ./configs/stylix.nix

    # Spotify theming tool
    ../../modules/configs/user/spicetify.nix
    #./configs/spicetify.nix

    # Custom startpage
    ../../modules/configs/user/startpage/style.nix
    ../../modules/configs/user/startpage/service.nix

    # These configs have to be generated manually
    ../../modules/configs/user/darkreader.nix

    ../../modules/configs/user/vdirsyncer.nix

    ../../modules/configs/user/fastfetch.nix

    # custom style for plantuml server
    #../../modules/configs/user/plantuml.nix
    #./configs/plantuml.nix

    # VS Code
    ../../modules/configs/user/vscode.nix

    # Projects
    ../../modules/configs/user/projects/forgetter.nix
    ../../modules/configs/user/projects/science.nix
    ../../modules/configs/user/projects/art.nix
    ../../modules/configs/user/projects/photography.nix
    ../../modules/configs/user/projects/tech.nix
    ../../modules/configs/user/projects/music.nix

    ../../modules/configs/user/obsidian/obsidian-stylix-css.nix
    #./configs/obsidian/obsidian-stylix-css.nix

    # touch pad gestures
    ../../modules/configs/user/fusuma.nix

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
    createNotes = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/notes/${config.home.username}\n";
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
