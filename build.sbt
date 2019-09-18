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
