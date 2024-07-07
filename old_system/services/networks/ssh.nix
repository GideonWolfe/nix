{ config, lib, pkgs, ... }:

{
	# Enable OpenSSH
	services.openssh.enable = true;
	# OpenSSH Settings
	services.openssh.settings = {
		PermitRootLogin = "no";
		PasswordAuthentication = false;
	};
}
