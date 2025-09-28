{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [


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
