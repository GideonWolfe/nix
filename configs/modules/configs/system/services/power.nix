{ config, lib, pkgs, ... }:

{
  # allows to control pwer based on user defined profiles (required for hyprpanel battery modules )
  services.power-profiles-daemon.enable = true;
  # power control support for applications (required for hyprpanel battery modules )
  services.upower.enable = true;
}
