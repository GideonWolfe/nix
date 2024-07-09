let
  gideon =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJx8xzFoJ5l6XPpQ2KXjhQ6Ja0Htp4ubIFyTL5EP6Z5A gideon@hermes";
  users = [ gideon ];

  hermes =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRKh8hcmNRrpjo7o8zS6cy+Xq3hbyUITdAQCo1RpMFq root@hermes";
  systems = [ hermes ];
in { "test1.age".publicKeys = users ++ systems; }
