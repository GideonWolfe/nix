{ lib, ... }: {
  # Central source of truth for external infrastructure
  options.local.world = lib.mkOption { };
  config.local.world = import ./world-data.nix;
}
