{ pkgs, lib, config, ... }:

let
  # Copy startpage data to the Nix store
  startpageData = pkgs.stdenv.mkDerivation {
    name = "startpage-data";
    src = ./data;
    installPhase = ''
      mkdir -p $out
      cp -r * $out/
    '';
  };
in
{
  # Serve startpage from Nix store (read-only)
  systemd.user.services.startpage = {
    Unit = { Description = "startpage being served by miniserv"; };
    Install = { WantedBy = [ "default.target" ]; };
    Service = {
      Type = "simple";
      Restart = "always";
      RestartSec = 1;
      WorkingDirectory = "${startpageData}";
      ExecStart = "${pkgs.miniserve}/bin/miniserve --index index.html -p 9876";
    };
  };

  # Note: File watching is no longer needed since files are in read-only Nix store
  # To update the startpage, rebuild the system configuration
}
