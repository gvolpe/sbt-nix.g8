{ jdk ? "adoptopenjdk-openj9-bin-11" }:

let
  pkgs = import ./pkgs.nix { inherit jdk; };
in
  pkgs.mkShell {
    buildInputs = [ pkgs.sbt ];
  }
