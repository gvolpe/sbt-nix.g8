import Dependencies._
import com.typesafe.sbt.packager.docker._

ThisBuild / scalaVersion     := "$scala_version$"
ThisBuild / version          := "0.1.0-SNAPSHOT"
ThisBuild / organization     := "$organization$"

val nixDockerSettings = List(
  name := "sbt-nix-bootstrap-custom",
  dockerCommands := Seq(
    Cmd("FROM", "base-jre:latest"),
    Cmd("COPY", "1/opt/docker/lib/*.jar", "/lib/"),
    Cmd("COPY", "2/opt/docker/lib/*.jar", "/app.jar"),
    ExecCmd("ENTRYPOINT", "java", "-cp", "/app.jar:/lib/*", "$organization$.$name$.Hello")
  )
)

lazy val root = (project in file("."))
  .enablePlugins(JavaAppPackaging)
  .enablePlugins(DockerPlugin)
  .settings(
    libraryDependencies ++= Seq(
      catsCore,
      scalaTest % Test
    )
  )
  .settings(nixDockerSettings: _*)
