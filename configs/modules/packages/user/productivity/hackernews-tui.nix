{ lib, fetchFromGitHub, rustPlatform, }:
let version = "v0.13.5";
in rustPlatform.buildRustPackage {
  pname = "hackernews_tui";
  inherit version;

  src = fetchFromGitHub {
    owner = "aome510";
    repo = "hackernews-TUI";
    tag = version;
    hash = "sha256-p2MhVM+dbNiWlhvlSKdwXE37dKEaE2JCmT1Ari3b0WI=";
  };

  cargoHash = "sha256-nP/xGUxeNGtcTYdyDxEWeO/EW2ChB8QDteE3rCWFHEA=";

  meta = {
    description = "A Terminal UI to browse Hacker News";
    homepage = "https://github.com/aome510/hackernews-TUI";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
}
