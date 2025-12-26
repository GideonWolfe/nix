{ config, lib, inputs, pkgs, ... }:

{
  home.packages = with pkgs; [

    ##########
    # CAD/3D #
    ##########
    # TODO enable when more space
    pkgs.freecad # general CAD
    pkgs.kicad # PCB designer
    pkgs.kicad-small # PCB designer
    pkgs.blender # 3D modeler, animator, and designer
    pkgs.sweethome3d.application # Interior design GUI
    pkgs.sweethome3d.textures-editor
    pkgs.sweethome3d.furniture-editor
    pkgs.candle # GRBLE/Gcode visualizer (for Cnc I think)
    pkgs.mujoco # general purpose physics sim/modeler
    pkgs.kdePackages.step # physics simulator
    pkgs.openrocket # 3D rocket simulator/modeler
    pkgs.leocad # 3D CAD modeler for legos

    # 3D printing
    pkgs.bambu-studio
    #pkgs.orca-slicer # Slicer for 3D printing and Bambu printers
    #pkgs.cura
  ];
}
