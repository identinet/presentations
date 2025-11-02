---
# This is a Slidesdown presentation. Learn about Slidesdown at https://slidesdown.github.io

# Metadata about the presentation:
title: What is Nix and do I need it?
subject: Introduction to NixOS, nixpkgs and nix
author: Jan Christoph Ebersbach
date: 2025-11-02
keywords: nix nixos nixpkgs linux

# Presentation settings:
# URL to favicon
favicon: https://nixos.wiki/favicon.png
# Theme, list of supported themes: https://github.com/slidesdown/slidesdown.github.io/tree/main/vendor/reveal.js/dist/theme
theme: https://identinet.github.io/slidesdown-theme/identiops.css
# Code highlighting theme, list of supported themes: https://github.com/slidesdown/slidesdown.github.io/tree/main/vendor/highlight.js
highlight-theme: tokyo-night-dark

# Show progress bar
progress: true
# Show controls
controls: false
# Center presentation
center: true
# Create separate pages for fragments
pdfSeparateFragments: false
# Loop the presentation
loop: false
# Controls automatic progression to the next slide
# - 0:      Auto-sliding only happens if the data-autoslide HTML attribute
#           is present on the current slide or fragment
# - 1+:     All slides will progress automatically at the given interval in milliseconds
# - false:  No auto-sliding, even if data-autoslide is present
autoSlide: 0
# Activate the scroll view (disables 3d navigation), see https://revealjs.com/scroll-view/
# view: scroll
# Full list of supported settings:
# - https://revealjs.com/config/
# - https://github.com/hakimel/reveal.js/blob/master/js/config.js
# - https://github.com/slidesdown/slidesdown/blob/main/public/plugin/slidesdown.js#L758
# UnoCSS styling: https://unocss.dev/interactive/ and https://tailwindcss.com/docs
# Icons: https://icones.js.org and https://unocss.dev/presets/icons
---

# What is Nix and do I need it?

<!-- .slide: data-background-image="./figures/NixOS-58829513.webp" -->

<!-- Language, Packages & OS -->

<!-- Author: Jan Christoph Ebersbach -->

note:

- Who am I?
- What's my Linux and NixOS experience?

<style>
/* highlight headings nicely so they stand out against the background */
h2, h3 {
  /* filter: drop-shadow(10px 10px 7px white); */
  border-radius: 0.75rem;
  background-color: rgb(255 255 255 / 0.5);
  padding-left: 1rem;
  padding-right: 1rem;
  margin: 0 0 2em 0;
  display: inline-block;
}
</style>

<!-- generated with
!deno run --allow-read --allow-write https://deno.land/x/remark_format_cli@0.4.0/remark-format.js --maxdepth 2 %
-->

## Agenda

