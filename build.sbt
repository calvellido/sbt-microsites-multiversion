// lazy val commonSettings = Seq(
//   micrositeDescription := "sbt-microsites-multiversion description",
//   micrositeAuthor := "ACME",
//   micrositeUrl := "https://calvellido.github.io/sbt-microsites-multiversion/",
//   micrositeDocumentationUrl := "docs",
//   micrositeOrganizationHomepage := "https://www.47deg.com",
//   micrositeGithubOwner := "calvellido",
//   micrositeGithubRepo := "sbt-microsites-multiversion",
//   micrositeGitterChannel := false,
//   micrositePushSiteWith := GitHub4s,
//   micrositeGithubToken := sys.env.get("GITHUB_TOKEN")
// )
//
// lazy val root = (project in file("."))
//   .settings(name := "sbt-microsites-multiversion")
//   .aggregate(docs)
//   .dependsOn(docs)
//
// lazy val docs = (project in file("docs"))
//   .settings(moduleName := "sbt-microsites-multiversion-docs")
//   .settings(commonSettings: _*)
//   .enablePlugins(MicrositesPlugin)


micrositeName := "sbt-microsites-multiversion"
micrositeDescription := "sbt-microsites-multiversion description"
micrositeAuthor := "ACME"
micrositeUrl := "https://calvellido.github.io/sbt-microsites-multiversion/"
micrositeDocumentationUrl := "docs"
micrositeOrganizationHomepage := "https://www.47deg.com"
micrositeGithubOwner := "calvellido"
micrositeGithubRepo := "sbt-microsites-multiversion"
micrositeGitterChannel := false
micrositePushSiteWith := GitHub4s
micrositeGithubToken := sys.env.get("GITHUB_TOKEN")

enablePlugins(MicrositesPlugin)
