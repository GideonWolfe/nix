{
  # Enable the Yubikey Agent, which replaces ssh-agent
  # Handles forwarding SSH auth requests to the Yubikey
  services.yubikey-agent.enable = true;

  # Notifies user when Yubikey awaiting touch
  programs.yubikey-touch-detector.enable = true;

  # Enable smartcard detection
  services.pcscd.enable = true;
}
