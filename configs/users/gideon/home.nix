{ lib, config, inputs, ... }:

let

  #TODO: how to use?
  pkgDir = "../../modules/packages/user";

in {

  imports = [

    # Imports a list of all user based secrets
    # only the ones readable by this user will be generated
    #../../secrets/user_secrets.nix

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

    # Common user config
    ../../modules/configs/user/common.nix

    # Sops secret definitions
        #./configs/secrets/sops.nix

    # Personal SSH config
    ./configs/ssh/ssh.nix
    #../../modules/keys/ssh.nix

    # GPG settings
    ./configs/gpg/gpg.nix

    # Configs for calendar settings and sync
    ./configs/calendar/calendar.nix
    ./configs/calendar/khal.nix
    ./configs/calendar/calcure.nix

    # Configs for contacts settings and sync
    ./configs/contacts/contacts.nix
    ./configs/contacts/khard.nix

    # Neomutt
    ./configs/email/neomutt/neomutt.nix
    ./configs/email/thunderbird/thunderbird.nix # uses lots of storage
    ./configs/email/email.nix
    ./configs/email/mbsync.nix

    # Weechat
    ./configs/weechat/buflist.nix
    ./configs/weechat/weechat.nix

    # Nix theming framwork
    ./configs/stylix.nix

    # user specific git config
    ./configs/git.nix

    # TODO move this to common user
    ../../modules/configs/user/vdirsyncer/vdirsyncer.nix

    # Projects
    ../../modules/configs/user/projects/forgetter.nix
    ../../modules/configs/user/projects/science.nix
    ../../modules/configs/user/projects/art.nix
    ../../modules/configs/user/projects/photography.nix
    ../../modules/configs/user/projects/tech.nix
    ../../modules/configs/user/projects/music.nix

    # Thunderbird config and theme
    # TODO abstract to common, maybe rename profile?
    ../../modules/configs/user/thunderbird/thunderbird.nix

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
