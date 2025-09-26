# Desktop Role - Self-contained desktop environment setup
# Import this file directly in your host configuration to get a full desktop setup
{ config, lib, pkgs, ... }:

{
  # Essential GUI applications
  environment.systemPackages = with pkgs; [
    # Browsers
    firefox
    chromium
    
    # Communication
    thunderbird
    discord
    slack
    
    # Office & Productivity
    libreoffice
    obsidian
    
    # Graphics & Media
    gimp
    inkscape
    vlc
    mpv
    
    # File Management
    nautilus
    
    # Development (GUI)
    vscode
    
    # System Tools (GUI)
    gnome-system-monitor
    gnome-calculator
    
    # Archive Management
    file-roller
    
    # PDF Viewer
    evince
    
    # Terminal emulator
    gnome-terminal
  ];

  # Desktop Services
  services = {
    # X11 support
    xserver.enable = lib.mkDefault true;
    
    # Printing support
    printing.enable = lib.mkDefault true;
    
    # Audio
    pipewire = {
      enable = lib.mkDefault true;
      alsa.enable = lib.mkDefault true;
      alsa.support32Bit = lib.mkDefault true;
      pulse.enable = lib.mkDefault true;
      jack.enable = lib.mkDefault true;
    };
    
    # Bluetooth
    blueman.enable = lib.mkDefault true;
    
    # File indexing for search
    locate.enable = lib.mkDefault true;
    
    # Thumbnail generation
    tumbler.enable = lib.mkDefault true;
  };

  # Hardware support
  hardware = {
    # Disable PulseAudio since we use PipeWire
    pulseaudio.enable = false;
    
    # Enable Bluetooth
    bluetooth.enable = lib.mkDefault true;
    
    # Graphics drivers
    graphics.enable = lib.mkDefault true;
  };

  # Security services for desktop
  security = {
    # Polkit for privilege escalation dialogs
    polkit.enable = lib.mkDefault true;
    
    # RTKit for real-time audio
    rtkit.enable = lib.mkDefault true;
  };

  # Enable programs needed for desktop
  programs = {
    # Enable dconf for GNOME applications
    dconf.enable = lib.mkDefault true;
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      # Core fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      
      # Programming fonts
      fira-code
      fira-code-symbols
      
      # Additional fonts
      font-awesome
    ];
  };
}
