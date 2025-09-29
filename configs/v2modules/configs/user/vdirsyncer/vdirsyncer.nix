{ pkgs, lib, config, ... }:

{
    # Enable HM to manage vdirsyncer
	programs.vdirsyncer = {
		enable = true;
	};
    # Enable creation of vdirsyncer service
	services.vdirsyncer = {
		enable = true;
	};
}
