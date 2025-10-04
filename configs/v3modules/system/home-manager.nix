{ config, lib, pkgs, inputs, ... }:

# Set some basic home manager settings
{
    imports = [
        home-manager.nixosModules.home-manager
    ];

    home-manager.useGlobalPkgs = false;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "hm-backup";
}