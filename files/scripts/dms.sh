#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
sudo -v && curl -fsSL https://install.danklinux.com | sh -s -- \
  -c hyprland -t kitty --include-deps dms-greeter --replace-configs-all -y
