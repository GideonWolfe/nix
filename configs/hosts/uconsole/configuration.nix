{ lib, modulesPath, pkgs, config, inputs, ... }: {

  # grabbing the official nixpkgs module for digital ocean
  imports = [

  ];

  networking.hostName = "uconsole"; # Define your hostname.

  users.users.gideon = {
    home = "/home/gideon";
    isNormalUser = true;
    shell = pkgs.fish;
    initialPassword = "pw123";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
    ];
    packages = with pkgs; [ neovim tree cowsay sysz ];
    openssh = {
      authorizedKeys.keys = [ config.local.ssh.keys.gideon_ssh_sk ];
    };
  };

  # enable fish systemwide
  programs.fish.enable = true;

  system.stateVersion = "25.05";
}
