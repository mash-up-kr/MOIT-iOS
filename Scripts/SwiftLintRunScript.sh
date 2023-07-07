# #!/bin/sh

# #  SwiftLintRunScript.sh
# #  Manifests
# #
# #  Created by 김찬수 on 2023/04/28.
# #

export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin"
if which swiftlint >/dev/null; then

    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

    swiftlint --config "$DIR/.swiftlint.yml" 2>/dev/null || true

else
    echo "warning: SwiftLint not installed, download from"
fi
