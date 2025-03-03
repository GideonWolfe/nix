{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Pipewire
    pipewire
    qpwgraph # QT patchbay for pipewire
    helvum # GTK patchbay
    coppwr # Low level control GUI for the PipeWire multimedia server
    pwvucontrol # volume control gui

    # Pulseaudio
    pulseaudio # included to get pactl, not actually running via hardware.pulseaudio
    pavucontrol # PulseAudio control GUI

    # Alsa
    alsa-utils # amixer and other utilities

    # General
    playerctl # MPRIS control CLI
    ffmpeg
    soundconverter # sound conversion GUI

    # musicbrainz tagger
    picard
  ];
}
