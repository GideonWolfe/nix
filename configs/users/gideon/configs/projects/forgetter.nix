{ lib, config, ... }:

{
  home.activation = {
    # Create initial project directory
    createForgetter = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/forgetter/\n";
    # folder for finished releases, including their lyrics, artwork, and final mastered files
    createForgetterReleases = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/forgetter/releases/\n";
    # folder for production, where all the DAW files are stored and potential artwork
    createForgetterProduction = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/forgetter/production/\n";
    # Anything for press kits, bios, band photos, etc
    createForgetterMedia = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/forgetter/media/\n";
  };
}
