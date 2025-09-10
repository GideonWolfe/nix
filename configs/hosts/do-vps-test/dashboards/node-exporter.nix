{ pkgs, ... }:
let
  dashboards = pkgs.fetchFromGitHub {
    owner = "rfmoz";
    repo = "grafana-dashboards";
    rev = "0d3a3c0118f27873342626a4ecb36d35acf0ad01";
    sha256 = "1lf21fxqc96876izglspsskvwcfjdd9dx88m9mhbdks560797c4l";
  };
in {
  services.grafana.provision.dashboards.settings.providers = [{
    name = "node-exporter-full";
    options.path = "${dashboards}/prometheus/node-exporter-full.json";
  }];
}
