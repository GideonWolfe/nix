{
  outputs = { nixpkgs, self }:
  let
    configuration = { config, pkgs, lib, ... }:
    {
      imports = [
        ./configuration.nix
        ./initial-setup.nix
      ];
    };
    eval = nixpkgs.legacyPackages.aarch64-linux.nixos configuration;
  in
  {
    packages.aarch64-linux = {
      nixos = eval.config.system.build.toplevel;
      sdImage = eval.config.system.build.sdImage;
      inherit eval;
    };
  };
}
