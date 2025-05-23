{ config, lib, pkgs, inputs, ... }:

{
  # XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.lxqt.xdg-desktop-portal-lxqt
    ];
  };
  xdg.portal.wlr.enable = true;
  xdg.portal.lxqt.enable = true;

}
