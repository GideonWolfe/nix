{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	programs.wofi = {
		enable = true;

		# https://cloudninja.pw/docs/wofi.html
        # HACK: override because HM module wants to conflict? as of 24.11
		style = lib.mkForce ''
			#outer-box {
				border: 2px solid ${base0E};
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
