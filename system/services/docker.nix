{ config, lib, pkgs, ... }:

{
	# Enable docker daemon
	virtualisation.docker.enable = true;

	# Choose docker as the backend for OCI containers configured via nix
	virtualisation.oci-containers.backend = "docker";
}
