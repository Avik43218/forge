#!/bin/bash

CURR_VIDEO=$(grep -Po '(?<=VideoUrls=)file://.*' ~/.config/plasma-org.kde.plasma.desktop-appletsrc | head -n 1)

export USER_ID=$(id -u)
export XDG_RUNTIME_DIR="/run/user/$USER_ID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

if [ -z "$1" ]; then
    dbus-send --session --dest=org.kde.plasmashell --type=method_call \
    /PlasmaShell org.kde.PlasmaShell.evaluateScript \
    "string:
    var allDesktops = desktops();
    for (var i = 0; i < allDesktops.length; i++) {
        var d = allDesktops[i];
        d.wallpaperPlugin = 'luisbocanegra.smart.video.wallpaper.reborn';
        d.currentConfigGroup = ['Wallpaper', 'luisbocanegra.smart.video.wallpaper.reborn', 'General'];
        d.writeConfig('VideoUrls', '$CURR_VIDEO');
        d.writeConfig('LastVideo', '');
    }"

else 
    dbus-send --session --dest=org.kde.plasmashell --type=method_call \
    /PlasmaShell org.kde.PlasmaShell.evaluateScript \
    "string:
    var allDesktops = desktops();
    for (var i = 0; i < allDesktops.length; i++) {
        var d = allDesktops[i];
        d.wallpaperPlugin = 'luisbocanegra.smart.video.wallpaper.reborn';
        d.currentConfigGroup = ['Wallpaper', 'luisbocanegra.smart.video.wallpaper.reborn', 'General'];
        d.writeConfig('VideoUrls', 'file:///home/$USER/Pictures/Wallpapers/$1');
        d.writeConfig('LastVideo', '');
    }"
fi
