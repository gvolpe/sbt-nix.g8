{ jdk ? "jdk11_headless" }:

let
  pname = "sbt-nix-$name$";
  pinned = import nix/pinned.nix;
  config = import nix/config.nix { inherit jdk; };
  sbtix  = import pinned.sbt-derivation;
  pkgs   = import pinned.nixpkgs {
    inherit config;
    overlays = [ sbtix ];
  };
  java = pkgs.\${jdk};
  mainClass = "$package$.Hello";
  inherit (pkgs) sbt makeWrapper;
  inherit (pkgs.lib) escapeShellArg sourceByRegex;
in
sbt.mkDerivation {
  inherit pname;
  version = "1.0.0";

  depsSha256 = "16zali9b9qhpi7kv69dwflbyiw6z6l0f66n5q3zk76c6rnrzqzy9";

  depsWarmupCommand = ''
    sbt compile
  '';

  nativeBuildInputs = [ pkgs.makeWrapper ];

  src = sourceByRegex ./. [
    "^project\$"
    "^project/.*\$"
    "^src\$"
    "^src/.*\$"
    "^build.sbt\$"
  ];

  buildPhase = ''
    sbt stage
  '';

  installPhase = ''
    mkdir -p \$out/{bin,lib}
    cp -ar target/universal/stage/lib \$out/lib/\${pname}
    makeWrapper \${java}/bin/java \$out/bin/\${pname} \
      --add-flags "-cp '\$out/lib/\${pname}/*' \${escapeShellArg mainClass}"
  '';
}

