{ lib, config, ... }:

{
  home.activation = {
    # Create initial project directory
    createMusic = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/music/\n";
  };
}
