{ pkgs, lib, config, ... }:

{
  virtualisation.oci-containers.containers.backrest = {
    image = "garethgeorge/backrest:latest";
    ports = [ "9898:9898" ];
    autoStart = true;
    volumes = [
      # Mount Backrest data directory
      "/var/lib/backrest/data:/data"
      "/var/lib/backrest/config:/config"
      "/var/lib/backrest/cache:/cache"
      
      # Mount your existing restic repositories (read-only)
      "/run/media/overseer/mnemosyne/backups:/repos:ro"
      
      # Mount the password file (read-only)
      "/run/media/overseer/mnemosyne/backuppass.txt:/backuppass.txt:ro"
    ];
  };
}