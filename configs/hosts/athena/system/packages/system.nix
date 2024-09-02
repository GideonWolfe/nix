{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [

    # To create partitions
    parted
    # To set up XFS on parity drives
    xfsprogs
    # Merger FS for data disks
    mergerfs
    mergerfs-tools

    # Greeter daemon for login sessions
    greetd.greetd
    # actual greeter
    greetd.tuigreet
    # Lockscreen
    #swaylock-effects
    # Boot splash
    #plymouth
    #adi1090x-plymouth-themes

    # Agenix client for secret management
    inputs.agenix.packages."${system}".default

    # Nix tools
    nix-tree # browse dependencies of nix store

    # make secrets available to apps
    gnome.gnome-keyring

    # Terminals
    alacritty
    foot # default wayland/sway term
    kitty

    chromium

    # Navigation
    tree
    eza # better ls (formerly exa)
    zoxide # better cd
    tmux
    screen

    # File Operations
    #unrar
    unzip
    libsForQt5.ark # advanced archive manager, haven't figured out KDE theming yet
    gnome.file-roller # archive utility
    zip
    czkawka # duplicate file finding GUI
    szyszka # bulk file renamer GUI
    file
    ripgrep

    # Monitors
    atop # system/process monitor
    btop
    htop # system/process monitor
    gotop # system/process monitor
    iotop # IO monitor
    ioping # IO latency monitor
    dnstop # DNS traffic monitor
    bandwhich # bandwidth monitor
    jnettop
    ktop # kernel monitor
    kernelshark # GUI kernel monitor
    glances # system/process monitor
    bmon # bandwidth monitor
    nload # network load monitor
    nmon # system monitor
    powertop # power analyzer (intel laptops)
    lm_sensors # hardware sensors
    hddtemp # display hard disk temps
    pkgtop # TUI package monitor
    cpupower-gui # GUI for tweaking CPU
    hardinfo # GUI for devices/hardware
    hwinfo # get info about hardware
    psensor # hardware monitoring GUI
    zenith # another TUI system monitor

    # Utilities
    bc # calculator
    bat # better cat
    csview # cat out CSV files
    imv # like mpv for images
    fd # better find
    lnav # logfile viewer
    sysz # fzf for systemctl
    moreutils # additional unix tools
    s-tui # TUI stress tester
    #rofi
    wofi
    bemenu # like dmenu, required by sth
    scrot # screenshot
    flameshot # screenshot GUI
    speedtest-cli
    xdg-user-dirs # change default user directoryies
    xdg-utils
    fzf
    gnome.gucharmap # Unicode character viewer
    gnome.gnome-font-viewer
    tldr # better man pages with examples
    espeak
    libsForQt5.qt5.qttools # toolset that includes qdbusviewer
    libsForQt5.qt5.qtwayland # wayland compatibility
    gpg-tui # TUI for GnuPG

    pstree # process tree

    # Notification daemon
    libnotify
    #dunst
    mako

    # Disk Automount daemon
    udiskie

    # Print daemon
    cups

    # Idle Daemon for Wayland
    swayidle

    # Virtualization service
    # TODO enable on real hardware
    #libvirt
    #virt-manager

    # Alternate shells
    fish
    fishPlugins.done

    # Collection of colorschemes
    base16-schemes

    # Filesystem Utilities
    ntfs3g # NTFS driver
    gparted
    gnome.gnome-disk-utility
    diskonaut # disk usage analyzer TUI
    baobab # disk usage analyzer GUI
    ventoy # create bootable USBs
    simple-mtpfs # mount cell phone filesystems
    dosfstools # drivers for DOS filesystems
    smartmontools # SMART disk monitoring
    gsmartcontrol # GUI for smart

    # Hardware 
    lact # GUI for AMD GPU control
    pciutils # providing utils for PCI devices such as lspci command
    #vial # QMK fork and GUI for keyboard configuration
    #yubikey-personalization-gui

    # File managers
    ranger
    xfce.thunar
    xfce.thunar-volman # allow thunar to manage removable drives
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin # we have easytag for this but it doesn't hurt

    # Replacements for various X utils
    wev # wayland xev
    ydotool # (wayland xdotool)
    wl-clipboard # wayland xclip

    nc4nix

    jq

    lazydocker

    # monitor data being sent through pipe
    pv
  ];

  fonts.packages = with pkgs; [
    # collection of patched fonts
    nerdfonts
    noto-fonts
    # symbols and emoji (outlined)
    symbola
    noto-fonts-monochrome-emoji
    # chinese, japanese, korean
    noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    # Font Awesome
    font-awesome
    font-awesome_5
  ];
}
