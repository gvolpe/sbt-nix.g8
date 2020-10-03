{ jdk ? "jdk11_headless" }:

# build definition for the `modules/wrapper` project
let
  pinned = import nix/pinned.nix;
  config = import nix/config.nix { inherit jdk; };
  sbtix  = import pinned.sbt-derivation;
  pkgs   = import pinned.nixpkgs {
    inherit config;
    overlays = [ sbtix ];
  };
  java = pkgs.${jdk};
  mainClass = "demo.Hello";
in
pkgs.sbt.mkDerivation rec {
  pname = "sbt-nix-wrapper";
  version = "1.0.0";

  depsSha256 = "1n5zk4n14qlcr1lzjn7hcvz6iixjknhvl024qpx46jdk6mf2dh1c";

  nativeBuildInputs = [ pkgs.makeWrapper ];

  src = ./.;

  buildPhase = ''
    sbt "sbt-nix-derivation/stage"
  '';

  installPhase = ''
    mkdir -p $out/{bin,lib}
    cp -ar modules/wrapper/target/universal/stage/lib $out/lib/${pname}
    makeWrapper ${java}/bin/java $out/bin/${pname} \
      --add-flags "-cp '$out/lib/${pname}/*' ${pkgs.lib.escapeShellArg mainClass}"
  '';
}
