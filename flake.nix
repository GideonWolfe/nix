{
  description = "first flake";

  inputs = {

    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-24.11"; };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    # Hyprpanel
    # Adding as flake until an official HM module is merged
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    # Theming engine
    stylix = {
      url = "github:danth/stylix/release-24.11";
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
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secret Management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, agenix, stylix, spicetify-nix, nixvim
    , hyprpanel, sops-nix, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      # Definitions for individual hosts
      nixosConfigurations = {

        # Original testing VM
        hermes = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            stylix.nixosModules.stylix
            agenix.nixosModules.default
            ./configs/hosts/hermes/configuration.nix
          ];
        };

        # Thinkpad T490
        poseidon = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            stylix.nixosModules.stylix
            agenix.nixosModules.default
            ./configs/hosts/poseidon/configuration.nix

            # TESTING HM MODULE
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.gideon.imports = [
                ./configs/users/gideon/home.nix
                ./configs/modules/configs/user/laptop-hyprpanel-layout/laptop-hyprpanel-layout.nix
                # agenix.homeManagerModules.age
                # nixvim.homeManagerModules.nixvim
                # spicetify-nix.homeManagerModules.default
                # hyprpanel.homeManagerModules.hyprpanel
              ];
            }
          ];
        };

        hades = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            stylix.nixosModules.stylix
            agenix.nixosModules.default
            sops-nix.nixosModules.sops
            ./configs/hosts/hades/configuration.nix

            # TESTING HM MODULE
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.gideon.imports = [
                ./configs/users/gideon/home.nix
                ./configs/hosts/hades/system/graphics/hades-hyprland-monitors.nix
                ./configs/hosts/hades/system/graphics/hades-hyprpanel-layout.nix
                # INFO: these got moved to home.nix!
                # agenix.homeManagerModules.age
                # nixvim.homeManagerModules.nixvim
                # spicetify-nix.homeManagerModules.default
                # hyprpanel.homeManagerModules.hyprpanel
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
            agenix.nixosModules.default
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
            agenix.homeManagerModules.age
            nixvim.homeManagerModules.nixvim
            spicetify-nix.homeManagerModules.default
            hyprpanel.homeManagerModules.hyprpanel
            ./configs/users/gideon/home.nix
          ];
        };

        # Specific HM config for my desktop
        # the exact same home.nix, but i'm adding my desktop hyprland monitor config
        # "gideon@hades" = home-manager.lib.homeManagerConfiguration {
        #   inherit pkgs;
        #   extraSpecialArgs = {
        #     inherit spicetify-nix;
        #     inherit inputs;
        #   };
        #   modules = [
        #     stylix.homeManagerModules.stylix
        #     agenix.homeManagerModules.age
        #     nixvim.homeManagerModules.nixvim
        #     spicetify-nix.homeManagerModules.default
        #     hyprpanel.homeManagerModules.hyprpanel
        #     ./configs/users/gideon/home.nix
        #     ./configs/hosts/hades/system/graphics/hades-hyprland-monitors.nix
        #     ./configs/hosts/hades/system/graphics/hades-hyprpanel-layout.nix
        #   ];
        #   # TODO: figure this out
        #   # modules = baseUserModules + [
        #   #   ./configs/users/gideon/home.nix
        #   #   ./configs/hosts/hades/system/graphics/hades-hyprland-monitors.nix
        #   #   ./configs/hosts/hades/system/graphics/hades-hyprpanel-layout.nix
        #   # ];
        # };

        # Specific HM config for my laptop
        # the exact same home.nix, but i'm adding my desktop hyprland monitor config
        # "gideon@poseidon" = home-manager.lib.homeManagerConfiguration {
        #   inherit pkgs;
        #   extraSpecialArgs = {
        #     inherit spicetify-nix;
        #     inherit inputs;
        #   };
        #   modules = [
        #     stylix.homeManagerModules.stylix
        #     agenix.homeManagerModules.age
        #     nixvim.homeManagerModules.nixvim
        #     spicetify-nix.homeManagerModules.default
        #     hyprpanel.homeManagerModules.hyprpanel
        #     ./configs/users/gideon/home.nix
        #     ./configs/modules/configs/user/laptop-hyprpanel-layout.nix
        #   ];
        # };

        # overseer = home-manager.lib.homeManagerConfiguration {
        #   inherit pkgs;
        #   extraSpecialArgs = {
        #     inherit spicetify-nix;
        #     inherit inputs;
        #   };
        #   modules = [
        #     stylix.homeManagerModules.stylix
        #     agenix.homeManagerModules.age
        #     nixvim.homeManagerModules.nixvim
        #     spicetify-nix.homeManagerModules.default
        #     ./configs/users/overseer/home.nix
        #   ];
        # };
      };
    };

}
