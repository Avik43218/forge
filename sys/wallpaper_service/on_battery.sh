#!/bin/bash

export USER_ID=$(id -u)
export XDG_RUNTIME_DIR="/run/user/$USER_ID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

dbus-send --session --dest=org.kde.plasmashell --type=method_call \
/PlasmaShell org.kde.PlasmaShell.evaluateScript \
"string:
var allDesktops = desktops();
for (var i = 0; i < allDesktops.length; i++) {
    var d = allDesktops[i];
    d.wallpaperPlugin = 'org.kde.image';
    d.currentConfigGroup = ['Wallpaper', 'org.kde.image', 'General'];
    d.writeConfig('Image', 'file:///home/$USER/Pictures/Wallpapers/picture.jpg');
}"

