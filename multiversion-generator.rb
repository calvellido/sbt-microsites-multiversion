#!/usr/bin/env ruby
require 'json'

## VERSIONED DOCS GENERATION ##

# If you want a specific version to be served as default, set this value to the
# branch/tag you want. Otherwise it will be the latest version on alphabetical order.
# If there's no tags, then `master` branch content will be served at root path.
$default_version = "0.2.0"

# If you want to build the current branch (usually `master`) and serve it,
# set the path/name in here. If you leave it empty no site will be built for it.
$current_branch_path = "next"

# This is a list to filter -out- tags we know are not valuable to generate docs
# for. If you set one tag in the default_version, you can add it here, so it's
# not generated twice. Unless you want to have the same content at two paths.
$invalid_tags = ["0.2.0"]

# This is a list to filter -in- tags. Unless it's empty, where it will be ignored.
# If you want an empty tags list in the end (for some reason ¯\_(ツ)_/¯)
# you can cancel these filterings with both lists having the same values:
# invalid_tags = ["0.1.0"], valid_tags = ["0.1.0"]
$valid_tags = []

# The path of the dir where the Jekyll source is located.
$source_dir = "target/site"

# The path of the dir that will be published. Check out GitHub Pages/Travis for this.
$publishing_dir = "pub-dir"

# The path of the dir to temporarily store the different sites content.
$gen_docs_dir = "gen-docs"


# Generate the Jekyll site through sbt-microsites based on the contents source.
#
# @param version [String] The version for which the sbt-microsites site will be generated.
# @param versions_list [Array] The list of versions available to select in the whole project.
# @return [nil] nil.
def generate_microsite(version, versions_list)
  system "echo == Generating site for #{version}"
  # this_versions = versions_list.dup;
  # this_versions[versions_list.find_index("title" => version)] = {
  #   "title" => version,
  #   "this" => true
  # };
  # micrositeDataDirectory
  # `mkdir -p #{$source_dir}/_data`
  # File.write("#{$source_dir}/_data/versions.json", JSON.pretty_generate(this_versions))
  # Removing lockfile to avoid conflicts in case it differs between versions
  # system "rm #{$source_dir}/Gemfile.lock"
  # sbt ++$TRAVIS_SCALA_VERSION ^^$SBT_VERSION clean compile test

  currentMicrositeBaseUrl = `sbt --error 'print micrositeBaseUrl'`.strip
  system "echo == micrositeBaseUrl is #{currentMicrositeBaseUrl} lalalala"
  system "echo == micrositeBaseUrl will become #{currentMicrositeBaseUrl}/#{version}"

  # system "sbt makeMicrosite";
  `sbt 'set micrositeBaseUrl := "#{currentMicrositeBaseUrl}/#{version}"' makeMicrosite`

  # system "JEKYLL_ENV=production BUNDLE_GEMFILE=./#{$source_dir}/Gemfile bundle exec jekyll build -s #{$source_dir} -d #{$gen_docs_dir}/#{version} -b #{version}"
  # system "rm -rf #{$source_dir}/docs"
  `mkdir -p #{$gen_docs_dir}`
  `mkdir -p #{$gen_docs_dir}/#{version}`

  `mv #{$source_dir}/* #{$gen_docs_dir}/#{version}`

  system "ls -la #{$source_dir}"
  system "ls -la #{$gen_docs_dir}/#{version}"
end


# Initially, we save the name of the current branch/tag to be used later
current_branch_tag = `git name-rev --name-only HEAD`.strip
# system "echo == Current branch/tag is #{current_branch_tag} lalalalala"
# current_branch_tag_chars = current_branch_tag.chars
# system "echo == Current branch/tag chars are #{current_branch_tag_chars}"
# current_branch_tag
system "echo == Current branch/tag is #{current_branch_tag} lalalalalala"

#This is the list of versions that will be built, and used, as part of the process
versions = []
versions.unshift({
  "title" => $default_version,
})

# Besides default, another version that will be available to select will be
# the current branch/tag, if desired through the use of $current_branch_path
if !$current_branch_path.to_s.empty?
  versions.push({
    "title" => $current_branch_path,
  })
end

# Directory initialization
`mkdir -p #{$publishing_dir}`
`mkdir -p #{$gen_docs_dir}`
`touch #{$gen_docs_dir}/.gitkeep`

