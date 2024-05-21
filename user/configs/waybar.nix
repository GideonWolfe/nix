{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

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
			color: @base0A;
		}
		.modules-left #workspaces button.focused,
		.modules-left #workspaces button.active {
			border-bottom: 3px solid @base08;
			color: @base05;
		}
		.modules-center #clock {
			color: @base06
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
					"group/systemStats"
					"backlight/slider"
					"network"
					"battery"
					"cava"
					"wireplumber"
					"mpris"
					#"bluetooth"
					"custom/weather"
					"tray"
				];

				"network" = {
					# TODO icons and info with color codes
					format = " {ifname}";
					format-wifi = "<span color='${base0E}'> </span>";
					format-ethernet = "<span color='${base0E}'> </span>";
					format-disconnected = "<span color='${base08}'> </span>"; #An empty format will hide the module.
					tooltip-format = "{ifname} via {gwaddr} 󰊗";
					#tooltip-format-wifi = " {essid} \n {ipaddr}/{cidr} \n {signalStrength}% Strength \n {bandwidthUpBits} \n {bandwidthDownBits}";
					#tooltip-format-ethernet = "{ifname} \n{ipaddr}/{cidr} \n {bandwidthUpBits} \n {bandwidthDownBits}";
					#TODO this is neater but adds a ton of whitespace
					# The whitespace disappears when this text is left aligned but its UGLY
					tooltip-format-ethernet = 
					"
					<span color='${base0E}'></span>{ifname}
					<span color='${base0E}'></span>{ipaddr}/{cidr}
					<span color='${base0E}'> </span>{bandwidthUpBits}
					<span color='${base0E}'> </span>{bandwidthDownBits}
					";
					tooltip-format-wifi = 
					"
					<span color='${base0E}'> </span>{essid}
					<span color='${base0E}'></span>{ipaddr}/{cidr}
					<span color='${base0E}'> </span>{signalStrength}
					<span color='${base0E}'> </span>{bandwidthUpBits}
					<span color='${base0E}'> </span>{bandwidthDownBits}
					";
					tooltip-format-disconnected = "Disconnected";
					max-length = 50;
					on-click = "nm-connection-editor";
				};

				"bluetooth" = {
					format = " {status}";
					format-connected = " {device_alias}";
					format-connected-battery = " {device_alias} {device_battery_percentage}%",
					#format-device-preference = [ "device1", "device2" ]; preference list deciding the displayed device
					tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
					tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
					tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
					tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
				};

				"group/systemStats" = {
					orientation = "horizontal";
					modules = [
						"cpu"
						"memory"
						"disk"
						"temperature"
					];
					drawer = {
						transition-duration = 500;
						transition-left-to-right = false;
						children-class = "test";
					};
				};
				"disk" = {
					format = "<span color='${base0E}'> </span>{percentage_used}%";
					on-click = "baobab /";
					on-click-middle = "alacritty --command diskonaut /";
					on-click-right = "alacritty --command sudo iotop";
				};

				"temperature" = {
					format = " {temperatureC}";
					on-click = "psensor";
				};
				"memory" = {
					format = "<span color='${base0A}'></span>{percentage}%";
					on-click = "alacritty --command NMON=m nmon";
				};
				"cpu" = {
					format = "{icon}{usage}%";
					#format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
					format-icons = [
					"<span color='${base0B}'></span>"
					"<span color='${base0A}'></span>"
					"<span color='${base09}'></span>"
					"<span color='${base08}'></span>"
					];
					on-click = "sudo cpupower-gui";
					on-click-right = "hardinfo";
				};
				"battery" = {
					on-click = "sudo powertop";
				};
				
				"wireplumber" = {
					format = "{icon} {volume}%";
					on-click-middle = "qpwgraph";
					on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
					format-muted = "<span color='${base08}'> {volume}%</span>";
					#format-icons = [ "" "" ""];
					format-icons = [ 
						"<span color='${base0D}'></span>"
						"<span color='${base0B}'></span>"
						"<span color='${base0A}'></span> "
						"<span color='${base08}'></span> "
					];
				};

				"custom/weather" = {
					format = "{}°";
					tooltip = true;
					interval = 3600;
					exec = "wttrbar --main-indicator temp_F --fahrenheit --mph --location New_York";
					return-type = "json";
				};

				"sway/workspaces" = {
					disable-scroll = true;
					all-outputs = true;
					format = "{icon}";
					# Workspace Icons
					format-icons = {
						"1" = "";
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
					framerate = 80;
					sensitivity = 1;
					bars = 7;
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
							months = "<span color='${base0D}'><b>{}</b></span>";
							days =  "<span color='${base05}'><b>{}</b></span>";
							weeks = "<span color='${base0B}'><b>W{}</b></span>";
							weekdays = "<span color='${base0C}'><b>{}</b></span>";
							today = "<span color='${base08}'><b><u>{}</u></b></span>";
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
