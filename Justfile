#!/usr/bin/env just --justfile
# Documentation: https://just.systems/man/en/

set shell := ['nu', '-c']

# Integration with nodejs package.json scripts, see https://just.systems/man/en/chapter_65.html

export PATH := env('PWD') / 'node_modules/.bin:' + env('PATH')

# To override the value of SOME_VERSION, run: just --set SOME_VERSION 1.2.4 TARGET_NAME

SOME_VERSION := '1.2.3'

# Print this help
default:
    @just -l

# Format Justfile
format:
    @just --fmt --unstable

# Install git commit hooks
githooks:
    #!/usr/bin/env nu
    $env.config = { use_ansi_coloring: false, error_style: "plain" }
    let hooks_folder = '.githooks'
    if (git config core.hooksPath) != $hooks_folder {
      print 'Installing git commit hooks'
      git config core.hooksPath $hooks_folder
      # npm install -g @commitlint/config-conventional
    }
    if not ($hooks_folder | path exists) {
      mkdir $hooks_folder
      "#!/usr/bin/env -S sh\nset -eu\njust test" | save $"($hooks_folder)/pre-commit"
      chmod 755 $"($hooks_folder)/pre-commit"
      "#!/usr/bin/env -S sh\nset -eu\n\nMSG_FILE=\"$1\"\nPATTERN='^(fix|feat|docs|style|chore|test|refactor|ci|build)(\\([a-z0-9/-]+\\))?!?: [a-z].+$'\n\nif ! head -n 1 \"${MSG_FILE}\" | grep -qE \"${PATTERN}\"; then\n\techo \"Your commit message:\" 1>&2\n\tcat \"${MSG_FILE}\" 1>&2\n\techo 1>&2\n\techo \"The commit message must conform to this pattern: ${PATTERN}\" 1>&2\n\techo \"Contents:\" 1>&2\n\techo \"- follow the conventional commits style (https://www.conventionalcommits.org/)\" 1>&2\n\techo 1>&2\n\techo \"Example:\" 1>&2\n\techo \"feat: add super awesome feature\" 1>&2\n\texit 1\nfi"| save $"($hooks_folder)/commit-msg"
      chmod 755 $"($hooks_folder)/commit-msg"
      # if not (".commitlintrc.yaml" | path exists) {
      # "extends:\n  - '@commitlint/config-conventional'" | save ".commitlintrc.yaml"
      # }
      # git add $hooks_folder ".commitlintrc.yaml"
      git add $hooks_folder
    }

# Update README.md
update: githooks
    #!/usr/bin/env nu
    let repository = "github.com/identinet/presentations"
    let slidesdown = "https://slidesdown.github.io/?slides="
    glob "*/metadata.json" | sort -rn | each {|filename|
      let metadata = open $filename
      let folder = $filename | path dirname | path basename
    let presenter = $metadata.Presenter
      let metadata = $metadata | upsert Title $"<a name="($folder)" href="#($folder)">($in.Title)</a>"
      let metadata = $metadata | upsert Place $"<a href="($in.Place.url)">($in.Place.name)</a>"
      let metadata = $metadata | upsert Presenter ($in.Presenter | each { $"<a href="($in.url)">($in.name)</a>" } | str join " and ")
      let metadata = $metadata | upsert Slides $"[![($metadata.Title)]\(./($folder)/preview.png\)]\(($slidesdown)($repository)/($folder)/SLIDES.md\)"
      let metadata = $metadata | insert Source $"<a href="https://($repository)/tree/main/($folder)">($folder)</a>"
      $metadata
    } | to md | lines |
    insert 0 "# [identinet](https://identinet.io) presentations" |
    insert 1 $"[GitHub Repository]\(https://($repository)\)" |
    insert 2 "" |
    to text | save -f README.md

# Test application
test:
    # not yet implemented
