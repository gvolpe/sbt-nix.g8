{ jdk ? "jdk11" }:

# build definition for the `modules/nixified` project
let
  pinned = import nix/pinned.nix;
  config = import nix/config.nix { inherit jdk; };
  sbtix  = import pinned.sbt-derivation;
  pkgs   = import pinned.nixpkgs {
    inherit config;
    overlays = [ sbtix ];
  };
in
pkgs.sbt.mkDerivation {
  pname = "sbt-nixified";
  version = "1.0.0";

  depsSha256 = "02xxc6fy73v1m2awmavca7lgyr06fhjyg3q2q08cxr6nmy1s4b23";

  src = ./.;

  buildPhase = ''
    sbt "sbt-nix-derivation/assembly"
  '';

  installPhase = ''
    cp modules/nixified/target/scala-*/*-assembly-*.jar $out
  '';
}
