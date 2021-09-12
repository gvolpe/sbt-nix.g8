{
  nixpkgs = fetchTarball {
    name   = "nixos-unstable-2021-09-11";
    url    = "https://github.com/NixOS/nixpkgs/archive/f49dfac.tar.gz";
    sha256 = "02jw1vban780kdirz7xfa2g9x6m3gqfn53nzapp7flgzp0i2vvpa";
  };

  sbt-derivation = fetchTarball {
    name   = "sbt-derivation-2021-04-03";
    url    = "https://github.com/zaninime/sbt-derivation/archive/920b6f1.tar.gz";
    sha256 = "0apg8mk7bzq418c1jyq5s5c3sp6bh4smirwxi29dhbnyp8q9ddv7";
  };
}
