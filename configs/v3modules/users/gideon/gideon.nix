{ config, lib, pkgs, ... }:

{
  # Configuration for the Gideon user on a SYSTEM level
  users.users.gideon = {
    home = "/home/gideon";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "docker" # Let the user run docker commands
      "dialout" # let programs run by the user (like chirp) access USB ports
      "input" # let programs run by the user (like chirp) access touchpad input (for fusuma gestures)
      "i2c"       # allow the user to control i2c devices like external displays through ddc
      "plugdev" # for RTL-SDR
      "storage" # for udiskie
    ];
    #packages = with pkgs; [ firefox vim tree ];
  };
}