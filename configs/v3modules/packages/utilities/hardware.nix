{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [

    # Hardware 
    light # utility for changing backlight brightness
    piper # GTK frontend to configure mice
    solaar # GUI for Logitech Unifying Reciever config
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
    s-tui # TUI stress tester
    # Yubikey stuff
    yubioath-flutter # Yubikey authenticator/manager
    yubikey-manager # CLI manager

  ];
}
