---
# Metadata about the presentation:
title: Veröffentlichte Daten, aber bitte verifizierbar!
author: Jan Christoph Ebersbach
date: 2024-03-12
keywords: ssi did linked-vp vc vp verifiable credential presentation public data

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

# <img src="./chainist.jpg" class="h-[0.8em] shadow-md m-0" /> Veröffentlichte Daten, aber bitte verifizierbar!

Jan Christoph Ebersbach

<!-- generated with
!deno run --unstable --allow-read --allow-write https://deno.land/x/remark_format_cli@v0.1.0/remark-format.js --maxdepth 2 %
-->

## Agenda

<!-- .slide: data-visibility="hidden" -->

1. [Introduction](#introduction)
2. [Status](#status)
3. [Demo](#demo)
4. [Next Steps](#next-steps)
5. [Approval by Working Group](#approval-by-working-group)

## Who am I <div class="i-fa6-solid-question color-[var(--lightPrimary1)] inline-block mb-[-0.2em]"></div>

<div class="grid grid-cols-[1fr_4fr] gap-4 justify-center justify-items-start content-center items-start text-start">
<div class="i-fa6-solid-user color-[var(--lightPrimary1)] justify-self-end"></div> Jan Christoph or JC
<div class="i-fa6-solid-graduation-cap color-[var(--lightPrimary1)] justify-self-end"></div> Computer Scientist
<div class="i-fa6-solid-rocket color-[var(--lightPrimary1)] justify-self-end"></div> Founder identinet
<div class="i-fa6-solid-earth-europe color-[var(--lightPrimary1)] justify-self-end"></div> Bremen, Germany
<div class="i-fa6-solid-heart-pulse color-[var(--lightSecondary1)] justify-self-end"></div> FLOSS, Kubernetes, Blockchain,<br>Self-Sovereign Identity
</div>

## Public / Published Data

<!-- - I will talk about public data and the need to verify it's authenticity with ease. -->

### Examples of org public data

<div class="grid grid-cols-2 items-center">

- Organizational data on imprint page
- Terms of Use, Privacy Policy
- Partner logos and certificates
- Initiatives and services
- EU product passes

<figure>
  <img src="./bund.png" class="shadow-md" />
  <figcaption><small>bund.de</small></figcaption>
</figure>

</div>

### Examples of personal public data

<div class="grid grid-cols-2 items-center">

- LinkedIn personal identity
- Work experience and education

<figure>
  <img src="./linkedin.png" class="shadow-md" />
  <figcaption><small>linkedin.com</small></figcaption>
</figure>

</div>

### Challenges

<div class="grid grid-cols-2">
<div>

- Fraud
- Misrepresentation
- Misattribution

</div>

- Duplication of data in processes
- Discoverability of data
- Verification effort

</div>

### How could we fix the challenges?

<div class="fragment">Provenance!</div>

<div class="fragment">

|             |              |
| ----------- | ------------ |
| who         | Identifier 1 |
| said what   | Data         |
| about whom? | Identifier 2 |

</div>

<div class="fragment">

If I trust `Identifier 1` <span class="fragment">and have access to the
data</span><span class="fragment">, I can start reasoning about
`Identifier 2`!</span>

</div>

## What technologies do we have?

<div class="fragment">Self-Sovereign Identity</div>

### W3C Decentralized Identifiers (DID)

<div class="grid gird-cols-2">

- Global cryptographic identifiers
- DID Document describes current configuration of identifier
- Cryptographic keys can be rotated without changing the identifier
- Various storage backends (web servers to blockchains)

```
did:web:identinet.io
did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup
```

### DID Document

<!-- .slide: data-auto-animate="1" -->

```json []
{
  "@context": ["..."],
  "id": "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup",
  "verificationMethod": [
    {
      "id": "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup#z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup",
      "type": "Ed25519VerificationKey2018",
      "controller": "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup",
      "publicKeyJwk": {
        "kty": "OKP",
        "crv": "Ed25519",
        "x": "mmwK9RmBKslfTt6Fv0ZuRWsQwK6WYQ0JVS1eNuv71pM"
      }
    }
  ],
  "authentication": [
    "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup#z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup"
  ],
  "assertionMethod": [
    "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup#z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup"
  ]
}
```

### DID Document

<!-- .slide: data-auto-animate="1" -->

```json [3]
{
  "@context": ["..."],
  "id": "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup",
  "verificationMethod": [
    {
      "id": "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup#z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup",
      "type": "Ed25519VerificationKey2018",
      "controller": "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup",
      "publicKeyJwk": {
        "kty": "OKP",
        "crv": "Ed25519",
        "x": "mmwK9RmBKslfTt6Fv0ZuRWsQwK6WYQ0JVS1eNuv71pM"
      }
    }
  ],
  "authentication": [
    "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup#z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup"
  ],
  "assertionMethod": [
    "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup#z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup"
  ]
}
```

### DID Document

<!-- .slide: data-auto-animate="1" -->

```json [9-13]
{
  "@context": ["..."],
  "id": "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup",
  "verificationMethod": [
    {
      "id": "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup#z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup",
      "type": "Ed25519VerificationKey2018",
      "controller": "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup",
      "publicKeyJwk": {
        "kty": "OKP",
        "crv": "Ed25519",
        "x": "mmwK9RmBKslfTt6Fv0ZuRWsQwK6WYQ0JVS1eNuv71pM"
      }
    }
  ],
  "authentication": [
    "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup#z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup"
  ],
  "assertionMethod": [
    "did:key:z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup#z6Mkpr4PFqRDEgG3idTrF6HYDy9UXuxBeQna8ETXr7oLvJup"
  ]
}
```

</div>

### W3C Verifiable Credentials (VC)

- Data / claims <!-- .element: class="fragment" -->
- issued from one identifier <!-- .element: class="fragment" -->
- to another identifier <!-- .element: class="fragment" -->
- Verifiable Presentations combine multiple VCs for presentation to a third
  party <!-- .element: class="fragment" -->

### Verifiable Credential

<!-- .slide: data-auto-animate="1" -->

```json []
{
  "@context": ["..."],
  "type": ["VerifiableCredential"],
  "credentialSubject": {
    "id": "did:web:identinet.io",
    "type": "Organization",
    "legalName": "identinet GmbH",
    "address": "Werdertor 2, 28199 Bremen, Germany"
  },
  "issuer": "did:web:identinet.io",
  "issuanceDate": "2024-02-29T08:15:14Z",
  "proof": {
    "type": "Ed25519Signature2020",
    "proofPurpose": "assertionMethod",
    "proofValue": "z4r1qQpD5MAQ5uQn1Zrx47TbcuVAGnsPyZtjwmxaa1gShak1HMsgMf1GaExExn2Syd9mYyAMRErW6JTVQZpedqWV2",
    "verificationMethod": "did:web:id-presentation.localhost%3A8443#LCkuDZkqvwMD8rMY9OKV9MErvOLwDKwlzgVgxuvmuV8",
    "created": "2024-02-29T08:15:15.084079894Z"
  }
}
```

### Verifiable Credential

<!-- .slide: data-auto-animate="1" -->

```json [10]
{
  "@context": ["..."],
  "type": ["VerifiableCredential"],
  "credentialSubject": {
    "id": "did:web:identinet.io",
    "type": "Organization",
    "legalName": "identinet GmbH",
    "address": "Werdertor 2, 28199 Bremen, Germany"
  },
  "issuer": "did:web:identinet.io",
  "issuanceDate": "2024-02-29T08:15:14Z",
  "proof": {
    "type": "Ed25519Signature2020",
    "proofPurpose": "assertionMethod",
    "proofValue": "z4r1qQpD5MAQ5uQn1Zrx47TbcuVAGnsPyZtjwmxaa1gShak1HMsgMf1GaExExn2Syd9mYyAMRErW6JTVQZpedqWV2",
    "verificationMethod": "did:web:id-presentation.localhost%3A8443#LCkuDZkqvwMD8rMY9OKV9MErvOLwDKwlzgVgxuvmuV8",
    "created": "2024-02-29T08:15:15.084079894Z"
  }
}
```

### Verifiable Credential

<!-- .slide: data-auto-animate="1" -->

```json [5]
{
  "@context": ["..."],
  "type": ["VerifiableCredential"],
  "credentialSubject": {
    "id": "did:web:identinet.io",
    "type": "Organization",
    "legalName": "identinet GmbH",
    "address": "Werdertor 2, 28199 Bremen, Germany"
  },
  "issuer": "did:web:identinet.io",
  "issuanceDate": "2024-02-29T08:15:14Z",
  "proof": {
    "type": "Ed25519Signature2020",
    "proofPurpose": "assertionMethod",
    "proofValue": "z4r1qQpD5MAQ5uQn1Zrx47TbcuVAGnsPyZtjwmxaa1gShak1HMsgMf1GaExExn2Syd9mYyAMRErW6JTVQZpedqWV2",
    "verificationMethod": "did:web:id-presentation.localhost%3A8443#LCkuDZkqvwMD8rMY9OKV9MErvOLwDKwlzgVgxuvmuV8",
    "created": "2024-02-29T08:15:15.084079894Z"
  }
}
```

### Verifiable Credential

<!-- .slide: data-auto-animate="1" -->

```json [6-8]
{
  "@context": ["..."],
  "type": ["VerifiableCredential"],
  "credentialSubject": {
    "id": "did:web:identinet.io",
    "type": "Organization",
    "legalName": "identinet GmbH",
    "address": "Werdertor 2, 28199 Bremen, Germany"
  },
  "issuer": "did:web:identinet.io",
  "issuanceDate": "2024-02-29T08:15:14Z",
  "proof": {
    "type": "Ed25519Signature2020",
    "proofPurpose": "assertionMethod",
    "proofValue": "z4r1qQpD5MAQ5uQn1Zrx47TbcuVAGnsPyZtjwmxaa1gShak1HMsgMf1GaExExn2Syd9mYyAMRErW6JTVQZpedqWV2",
    "verificationMethod": "did:web:id-presentation.localhost%3A8443#LCkuDZkqvwMD8rMY9OKV9MErvOLwDKwlzgVgxuvmuV8",
    "created": "2024-02-29T08:15:15.084079894Z"
  }
}
```

## Self-Sovereign Identity & the Web

### How to connect DIDs to a website?

- did:web, did:dns - tightly coupled to the web / DNS
- [Well Known DID Configuration](https://identity.foundation/.well-known/resources/did-configuration/)
  to connect any DID to a website via the `.well-known` path specification

### How to connect VCs to the web?

- Verifiable Credentials are usually stored in a private wallet
  <!-- .element: class="fragment" -->
- Exchange of VCs happens via interactive protocols like DIDComm Messaging and
  OpenID4VC
  <!-- .element: class="fragment" -->

<span class="fragment">Lots of ceremony and technology required before VCs can
be accessed and verified 😩</span>

## DIF Linked Verifiable Presentation Specification

What if Verifiable Credentials could be published and referenced from a DID?

- Open standard available at Decentralized Identity Foundation <br>
  <https://identity.foundation/linked-vp>

### How to use it?

1. Combine multiple Verifiable Credentials into a Verifiable Presentation
   <!-- .element: class="fragment" -->
1. Publish signed presentation at URL <!-- .element: class="fragment" -->
1. Extend DID document with service endpoint of type
   LinkedVerifiablePresentation <!-- .element: class="fragment" -->

```json [4-6]
"service": [
  {
    "id": "did:example:123#foo",
    "type": "LinkedVerifiablePresentation",
    "serviceEndpoint":
      "https://foo.example.com/presentation.json"
  },
```

<!-- .element: class="fragment" -->

## Demo

<figure class="w-[70%] m-auto"}>
  <img class="shadow-md" src="./plugin.png" />
  <figcaption><small>identinet Browser Plugin</small></figcaption>
</figure>

## Special Thanks

- Decentralized Identity Foundation
- DIF Identifiers & Discovery Working Group
- Simon Mang

---

<h2>Thank you for your time!</h2>

<!-- - For which use cases would you like to use the technology? -->
<!-- - Which challenges do you see? -->
<!-- - What is missing to make the technology useful for your use case? -->

---

<h2>References</h2>

- linked-vp specification: <https://identity.foundation/linked-vp/>
- linked-vp git repository:
  <https://github.com/decentralized-identity/linked-vp>
- identinet-plugin: <https://github.com/identinet/identinet-plugin>
