# Alemayehu Bitew — Developer Portfolio

A responsive personal portfolio built with Flutter Web, using an amber, charcoal, and off-white visual system.

**Positioning:** Full-Stack Developer and Digital Marketer  
**Live portfolio:** https://ayehualem.netlify.app/  
**GitHub profile:** https://github.com/ayehu1alem

## Project status

This repository was confirmed empty before the initial scaffold was added. This is a fresh implementation foundation, not a recovered copy of the currently deployed website. The existing Netlify site is not changed by commits to this repository unless you separately connect this repository to its deployment pipeline.

## Run locally

Install the Flutter SDK, then run:

```bash
flutter pub get
flutter run -d chrome
```

Build a release website:

```bash
flutter build web --release
```

Flutter writes the deployable site to `build/web`.

## Netlify

The included `netlify.toml` uses `build/web` as the publish directory and `tool/netlify_build.sh` to install/use Flutter in a Linux build environment. Once this repository is connected to a Netlify site, verify the build log and deploy preview before changing any existing production site. Do not change your current site's repository or production settings until you have reviewed the preview.

## Personalize before final launch

Review `lib/main.dart` and update the following with verified details:
- Project descriptions, status, and links.
- Preferred professional contact email and social profiles.
- Any certificates, education, dates, metrics, and client permissions you want to publish.

No unverified years of experience, client outcomes, testimonials, or contact addresses are claimed in this starter.

## Quality checklist

- [ ] Run `flutter analyze`.
- [ ] Run `flutter test`.
- [ ] Build with `flutter build web --release`.
- [ ] Test mobile, tablet, and desktop layouts.
- [ ] Confirm all public links and contact details.
- [ ] Inspect a Netlify deploy preview before publishing.

## SEO note

The HTML document includes a descriptive title, description, canonical URL, theme color, and social metadata. Flutter Web renders most application content through its app renderer, so a portfolio whose primary goal is search traffic may benefit later from a semantic HTML/static-site landing page or a hybrid approach. See the official [Flutter Web deployment guide](https://docs.flutter.dev/deployment/web).
