{ imgName ? "base-jre", pkgs, jre }:

pkgs.dockerTools.buildLayeredImage {
  name      = imgName;
  tag       = "latest";
  contents  = [ pkgs.${jre} ];
}
