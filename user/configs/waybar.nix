{ pkgs, lib, ... }:

{
	programs.waybar = {
		enable = true;

		# TODO finish styling
		# General colors are provided by stylix, these are overrides
		# This gets concatenated to ~/.config/waybar/style.css
		# this means we have access to @ vars from that css file
		#.modules-left #workspaces button.focused,
		#.modules-left #workspaces button.active {
		style = ''
		.modules-left #workspaces button {
			color: @base05;
		}
		.modules-left #workspaces button.focused,
		.modules-left #workspaces button.active {
			border-bottom: 3px solid @base08;
			color: @base0A;
		}
		'';

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
					#"sway/window"
					"clock"
				];
				modules-right = [ 
					"backlight/slider"
					"group/systemStats"
					"battery"
					"cava"
					"wireplumber"
					"mpris"
					#"bluetooth"
					"tray"
				];

				"group/systemStats" = {
					orientation = "vertical";
					modules = [
						"cpu"
						"memory"
						"disk"
					];
					drawer = {
						transition-duration = 500;
						transition-left-to-right = false;
						children-class = "test";
					};
				};
				"disk" = {
					format = " {percentage_used}%";
				};
				"memory" = {
					format = "{percentage}%";
				};
				"cpu" = {
					format = "{icon0} {icon1} {icon2} {icon3} {icon4} {icon5} {icon6} {icon7}";
					format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
				};
				
				"wireplumber" = {
					format = "{icon} {volume}%";
					on-click-middle = "qpwgraph";
					on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
					format-muted = "<span color='#FF0000'> {volume}%</span>";
					#format-icons = [ "" "" ""];
					format-icons = [ 
						"<span color='#FFFFFF'></span>"
						""
						""
					];
				};

				"sway/workspaces" = {
					disable-scroll = true;
					all-outputs = true;
					format = "{icon}";
					# Workspace Icons
					format-icons = {
						"1" = ""; # TODO this specific one doesn't show up
						"2" = "";
						"3" = "";
						"4" = "";
						"5" = "";
						"6" = "";
						"7" = "";
						"8" = "";
						"9" = "";
						# TODO this works for color but can't reference icon
						# I think waybar exposes CSS for it
						#"focused" = "<span color='#FFFFFF'>{icon}</span>";
						#"urgent" = "";
						#"default" = "";
					};
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

				"clock" = {
					interval = 60;
					tooltip = true;
					format = "{:%H:%M}";
					#TODO this should work but I don't think stylix-23.11 has lib.stylix?
					#format = "<span color=${lib.stylix.colors.withHashtag.base04}>{:%H:%M}</span>";
					# long date on hover
					#tooltip-format = "{:%Y-%m-%d}";

					# calendar on hover
					tooltip-format = "\n<span size='9pt' font='Hack Nerd Font Mono'>{calendar}</span>";

					# Calendar Settings
					calendar = {
						mode = "year";
						mode-mon-col = 3;
						week-pos = "right";
						on-scroll = 1;

						# Calendar Format
						format = {
							months = "<span color='#ffead3'><b>{}</b></span>";
							days =  "<span color='#ecc6d9'><b>{}</b></span>";
							weeks = "<span color='#99ffdd'><b>W{}</b></span>";
							weekdays = "<span color='#ffcc66'><b>{}</b></span>";
							today = "<span color='#ff6699'><b><u>{}</u></b></span>";
						};
					};

					# Widget Actions
					actions =  {
						on-click-right = "mode";
						#on-click-forward = "tz_up";
						#on-click-backward = "tz_down";
						#on-scroll-up = "shift_up";
						#on-scroll-down = "shift_down";
					};
				};
			};
		};
	};
}
