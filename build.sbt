micrositeName := "sbt-microsites-multiversion"
micrositeDescription := "sbt-microsites-multiversion description"
micrositeAuthor := "ACME"
micrositeDocumentationUrl := "docs"
micrositeOrganizationHomepage := "https://www.47deg.com"
micrositeGithubOwner := "calvellido"
micrositeGithubRepo := "sbt-microsites-multiversion"
micrositeGitterChannel := false
micrositePushSiteWith := GitHub4s
micrositeGithubToken := Option(System.getenv().get(name("GITHUB_TOKEN")))

enablePlugins(MicrositesPlugin)
