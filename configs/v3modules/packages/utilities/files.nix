{ config, lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [

    # File Operations
    unrar
    unzip
    file-roller # archive utility
    zip
    p7zip
    czkawka # duplicate file finding GUI
    szyszka # bulk file renamer GUI
    file
    ripgrep # better grep
    clapgrep # GUI ripgrep
    xcp # better cp

    # Filesystem Utilities
    ntfs3g # NTFS driver
    gparted
    gnome-disk-utility
    gdu # disk usage analyzer TUI
    baobab # disk usage analyzer GUI
    dysk # better df
    impression # GNOME util to quickly burn ISOs
    simple-mtpfs # mount cell phone filesystems
    dosfstools # drivers for DOS filesystems
    uefitool # GUI for manipulating and viewing UEFI firmware files

    # File managers
    ranger
    xfce.thunar
    xfce.thunar-volman # allow thunar to manage removable drives
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin # we have easytag for this but it doesn't hurt
    libsForQt5.ark # advanced archive manager, haven't figured out KDE theming yet
    nautilus
    sushi # quick preview for nautilus
    tuifimanager # GUI like fm in the TUI

    # List open files
    lsof

    # backup CLI
    restic

  ];
}
