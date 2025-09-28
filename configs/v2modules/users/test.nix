{ config, lib, pkgs, ... }:

{
  # System user configuration
  users.users.test = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ 
      "wheel" 
      "docker"    # For development/ai role
    ];
    initialPassword = "test"; # For testing only
  };

  # Home-manager configuration for this user
  home-manager.users.test = {
    home.stateVersion = "25.05";
    
    # User-specific home manager settings can go here
    # The roles will automatically enable relevant modules
  };
}
