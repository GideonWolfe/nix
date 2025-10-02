{ config, lib, pkgs, ... }:

{
  # Test user definition - self-contained
  options.custom.userPresets.test = lib.mkOption {
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
      secretsFile = null; # Test user has no secrets by default
      homeManagerConfig = {
        imports = [
          ../../configs/user/common.nix
        ];
        # Test user specific home-manager config
      };
    };
    description = "Test user preset configuration";
  };
}
