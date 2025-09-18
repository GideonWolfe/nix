{
  description = "first flake";

  inputs = {

    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-25.05"; };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    # NixOS hardware support for third party hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Theming engine
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    # Spotify theme
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Configure neovim with Nix!
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secret Management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Deployment tool
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # cool visualizer
    xyosc = { url = "github:make-42/xyosc"; };

    dsd-fme = { url = "github:lwvmobile/dsd-fme"; };

    # provides some AI tools like crush (maybe redundant later)
    nix-ai-tools.url = "github:numtide/nix-ai-tools";

  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, stylix, spicetify-nix
    , nixvim, sops-nix, deploy-rs, xyosc, dsd-fme, nix-ai-tools, disko, ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Import world configuration data for use in flake
      worldData = import ./configs/modules/world-data.nix;
    in {

      # Definitions for individual hosts
      nixosConfigurations = {

        do-vps-test = lib.nixosSystem {
          #inherit system;
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            #sops-nix.nixosModules.sops
            ./configs/modules/world.nix
            ./configs/hosts/do-vps-test/disko.nix
            # Changes through here will be applied during install AND colmena apply
            ./configs/hosts/do-vps-test/configuration.nix
          ];
        };

        # Original testing VM
        # hermes = lib.nixosSystem {
        #   inherit system;
        #   specialArgs = { inherit inputs; };
        #   modules = [
        #     stylix.nixosModules.stylix
        #     ./configs/hosts/hermes/configuration.nix
        #   ];
        # };

        uconsole = lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            nixos-hardware.nixosModules.raspberry-pi-4
            ./configs/hosts/uconsole/configuration.nix
          ];
        };
        # Convenience attribute to build the SD image
        images.uconsole =
          self.nixosConfigurations.uconsole.config.system.build.sdImage;

        # Thinkpad T490
        poseidon = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            stylix.nixosModules.stylix
            ./configs/hosts/poseidon/configuration.nix

            # TESTING HM MODULE
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.gideon.imports = [
                ./configs/users/gideon/home.nix
                ./configs/modules/configs/user/laptop-hyprpanel-layout/laptop-hyprpanel-layout.nix
              ];
            }
          ];
        };

        hades = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            stylix.nixosModules.stylix
            sops-nix.nixosModules.sops
            ./configs/modules/world.nix
            ./configs/hosts/hades/configuration.nix

            # TESTING HM MODULE
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.gideon.imports = [
                ./configs/users/gideon/home.nix
                ./configs/hosts/hades/system/hades-hyprland-monitors.nix
                ./configs/hosts/hades/system/hades-hyprpanel-layout.nix
              ];
            }
          ];
        };

        # Homeserver
        athena = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            stylix.nixosModules.stylix
            sops-nix.nixosModules.sops
            ./configs/hosts/athena/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.overseer.imports =
                [ ./configs/users/overseer/home.nix ];
            }
          ];
        };
      };

      # Definitions for individual users
      homeConfigurations = {
        gideon = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit spicetify-nix;
            inherit inputs;
          };
          modules = [
            stylix.homeManagerModules.stylix
            #agenix.homeManagerModules.age
            nixvim.homeManagerModules.nixvim
            spicetify-nix.homeManagerModules.default
            #hyprpanel.homeManagerModules.hyprpanel
            ./configs/users/gideon/home.nix
          ];
        };
      };

      # Deploy-rs configuration
      deploy.nodes.do-vps-test = {
        hostname = worldData.hosts.monitor.ip;
        fastConnection = false;
        profiles.system = {
          sshUser = "root";
          sshOpts = [ "-i" "/home/gideon/.ssh/gideon_ssh_sk" ];
          path = deploy-rs.lib.x86_64-linux.activate.nixos
            self.nixosConfigurations.do-vps-test;
          user = "root";
        };
      };

      # This is highly advised, and will prevent many possible mistakes
      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };

}
