{ lib, rustPlatform, fetchFromGitHub, ... }:
rustPlatform.buildRustPackage rec {
  pname = "adsb_deku";
  #TODO: Can't use the most recent package because the rustc version isn't in stable...
  # i'm too lazy to make an overlay
  version = "v2025.05.03";
  #version = "v2024.09.02";

  src = fetchFromGitHub {
    owner = "rsadsb";
    repo = pname;
    rev = version;
    sha256 = "sha256-MmCaH9SNxuDLOJGd/lc68fYnZyg01S7m9u9cVQxmBTw=";
    #sha256 = "sha256-MmCaH9SNxuDLOJGd/lc68fYnZyg01S7m9u9cVQxmBTw=";
  };

  cargoHash = "sha256-w5/nDcrWG6v3iIvXvEKc1O0F9WBx+5oFnGLqK39u5mQ=";
  #cargoSha256 = "sha256-2wio1tbZdmjhQFDQQWrM3KTuTf0y7ofWy7fPtNxh9Fg=";

  meta = with lib; {
    description = "Rust ADS-B decoder + tui radar application";
    homepage = "https://github.com/rsadsb/adsb_deku";
    license = licenses.mit;
    #maintainers = [ maintainers.gideonwolfe ];
  };
}
