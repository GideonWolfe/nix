{ config, lib, pkgs, ... }:

{
  # Helper functions to set predefined user configurations
  options.custom.userPresets = {
    gideon = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true; # NOTE: possibly remove?
      default = {
        name = "gideon";
        home = "/home/gideon";
        shell = pkgs.fish;
        initialPassword = "test"; # For testing only
        extraGroups = [
          "wheel"     # Enable 'sudo' for the user
          "docker"    # Let the user run docker commands  
          "dialout"   # let programs run by the user (like chirp) access USB ports
          "input"     # let programs run by the user (like chirp) access touchpad input (for fusuma gestures)
          "i2c"       # allow the user to control i2c devices like external displays through ddc
          "plugdev"   # needed for RTL-SDR
          "storage"   # needed for udisks/udiskie
        ];
        packages = with pkgs; [ firefox tree ];
        openssh.authorizedKeys = [
          # Example SSH public key - replace with actual key
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... gideon@example.com"
        ];
        homeManagerConfig = {
          imports = [
            ../configs/user/common.nix
          ];
          # Additional home-manager config specific to gideon can go here
        };
      };
      description = "Gideon user preset configuration";
    };

    test = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
      default = {
        name = "test";
        home = "/home/test";
        shell = pkgs.fish;
        extraGroups = [
          "wheel"   # Enable 'sudo' for the user
          "docker"  # For development/ai features
        ];
        initialPassword = "test"; # For testing only
        openssh.authorizedKeys = [
          # Example SSH public key for test user - replace with actual key
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... test@example.com"
        ];
        homeManagerConfig = {
          imports = [
            ../../configs/user/common.nix
          ];
          # Test user specific home-manager config
        };
      };
      description = "Test user preset configuration";
    };
  };
}
