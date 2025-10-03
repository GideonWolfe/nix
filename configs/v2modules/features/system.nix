{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let 
  cfg = config.custom.features.system;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.custom.features.system = {
    enable = lib.mkEnableOption "Base system configuration with Home Manager bootstrap and common system modules";
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
      # Font utilities
      gucharmap
      gnome-font-viewer
    ];

    # Essential fonts for all systems
    fonts.packages = with pkgs; [
      # collection of patched fonts
      nerd-fonts.hack
      # symbols and emoji (outlined)
      noto-fonts-monochrome-emoji
      # Font Awesome
      font-awesome
      font-awesome_5
    ];

    # Enable flakes by default
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    # Allow unfree packages by default
    nixpkgs.config.allowUnfree = true;
    
    # Set default console keymap
    console.keyMap = "us";
  };
}
