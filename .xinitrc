#!/bin/sh
#                                            #
##                .xinitrc                  ##
###                                        ###
#### ~ created by Flasheh                 ####
##############################################

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

## copy/paste
/usr/bin/autocutsel -fork &
/usr/bin/autocutsel -selection PRIMARY -fork &

## Load up my Xdefault 
xrdb -load ~/.Xdefaults

## Set Wallpaper
feh --bg-scale ~/wallpapers/wallpaper-875318.jpg &

## Font db update
xset +fp /usr/share/fonts/local
xset fp rehash

## Urxvt Daemon
urxvtd -q -o -f

## Start xbindkeys, for multimedia keys
xbindkeys &

## Time to blast some music through my speakers 
mpd ~/.mpd/mpd.conf

## Add favourites to front of dmenu
~/scripts/dmenuadd

## Start netspeed script for statusbar
~/scripts/netspeed eth0 &

## Add conky to statusbar
#conky | while read -r; do xsetroot -name "$REPLY"; done &

## Start this shit up. default: dwm
DEFAULT_SESSION=~/scripts/startdwm
case $1 in
openbox)
	exec openbox-session
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac
