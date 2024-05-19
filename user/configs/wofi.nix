{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.wofi = {
		enable = true;

		# https://cloudninja.pw/docs/wofi.html
		style = ''
			#outer-box {
				border: 2px solid ${base0A};
			}
			#text:selected {
				background-color: ${base00};
				color: ${base0B};
				font-weight: bold;
			}
			#entry:selected {
				background-color: ${base00};
				border-style: none;
			}
			#input {
				background-color: ${base00};
				border-style: none;
				color: ${base0E};
			}
		'';
	};
}