1. [How do you ..](#how-do-you-)
2. [What is Nix?](#what-is-nix)
3. [NixOS](#nixos)
4. [Installation](#installation)
5. [My Use Cases](#my-use-cases)
6. [Challenges](#challenges)
7. [Other resources](#other-resources)

<!-- .element: class="columns-2 gap-20" -->

## How do you ..

- transfer your current software configuration to a new laptop?
  <!-- .element: class="fragment" -->
- remember the settings that make your wifi / audio hardware work?
  <!-- .element: class="fragment" -->
- manage software that's not offered by your Linux distro?
  <!-- .element: class="fragment" -->
- manage software development environments?
  <!-- .element: class="fragment" -->
- deal with conflicting software dependencies between projects, e.g. ruby1.4 &
  <!-- .element: class="fragment" --> ruby2.3 / python2 & python3?

## What is Nix?

- nixpkgs — the largest Linux package collection (120k pkgs)
  <!-- .element: class="fragment" -->
- nix — the functional programming language <!-- .element: class="fragment" -->
- nix — the package manager <!-- .element: class="fragment" -->
- NixOS — OS built on top of nixpkgs <!-- .element: class="fragment" -->

🤯

### What makes nix special for me?

- 🔒 Declarative and reproducible: get exactly what you asked for
- 💪 Powerful: packages and system configuration in one
- 🚁 Versatile: OS, cross-platform packages, create docker containers
- 🤩 Program everything: Nix language for system configuration
- 📈 Extensible: package / option missing? Add it yourself!
- 🚀 Open for contributions: one git repository for all packages

<!-- .element: class="columns-2 gap-10 text-4xl" -->

## NixOS

<!-- .slide: data-background-image="./figures/NixOS-58829513.webp" -->

<https://nixos.org>

Nix: means snow in Latin ❄️

λ: Nix logo is constructed from lambda signs, nod to the functional programming
language Haskell

### Packages - nixpkgs

📦 <https://search.nixos.org/packages>

📦 <https://github.com/NixOS/nixpkgs>

```nix
{
  fonts = {
    packages = with pkgs; [
      inter
      nerd-fonts.jetbrains-mono
    ];
  };
  environment = {
    systemPackages = with pkgs; [
      neovim
      unstable.zoom-us
      # ...
    ];
  }
}
```

note:

- two versions: stable and unstable
- packages contains unfree packages as well - zoom-us
- access to the source
- access to the home page

### System Configuration

🗎 <https://search.nixos.org/options>

```nix
{
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_17;
  boot.initrd.availableKernelModules = [ "nvme" "usbhid" ];
  boot.kernelModules = [ "kvm-amd" ];
  fileSystems."/home" = {
    device = "/dev/mapper/system";
    fsType = "btrfs";
    options = [ "subvol=@home" "autodefrag" "ssd" "noatime" ];
  };
}
```

note:

- Configurations differ between versions!
- Configuration of systemd services

### How Nix works

| Path                           | Used for                                                                                                                           |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| `/etc/nixos`                   | NixOS system configuration                                                                                                         |
| `/nix/store`                   | Extracted packages, e.g. `/nix/store/7fl78lyglbprcy21jlxh9vk7hvm0n8s0-neovim-0.11.4/`                                              |
| `/nix/var/nix/profiles/system` | NixOS current system configuration profile that links to all included packages (multiple configuration can exist at the same time) |
| `PATH` & `LD_LIBRARY_PATH`     | Heavily used to provide (force) the exact environment that a package needs via wrapper scripts — not more, not less!               |

<!-- .element: class="text-2xl" -->

note:

- Each package uniquely comes with what it needs
- Declare dependencies, runtime (native) and build (build), in configuration
- Dependencies are LD\_LIBRARY\_PATH-linked into the package’s environment
- No internet/network access during build
- No external file system access during build
- Build environment is immutable
- Package store is immutable
- Packages are made available to the whole system via profiles
- Multiple profiles can exist, e.g. an update creates a new profile
- Profiles can be created spontaneously for a shell that I want to execute

### Other related Topics

### Home-Manager

- If I can manage my OS configuration with Nix, why can't I use it for my user
  configuration and dotfiles?
- <https://nix-community.github.io/home-manager/>

### Flakes

- nixpkgs is the all-encompassing package repository. If one package depends on
  another, it is referred to within the same version of the repository -
  reproducible!
- How do I pin package versions when my package isn't part of nixpkgs?
- <https://nixos.wiki/wiki/Flakes>

→ Flakes are the future, don't use plain nixpkgs anymore! nixpkgs also ships a
flake configuration! <!-- .element: class="text-blue" -->

## Installation

- NixOS: use NixOS as the main operating system
- nixpkgs: install nixpkgs alongside your existing OS - Linux, macOS, Windows

https://nixos.org

### Usage

<!-- .slide: data-background-image="./figures/cheatsheet.png" -->

<a href="https://nixcademy.com/downloads/cheatsheet.pdf" class="!text-white bg-blue py-2 px-4 rounded-full underline shadow">nixcademy.com/downloads/cheatsheet.pdf</a>

## My Use Cases

### Package software I need

- `dyff`: <https://search.nixos.org>
- 🎉 Nixpkgs comes with support for lots of programming languages:
  <https://nixos.org/manual/nixpkgs/stable/#chap-language-support>
- 🤯 GitHub Actions automatically create PRs for software updates:
  <https://github.com/NixOS/nixpkgs/pulls>

### Desktop / Server OS

- Package configuration
- System configuration
  - Hardware
  - Backup
  - Systemd
  - Services
- 🚀 Flakes enabled for full reproduciblity

### Docker / OCI image creation

- OCI images are layers of file systems
- Each instruction in a `Dockerfile` creates a new layer
- A nix package is fully self-contained software package that can be executed on
  its own
- 🤯 Nixpkgs can output nix packages as OCI images
- 🚀 No more `Dockerfile` magic, just name your packages and entrypoint and
  you're done!

### Development environment

- For each software project, I create a flake that tracks all dependencies and
  pins them
  - Initialize flake: `nix flake init`
- A flake can have multiple outputs: OCI image, package, and shell
  - Start shell: `nix develop`
- [direnv](https://direnv.net) integrates nicely with Nix for automated
  development shells!
  - Load all dependencies: `cd my-project`
- Example project: <https://github.com/identinet/identinet>
- Alternative: <https://devenv.sh/>

## Challenges

- ♻️ Release cycle 6 months
- 😱 120k packages, sometimes things break
- 😅 Nix language has interesting quirks - the main challenge is to learn the
  standard library
- 🫣 Nix Flakes: the future of nix packages is still experimental
- 😢 Manually downloaded software doesn't work because the Nix system doesn't
  provide any system-wide libraries

## Other resources

- Nix, nixpkgs and NixOS manuals: <https://nixos.org/learn/>
- NixOS Wiki <https://wiki.nixos.org> (helpful for NixOS but incomplete, combine
  it with [ArchWiki](https://wiki.archlinux.org))
- Slides: https://github.com/identinet/presentations

---

<h2>The End</h2>

I ❤️ Nix ❄️

Thank you for your time.
