{ lib, config, ... }:

{
  home.activation = {
    # Create initial project directory
    createArt = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/art/\n";
  };
}
