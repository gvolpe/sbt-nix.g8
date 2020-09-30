# sbt-nix

The only requirement to compile and run this project is [Nix](https://nixos.org/download.html). You can install it with the following command:

```shell
curl -L https://nixos.org/nix/install | sh
```

To have `coursier`, `java` and `sbt` available, run `nix-shell`. Then you can use any of these packages as usual.

Note: in order to create the `base-jre`, you also need to have Docker installed as it needs to run as daemon so it cannot be provided in the `shell.nix`.

Make sure you read the comprehensive guide at https://github.com/gvolpe/sbt-nix.g8, if you feel stuck.
