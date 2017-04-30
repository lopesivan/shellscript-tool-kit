#!/usr/bin/env bash

wide="file:///home/ivan/Imagens/cropped-3840-2160-478587.jpg"
base="$HOME/Imagens/Backgrounds"
depth=2 # set as required

function getpics() {
    find "$1" -maxdepth $depth -type f -iregex ".*\(jpg\|jpeg\|gif\|png\|bmp\)$"
}

set_picture()
{
    echo setting picture
    photo=$(getpics "$base" | shuf -n1)
    uri="file://$photo"
    DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.screensaver picture-options "scaled"
    DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-options "scaled"
    DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri "$uri"
    echo $uri
}

set_wide_picture()
{
    echo setting to wide picture
    DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.screensaver picture-options "spanned"
    DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-options "spanned"
    DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.screensaver picture-uri "$wide"
    DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri "$wide"
}

xrandr -q| grep -q -c ' connected'
if test $? -eq 0; then
    #set_wide_picture
    set_picture
fi

exit 0
