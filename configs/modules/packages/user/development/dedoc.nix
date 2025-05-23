{ lib, fetchFromGitHub, rustPlatform, }:
let version = "0.2.6";
in rustPlatform.buildRustPackage {
  pname = "dedoc";
  inherit version;

  src = fetchFromGitHub {
    owner = "toiletbril";
    repo = "dedoc";
    tag = version;
    hash = "sha256-tV0bStmfHB4PetgIZwnEL0E7/HrMdrb1DYSmyqtyoWM=";
  };

  #cargoHash = "sha256-pFpX4u7TeDDqJDMH9j7bKeqRHKiESTnXaBi0/yF/UPU=";
  cargoHash = "sha256-8zSQSoWxXU5r1Z/c1AeIIbTzN1z/JBwpjvbit/baUAE=";

  meta = {
    description = "terminal based viewer for DevDocs ";
    homepage = "https://github.com/toiletbril/dedoc";
    license = lib.licenses.unlicense;
    maintainers = [ ];
  };
}
