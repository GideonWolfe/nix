{ config, lib, pkgs, ... }:

{
	# Enable docker daemon
	virtualisation.docker.enable = true;
}
