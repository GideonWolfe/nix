{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ###########
    # CONFIGS #
    ###########

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Base Level system configuration
    ../../v3modules/system/core/system.nix

    # Import the gideon system user configuration
    ../../v3modules/users/gideon/gideon.nix

    #TEST: localAI
    ../../modules/configs/system/services/ai/localai.nix
  ];

  # Enable custom features
  custom.features.wireguard.enable = true;
  custom.features.secrets.enable = true;
  custom.features.monitoring.enable = false;
  custom.features.gaming.enable = true;
  custom.features.hardware.enable = true;

  # TEST to allow cross compilation for ARM
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    # ....
  ];

  networking.hostName = "poseidon"; # Define your hostname.

  system.stateVersion = "23.11";

}
