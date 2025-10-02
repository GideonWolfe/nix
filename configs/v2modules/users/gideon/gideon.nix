{ config, lib, pkgs, ... }:

{
  # Gideon user definition - self-contained
  options.custom.userPresets.gideon = lib.mkOption {
    type = lib.types.attrs;
    readOnly = true;
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
        # Yubikey Public Key
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKZGmiV6gXdzztdYoqrZDbFqAHpM+5rMgmQZ+6gpR98xAAAACnNzaDpnaWRlb24="
      ];
      secretsFile = ../../../secrets/gideon_secrets.yaml;
      homeManagerConfig = {
        imports = [
          ../../configs/user/common.nix
        ];
        # Additional home-manager config specific to gideon can go here
      };
    };
    description = "Gideon user preset configuration";
  };
}
