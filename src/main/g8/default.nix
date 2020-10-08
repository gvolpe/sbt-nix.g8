{ jdk ? "jdk11_headless" }:

let
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
sbt.mkDerivation rec {
  pname = "sbt-nix-$name$";
  version = "1.0.0";

  # update this value with whatever Nix suggests after running `nix-build`
  depsSha256 = "0000000000000000000000000000000000000000000000000000";

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
    cp -ar modules/wrapper/target/universal/stage/lib \$out/lib/${pname}
    makeWrapper \${java}/bin/java \$out/bin/\${pname} \
      --add-flags "-cp '\$out/lib/\${pname}/*' \${escapeShellArg mainClass}"
  '';
}

