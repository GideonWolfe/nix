{
  description = "first flake";

  inputs = {

    nixpkgs = {
      #url = "github:NixOS/nixpkgs/nixos-24.11"; 
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };

    home-manager = {
      #url = "github:nix-community/home-manager/release-24.11";
      url = "github:nix-community/home-manager/release-25.05";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    # Hyprpanel
    # Adding as flake until an official HM module is merged
    #hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    # Theming engine
    stylix = {
      #url = "github:danth/stylix/release-24.11";
      url = "github:nix-community/stylix/release-25.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    # Spotify theme
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Configure neovim with Nix!
    nixvim = {
      #url = "github:nix-community/nixvim/nixos-24.11";
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secret Management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # cool visualizer
    xyosc = { url = "github:make-42/xyosc"; };

    dsd-fme = { url = "github:lwvmobile/dsd-fme"; };

    # provides some AI tools like crush (maybe redundant later)
    nix-ai-tools.url = "github:numtide/nix-ai-tools";

  };

  outputs = { self, nixpkgs, home-manager, stylix, spicetify-nix, nixvim
    , sops-nix, xyosc, dsd-fme, nix-ai-tools, disko, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      # Definitions for individual hosts
      nixosConfigurations = {

        do-vps-test = lib.nixosSystem {
          #inherit system;
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./configs/hosts/do-vps-test/disko.nix
            ./configs/hosts/do-vps-test/configuration.nix
          ];
        };

        # Original testing VM
        hermes = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            stylix.nixosModules.stylix
            ./configs/hosts/hermes/configuration.nix
          ];
        };

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
    };

}
