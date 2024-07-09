{
  description = "first flake";

  inputs = {

    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-24.05"; };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    # Overriding hyperland package to get more opts
    #hyprland.url = "github:hyprwm/Hyprland";

    stylix = {
      url = "github:danth/stylix/release-24.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    spicetify-nix = { url = "github:the-argus/spicetify-nix"; };

    # Configure neovim with Nix!
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, agenix, stylix, spicetify-nix, nixvim
    , ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      # Definitions for individual hosts
      nixosConfigurations = {

        hermes = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            stylix.nixosModules.stylix
            # agenix.nixosModules.default
            ./configs/hosts/hermes/configuration.nix
          ];
        };
      };

      # Definitions for individual users
      homeConfigurations = {
        gideon = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit spicetify-nix; };
          modules = [
            stylix.homeManagerModules.stylix
            #agenix.homeManagerModules.age
            agenix.homeManagerModules.default
            nixvim.homeManagerModules.nixvim
            ./configs/users/gideon/home.nix
          ];
        };
      };
    };

}
