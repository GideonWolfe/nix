{ pkgs, inputs ? null, ... }:

{
  home.packages = [
    # Script to prepare the Portapack environment
    (pkgs.writeScriptBin "portapack" (builtins.readFile ./portapack.py))
    # Script to handle radio reference data
    (pkgs.writeScriptBin "radioref" (builtins.readFile ./radioref.py))
  ];
}
