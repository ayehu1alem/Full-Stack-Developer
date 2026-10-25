#!/usr/bin/env bash
set -euo pipefail

# Netlify's standard image does not guarantee that Flutter is installed.
# Install the stable SDK into the build user's home directory when needed.
FLUTTER_HOME="${HOME}/flutter"
if [ ! -x "${FLUTTER_HOME}/bin/flutter" ]; then
  git clone --depth 1 --branch stable https://github.com/flutter/flutter.git "${FLUTTER_HOME}"
fi

export PATH="${FLUTTER_HOME}/bin:${PATH}"
flutter --version
flutter config --enable-web
flutter pub get
flutter test
flutter build web --release
