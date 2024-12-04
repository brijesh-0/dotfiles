#!/bin/bash

sudo apt purge -y staruml

if [ -d "/usr/bin/staruml" ]; then
  sudo rm -rf /usr/bin/staruml
fi

if [ -d "/usr/share/doc/staruml" ]; then
  sudo rm -rf /usr/share/doc/staruml
fi

if [ -d "$HOME/.config/StarUML" ]; then
  rm -rf $HOME/.config/StarUML
fi

DEB_URL="https://staruml.io/api/download/releases-v6/StarUML_6.3.0_amd64.deb"
DEB_FILE="StarUML_6.3.0_amd64.deb"

curl -L $DEB_URL --output $DEB_FILE

sudo dpkg -i $DEB_FILE

# sudo apt-get install -f -y

# rm -f $DEB_FILE

echo "StarUML has been successfully reinstalled!"

