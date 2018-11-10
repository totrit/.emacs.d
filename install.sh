#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null && pwd  )"
# Copy to .emacs to HOME dir
cp $DIR/.emacs $DIR/..
# Install Emacs
brew cask install emacs
# Download dependencies to 'vendor' folder
mkdir -p $DIR/vendor
wget https://cytranet.dl.sourceforge.net/project/plantuml/plantuml.jar -O $DIR/vendor/plantuml.jar
# Install external executables
brew install proselint # For Flycheck - syntax check
brew install aspell # For spell check
# Launch Emacs to see if it works
/Applications/Emacs.app/Contents/MacOS/Emacs
