{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Greeter daemon for login sessions
    greetd.greetd
    # actual greeter
    greetd.tuigreet
    # Lockscreen
    #swaylock
    swaylock-effects
    # Boot splash
    plymouth
    adi1090x-plymouth-themes

    # Agenix client for secret management
    #inputs.agenix.packages."${system}".default
    sops

    # Yubikey stuff
    yubioath-flutter # Yubikey authenticator/manager
    yubikey-manager # CLI manager

    # Manage user configs
    # this bootstraps so we can build HM config (which also installs/enables hm)
    home-manager

    # Nix tools
    nix-tree # browse dependencies of nix store
    nix-output-monitor # adds visuals to build outputs

    # backup CLI
    restic

    # make secrets available to apps
    gnome-keyring

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
    unrar
    unzip
    libsForQt5.ark # advanced archive manager, haven't figured out KDE theming yet
    file-roller # archive utility
    zip
    p7zip
    czkawka # duplicate file finding GUI
    szyszka # bulk file renamer GUI
    file
    ripgrep # better grep
    clapgrep # GUI ripgrep
    xcp # better cp

    gnome-decoder # QR code GUI
    gnome-clocks # GUI for clocks/timers/alarms

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
    netscanner # network scanner
    wavemon # network monitor
    flent # Advanced network tester CLI and GUI
    netperf # util to measure network performance (required by flent)
    http-getter # (required by flent)
    trippy
    ktop # kubernetes monitor
    kernelshark # GUI kernel monitor
    sysdig # advanced system tracing tool
    kmon # TUI kernel monitor
    glances # system/process monitor
    bmon # bandwidth monitor
    nload # network load monitor
    oha # HTTP monitor/tester
    nmon # system monitor
    powertop # power analyzer (intel laptops)
    lm_sensors # hardware sensors
    hddtemp # display hard disk temps
    pkgtop # TUI package monitor
    cpupower-gui # GUI for tweaking CPU
    hardinfo2 # GUI for devices/hardware
    hwinfo # get info about hardware
    resources # hardware monitoring GUI
    zenith # another TUI system monitor
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
    speedtest-cli
    #BUG: conflicts with "speedtest" command offered by speedtest-cli
    #speedtest # GTK frontend for librespeed
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
    #dunst
    #mako

    # Disk Automount daemon
    udiskie

    # Print daemon
    cups

    # Idle Daemon for Wayland
    swayidle

    # Virtualization service
    #libvirt
    #virt-manager
    qemu
    nemu # TUI for qemu
    bottles # Wine prefix manager GUI

    # Alternate shells
    fish
    fishPlugins.done

    # Collection of colorschemes
    base16-schemes

    # Filesystem Utilities
    ntfs3g # NTFS driver
    gparted
    gnome-disk-utility
    gdu # disk usage analyzer TUI
    baobab # disk usage analyzer GUI
    dysk # better df
    #ventoy # create bootable USBs #INFO: MARKED INSECURE
    impression # GNOME util to quickly burn ISOs
    simple-mtpfs # mount cell phone filesystems
    dosfstools # drivers for DOS filesystems
    uefitool # GUI for manipulating and viewing UEFI firmware files

    # Hardware 
    piper # GTK frontend to configure mice
    #solaar # GUI for Logitech Unifying Reciever config
    antimicrox # GUI for mapping buttons on input devices
    steamcontroller # drivers for the steam controller
    openrgb-with-all-plugins # OpenRGB
    #lact # GUI for AMD GPU control
    #nvitop # Interactive TUI for Nvidia GPU control # this may need additional plugins to detect other GPUs, check package list
    nvtopPackages.full # GPU monitor
    gpu-viewer # GUI for GPU info
    pciutils # providing utils for PCI devices such as lspci command
    #vial # QMK fork and GUI for keyboard configuration
    gsmartcontrol # GUI for smartmontools hard drive health
    kdiskmark # disk benchmark GUI
    dualsensectl # CLI interface for controlling Sony Dualsense controllers
    ddcui # GUI for controlling DDC compatible external displays (gddcontrol comes default but segfaults)
    simple-scan # GNOME GUI for document scanner
    gnome-firmware # GUI for installing device firmware
    gnome-tecla # GUI for viewing keyboard layout
    usbutils # adds utilities like lsusb

    # File managers
    ranger
    xfce.thunar
    xfce.thunar-volman # allow thunar to manage removable drives
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin # we have easytag for this but it doesn't hurt
    nautilus
    sushi # quick preview for nautilus
    tuifimanager # GUI like fm in the TUI

    # Replacements for various X utils
    wev # wayland xev
    evtest # event tester like wev but picks up things wev doesn't?
    ydotool # (wayland xdotool)
    wl-clipboard # wayland xclip

    # Clipboard history tool
    clipse # TUI

    # Icon set
    #papirus-icon-theme
    #papirus-folders

    weechat

    # List open files
    lsof

  ];

  fonts.packages = with pkgs; [
    # collection of patched fonts
    nerd-fonts.hack
    #noto-fonts
    # symbols and emoji (outlined)
    #symbola
    noto-fonts-monochrome-emoji
    # chinese, japanese, korean
    #noto-fonts-cjk
    #noto-fonts-cjk-sans
    #noto-fonts-cjk-serif
    # Font Awesome
    font-awesome
    font-awesome_5
  ];
}
