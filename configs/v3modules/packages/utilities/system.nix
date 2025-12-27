{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [

    # Boot splash
    # Possibly implicitly required by plymouth config?
    plymouth
    adi1090x-plymouth-themes

    #############
    # Nix Tools #
    #############
    nix-tree # browse dependencies of nix store
    nix-output-monitor # adds visuals to build outputs
    nixos-anywhere # install Nix on fresh machines
    deploy-rs # just to make the binary available, can still use nix run and the flake URL

    ###############
    # Linux Utils #
    ###############
    xdg-user-dirs # change default user directoryies
    xdg-utils
    gnome-logs # GUI logfile viewer
    libnotify


    # make secrets available to apps
    # should be installed by gnome-keyring service
    #gnome-keyring


    ########
    # DBUS #
    ########
    bustle # GTK app for viewing DBUS activity
    libsForQt5.qt5.qttools # toolset that includes qdbusviewer

    #################
    # App Launchers #
    #################
    wofi
    bemenu # like dmenu, required by sth

    #appimage-run # run appimages without dependency errors from nix

    ###########
    # Viewers #
    ###########
    imv # like mpv for images
    f3d # lightweight 3D model viewer

    ##################
    # Virtualization #
    ##################
    qemu
    nemu # TUI for qemu
    bottles # Wine prefix manager GUI
    distrobox # container manager for dev environments

    ###############
    # Screenshots #
    ###############
    swappy # screenshot GUI
    hyprshot # screenshot tool
    grimblast # hyprland screenshot helper

    #################
    # Wayland Utils #
    #################
    wev # wayland xev
    wlprop # wayland xprop
    evtest # event tester like wev but picks up things wev doesn't?
    ydotool # (wayland xdotool)
    wl-clipboard # wayland xclip
    wdisplays
    wayland-utils
    slurp # select region in wayland compositor (like slop for X)
    wf-recorder # screen recorder util
    hyprpicker # wayland color picker
    libsForQt5.qt5.qtwayland # wayland compatibility
  ];
}
