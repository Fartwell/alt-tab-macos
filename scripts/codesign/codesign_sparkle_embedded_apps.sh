#!/usr/bin/env bash

# set to empty for debug builds
OTHER_CODE_SIGN_FLAGS="${OTHER_CODE_SIGN_FLAGS:-}"

set -exu

if [[ -z "${CODE_SIGN_IDENTITY:-}" || "${CODE_SIGNING_ALLOWED:-YES}" == "NO" ]]; then
	echo "Skipping Sparkle embedded app codesign; no signing identity available."
	exit 0
fi

# codesign --deep is only 1 level deep. It misses Sparkle embedded app AutoUpdate
# this build phase script works around the issue

codesign --verbose --force --sign "$CODE_SIGN_IDENTITY" $OTHER_CODE_SIGN_FLAGS "${CODESIGNING_FOLDER_PATH}/Contents/Frameworks/Sparkle.framework/Versions/A/Resources/Autoupdate.app"
