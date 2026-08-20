#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
systemctl --user add-wants hyprland-session.target dms

# changing default shell to zsh
sudo sed -i "s|^SHELL=.*|SHELL=/usr/bin/zsh|" /etc/default/useradd

# remove default bash configs
rm /etc/skel/.bash_logout
rm /etc/skel/.bash_profile
rm /etc/skel/.bashrc

# theming lock screen
setfacl -m u:greeter:x /etc/skel/
setfacl -m u:greeter:x /etc/skel/.config
setfacl -m u:greeter:x /etc/skel/.local
setfacl -m u:greeter:x /etc/skel/.local/state
setfacl -m u:greeter:x /etc/skel/.local/share

sudo chgrp -R greeter /etc/skel/.config/DankMaterialShell
sudo chmod -R g+rX /etc/skel/.config/DankMaterialShell

sudo chgrp -R greeter /etc/skel/.local/state/DankMaterialShell
sudo chmod -R g+rX /etc/skel/.local/state/DankMaterialShell

sudo chgrp -R greeter /etc/skel/.local/share/color-schemes/
sudo chmod -R g+rX /etc/skel/.local/share/color-schemes/

sudo ln -sf /etc/skel/.config/DankMaterialShell/settings.json /var/cache/dms-greeter/settings.json
sudo ln -sf /etc/skel/.local/state/DankMaterialShell/session.json /var/cache/dms-greeter/session.json
sudo ln -sf /etc/skel/.local/share/color-schemes/dms-colors.json /var/cache/dms-greeter/colors.json
