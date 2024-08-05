let
  #  My public key to my server agenix private key
  overseer =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+cpY8rRgcjRMY8jfgeFsUP42LtIBiijREvGo0dfNLu overseer@athena";
  users = [ overseer ];

  athena =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHbN0uqCdvtM2g3yB7JzXrylXRvjcNwVbZoOlDLnc/v root@athena";
  systems = [ athena ];
in {
  "traefik_env.age".publicKeys = users ++ systems;
}
