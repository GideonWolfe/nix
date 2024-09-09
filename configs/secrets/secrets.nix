let
  gideon_hermes =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF30ngUW/93exkg3QRkZvqQIrjgjYnTt8rQQaVVbmBXc gideon@hermes";

  root_hermes =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRKh8hcmNRrpjo7o8zS6cy+Xq3hbyUITdAQCo1RpMFq root@hermes";

  root_athena =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHbN0uqCdvtM2g3yB7JzXrylXRvjcNwVbZoOlDLnc/v root@athena";

  users = [ gideon_hermes ];
  systems = [ root_hermes root_athena ];

in {
  # "test_users_secret.age".publicKeys = users;
  # "test_systems_secret.age".publicKeys = systems;
  # "test_users_and_systems_secret.age".publicKeys = users ++ systems;
  # "test_specific_user.age".publicKeys = [ gideon_hermes ];
  # "test_specific_system.age".publicKeys = [ root_hermes ];
  # Server secrets
  "traefik_env.age".publicKeys = [ root_athena ];
  "vaultwarden_env.age".publicKeys = [ root_athena ];
  "mealie_env.age".publicKeys = [ root_athena ];
  "crowdsec_api_key.age".publicKeys = [ root_athena ];
  # User secrets
  "vdirsyncer_google_client_id.age".publicKeys = [ gideon_hermes ];
  "vdirsyncer_google_client_secret.age".publicKeys = [ gideon_hermes ];
  "mbsync_google_wolfegideon_app_password.age".publicKeys = [ gideon_hermes ];
  "mbsync_gideonwolfexyz_password.age".publicKeys = [ gideon_hermes ];
  "mbsync_gideonwolfecom_password.age".publicKeys = [ gideon_hermes ];
  "weechat_libera_password.age".publicKeys = [ gideon_hermes ];
  "newsboat_config.age".publicKeys = [ gideon_hermes ];
}
