{ config, lib, pkgs, inputs, ... }:

{
	# Enable Stylix for system level theming
	programs.stylix = {
		enable = true;
		image = ./zT7uCe2.png;
		#image = /home/gideon/nix/user/configs/zT7uCe2.png;
	};	
}