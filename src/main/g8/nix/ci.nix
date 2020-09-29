{ jdk ? "jdk11" }:

let
  pkgs = import ./pkgs.nix { inherit jdk; };
in
  pkgs.mkShell {
    buildInputs = [ pkgs.sbt ];
  }
