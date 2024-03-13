---
# Metadata about the presentation:
title: DIF Linked Verifiable Presentation
author: Jan Christoph Ebersbach
date: 2024-02-26
keywords: dif linked-vp identifiers discovery verifiable credential presentation did

# Presentation settings:
# URL to favicon
# favicon: /favicon.svg
favicon: https://identinet.github.io/slidesdown-theme/images/favicon.svg
# Theme, list of supported themes: https://github.com/slidesdown/slidesdown/tree/main/docs/reveal.js/dist/theme
# theme: white
theme: https://identinet.github.io/slidesdown-theme/identinet.css
# Code highlighting theme, list of supported themes: https://github.com/slidesdown/slidesdown/tree/main/docs/reveal.js/plugin/highlight
highlight-theme: tokyo-night-dark

# Show progress bar
progress: true
# Show controls
controls: false
# Center presentation
center: true
# Create separate pages for fragments
pdfSeparateFragments: false
# Full list of supported settings: https://revealjs.com/config/ or
# https://github.com/hakimel/reveal.js/blob/master/js/config.js
---

# DIF Work Item linked-vp

<!-- generated with
!deno run --unstable --allow-read --allow-write https://deno.land/x/remark_format_cli@v0.2.0/remark-format.js --maxdepth 2 %
-->

## Agenda

1. [Introduction](#introduction)
2. [Status](#status)
3. [Demo](#demo)
4. [Next Steps](#next-steps)
5. [Approval by Working Group](#approval-by-working-group)

## Introduction

- Numerous interactive protocols exist for sharing Verifiable Credentials
  privately (OpenID4VC and DIDComm Messaging)
- How to discover and access verifiable data prior to an interaction?

### Use Cases

- Discover verifiable data about a website
- Simplify onboarding of suppliers and customers
- Make mandatory data verifiable
- Decentralized business network
- Replicate X.509 certificates

## Status

- Linked-vp specification defines a new service endpoint for DID documents that
  links to Verifiable Presentations.

```json [4-6]
"service": [
  {
    "id": "did:example:123#foo",
    "type": "LinkedVerifiablePresentation",
    "serviceEndpoint":
      "https://bar.example.com/presentation.json"
  },
```

### History 1

- Original idea for specification created during did:hack:
  [identinet-plugin](https://github.com/identinet/identinet-plugin)
- Linked-vp approval as work item in Nov 2023
- Monthly meetings held to advance the specification

### History 2

- Specification publicly hosted: <https://identity.foundation/linked-vp>
- Custom JSON-LD context created for type `LinkedVerifiablePresentation`
- Known implementations:
  [identinet-plugin](https://github.com/identinet/identinet-plugin)

## Demo

<img class="shadow-md" src="./plugin.png" />

## Next Steps

<div class="text-4xl">

| Status    | Task                                                                                                                          |
| --------- | ----------------------------------------------------------------------------------------------------------------------------- |
| ↻ Pending | Presentation to gain Working Group Approval                                                                                   |
| ↻ Pending | Addition to DID Specification Registries                                                                                      |
| ☐ Todo    | Define test vectors for conformance testing                                                                                   |
| ☐ Todo    | Add permanent link to DIF's [spec tracking repository](https://github.com/decentralized-identity/specs/blob/master/README.md) |

</div>

## Approval by Working Group

<div class="grid grid-cols-2 grid-items-center">

- Questions ❓
- Comments 💭
- Wishes 🪄

<img class="shadow-md" src="./spec.png" />

</div>

---

<h2>References</h2>

- DIF linked-vp specification: https://identity.foundation/linked-vp/
- Git repository linked-vp: https://github.com/decentralized-identity/linked-vp
