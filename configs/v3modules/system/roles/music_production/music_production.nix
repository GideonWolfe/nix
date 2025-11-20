{ config, lib, pkgs, inputs, pathConfig ? {}, ... }:

let 
  cfg = config.custom.features.music_production;
  
  # Lightweight utility packages - enabled by default
  musicApps = with pkgs; [
    # Utilities
    fmit # instrument tuner
    lingot # instrument tuner
    vmpk # Virtual MIDI Piano Keyboard
    piano-rs # TUI piano
    fretboard # guitar chord identifier
    coltrane # Music calculation GUI/TUI
    transcribe # music player optimized for transcribing music
    glicol-cli # TUI for glicol (coding music)
    frescobaldi # Lillypond GUI for writing scores
    kdePackages.minuet # Learn music theory
    solfege # Learn music theory
  ];

  # Full music creation suites - disabled by default
  musicDAWs = with pkgs; [
    # Digital Audio Workstations
    reaper # Professional DAW
    zrythm # Free/open source DAW
    mixxx # DJ software
    
    # Plugin frameworks and effects
    yabridge # Yabridge for using Windows VSTs
    yabridgectl
    kapitonov-plugins-pack # LV2 Plugins
    calf # Music plugins (effects, tools, etc)
    infamousPlugins # More LV2 plugins
    
    # Instruments and synthesizers
    drum-machine # GTK drum machine
    helm # Virtual synthesizer
    
    # Guitar processing
    rakarrack # Multi-effects processor emulating pedalboard
    guitarix # Guitar amp engine
    gxpluginx-lv2 # Guitarix plugins
    tonelib-metal # Metal guitar tones
    tonelib-gfx
    tonelib-jam
    proteus # Capture guitar sound and train ML model on it
    tuxguitar # GUI for writing tabs
    powertabeditor # Tab editor for guitar
    
  ];
  
in {
  options.custom.features.music_production = {
    enable = lib.mkEnableOption "Music Production Support";
    
    apps = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable lightweight music utility applications";
    };
    
    daws = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable full music production suites (DAWs, plugins, instruments)";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = 
      lib.optionals cfg.apps musicApps ++
      lib.optionals cfg.daws musicDAWs;
  };
}
