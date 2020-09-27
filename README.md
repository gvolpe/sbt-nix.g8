# sbt-nix-bootstrap

It showcases the power of [Nix](https://nixos.org/) and how it can be applied to Scala projects.

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
