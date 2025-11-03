#!/usr/bin/env just --justfile
# Documentation: https://just.systems/man/en/

set shell := ['nu', '-c']

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
        "#!/usr/bin/env -S sh\nset -eu\n\nMSG_FILE=\"$1\"\nPATTERN='^(fix|feat|docs|style|chore|test|refactor|ci|build)(\\([A-Za-z0-9_/-]+\\))?!?: [a-z].+$'\n\nif ! head -n 1 \"${MSG_FILE}\" | grep -qE \"${PATTERN}\"; then\n\techo \"Your commit message:\" 1>&2\n\tcat \"${MSG_FILE}\" 1>&2\n\techo 1>&2\n\techo \"The commit message must conform to this pattern: ${PATTERN}\" 1>&2\n\techo \"Contents:\" 1>&2\n\techo \"- follow the conventional commits style (https://www.conventionalcommits.org/)\" 1>&2\n\techo 1>&2\n\techo \"Example:\" 1>&2\n\techo \"feat: add super awesome feature\" 1>&2\n\texit 1\nfi"| save $"($hooks_folder)/commit-msg"
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
    let repository = "identinet/presentations"
    let github_repository = $"github.com/($repository)"
    let slidesdown = "https://slidesdown.github.io/?slides="
    glob "*/metadata.json" | sort -rn | each {|filename|
        let metadata = open $filename
        let extended_metadata = {}
        let folder = $filename | path dirname | path basename
        let presenter = $metadata.Presenter
        let extended_metadata = $metadata | upsert Title $"<a name="($folder)" href="#($folder)">($in.Title)</a>"
        let extended_metadata = $extended_metadata | upsert Location $"<a href="($in.Location.url)">($in.Location.name)</a>"
        let extended_metadata = $extended_metadata | upsert Presenter ($in.Presenter | each { $"<a href="($in.url)">($in.name)</a>" } | str join " and ")
        let url = [$slidesdown ([$github_repository $folder SLIDES.md] | path join)] | str join ""
        let optimized_preview = [$folder preview_optimized.png] | path join
        let preview_raw_url = [https://raw.githubusercontent.com $repository refs/heads/main $folder preview_optimized.png] | path join
        let preview_small = [$folder preview_small.png] | path join
        if not ($preview_small | path exists) { convert -resize 240x $optimized_preview $preview_small }
        let extended_metadata = $extended_metadata | upsert Slides $"[![($metadata.Title)]\(./($preview_small)\)]\(./($folder)\)"
        let extended_metadata = $extended_metadata | insert Source $"<a href="https://($github_repository)/tree/main/($folder)">($folder)</a>"
        $"<!doctype html>
    <html>
      <head>
        <meta charset=\"utf-8\" />
        <title>Redirecting to https://slidesdown.github.io/</title>
        <meta http-equiv=\"refresh\" content=\"0; URL=($url)\" />
        <meta content=\"($preview_raw_url)\" property=\"og:image\">
        <meta content=\"1200\" property=\"og:image:width\">
        <meta content=\"630\" property=\"og:image:height\">
        <meta content=\"($metadata.Presenter)\" property=\"og:article:author\">
        <meta content=\"@identinet\" name=\"twitter:site\">
        <meta content=\"($metadata.Title)\" property=\"og:title\">
        <meta content=\"@identinet\" name=\"twitter:creator\">
        <meta content=\"summary_large_image\" name=\"twitter:card\">
        <meta content=\"($metadata.Language)\" property=\"og:locale\">
        <link rel=\"canonical\" href=\"https://presentations.identinet.io\" />
        <script src=\"https://scripts.simpleanalyticscdn.com/latest.js\" async=\"\"></script>
      </head>
      <body>
        <h1>Redirecting to https://slidesdown.github.io/</h1>
      </body>
    </html>" | save -f ([$folder index.html] | path join)
        $"# ($metadata.Title) — ($metadata.Date)

    | Presenter | Location | Slides |
    | - | - | - |
    | ($extended_metadata.Presenter) | ($extended_metadata.Location) | [![($metadata.Title)]\(./($preview_small | path basename)\)]\(($url)\) |" | save -f ([$folder README.md] | path join)
        $extended_metadata
    } | to md | lines |
    insert 0 "# [identinet](https://identinet.io) presentations" |
    insert 1 $"[GitHub Repository]\(https://($repository)\)" |
    insert 2 '<script src="https://scripts.simpleanalyticscdn.com/latest.js" async=""></script>' |
    insert 3 "" |
    to text | save -f README.md

# Test application
test:
    # not yet implemented
