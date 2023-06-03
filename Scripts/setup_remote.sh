#!/bin/zsh

# Create the script file
touch moit_fetch.sh

# Open the file and add the commands
echo '#!/bin/zsh
tuist fetch
rm -rf Tuist/Dependencies/Carthage/Checkouts/PinLayout/TestProjects
carthage build PinLayout --project-directory Tuist/Dependencies --platform iOS --use-xcframeworks --no-use-binaries --use-netrc --cache-builds --verbose
tuist fetch' > moit_fetch.sh

# Make the script executable
chmod +x moit_fetch.sh

./moit_fetch.sh
