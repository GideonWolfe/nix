    { pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "ugene";
  version = "52.1";

  src = pkgs.fetchFromGitHub {
    owner = "ugeneunipro";
    repo = "ugene";
    rev = version;
    sha256 = "sha256-SAD69v5F+sQ6bmON8hWE9RuNgolYhLgae5F6R4d8H7c="; # Replace with actual hash
  };

  buildInputs = with pkgs; [
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtscript
    libsForQt5.qt5.qtnetworkauth
    libsForQt5.qt5.qtwebsockets
    zlib
    libGL
    libGLU
    xorg.libXtst
    mesa
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    libsForQt5.qt5.wrapQtAppsHook
    #libsForQt5.qt5.qtscript
    pkg-config
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  # Set Qt5_DIR environment variable as required by UGENE build system
  preConfigure = ''
    export Qt5_DIR=${pkgs.libsForQt5.qt5.qtbase.dev}/lib/cmake/Qt5
  '';

  # Optional: Arguments for wrapQtAppsHook
  # qtWrapperArgs = [ "--prefix PATH : ${pkgs.qttools.bin}/bin" ];

  meta = with pkgs.lib; {
    description = "Free open-source cross-platform bioinformatics software";
    homepage = "http://ugene.net/";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
    maintainers = [ ]; # Add your name/email here if desired
  };
}