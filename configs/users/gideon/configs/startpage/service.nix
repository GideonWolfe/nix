{ pkgs, lib, ... }:

{

  # Define our Startpage docker service
  lib.virtualisation.oci-containers.containers.startpage = {

    # Map port 80 inside the container to 9876 on the host
    ports = [ "9876:80" ];

    image = "nginx";

    hostname = "startpage";

    autoStart = true;

    volumes = [
      "./data/style.css:/usr/share/nginx/html/styles/style.css"
      "./data/default.conf:/etc/nginx/conf.d/default.conf"
      "./data/index.html:/usr/share/nginx/hgml/index.html"
      # This may not be needed, I think the page respects the default FF font
      "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/HackNerdFontMono-Regular.ttf:/usr/share/nginx/html/fonts/font.ttf"
    ];

  };
}
