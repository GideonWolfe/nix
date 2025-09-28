{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # DAWs
    reaper # DAW
    mixxx # DJ software
    zrythm # DAW
    glicol-cli # TUI for glicol (coding music)

    # Plugin stuff
    yabridge # Yabridge for using Windows VSTs
    yabridgectl
    kapitonov-plugins-pack # More LV2 Plugins
    calf # music plugins (effects, tools, etc)
    infamousPlugins # more LV2 plugins

    # Drums
    drum-machine # GTK drum machine

    # Piano
    vmpk # Virtual MIDI Piano Keyboard
    piano-rs # TUI piano
    helm # virtual synthesizer

    # Guitar
    rakarrack # multi-effects processor emulating pedalboard
    guitarix # Guitar amp engine
    gxpluginx-lv2 # Guitarix plugins
    tonelib-metal # metal guitar tones
    tonelib-gfx
    tonelib-jam
    proteus # Capture guitar sound and train ML model on it
    tuxguitar # GUI for writing tabs
    fretboard # guitar chord identifier
    powertabeditor # Tab editor for guitar

    # Composition and Theory
    frescobaldi # lillypond GUI for writing scores
    transcribe # music player optimized for transcribing music
    coltrane # Music calculation GUI/TUI
    kdePackages.minuet # Learn music theory
    solfege # Learn music theory

    # Utilities
    fmit # instrument tuner
    lingot # instrument tuner

  ];
}
