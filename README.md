# sbt-nix-bootstrap

Maybe include some introduction, screenshot of the Twitter poll and links to my talks.

## What is Nix?

[Nix](https://nixos.org/) is a functional package manager [EXPAND].

https://nixos.org/learn.html

### Install Nix

You are only a command away (unless you are on NixOS):

```
curl -L https://nixos.org/nix/install | sh
```

More details at: https://nixos.org/download.html

## Reproducibility

The most popular use of Nix is for creating *reproducible development environments* that work across different machines and platforms (e.g. `darwin`, `linux`).

TODO: Explain how multiple teams can share a single `shell.nix` (e.g. frontend and backend teams).

It is appealing for new members joining the team. On day one, all they need to do is to git-clone the project, install Nix, run `nix-shell` and all the project's dependencies will become available. It sounds like magic!

### Avoid global installation of Java & Sbt

Instead of installing binaries from the web, let Nix manage your dependencies. This is crucial when working in big teams. We will no longer hear "it compiles on my machine".

Here's an example of a simple `shell.nix` that has two dependencies: `jdk11` and `sbt`.

```nix
{ jdk ? "jdk11" }:

let
  pkgs = import ./pkgs.nix { inherit jdk; };
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.${jdk}
      pkgs.sbt
    ];
  }
```

Where `pkgs.nix` defines an *exact* version of the Nixpkgs (more on this later). The important part is that every member of the team will have access to the same JDK version.

To access the software declared in `shell.nix`, we only need to run `nix-shell`.

## Use cases

- Dev shell with dependencies (can include things like `jekyll` for microsites, etc).
- Same dev shell to run on CI build (even with a matrix of Java versions).
- Same JRE to create Docker image (reproducibility, and also smaller images).

## Docker images

```
REPOSITORY                  TAG                            IMAGE ID            CREATED             SIZE
sbt-nix-bootstrap-custom    0.1.0-SNAPSHOT                 94e713b3fa0d        6 seconds ago       179MB
sbt-nix-bootstrap-default   0.1.0-SNAPSHOT                 c0320ed1b643        2 minutes ago       221MB
sbt-nix-assembly            latest                         61b30afca2fc        9 minutes ago       179MB
base-jre                    latest                         58028d3adc50        50 years ago        163MB
```

### Custom Nix Docker image using sbt-assembly

```
cd modules/assembly/ && ./build.sh
docker run -it sbt-nix-assembly:latest
```

### Default Docker image using sbt-native-packager

```
sbt "sbt-nix-native-default/docker:publishLocal"
docker run -it sbt-nix-bootstrap-default:0.1.0-SNAPSHOT
```

### Custom Nix Docker image using sbt-native-packager

```
sbt "sbt-nix-native-custom/docker:publishLocal"
docker run -it sbt-nix-bootstrap-custom:0.1.0-SNAPSHOT
```
