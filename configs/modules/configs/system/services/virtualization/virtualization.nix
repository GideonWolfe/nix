{ config, lib, pkgs, ... }:

{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "gideon" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
