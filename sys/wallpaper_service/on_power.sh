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
    d.wallpaperPlugin = 'luisbocanegra.smart.video.wallpaper.reborn';
    d.currentConfigGroup = ['Wallpaper', 'luisbocanegra.smart.video.wallpaper.reborn', 'General'];
    d.writeConfig('VideoUrls', 'file:///home/$USER/Pictures/Wallpapers/video.mp4');
}"
