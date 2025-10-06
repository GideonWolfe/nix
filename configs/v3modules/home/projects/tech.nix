{ lib, config, ... }:

{
  home.activation = {
    # Create initial project directory
    createTech = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/tech/\n";
  };
}
