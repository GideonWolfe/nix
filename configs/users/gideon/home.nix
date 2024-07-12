{ lib, config, ... }:

{

  imports = [

    ./secrets/secret_defs.nix
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

    # Art
    ./packages/productivity/art.nix

    # Comms
    ./packages/productivity/comms.nix

    # Gaming
    #./user/packages/gaming.nix

    # STEM
    #./packages/science/astronomy.nix
    #./packages/science/biology.nix
    #./packages/science/chemistry.nix
    #./packages/science/data.nix
    #./user/packages/science/education.nix
    #./packages/science/geography.nix
    #./packages/science/math.nix
    #./user/packages/science/medecine.nix
    ./packages/science/utilities.nix
    #./packages/science/engineering.nix

    # Development
    ./packages/development/rust.nix
    ./packages/development/utils.nix

    # Random fun packages
    ./packages/fun.nix

    ###########
    # CONFIGS #
    ###########

    # Session/env variables
    ./configs/session-variables.nix

    # Configs for calendar settings and sync
    ./configs/calendar/calendar.nix
    ./configs/calendar/khal.nix

    # Configs for contacts settings and sync
    ./configs/contacts/contacts.nix
    ./configs/contacts/khard.nix

    # Hyprland
    # Enable when ready for it
    ./configs/hyprland.nix
    ./configs/sway.nix
    ./configs/swaylock.nix
    ./configs/swayidle.nix

    # Cursor settings
    ./configs/cursor.nix

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
    #./configs/email/neomutt/neomuttrc.nix
    #./configs/email/neomutt/settings.nix
    #./configs/email/neomutt/mailcap.nix
    #./configs/email/neomutt/mappings.nix
    #./configs/email/neomutt/colors.nix
    ./configs/email/neomutt/neomutt.nix
    ./configs/email/email.nix
    ./configs/email/mbsync.nix

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

    # These configs have to be generated manually
    ./configs/darkreader.nix

    # These configs have to be generated manually
    ./configs/vdirsyncer.nix

    # VS Code
    #./configs/vscode.nix
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
    createDraft = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/mail/gmail/drafts/\n";
    createInbox = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/mail/gmail/inbox/\n";
    createAll = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/mail/gmail/all/\n";
    createStarred = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/mail/gmail/starred/\n";
    createSent = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/mail/gmail/sent/\n";
    createTrash = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/mail/gmail/trash/\n";
    createSpam = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/mail/gmail/spam/\n";
    createCalendarGmail = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/calendars/gmail/\n";
    createContactsGmail = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/contacts/gmail/\n";
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
