{
  nixpkgs = fetchTarball {
    name   = "nixos-unstable-2020-09-25";
    url    = "https://github.com/NixOS/nixpkgs-channels/archive/72b9660dc18b.tar.gz";
    sha256 = "1cqgpw263bz261bgz34j6hiawi4hi6smwp6981yz375fx0g6kmss";
  };

  sbt-derivation = fetchTarball {
    name   = "sbt-derivation-2020-10-08";
    url    = "https://github.com/zaninime/sbt-derivation/archive/9666b2b.tar.gz";
    sha256 = "17r74avh4i3llxbskfjhvbys3avqb2f26pzydcdkd8a9k204rg9z";
  };
}
