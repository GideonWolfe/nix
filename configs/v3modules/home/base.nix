{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  imports = [

    ###########
    # Modules #
    ###########
    inputs.nixvim.homeManagerModules.nixvim
    inputs.spicetify-nix.homeManagerModules.default
    #inputs.stylix.homeManagerModules.stylix

    ###############
    # Shell Stuff #
    ###############
    ./apps/shell/fish.nix # Primary shell
    ./apps/shell/bash.nix # backup shell
    ./apps/shell/starship.nix # gives a good prompt to bash and nix shells
    ./apps/zellij/zellij.nix # better screen/tmux
    ./apps/nh/nh.nix # wrapper for nix builds
    ./apps/zoxide/zoxide.nix # better cd
    ./apps/eza/eza.nix # better ls
    ./apps/bat/bat.nix # better cat
    ./apps/atuin/atuin.nix # TUI shell history

    ###############
    # Environment #
    ###############
    ./sessions/global/session-variables.nix # environment vars
    ./sessions/global/xdg-user-dirs.nix # default directories
    ./sessions/global/mimetypes.nix # default programs
    ./apps/gpg/gpg.nix # enable GPG to run

    ##############
    # UI/Desktop #
    ##############
    ./sessions/global/ui/stylix.nix



    ########################################
    # Themes and other application configs #
    ########################################
    ./apps/nixvim/nixvim.nix
    ./apps/btop/btop.nix # btop theme
    #./apps/git/git.nix
  ];
}
