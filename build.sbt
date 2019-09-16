micrositeName := "sbt-microsites-multiversion"
micrositeDescription := "sbt-microsites-multiversion description"
micrositeAuthor := "ACME"
micrositeDocumentationUrl := "docs"
micrositeOrganizationHomepage := "https://www.47deg.com"
micrositeGithubOwner := "calvellido"
micrositeGithubRepo := "sbt-microsites-multiversion"
micrositeGitterChannel := false
micrositePushSiteWith := GitHub4s
micrositeGithubToken := getEnvVar("GITHUB_TOKEN")

enablePlugins(MicrositesPlugin)
