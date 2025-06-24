{ config, lib, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		# GNU C Compiler
		gcc
		# Make
		gnumake
		# Python
		python3
		# Docker
		docker
		docker-compose
		# Java
		jdk
		git
        distrobox
	];
}
