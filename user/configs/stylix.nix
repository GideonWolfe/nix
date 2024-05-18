{ pkgs, lib, stylix, ... }:

{
	# Set wallpaper
	#stylix.image = /home/gideon/pictures/wallpapers/YxvmITo.jpg;	
	stylix.image = ./zT7uCe2.png;	

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

		emoji = {
			name = "Symbola";
			package = pkgs.symbola;
		};

		sizes = {
			desktop = 13;
			applications = 15;
		};
	};

}
