{ config, lib, pkgs, ... }:

{
  # Enable udisks to automount disks
  services.udisks2.enable = true;

}
