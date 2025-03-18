{ config, lib, pkgs, ... }:

{
	# Enable GVFS (required for caching album artwork)
	services.gvfs.enable = true;
}
