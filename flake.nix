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

    # Overriding hyperland package to get more opts
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    #ags.url = "github:Aylur/ags";

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    #spicetify-nix = { url = "github:the-argus/spicetify-nix"; };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Configure neovim with Nix!
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, agenix, stylix, spicetify-nix, nixvim
    , hyprland, hyprland-plugins, hyprpanel, ... }@inputs:
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
            #hyprland.homeManagerModules.default
            stylix.homeManagerModules.stylix
            agenix.homeManagerModules.age
            nixvim.homeManagerModules.nixvim
            #ags.homeManagerModules.default
            spicetify-nix.homeManagerModules.default
            ./configs/users/gideon/home.nix
          ];
        };

        overseer = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            stylix.homeManagerModules.stylix
            agenix.homeManagerModules.age
            nixvim.homeManagerModules.nixvim
            ./configs/users/overseer/home.nix
          ];
        };
      };
    };

}
