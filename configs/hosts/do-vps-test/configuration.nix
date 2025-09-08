{ lib, modulesPath, pkgs, config, ... }: {

  # grabbing the official nixpkgs module for digital ocean
  imports = [
    "${modulesPath}/virtualisation/digital-ocean-config.nix"
    ../../modules/keys/ssh.nix # access to my keys
  ];

  # virtualisation.digitalOcean = {
  #       # Allow setting SSH keys from DigitalOcean metadata
  #       #TEST: does this take from the key we selected during droplet creation?
  #       setSshKeys = true;
  #   };

  # maybe this makes SSH work?
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix = {
    settings = {
      tarball-ttl = 300;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      #PermitRootLogin = "no";
    };
  };

  networking.useDHCP = lib.mkForce false;

  # Digitalocean stuff
  # https://github.com/nix-community/nixos-anywhere-examples/blob/main/digitalocean.nix

  services.cloud-init = {
    enable = true;
    network.enable = true;
    settings = {
      #networking.enable = true;
      datasource_list = [ "ConfigDrive" "Digitalocean" ];
      datasource.ConfigDrive = { };
      datasource.Digitalocean = { };
      # Based on https://github.com/canonical/cloud-init/blob/main/config/cloud.cfg.tmpl
      cloud_init_modules = [
        "seed_random"
        "bootcmd"
        "write_files"
        "growpart"
        "resizefs"
        "set_hostname"
        "update_hostname"
        # Not support on NixOS
        #"update_etc_hosts"
        # throws error
        #"users-groups"
        # tries to edit /etc/ssh/sshd_config
        #"ssh"
        "set_password"
      ];
      cloud_config_modules = [
        "ssh-import-id"
        "keyboard"
        # doesn't work with nixos
        #"locale"
        "runcmd"
        "disable_ec2_metadata"
      ];
      ## The modules that run in the 'final' stage
      cloud_final_modules = [
        "write_files_deferred"
        "puppet"
        "chef"
        "ansible"
        "mcollective"
        "salt_minion"
        "reset_rmc"
        # install dotty agent fails
        #"scripts_vendor"
        "scripts_per_once"
        "scripts_per_boot"
        # /var/lib/cloud/scripts/per-instance/machine_id.sh has broken shebang
        #"scripts_per_instance"
        "scripts_user"
        "ssh_authkey_fingerprints"
        "keys_to_console"
        "install_hotplug"
        "phone_home"
        "final_message"
      ];
    };
  };
  #

  networking.hostName = "wumpus"; # Define your hostname.

  users.users.gideon = {
    home = "/home/gideon";
    isNormalUser = true;
    shell = pkgs.fish;
    initialPassword = "pw123";
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
    ];
    packages = with pkgs; [ neovim tree cowsay ];
    openssh = {
      authorizedKeys.keys = [ config.local.ssh.keys.gideon_ssh_sk ];
    };
  };

  # enable fish systemwide
  programs.fish.enable = true;

  system.stateVersion = "25.05";
}
