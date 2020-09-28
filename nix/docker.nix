{ imgName ? "base-jre"
, jdk ? "jdk11"
, jre ? "adoptopenjdk-jre-openj9-bin-11"
, pkgs ? import ./pkgs.nix { inherit jdk; }
}:

pkgs.dockerTools.buildLayeredImage {
  name      = imgName;
  tag       = "latest";
  contents  = [ pkgs.${jre} ];
}
