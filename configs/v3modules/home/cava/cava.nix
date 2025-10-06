{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.cava = {
		enable = true;
		settings = {
			general = {
				framerate = 80;
				bar_width = 1;
				bar_spacing = 1;
			};

			# TODO add after colors
			color = {
				gradient = 1;
				gradient_count = 4;
				gradient_color_1 = "'${base0E}'";
				gradient_color_2 = "'${base0B}'";
				gradient_color_3 = "'${base0A}'";
				gradient_color_4 = "'${base06}'";
			};

			output = {
				method = "ncurses";
				channels = "mono";
			};

			smoothing = {
				integral = 85;
				gravity = 100;
			};
		};

	};
}
