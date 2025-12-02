{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  programs.television = {
	enable = true;
	enableFishIntegration = true;
	channels = {
	  nix-search-tv = {
	    cable_channel = [
	      {
		name = "nixpkgs";
		source_command = "nix-search-tv print";
		preview_command = "nix-search-tv preview {}";
	      }
	    ];
	  };
	};
  };
}
