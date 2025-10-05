{ config, lib, pkgs, inputs, ... }:

# Set some basic home manager settings
{
    imports = [
        inputs.home-manager.nixosModules.home-manager
    ];

    home-manager.useGlobalPkgs = true;  # Use system-level pkgs (includes allowUnfree)
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "hm-backup";
}