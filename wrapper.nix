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
  inherit (pkgs) sbt makeWrapper;
  inherit (pkgs.lib) escapeShellArg sourceByRegex;
in
sbt.mkDerivation rec {
  pname = "sbt-nix-wrapper";
  version = "1.0.0";

  # make sure to delete all the `target` folders, including those under each module: `modules/.../target`
  depsSha256 = "09ngvlazgfxandg4ajh4lj53gyccdayjlj1rn100jfjm8cpg5nkv";

  nativeBuildInputs = [ pkgs.makeWrapper ];

  src = sourceByRegex ./. [
    "^project$"
    "^project/.*$"
    "^modules/wrapper/src$"
    "^modules/wrapper/src/.*$"
    "^build.sbt$"
  ];

  buildPhase = ''
    sbt "sbt-nix-wrapper/stage"
  '';

  installPhase = ''
    mkdir -p $out/{bin,lib}
    cp -ar modules/wrapper/target/universal/stage/lib $out/lib/${pname}
    makeWrapper ${java}/bin/java $out/bin/${pname} \
      --add-flags "-cp '$out/lib/${pname}/*' ${escapeShellArg mainClass}"
  '';
}
