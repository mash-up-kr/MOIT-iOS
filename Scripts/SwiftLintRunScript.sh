# #!/bin/sh

# #  SwiftLintRunScript.sh
# #  Manifests
# #
# #  Created by 김찬수 on 2023/04/28.
# #

export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin"
if which swiftlint >/dev/null; then
    # Use the directory of the parent of this script as the working directory
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
    cd "$DIR"
    swiftlint --config .swiftlint.yml
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi