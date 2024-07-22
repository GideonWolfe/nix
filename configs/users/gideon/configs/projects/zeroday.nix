{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;

{
  # Create initial project directory
  home.activation = {
    createZeroDay = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "  mkdir -p ${config.home.homeDirectory}/projects/zeroday/zeroday/\n";
    cloneZeroDay = lib.hm.dag.entryAfter [ "writeBoundary" ]
      "GIT_SSH=${lib.getExe pkgs.openssh} ${
        lib.getExe pkgs.git
      } -C ${config.home.homeDirectory}/projects/zeroday/zeroday/ pull || GIT_SSH=${
        lib.getExe pkgs.openssh
      } ${
        lib.getExe pkgs.git
      } clone github:gideonwolfe/zeroday ${config.home.homeDirectory}/projects/zeroday/zeroday/";
  };

  # home.file.zeroDayRepo = {
  #   enable = true;
  #   recursive = true;
  #   target = "projects/zeroday/zeroday";
  #   source = builtins.fetchGit {
  #     url = "github:gideonwolfe/zeroday";
  #     ref = "main";
  #   };
  # };
  # # zeroDayRepo = builtins.fetchFromGitHub {
  #   url = "github:gideonwolfe/zeroday";
  #   owner = "GideonWolfe";
  #   repo = "zeroday";
  #   githubBase = "github@github.com";
  # };
}
