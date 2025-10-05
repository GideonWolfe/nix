{ config, lib, pkgs, ... }:

let
  # Define the package directory - currently pointing to v2modules
  packageDir = ../../../v2modules/packages;
in {
  imports = [
    # Art packages
    # "${packageDir}/art/art.nix"
    # "${packageDir}/art/music_production.nix"
    # "${packageDir}/art/painting.nix"

    # Development packages
    # "${packageDir}/development/dedoc.nix"
    # "${packageDir}/development/js.nix"
    # "${packageDir}/development/python.nix"
    # "${packageDir}/development/rust.nix"
    # "${packageDir}/development/security.nix"
    # "${packageDir}/development/utils.nix"

    # Gaming packages
    #"${packageDir}/gaming/gaming.nix"

    # Pentesting packages
    # "${packageDir}/pentesting/cracking.nix"
    # "${packageDir}/pentesting/osint.nix"
    # "${packageDir}/pentesting/reverse_engineering.nix"
    # "${packageDir}/pentesting/systems.nix"
    # "${packageDir}/pentesting/wifi.nix"

    # Productivity packages
    # "${packageDir}/productivity/audio.nix"
    # "${packageDir}/productivity/basalt-tui.nix"
    # "${packageDir}/productivity/productivity.nix"
    # "${packageDir}/productivity/video.nix"
    # "${packageDir}/productivity/web.nix"
    
    # Productivity - Communication packages
    # "${packageDir}/productivity/comms/comms.nix"
    # "${packageDir}/productivity/comms/irc.nix"
    # "${packageDir}/productivity/comms/matrix.nix"
    # "${packageDir}/productivity/comms/signal.nix"
    
    # Productivity - News packages
    # "${packageDir}/productivity/news/hackernews-tui.nix"
    # "${packageDir}/productivity/news/news.nix"

    # Science packages
    # "${packageDir}/science/utilities.nix"
    
    # Science - Astronomy
    # "${packageDir}/science/astronomy/astronomy.nix"
    
    # Science - Biology
    # "${packageDir}/science/biology/asciiMol.nix"
    # "${packageDir}/science/biology/biology.nix"
    # "${packageDir}/science/biology/plascad.nix"
    # "${packageDir}/science/biology/ugene.nix"
    
    # Science - Chemistry
    #"${packageDir}/science/chemistry/chemistry.nix"
    
    # Science - Data
    #"${packageDir}/science/data/data.nix"
    #"${packageDir}/science/data/euporie.nix"
    
    # Science - Engineering
    #"${packageDir}/science/engineering/cad.nix"
    #"${packageDir}/science/engineering/electronics.nix"
    
    # Science - Geography
    #"${packageDir}/science/geography/geography.nix"
    
    # Science - Math
    #"${packageDir}/science/math/math.nix"
    
    # Science - Medicine
    #"${packageDir}/science/medecine/medecine.nix"
    
    # Science - Radio
    #"${packageDir}/science/radio/adsb_deku.nix"
    #"${packageDir}/science/radio/radio.nix"

    # Utility packages
    "${packageDir}/utilities/cli.nix"
    "${packageDir}/utilities/files.nix"
    "${packageDir}/utilities/fun.nix"
    "${packageDir}/utilities/hardware.nix"
    "${packageDir}/utilities/monitors.nix"
    "${packageDir}/utilities/networking.nix"
    "${packageDir}/utilities/system.nix"
  ];
}
