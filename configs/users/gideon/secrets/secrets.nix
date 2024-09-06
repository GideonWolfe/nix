let
  #  My public key to my master agenix private key
  gideon =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF30ngUW/93exkg3QRkZvqQIrjgjYnTt8rQQaVVbmBXc gideon@hermes";
  users = [ gideon ];

  hermes =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRKh8hcmNRrpjo7o8zS6cy+Xq3hbyUITdAQCo1RpMFq root@hermes";
  systems = [ hermes ];
in {
  "vdirsyncer_google_client_id.age".publicKeys = users ++ systems;
  "vdirsyncer_google_client_secret.age".publicKeys = users ++ systems;
  "mbsync_google_wolfegideon_app_password.age".publicKeys = users ++ systems;
  "mbsync_gideonwolfexyz_password.age".publicKeys = users ++ systems;
  "mbsync_gideonwolfecom_password.age".publicKeys = users ++ systems;
  "weechat_libera_password.age".publicKeys = users ++ systems;
  "newsboat_config.age".publicKeys = users ++ systems;
  "ssh_athena_ip.age".publicKeys = users ++ systems;
}
