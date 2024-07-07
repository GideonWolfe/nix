{ config, lib, pkgs, inputs, ... }:

let 
	tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
	hyprland-session = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions";
in
{
	# Enable greetd
	services.greetd = {
		enable = true;
		#settings = {
		#	default-session = {
		#		command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session}";
		#	};
		#};
		settings = {
			#initial_session = {
			#	command = "${pkgs.sway}/bin/sway";
			#	user = "gideon";
			#};
			#default_session = initial_session;
			default_session = {
				#command = "${tuigreet} --time --cmd ${pkgs.hyprland}/bin/Hyprland";
				command = "${tuigreet} --time --cmd ${pkgs.sway}/bin/sway";
				user = "greeter";

			};
		};
	};

}
