{ config, lib, pkgs, ... }:

# Full package list importing all available package modules
# Import this in your home.nix to get all packages
{
  imports = [
    ###########
    # CUSTOM  #
    ###########
    # we might not need to import here
    # ./custom/adsb_deku.nix
    # ./custom/basalt-tui.nix
    # ./custom/dedoc.nix
    # ./custom/hackernews-tui.nix
    # ./custom/asciiMol.nix
    # ./custom/plascad.nix
    # ./custom/ugene.nix

    ###############
    # DEVELOPMENT #
    ###############
    ./development/c.nix
    ./development/java.nix
    ./development/js.nix
    ./development/python.nix
    ./development/rust.nix
    ./development/utils.nix

    ##############
    # PENTESTING #
    ##############
    ./pentesting/pentesting.nix

    ################
    # PRODUCTIVITY #
    ################
    ./productivity/ai.nix
    ./productivity/art.nix
    ./productivity/audio.nix
    ./productivity/comms.nix
    ./productivity/productivity.nix
    ./productivity/video.nix

    ###########
    # SCIENCE #
    ###########
    ./science/utilities.nix
    
    # Science - Astronomy
    ./science/astronomy/astronomy.nix
    
    # Science - Biology
    ./science/biology/biology.nix
    
    # Science - Chemistry
    ./science/chemistry/chemistry.nix
    
    # Science - Data
    ./science/data/data.nix
    ./science/data/euporie.nix
    
    # Science - Engineering
    ./science/engineering/cad.nix
    ./science/engineering/electronics.nix
    
    # Science - Geography
    ./science/geography/geography.nix
    
    # Science - Math
    ./science/math/math.nix
    
    # Science - Medicine
    ./science/medecine/medecine.nix
    
    # Science - Radio
    ./science/radio/radio.nix

    #############
    # UTILITIES #
    #############
    ./utilities/cli.nix
    ./utilities/files.nix
    ./utilities/fonts.nix
    ./utilities/fun.nix
    ./utilities/hardware.nix
    ./utilities/monitors.nix
    ./utilities/networking.nix
    ./utilities/system.nix
  ];
}
