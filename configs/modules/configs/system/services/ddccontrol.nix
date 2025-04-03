{ config, lib, pkgs, ... }:

{
  # Enable configuration of external displays (brightness, etc)
  services.ddccontrol.enable = true;
}
