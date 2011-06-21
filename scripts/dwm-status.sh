#!/bin/bash

a="$(echo -e "\x08[")"
b="$(echo -e "\x08]")"

## Show 'RAM: xxx MB'
mem(){
	mem="$(free -m | grep + | awk '{print $3}')"
	echo -e "\x03RAM:\x01$mem MB"
}

## Show 'CPU: x%'
cpu(){
	cpu="$(eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); sleep 0.4; 
	eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); 
	intervaltotal=$((total-${prevtotal:-0})); 
	echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))")"
	echo -e "\x06CPU:\x01$cpu%"
}

## Show music now playing or paused when music is off
mpd(){

mpd="$(mpc current)"
title="$(audtool current-song)"
artist="$(audtool current-song-tuple-data artist)"

if [ $mpd == ""];then
	if [ $artist == ""];
	then
		echo -e "\x04$title"
	else
		echo -e "\x04${artist} - ${title}"
	fi
else
	echo -e "\x04$mpd" | head -c 75
fi

}

## Show 'PAC: x AUR: x'
pac(){
fakedb=/dev/shm/fakepacdb
aur=$(cat /dev/shm/aur.txt)
pkgs=$(pacman --dbpath "$fakedb" -Qqu | wc -l)
	echo -e "\x07PAC:\x01${pkgs}\x07AUR:\x01${aur}"
}

## Show date 'Dayname Month Day hh:mm pm/am' 
dte(){
	dte="$(date "+%a %b %d %I:%M%P")"
	echo -e "\x01$dte"
}

## Show 'Down xxKB/s UP: xxKB/s'
net(){
	netdown=$(cat /dev/shm/netdown.txt)
	netup=$(cat /dev/shm/netup.txt)
	echo -e "\x04DOWN:\x01$netdown\x04UP:\x01$netup"
}

## Put it in statusbar beween brackets
xsetroot -name "$a$(mpd)$b$a$(pac)$b$a$(mem)$(cpu)$b$a$(net)$b |$(dte)"
