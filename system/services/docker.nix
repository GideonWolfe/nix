{ config, lib, pkgs, ... }:

{
	# Enable docker daemon
	virtualisation.docker.enable = true;

	# Choose docker as the backend for OCI containers configured via nix
	virtualisation.oci-containers.backend = "docker";


	# test for startpage container 
	# Define our Startpage docker service
	virtualisation.oci-containers.containers.startpage = {

		# Map port 80 inside the container to 9876 on the host
		ports = ["9876:80"];

		image = "nginx";

		hostname = "startpage";
		
		autoStart = true;

		volumes = [
			"/home/gideon/nix/user/configs/startpage/data/style.css:/usr/share/nginx/html/styles/style.css"
			"/home/gideon/nix/user/configs/startpage/data/default.conf:/etc/nginx/conf.d/default.conf"
			"/home/gideon/nix/user/configs/startpage/data/index.html:/usr/share/nginx/html/index.html"
			# This may not be needed, I think the page respects the default FF font
			"${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/HackNerdFontMono-Regular.ttf:/usr/share/nginx/html/fonts/font.ttf"
		];

	};



}
