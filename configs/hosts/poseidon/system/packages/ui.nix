{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [

    # XDG portals
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    lxqt.xdg-desktop-portal-lxqt
    xdg-desktop-portal-kde

    # Window manager
    hyprland
    sway

    # Right click menu
    # this should be kando which is more recent
    #gnomeExtensions.fly-pie

    # Bar
    waybar
    wttrbar # weather status for waybar
    # TODO: this is a hack to account for the antipattern in the docs
    # https://github.com/Jas-SinghFSU/HyprPanel?tab=readme-ov-file#nixos--home-manager
    # instead of using an overlay, I pass hyprpanel as an output and reference it like this
    inputs.hyprpanel.packages.${pkgs.system}.default


    # Display configuration service
    kanshi
    wdisplays

    # Utils
    slurp # select region in wayland compositor (like slop for X)
    wayland-utils
    wf-recorder # screen recorder util
    hyprpicker # wayland color picker
    grimblast # hyprland screenshot helper
  ];
}
