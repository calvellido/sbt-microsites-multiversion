import microsites._

micrositeName := "sbt-microsites-multiversion"
micrositeDescription := "sbt-microsites-multiversion description"
micrositeAuthor := "ACME"
micrositeUrl := "https://calvellido.github.io/sbt-microsites-multiversion/"
micrositeBaseUrl := "sbt-microsites-multiversion"
micrositeDocumentationUrl := "docs"
micrositeOrganizationHomepage := "https://www.47deg.com"
micrositeGithubOwner := "calvellido"
micrositeGithubRepo := "sbt-microsites-multiversion"
micrositeGitterChannel := false
micrositePushSiteWith := GitHub4s
micrositeGithubToken := sys.env.get("GITHUB_TOKEN")
// micrositePalette := Map(
//         "brand-primary" -> "violet",
//         "brand-secondary"       -> "red",
//         "white-color"      -> "#FFFFFF"
// )
// micrositePalette := Map(
//         "brand-primary"     -> "#E05236",
//         "brand-secondary"   -> "#3F3242",
//         "brand-tertiary"    -> "#2D232F",
//         "gray-dark"         -> "#453E46",
//         "gray"              -> "#837F84",
//         "gray-light"        -> "#E3E2E3",
//         "gray-lighter"      -> "#F4F3F4",
//         "white-color"       -> "#FFFFFF")
// micrositeTheme := "pattern"
// micrositeHighlightLanguages ++= Seq("protobuf", "thrift")
// micrositeHighlightTheme := "monokai"
micrositeVersionList := List("0.1.0", "0.2.0")

enablePlugins(MicrositesPlugin)
