{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Greeter daemon for login sessions
    #greetd.greetd
    # actual greeter
    #greetd.tuigreet
    # Lockscreen
    #swaylock

    # Boot splash
    plymouth
    adi1090x-plymouth-themes

    # Nix tools
    nix-tree # browse dependencies of nix store
    nix-output-monitor # adds visuals to build outputs

    nixos-anywhere # install Nix on fresh machines
    deploy-rs # just to make the binary available, can still use nix run and the flake URL

    # backup CLI
    restic

    # make secrets available to apps
    gnome-keyring

    # Terminals
    alacritty
    foot # default wayland/sway term
    kitty

    libgtop # library for system monitoring (used by hyprpanel)
    light # utility for changing backlight brightness

    # Utilities
    bc # calculator
    bat # better cat
    bat-extras.batman
    bat-extras.batpipe
    bat-extras.batgrep
    bat-extras.batdiff
    bat-extras.batwatch
    bat-extras.prettybat
    csview # cat out CSV files
    imv # like mpv for images
    fd # better find
    lnav # logfile viewer
    gnome-logs # GUI logfile viewer
    sysz # fzf for systemctl
    moreutils # additional unix tools
    s-tui # TUI stress tester
    #rofi
    wofi
    bemenu # like dmenu, required by sth
    scrot # screenshot
    flameshot # screenshot GUI
    swappy # screenshot GUI
    hyprshot # screenshot tool
    #speedtest-cli #BUG: this 403s?
    speedtest-rs
    #BUG: conflicts with "speedtest" command offered by speedtest-cli
    speedtest # GTK frontend for librespeed
    xdg-user-dirs # change default user directoryies
    xdg-utils
    fzf
    gucharmap # Unicode character viewer
    gnome-font-viewer
    tldr # better man pages with examples
    espeak
    libsForQt5.qt5.qttools # toolset that includes qdbusviewer
    libsForQt5.qt5.qtwayland # wayland compatibility
    bustle # GTK app for viewing DBUS activity
    gpg-tui # TUI for GnuPG
    f3d # lightweight 3D model viewer
    #appimage-run # run appimages without dependency errors from nix

    pstree # process tree

    # Notification daemon
    libnotify

    # Virtualization service
    qemu
    nemu # TUI for qemu
    bottles # Wine prefix manager GUI

    # Utils
    slurp # select region in wayland compositor (like slop for X)
    wayland-utils
    wf-recorder # screen recorder util
    hyprpicker # wayland color picker
    grimblast # hyprland screenshot helper

    # Replacements for various X utils
    wev # wayland xev
    wlprop # wayland xprop
    evtest # event tester like wev but picks up things wev doesn't?
    ydotool # (wayland xdotool)
    wl-clipboard # wayland xclip
    wdisplays
  ];
}
