#!/bin/zsh

# Create the script file
touch ~/moit_fetch.sh

# Open the file and add the commands
echo '#!/bin/zsh
tuist fetch
rm -rf Tuist/Dependencies/Carthage/Checkouts/PinLayout/TestProjects
carthage build PinLayout --project-directory Tuist/Dependencies --platform iOS --use-xcframeworks --no-use-binaries --use-netrc --cache-builds --verbose
tuist fetch' > ~/moit_fetch.sh

# Make the script executable
chmod +x ~/moit_fetch.sh
chmod +x ~/.zshrc

# Add the new command to the .zshrc file
echo 'moit() {
    if [ "$1" = "fetch" ]; then
        ~/moit_fetch.sh
    elif [ "$1" = "generate" ]; then
        tuist generate
    elif [ "$1" = "clean" ]; then
        tuist clean
    elif [ "$1" = "edit" ]; then
        tuist edit
    else
        echo "Invalid command."
    fi
}' >> ~/.zshrc

# Reload .zshrc so the changes take effect immediately
source ~/.zshrc

# echo "" >> ~/.zshrc
# echo "moit() {" >> ~/.zshrc
# echo "    if [ \"\$1\" == \"fetch\" ]; then" >> ~/.zshrc
# echo "        ~/moit_fetch.sh" >> ~/.zshrc
# echo "    else" >> ~/.zshrc
# echo "        echo \"Invalid command. Use 'fetch'.\"" >> ~/.zshrc
# echo "    fi" >> ~/.zshrc
# echo "}" >> ~/.zshrc
# echo "" >> ~/.zshrc
