# Development Role - Orchestrates existing building block modules  
# This role should NOT configure services directly, but import dedicated modules
{ config, lib, pkgs, ... }:

{
  # Import the building block modules for development functionality
  imports = [
    # Package groups for development
    ../packages/system/development.nix
    ../packages/system/networking.nix  # Often needed for development
    
    # Service configurations for development (when they exist)
    # ../configs/system/services/docker.nix
    # ../configs/system/services/development/git.nix
  ];
}
