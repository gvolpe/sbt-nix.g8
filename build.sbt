import Dependencies._
import com.typesafe.sbt.packager.docker._

ThisBuild / scalaVersion     := "2.13.3"
ThisBuild / version          := "0.1.0-SNAPSHOT"
ThisBuild / organization     := "dev.profunktor"
ThisBuild / organizationName := "ProfunKtor"

// custom image build out of the nix base jre image: 179MB
val nixDockerSettings = List(
  name := "sbt-nix-bootstrap-custom",
  dockerCommands := Seq(
    Cmd("FROM", "base-jre:latest"),
    Cmd("COPY", "1/opt/docker/lib/*.jar", "/lib/"),
    Cmd("COPY", "2/opt/docker/lib/*.jar", "/app.jar"),
    ExecCmd("ENTRYPOINT", "java", "-cp", "/app.jar:/lib/*", "demo.Hello")
  )
)

// https://hub.docker.com/_/openjdk?tab=tags&page=1&name=jre
// default docker build with custom slim image: 221MB
val defaultDockerSettings = List(
  name := "sbt-nix-bootstrap-default",
  dockerBaseImage := "openjdk:11.0.8-jre-slim"
)

// for sbt-assembly
val assemblySettings = List(
  assemblyJarName in assembly := "app.jar",
  maintainer := "gvolpe@foo.com"
)

val licenseSettings = List(
  licenses += ("Apache-2.0", new URL("https://www.apache.org/licenses/LICENSE-2.0.txt"))
)

lazy val root = (project in file("."))
  .aggregate(
    `sbt-nix-assembly`,
    `sbt-nix-native-custom`,
    `sbt-nix-native-default`,
    `sbt-nix-derivation`
  )

lazy val `sbt-nix-assembly` = (project in file("modules/assembly"))
  .enablePlugins(JavaAppPackaging)
  .settings(
    libraryDependencies ++= Seq(
      catsCore,
      scalaTest % Test
    )
  )
  .settings(assemblySettings: _*)
  .settings(licenseSettings: _*)

lazy val `sbt-nix-native-custom` = (project in file("modules/native-custom"))
  .enablePlugins(JavaAppPackaging)
  .enablePlugins(DockerPlugin)
  .settings(
    libraryDependencies ++= Seq(
      catsCore,
      scalaTest % Test
    )
  )
  .settings(nixDockerSettings: _*)
  .settings(licenseSettings: _*)

lazy val `sbt-nix-native-default` = (project in file("modules/native-default"))
  .enablePlugins(JavaAppPackaging)
  .enablePlugins(DockerPlugin)
  .settings(
    libraryDependencies ++= Seq(
      catsCore,
      scalaTest % Test
    )
  )
  .settings(defaultDockerSettings: _*)
  .settings(licenseSettings: _*)

lazy val `sbt-nix-derivation` = (project in file("modules/nixified"))
  .enablePlugins(JavaAppPackaging)
  .settings(
    libraryDependencies ++= Seq(
      catsCore,
      scalaTest % Test
    )
  )
  .settings(licenseSettings: _*)

lazy val `sbt-nix-wrapper` = (project in file("modules/wrapper"))
  .enablePlugins(JavaAppPackaging)
  .enablePlugins(UniversalPlugin)
  .settings(
    libraryDependencies ++= Seq(
      catsCore,
      scalaTest % Test
    )
  )
  .settings(licenseSettings: _*)
