{ lib, config, ... }:

{
  home.activation = {
    # Create initial project directory
    createPhotography = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/photography/\n";
  };
}
