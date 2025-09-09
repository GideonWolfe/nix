{ lib, modulesPath, pkgs, config, inputs, ... }: {

  # grabbing the official nixpkgs module for digital ocean
  imports = [

    # Nix Maintained DigitalOcean configs
    "${modulesPath}/virtualisation/digital-ocean-config.nix"
    
    # my public keys
    ../../modules/keys/ssh.nix
    # infra variables
    ../../modules/world.nix
    # config for this specific system

    # Secrets
    ./vps_sops.nix # imports other modules and sets secret file

    # Applications
    ./grafana.nix # Run Grafana on this system
    ./prometheus.nix
  ];


  #sops = {

  #};

  services.traefik = {
    enable = true;

    # Give traefik access to digitalocean api key
    environmentFiles = [ config.sops.secrets."traefik/env".path ];

    staticConfigOptions = {

      log = {
        #level = "ERROR";
        level = "DEBUG";
      };

      api = {
        dashboard = true;
        insecure = true;
      };
      certificatesResolvers.myresolver.acme = {
        email = config.local.world.email.infra_email.address;
        storage = "/var/lib/traefik/gideonwolfe.json";
        tlsChallenge = true;
        dnsChallenge = { provider = "digitalocean"; };
      };

      entryPoints = {
        http = {
          address = ":80";
          forwardedHeaders.insecure = true;
          http.redirections.entryPoint = {
            to = "https";
            scheme = "https";
          };
        };
        https = {
          address = ":443";
          forwardedHeaders.insecure = true;
        };
      };
    };
  };

  # maybe this makes SSH work?
  networking.firewall.allowedTCPPorts = [ 22 80 443 ]; # 3000 for Grafana

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
      warn-dirty = false;
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
