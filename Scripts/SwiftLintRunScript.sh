# #!/bin/sh

# #  SwiftLintRunScript.sh
# #  Manifests
# #
# #  Created by 김찬수 on 2023/04/28.
# #

export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin"
if which swiftlint >/dev/null; then
    cd ${SRCROOT} && swiftlint
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
