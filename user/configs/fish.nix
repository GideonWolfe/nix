{ pkgs, lib, ... }:

{
	# Allow HM to manage fish config
	programs.fish = {
		enable = true;

		shellAbbrs = {
			x = "eza";
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

		functions = {

			# Print public IP
			myIp = {
				body = "curl ipinfo.io/ip";
			};

			# IFonfig like output but with ip command
			ifconfig = {
				body = "ip -br -c -a";
			};

			# Utility to quickly copy file to backup
			backup = {
				argumentNames = ["filename"];
				body = "cp $filename $filename.bak";
			};

			# Restore that backed up file
			restore = {
				argumentNames = ["file"];
				body = "mv $file (echo $file | sed s/.bak//)";
			};

			# Create a directory without relying on existing ones
			mkd = {
				body = "mkdir -pv $argv";
			};

			# Better defaults for tree
			tree = {
				body = "command tree -C --dirsfirst $argv";
			};

		};
			
		
	};

}
