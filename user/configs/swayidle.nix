{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
	services.swayidle = {
		enable = true;
		timeouts = [
			{
				timeout = 300;
				#command = "${pkgs.swaylock}/bin/swaylock -f";
				command = "${pkgs.swaylock-effects}/bin/swaylock -f";
				#command = "${config.home.homeDirectory}/nix/user/scripts/system/power/lock.sh";
				# TODO this chained command doesn't seem to work
				#command = "${pkgs.swaylock}/bin/swaylock -f; systemctl suspend";
			}
		];

	};
}
