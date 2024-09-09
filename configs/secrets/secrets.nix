let
  gideon_hermes =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF30ngUW/93exkg3QRkZvqQIrjgjYnTt8rQQaVVbmBXc gideon@hermes";

  root_hermes =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRKh8hcmNRrpjo7o8zS6cy+Xq3hbyUITdAQCo1RpMFq root@hermes";

  users = [ gideon_hermes ];
  systems = [ root_hermes ];

in {
  "test_users_secret.age".publicKeys = users;
  "test_systems_secret.age".publicKeys = systems;
  "test_users_and_systems_secret.age".publicKeys = users ++ systems;
  "test_specific_user.age".publicKeys = [ gideon_hermes ];
  "test_specific_system.age".publicKeys = [ root_hermes ];
}
