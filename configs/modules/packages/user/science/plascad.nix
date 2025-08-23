{ lib, rustPlatform, fetchFromGitHub, ... }:
rustPlatform.buildRustPackage rec {
  pname = "plascad";
  version = "0.7.7";

  src = fetchFromGitHub {
    owner = "David-OConnor";
    repo = pname;
    rev = version;
    sha256 = "sha256-BqIpH6O0bULr90YjNRwF5Javb8c2vFkSljlFlUfubWE=";
  };

  cargoHash = "sha256-hR8iFGjElo7Wl0BTGmVDzthRb9z9t8jl3jIjAZk/xIs=";

  meta = with lib; {
    description = " Plasmid and primer design software";
    homepage = "https://github.com/David-OConnor/plascad";
    license = licenses.mit;
    #maintainers = [ maintainers.gideonwolfe ];
  };
}
