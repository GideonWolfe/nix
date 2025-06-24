{ lib, fetchFromGitHub, rustPlatform, }:
let version = "basalt/v0.6.1";
in rustPlatform.buildRustPackage {
  pname = "basalt";
  inherit version;

  src = fetchFromGitHub {
    owner = "erikjuhani";
    repo = "basalt";
    tag = version;
    hash = "sha256-NQ12Q8IAcPLOTRCnUOko91QzoiFl8QPdchcpxdNKHLs=";
  };

  cargoHash = "sha256-HNreTDH6okBEbBeHpj9KdSM9InBsxEs5FQeCOw147ik=";

  meta = {
    description =
      "TUI Application to manage Obsidian notes directly from the terminal";
    homepage = "https://github.com/erikjuhani/basalt?ref=terminaltrove";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
}
