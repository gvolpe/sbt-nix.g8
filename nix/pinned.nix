{
  nixpkgs = fetchTarball {
    name   = "nixos-unstable-2020-09-25";
    url    = "https://github.com/NixOS/nixpkgs-channels/archive/72b9660dc18b.tar.gz";
    sha256 = "1cqgpw263bz261bgz34j6hiawi4hi6smwp6981yz375fx0g6kmss";
  };

  sbt-derivation = fetchTarball {
    name   = "sbt-derivation-2020-09-29";
    url    = "https://github.com/zaninime/sbt-derivation/archive/cf4b0c3bb930578c88f542e34ba862f16e711f97.tar.gz";
    sha256 = "1c4dxcm2vrzm9fb23nh33i62j8lks9nffmfr0g7iyf58cyamwah5";
  };
}
