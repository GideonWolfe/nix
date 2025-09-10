{ pkgs, ... }:
let
  dashboards = pkgs.fetchFromGitHub {
    owner = "traefik";
    repo = "traefik";
    rev = "c0b704e1b00ccf8def472c89211e7f26ac7a1fa4";
    sha256 = "sha256-wG90mqT51IVOuQvGPo3Rje+3YWHKXlbDmv4ZPkaoQyw=";
  };
in {
  services.grafana.provision.dashboards.settings.providers = [{
    name = "traefik";
    options.path = "${dashboards}/contrib/grafana/traefik.json";
  }];
}
