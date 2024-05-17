{ pkgs, lib, ... }:

{
	# Allow HM to manage fish config
	programs.fish = {
		enable = true;

		shellAbbrs = {
			x = "exa";
			v = "nvim";
			p = "python3";
			ga = "git add";
			gp = "git push";
			dc = "docker-compose";
		};


		#TODO there's no home manager setting for this??
		interactiveShellInit = ''
			set fish_greeting #disable greeting
			set __done_notification_command '${pkgs.libnotify}/bin/notify-send \$title \$message'
		'';

		plugins = [
			{
				name = "done";
				src = pkgs.fishPlugins.done.src;
			}
		];
			
		
	};

}
