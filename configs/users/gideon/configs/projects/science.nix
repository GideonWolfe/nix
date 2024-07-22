{ lib, config, ... }:

{
  home.activation = {
    # Create initial project directory
    createScience = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/science/\n";
  };
}
