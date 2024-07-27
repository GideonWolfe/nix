{ lib, config, ... }:

{
  home.activation = {
    # Create top level server folder
    createServer = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/server/\n";
    # All Services and their data
    createServerServices = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/server/services/\n";
    # Media stack
    createServerServicesMedia = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/server/services/media/\n";
    # All Served data
    createServerData = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/server/data/\n";
    # All Media
    createServerDataMedia = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/server/data/media/\n";
  };
}
