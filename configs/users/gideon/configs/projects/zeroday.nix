{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  home.activation = {
    # Create initial project directory
    createZeroDay = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/tech/zeroday/zeroday/\n";
    # If repo is missing, clone it, if not, pull it.
    cloneZeroDay = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "GIT_SSH=${lib.getExe pkgs.openssh} ${
        lib.getExe pkgs.git
      } -C ${config.home.homeDirectory}/projects/tech/zeroday/zeroday/ pull || GIT_SSH=${
        lib.getExe pkgs.openssh
      } ${
        lib.getExe pkgs.git
      } clone github:gideonwolfe/zeroday ${config.home.homeDirectory}/projects/tech/zeroday/zeroday/";
  };
}
