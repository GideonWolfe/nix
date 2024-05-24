{ config, lib, pkgs, ... }:

{
	home.packages = [


		##########
		# CAD/3D #
		##########
		# TODO enable when more space
		#pkgs.freecad # general CAD
		#pkgs.kicad # PCB designer
		#pkgs.blender # 3D modeler, animator, and designer
		pkgs.sweethome3d.application # Interior design GUI
		pkgs.sweethome3d.textures-editor
		pkgs.sweethome3d.furniture-editor
		#pkgs.cura
		#pkgs.candle # GRBLE/Gcode visualizer (for Cnc I think)

		###############
		# ELECTRONICS #
		###############
		pkgs.sigrok-cli # signal analysis software
		pkgs.pulseview # GUI for sigrok
		pkgs.chirp # GUI programming radios
	];
}
