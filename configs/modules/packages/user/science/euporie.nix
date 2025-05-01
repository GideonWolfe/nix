{ lib, python3Packages, fetchPypi, }:
python3Packages.buildPythonPackage rec {
  pname = "euporie";
  version = "2.8.11";
  format = "wheel";

  src = fetchPypi rec {
    inherit pname version format;
    dist = python;
    python = "py3";
    hash = "sha256-rLTnSJYCPAZRQMlJA3QHzUFYAAXxI6Pkq+xPuwGbSfA=";
  };

  # build-system = with python3Packages; [ hatchling ];
  dependencies = with python3Packages; [
    fastjsonschema
    fsspec
    imagesize
    jupyter-client
    jupytext
    linkify-it-py
    markdown-it-py
    mdit-py-plugins
    nbformat
    pillow
    platformdirs
    prompt-toolkit
    universal-pathlib
    pyperclip
    pygments
  ];

  meta = with lib; {
    description = "TUI for Jupyter notebooks";
    homepage = "https://github.com/joouha/euporie";
    license = licenses.mit;
  };
}
