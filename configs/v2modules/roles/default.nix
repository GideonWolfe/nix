{ config, lib, pkgs, inputs, ... }:

let 
  cfg = config.defaultRole;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.defaultRole = {
    enable = lib.mkEnableOption "Default system configuration with Home Manager bootstrap and common system modules";
  };

  config = lib.mkIf cfg.enable {
    # Bootstrap Home Manager for other roles to use
    home-manager = {
      useGlobalPkgs = false;
      useUserPackages = true;
      backupFileExtension = "hm-backup";
      extraSpecialArgs = { inherit inputs; };
    };

    # Essential system packages that all systems should have
    environment.systemPackages = with pkgs; [
      vim
      git
      curl
      wget
      htop
      tree
    ];

    # Enable flakes by default
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    # Allow unfree packages by default
    nixpkgs.config.allowUnfree = true;
    
    # Set default console keymap
    console.keyMap = "us";
  };
}
