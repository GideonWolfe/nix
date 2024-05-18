{ config, pkgs, ... }:

{

  imports = [
    ############
    # PACKAGES #
    ############

    #Theming
    ./user/packages/theming.nix

    # Web
    ./user/packages/web.nix

    # Audio
    ./user/packages/audio.nix
    
    # Video
    ./user/packages/video.nix

    # Art
    ./user/packages/art.nix

    # Science
    ./user/packages/science.nix

    # Engineering
    ./user/packages/engineering.nix

    # Development
    ./user/packages/development/rust.nix
    ./user/packages/development/utils.nix

    # Random fun packages
    ./user/packages/fun.nix

    # Productivity packages
    ./user/packages/productivity.nix

    # My wallpapers
    ./user/packages/wallpapers.nix

    ###########
    # CONFIGS #
    ###########

    # Hyprland
    # Enable when ready for it
    ./user/configs/hyprland.nix
    ./user/configs/sway.nix

    # Waybar
    ./user/configs/waybar.nix

    # Custom user directories
    ./user/configs/xdg-user-dirs.nix

    # Better CD
    ./user/configs/zoxide.nix

    # Better LS
    ./user/configs/eza.nix

    # Screenshotting tool
    ./user/configs/flameshot.nix

    # Cava
    ./user/configs/cava.nix

    # Git
    ./user/configs/git.nix

    # SSH
    ./user/configs/ssh/ssh.nix

    # Shell config
    ./user/configs/fish.nix

    # Notification client
    ./user/configs/mako.nix

    # Nix theming framwork
    ./user/configs/stylix.nix

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
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
