{ lib, config, inputs, ... }:

let

  #TODO: how to use?
  pkgDir = "../../modules/packages/user";

in {

  imports = [

    ############
    # PACKAGES #
    ############

    #Theming
    ../../modules/packages/user/theming.nix

    # Web
    ../../modules/packages/user/productivity/web.nix

    # Audio
    ../../modules/packages/user/productivity/audio.nix

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

    # Nix theming framwork
    ./configs/stylix.nix

    # user specific git config
    #./configs/git.nix

  ];

  # enable unfree package use with home manager (ie stylix referencing symbola font which is unfree)
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gideon";
  home.homeDirectory = "/home/gideon";

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
