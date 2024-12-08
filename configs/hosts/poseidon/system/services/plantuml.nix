{ pkgs, lib, config, ... }:

{
  # PlantUML server
  virtualisation.oci-containers.containers.plantuml = {
    image = "plantuml/plantuml-server:jetty";
    ports = [ "4205:8080" ];
    autoStart = true;
    environment = { ALLOW_PLANTUML_INCLUDE = "true"; };
    #BUG:"!include /themes/puml-theme-stylix.puml" and "!theme stylix from /themes" DO NOT WORK?!
    volumes =
      [ "/home/gideon/.config/plantuml/puml-theme-stylix.puml:/themes/puml-theme-stylix.puml" ];
  };

}
