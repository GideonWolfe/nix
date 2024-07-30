{ config, lib, pkgs, ... }:

{
  # Fan control
  hardware.fancontrol = {
    enable = true;
    config = '' 
    '';
  };
  services.hddfancontrol = {
    enable = true;
  };

}
