{ pkgs, lib, stylix, config, ... }:

{
    programs.git.userName = "GideonWolfe";
    programs.git.userEmail = "gideon@gideonwolfe.com";
    programs.git.signing.key = builtins.readFile ./gideon_pub.asc;
}
