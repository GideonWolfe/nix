# Desktop Role - Orchestrates existing building block modules
# This role should NOT configure services directly, but import dedicated modules
{ config, lib, pkgs, ... }:

{
  # Import the building block modules for desktop functionality
  imports = [
    # Package groups for desktop
    ../packages/system/networking.nix
    ../packages/system/ui.nix
    
    # Service configurations for desktop  
    ../configs/system/services/audio/pipewire.nix
    ../configs/system/services/hardware/printing.nix
    
    # Additional desktop services as needed
    # ../configs/system/services/graphics/wayland.nix
    # ../configs/system/services/nautilus.nix
  ];
}
