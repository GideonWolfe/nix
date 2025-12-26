{ lib, python3Packages, fetchPypi, }:
python3Packages.buildPythonApplication rec {
  pname = "asciimol";
  version = "1.2.5";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-sB8hHtjfCv5jFHXEoUG7zNn3d3QKihPLbgnR+Jyz4GQ=";
  };

  build-system = with python3Packages; [ setuptools ];
  dependencies = with python3Packages; [ numpy ];

  meta = with lib; {
    description = "TUI for drawing chemical diagrams";
    homepage = "https://github.com/dewberryants/asciiMol";
    license = licenses.bsd2;
  };
}