system "echo == == =="
system "ls -la #{$gen_docs_dir}"
system "echo == == =="


# Initial generic logic and dependencies for the docs site
# system "echo == Installing ruby dependencies"
# system "bundle install --gemfile #{$source_dir}/Gemfile --path vendor/bundle"

# Following logic will process and generate the different releases specific sites

# Then, tags will contain the list of Git tags present in the repo
tags = `git tag`.split("\n")
system "echo == The tags present in the repo are #{tags}"

# This is done to avoid the need to write down all the tags when we want everything in
if !$valid_tags.any?
  $valid_tags = tags
end

if tags.any?
  filtered_out_tags = tags.reject { |t| $invalid_tags.include? t }
  filtered_tags = filtered_out_tags.select { |t| $valid_tags.include? t }
  system "echo == And the tags that will be actually processed are #{filtered_tags}"
  # First iteration is done to have the list of versions available
  filtered_tags.each { |t|
                        versions.push({
                          "title" => t,
                        })
                      }
  filtered_tags.each { |t|
                        system "echo == == =="
                        system "ls -la #{$gen_docs_dir}"
                        system "echo == == =="

                        # `mkdir -p #{$gen_docs_dir}`
                        # `touch #{$gen_docs_dir}/.gitkeep`
                        # system "git add #{$gen_docs_dir}";

                        # system "git reset --hard HEAD";

                        `mkdir -p #{$gen_docs_dir}`
                        `mkdir -p #{$gen_docs_dir}/#{t}`
                        `touch #{$gen_docs_dir}/#{t}/.gitkeep`
                        # system "git add #{$gen_docs_dir}";

                        # system "git clean -dxfn";
                        # system "git clean -dxf";

                        system "git checkout -f #{t}"
                        system "echo == Current branch/tag is now #{t}"

                        system "echo == == =="
                        system "ls -la #{$gen_docs_dir}"
                        system "echo == == =="

                        # `mkdir -p #{$gen_docs_dir}`
                        # system "echo == Compiling the library in #{t}"
                        # system "swift package clean"
                        # system "swift build"
                        generate_microsite("#{t}", versions)
                        # `mv #{$source_dir}/* #{$gen_docs_dir}/#{t}`
                      }

  if filtered_tags.any?
    if $default_version.to_s.empty?
      $default_version = filtered_tags.last
    end
  else
    $default_version = "master"
  end
end


# Now, we generate the content available at the initial branch (master?)
# to be at $current_branch_path (/next?) path
if !$current_branch_path.to_s.empty?
  # system "git reset --hard HEAD";
  # system "git clean -dxfn";
  # system "git clean -dxf";
  `git checkout -f #{current_branch_tag}`
  system "echo == Current branch/tag is now #{current_branch_tag}"
  system "echo == Compiling the library in #{current_branch_tag}"
  # system "swift package clean"
  # system "swift build"
  generate_microsite($current_branch_path, versions)
end

# Finally, we generate the docs for the default version
# system "git reset --hard HEAD";
# system "git clean -dxfn";
# system "git clean -dxf";
`git checkout -f #{$default_version}`
system "echo == Current branch/tag is now #{$default_version}"
# system "echo == Compiling the library in #{current_branch_tag}"
# system "swift package clean"
# system "swift build"

system "echo == Generating microsite for #{$default_version}"
# Let's create the versions file for the default version
# `mkdir -p #{$source_dir}/_data`
# this_versions = versions.dup;
# this_versions[this_versions.find_index("title" => $default_version)] = {
#   "title" => $default_version,
#   "this" => true
# };
# File.write("#{$source_dir}/_data/versions.json", JSON.pretty_generate(this_versions))

# system "nef jekyll --project contents/Documentation --output docs --main-page contents/Home.md"
# The content available in the default branch will be generated by GH Pages itself
# system "ls -la #{$source_dir}"
generate_microsite($default_version, versions)

# We also move the rest of version generated sites to its publishing destination
`mv #{$gen_docs_dir}/* #{$publishing_dir}/`

# We need to remove dependencies dir, as it's unnecessary, and it messes GH Pages
# `rm -rf #{$source_dir}/vendor`

# And finally we move the source to the directory that will be published.
# Remember that this should be the same directory set in GH Pages/Travis.
# `mv #{$source_dir}/* #{$publishing_dir}/`
