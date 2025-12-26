{ config, lib, inputs, pkgs, ... }:

let adsb_deku = pkgs.python312Packages.callPackage ../../custom/adsb_deku.nix { };
in {
  home.packages = [
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
    pkgs.ax25-apps
    pkgs.hackrf
    pkgs.telegraph # morse code GUI
    pkgs.aldo # learn morse code
    pkgs.gpredict-unstable
  ];
}
