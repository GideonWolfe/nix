let
  gideon_hermes =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF30ngUW/93exkg3QRkZvqQIrjgjYnTt8rQQaVVbmBXc gideon@hermes";

  root_hermes =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRKh8hcmNRrpjo7o8zS6cy+Xq3hbyUITdAQCo1RpMFq root@hermes";

  root_athena =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHbN0uqCdvtM2g3yB7JzXrylXRvjcNwVbZoOlDLnc/v root@athena";

  root_poseidon =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHUk58I3PjFXu5EZAyFpFRUxNJpVou7meIRHZn00aHC root@poseidon";

  gideon_poseidon =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINnghAhilL7n/8w++x1CwrnBh+x3asbZmTUkWccR6K1o gideon@poseidon";

  users = [ gideon_hermes gideon_poseidon ];
  systems = [ root_hermes root_athena root_poseidon ];

in {
  # "test_users_secret.age".publicKeys = users;
  # "test_systems_secret.age".publicKeys = systems;
  # "test_users_and_systems_secret.age".publicKeys = users ++ systems;
  # "test_specific_user.age".publicKeys = [ gideon_hermes ];
  # "test_specific_system.age".publicKeys = [ root_hermes ];
  "test_specific_user.age".publicKeys = [ gideon_poseidon ];
  # Server secrets
  "traefik_env.age".publicKeys = [ root_athena ];
  "vaultwarden_env.age".publicKeys = [ root_athena ];
  "mealie_env.age".publicKeys = [ root_athena ];
  "crowdsec_api_key.age".publicKeys = [ root_athena ];
  # User secrets
  "vdirsyncer_google_client_id.age".publicKeys =
    [ gideon_hermes gideon_poseidon ];
  "vdirsyncer_google_client_secret.age".publicKeys =
    [ gideon_hermes gideon_poseidon ];
  "mbsync_google_wolfegideon_app_password.age".publicKeys =
    [ gideon_hermes gideon_poseidon ];
  "mbsync_gideonwolfexyz_password.age".publicKeys =
    [ gideon_hermes gideon_poseidon ];
  "mbsync_gideonwolfecom_password.age".publicKeys =
    [ gideon_hermes gideon_poseidon ];
  "weechat_libera_password.age".publicKeys = [ gideon_hermes gideon_poseidon ];
  # "newsboat_config.age".publicKeys = [ gideon_hermes gideon_poseidon ];
}
