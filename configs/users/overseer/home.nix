{ lib, config, inputs, ... }:

{

  imports = [
    # allow overseer to decode secrets
        #inputs.sops-nix.homeManagerModules.sops

    # grab gideon's secret defs
        #../gideon/configs/secrets/sops.nix
    ../gideon/configs/gpg/gpg.nix

    ############
    # PACKAGES #
    ############

    #Theming
    ./packages/theming.nix

    ###########
    # CONFIGS #
    ###########
    ../../modules/configs/user/common.nix

    # SSH
    ./configs/ssh/ssh.nix

    # Nix theming framwork
    ./configs/stylix.nix

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
