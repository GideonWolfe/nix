{ pkgs, lib, stylix, config, ... }:

{
	# Set wallpaper
	#stylix.image = "${config.home.homeDirectory}/nix/system/graphics/wallpapers/zT7uCe2.png";	
	#stylix.image = ./zT7uCe2.png;	
	stylix.image = ../../system/graphics/wallpapers/zT7uCe2.png;	

	# Override scheme (as opposed to getting from image)
	stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

	stylix.polarity = "dark";

	stylix.fonts = {
		#serif = {
		#	package = pkgs.nerdfonts;
		#	name = "Hack Nerd Font";
		#};

		sansSerif = {
			package = pkgs.nerdfonts;
			name = "Hack Nerd Font";
		};

		monospace = {
			package = pkgs.nerdfonts;
			name = "Hack Nerd Font Mono";
		};

		# TODO this font isn't found, and gucharmap doesn't show it providing the emojis? 
		# But it shows up as installed
		emoji = {
			name = "Noto Emoji";
			package = pkgs.noto-fonts-monochrome-emoji;
		};

		# This DOES provide the monochrome symbols according to gucharmap
		# but for whatever reason colored emojis show up
		#emoji = {
			#name = "Symbola";
			#package = pkgs.symbola;
		#};

		sizes = {
			desktop = 13;
			applications = 15;
		};
	};

}
