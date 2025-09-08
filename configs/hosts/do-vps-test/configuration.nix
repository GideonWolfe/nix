{ lib, modulesPath, pkgs, disko, ... }: {

  # grabbing the official nixpkgs module for digital ocean
  imports = [ "${modulesPath}/virtualisation/digital-ocean-config.nix" ];

  # virtualisation.digitalOcean = {
  #       # Allow setting SSH keys from DigitalOcean metadata
  #       #TEST: does this take from the key we selected during droplet creation?
  #       setSshKeys = true;
  #   };
  services.cloud-init = {
    enable = true;
    networking.enable = true;
  };

  disko.devices.disk = {
    disk0 = {
      device = "/dev/vda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            type = "efi";
            size = "512M";
            content = {
              type = "filesystem";
              format = "fat32";
              mountpoint = "/boot";
            };
          };
          root = {
            type = "linux";
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };

  #networking.useDHCP = lib.mkForce false;

  # Digitalocean stuff
  # https://github.com/nix-community/nixos-anywhere-examples/blob/main/digitalocean.nix

  # services.cloud-init = {
  #   enable = true;
  #   networking.enable = true;
  #   settings = {
  #     datasource_list = [ "ConfigDrive" "Digitalocean" ];
  #     datasource.ConfigDrive = { };
  #     datasource.Digitalocean = { };
  #     # Based on https://github.com/canonical/cloud-init/blob/main/config/cloud.cfg.tmpl
  #     cloud_init_modules = [
  #       "seed_random"
  #       "bootcmd"
  #       "write_files"
  #       "growpart"
  #       "resizefs"
  #       "set_hostname"
  #       "update_hostname"
  #       # Not support on NixOS
  #       #"update_etc_hosts"
  #       # throws error
  #       #"users-groups"
  #       # tries to edit /etc/ssh/sshd_config
  #       #"ssh"
  #       "set_password"
  #     ];
  #     cloud_config_modules = [
  #       "ssh-import-id"
  #       "keyboard"
  #       # doesn't work with nixos
  #       #"locale"
  #       "runcmd"
  #       "disable_ec2_metadata"
  #     ];
  #     ## The modules that run in the 'final' stage
  #     cloud_final_modules = [
  #       "write_files_deferred"
  #       "puppet"
  #       "chef"
  #       "ansible"
  #       "mcollective"
  #       "salt_minion"
  #       "reset_rmc"
  #       # install dotty agent fails
  #       #"scripts_vendor"
  #       "scripts_per_once"
  #       "scripts_per_boot"
  #       # /var/lib/cloud/scripts/per-instance/machine_id.sh has broken shebang
  #       #"scripts_per_instance"
  #       "scripts_user"
  #       "ssh_authkey_fingerprints"
  #       "keys_to_console"
  #       "install_hotplug"
  #       "phone_home"
  #       "final_message"
  #     ];
  #   };
  # };
  #

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "wumpus"; # Define your hostname.

  users.users.gideon = {
    home = "/home/gideon";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "docker" # Let the user run docker commands
    ];
    packages = with pkgs; [ neovim tree ];
  };

  # enable fish systemwide
  programs.fish.enable = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
