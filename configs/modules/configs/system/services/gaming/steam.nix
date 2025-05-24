{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall =
      true; # Open ports in the firewall for Steam Local Network Game Transfers
    # Enable/install Proton Tricks 
    protontricks.enable = true;
  };
  # Enable Udev rules for controllers and other hardware
  hardware.steam-hardware.enable = true;
  # Enable Xbox controller driver
  hardware.xone.enable = true;
}
