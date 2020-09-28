{ imgName ? "sbt-nix-assembly"
, jdk ? "jdk11"
, jre ? "adoptopenjdk-jre-openj9-bin-11"
}:

let
  pkgs = import ../../../nix/pkgs.nix { inherit jdk; };
  base = pkgs.callPackage ../../../nix/docker.nix { inherit jdk jre pkgs; };
in
  pkgs.writeShellScriptBin "build" ''
    cd ../../
    ${pkgs.sbt}/bin/sbt "sbt-nix-assembly/assembly"
    cd modules/assembly/
    docker load -i ${base}
    cp target/scala-2.13/app.jar nix/app.jar
    docker build -t ${imgName} nix/
    rm nix/app.jar
  ''
