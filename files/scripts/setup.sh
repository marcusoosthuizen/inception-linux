#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
systemctl --user add-wants hyprland-session.target dms

# changing default shell to zsh
NEW_SHELL=$(which zsh)
sudo sed -i "s|^SHELL=.*|SHELL=$NEW_SHELL|" /etc/default/useradd
