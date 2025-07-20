{ config, lib, inputs, pkgs, ... }:

let adsb_deku = pkgs.python312Packages.callPackage ./adsb_deku.nix { };
in {
  home.packages = [

    ##########
    # CAD/3D #
    ##########
    # TODO enable when more space
    pkgs.freecad # general CAD
    #pkgs.kicad # PCB designer
    pkgs.blender # 3D modeler, animator, and designer
    pkgs.sweethome3d.application # Interior design GUI
    pkgs.sweethome3d.textures-editor
    pkgs.sweethome3d.furniture-editor
    #pkgs.cura
    pkgs.candle # GRBLE/Gcode visualizer (for Cnc I think)
    pkgs.mujoco # general purpose physics sim/modeler
    pkgs.kdePackages.step # physics simulator
    pkgs.openrocket # 3D rocket simulator/modeler
    pkgs.leocad # 3D CAD modeler for legos
    #pkgs.orca-slicer # Slicer for 3D printing and Bambu printers

    ###############
    # ELECTRONICS #
    ###############
    #BUG: 404 for package
    #pkgs.baudline # scientific signal analysis app
    pkgs.sigrok-cli # signal analysis software
    pkgs.pulseview # GUI for sigrok
    pkgs.sigdigger # Qt-based digital signal analyzer
    #pkgs.scope-tui # TUI oscilloscope/vectorscope.spectroscope
    pkgs.picoscope # oscilloscope GUI
    pkgs.simulide # Simple real time electronic circuit simulator

    #########
    # RADIO #
    #########
    pkgs.chirp # GUI programming radios
    pkgs.jtdx # weak signal digital comm modes for HAM
    pkgs.gridtracker # GUI for jdtx
    pkgs.urh # Universal Radio Hacker
    pkgs.qdmr # GUI for DMR radio programming
    pkgs.qradiolink # SDR radio GUI
    # This is installed in the override I made for the theme
    #pkgs.sdrpp # SDR++
    pkgs.cubicsdr # sdr app
    pkgs.sdrangel
    pkgs.gnuradio
    pkgs.inspectrum
    pkgs.rtl-sdr
    pkgs.gqrx
    pkgs.welle-io # DAB/DAB+ decoding (internet radio)
    adsb_deku
    pkgs.unixcw # play a text file as morse code
    inputs.dsd-fme.packages.${pkgs.system}.default
    pkgs.fldigi
    pkgs.js8call
    pkgs.freedv # digital voice for HF radio
    pkgs.qlog # radio logging software
    pkgs.sdr-j-fm
    pkgs.inspectrum # GUI for analyzing captured signals
    pkgs.dump1090-fa
  ];
}
