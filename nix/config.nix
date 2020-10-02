{ jdk }:

{
  packageOverrides = p: {
    sbt = p.sbt.override {
      jre = p.${jdk};
    };
  };
}
