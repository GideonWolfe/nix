{ pkgs, lib, ... }:

{
	programs.waybar = {
		enable = true;

		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				height = 30;
				#TODO configure these dynamically with zanshin
				#output = [
					#"eDP-1"
					#"HDMI-A-1"
				#];
				modules-left = [ 
					"sway/workspaces"
					"sway/mode"
					#"wlr/taskbar"
				];
				modules-center = [ 
					"sway/window"
				];
				modules-right = [ 
					"backlight/slider"
					"cava"
					"wireplumber"
					"mpris"
					#"bluetooth"
					"tray"
				];

				"sway/workspaces" = {
					disable-scroll = true;
					all-outputs = true;
				};

				"mpris" = {
					format = "{player_icon} {dynamic}";
					format-paused = "{status_icon} <i>{dynamic}</i>";
					player-icons = {
						default = "▶";
						mpv = "🎵";
						firefox = "";
						#vlc = "";
					};
					status-icons = {
						paused = "⏸";
						playing = "▶";
					};
					# ignored-players = [firefox];
				};

				"cava" = {
					method = "pipewire";
					framerate = 60;
					sensitivity = 100;
					bars = 10;
					bar_delimiter = 0; # 0=none
					autosens = 1;
					format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
					sleep_timer = 10;
					hide_on_silence = true;
					monstercat = true;
					waves = true;

				};
			};
		};

	};
}
