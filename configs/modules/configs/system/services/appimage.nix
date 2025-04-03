{ config, lib, pkgs, ... }:

{
    programs.appimage = {
         enable = true;
         binfmt = true;
    };
}
