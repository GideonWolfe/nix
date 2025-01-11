{ config, lib, pkgs, ... }:

{
  home.packages = [

    pkgs.radare2
    #pkgs.iaito #radare2 gui
    pkgs.rizin # fork of r2
    pkgs.cutter # rizin gui
    #pkgs.rizinPlugins.rz-ghidra # add ghidra support
    #pkgs.cutterPlugins.rz-ghidra
    # TODO both conflicts when built
    #pkgs.ghidra
    pkgs.ghidra-bin
    # wifi tools
    #pkgs.aircrack-ng
    #pkgs.airgeddon
    #pkgs.airgorah
    #pkgs.tcpdump # network monitor
    #pkgs.termshark # Wireshark TUI
    #pkgs.wavemon # monitor wifi devices
    #pkgs.qFlipper
    pkgs.gpg-tui # TUI for GnuPG
    pkgs.sherlock # hunt down social media accounts
    #pkgs.john # John the ripper
    #pkgs.metasploit-framework
    #pkgs.johnny # GUI for John the Ripper

  ];
}
