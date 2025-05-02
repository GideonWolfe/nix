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
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    #ags.url = "github:Aylur/ags";

    stylix = {
      url = "github:danth/stylix/release-24.11";
      # url = "github:gideonwolfe/stylix/foliate";
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
    , hyprpanel, ... }@inputs:
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

        hades = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            stylix.nixosModules.stylix
            agenix.nixosModules.default
            ./configs/hosts/hades/configuration.nix
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
        "gideon@hades" = home-manager.lib.homeManagerConfiguration {
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
            ./configs/hosts/hades/system/graphics/hades-hyprland-monitors.nix
            ./configs/hosts/hades/system/graphics/hades-hyprpanel-layout.nix
          ];
        };

        # Specific HM config for my laptop
        # the exact same home.nix, but i'm adding my desktop hyprland monitor config
        "gideon@poseidon" = home-manager.lib.homeManagerConfiguration {
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
            ./configs/modules/configs/user/laptop-hyprpanel-layout.nix
          ];
        };

        overseer = home-manager.lib.homeManagerConfiguration {
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
            ./configs/users/overseer/home.nix
          ];
        };
      };
    };

}
