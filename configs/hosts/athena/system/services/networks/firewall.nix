{ config, lib, pkgs, ... }:

{
    networking.firewall.allowedTCPPorts = [ 80 8080 ];
}
