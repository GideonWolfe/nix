{ lib, ... }: {
  # Central location to manage SSH public keys for my users and systems
  options.local.ssh.keys = lib.mkOption { };
  config.local.ssh.keys = {
    # Hermes VM
    gideon_hermes =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF30ngUW/93exkg3QRkZvqQIrjgjYnTt8rQQaVVbmBXc gideon@hermes";
    root_hermes =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRKh8hcmNRrpjo7o8zS6cy+Xq3hbyUITdAQCo1RpMFq root@hermes";

    # Athena Homeserver
    gideon_athena =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+cpY8rRgcjRMY8jfgeFsUP42LtIBiijREvGo0dfNLu overseer@athena";
    root_athena =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHbN0uqCdvtM2g3yB7JzXrylXRvjcNwVbZoOlDLnc/v root@athena";
  };
}
