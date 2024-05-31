{
	description = "first flake";

	inputs = {
		nixpkgs = {
			url = "github:NixOS/nixpkgs/nixos-23.11";
		};

		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			inputs = {
				nixpkgs.follows = "nixpkgs";
			};
		};

		# Overriding hyperland package to get more opts
		#hyprland.url = "github:hyprwm/Hyprland";


		stylix = {
			url = "github:danth/stylix/release-23.11";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";
			};
		};

		spicetify-nix = {
			url = "github:the-argus/spicetify-nix";
		};

		# Configure neovim with Nix!
		nixvim = {
			url = "github:nix-community/nixvim/nixos-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};


	};

	outputs = {self, nixpkgs, home-manager, stylix, spicetify-nix, nixvim, ...} @inputs:
		let 
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
		nixosConfigurations = {

			hermes = lib.nixosSystem {
				inherit system;
				specialArgs = {inherit inputs;};
				# pass in stylix theming modules for system level theming (bootloaders, etc)
				modules = [stylix.nixosModules.stylix ./configuration.nix];
				#modules = [./configuration.nix];
			};
		};
		homeConfigurations = {
			gideon = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = {inherit spicetify-nix;};
				# pass in stylix theming modules for user apps
				modules = [stylix.homeManagerModules.stylix nixvim.homeManagerModules.nixvim ./home.nix];
			};
		};

	};

}
