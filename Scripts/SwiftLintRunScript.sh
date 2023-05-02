#!/bin/sh

#  SwiftLintRunScript.sh
#  Manifests
#
#  Created by 김찬수 on 2023/04/28.
#

export PATH="$PATH:/opt/homebrew/bin"
if which swiftlint >/dev/null; then
    swiftlint
else
    echo "warning: SwiftLint not installed, download form https://github.com/realm/SwiftLint"
fi
