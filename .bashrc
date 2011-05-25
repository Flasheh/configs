#                                            #
##                 .bashrc                  ##
###                                        ###
#### ~ created by Flasheh                 ####
##############################################

## check for an interactive session
[ -z "$PS1" ] && return

##############################################
##                  Aliases                 ##
##############################################

alias pacman="sudo pacman-color"
alias ls="ls --color=auto"
alias crossftp="sh crossftp/crossftp.sh"
alias xmplayer="echo -ne '\033]0;'mplayer'\007'; mplayer -zoom -vo x11 -wid `xwininfo -id $WINDOWID -tree | tail -n 2 | grep -oP '0x[0-9a-f]+ '`"
alias reboot='sudo shutdown -r now'
alias halt='sudo shutdown -h now'
alias diff='colordiff'
alias grep='grep --color=auto'
alias h="cd ~"
alias home="cd ~"
alias ..="cd .."y
alias ...="cd ../.."
alias urxvt='urxvtc'
alias pacsearch="pacman -Sl | cut -d' ' -f2 | grep "
alias pacup="sudo pacman-color -Syu"

##############################################
##             Terminal visuals             ##
##############################################
##  This gives: 'user@hostname' dir [:)] >  ##
##############################################

PS1="\[\e[01;39m\]'\u\[\e[01;30m\]@\[\e[01;39m\]\h' \[\e[01;30m\]\W \`
if [ \$? = 0 ];
        then echo -e '\[\e[01;30m\][''\[\e[01;32m\]:)''\[\e[01;30m\]]';
        else echo -e '\[\e[01;30m\][''\[\e[01;31m\]:(''\[\e[01;30m\]]';
fi\` \[\e[01;30m\]> \[\e[00m\]"

## Cowsay
cowsay -f sodomized.cow Life was like a box of chocolates, you never know what you are gonna get......  -- Forrest Gump
echo

##############################################
##            Other functions               ##
##############################################

## Completion
complete -cf sudo
complete -cf man

## Apps
export EDITOR="vim"

## Enhance colored ls output
eval $(dircolors -b)

## Bash history
export HISTCONTROL=ignoredups

## Extract Files
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
	      *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz $1        ;;
          *.exe)       cabextract $1  ;;
          *)           echo "\`$1': unrecognized file compression" ;;
      esac
  else
      echo "\`$1' is not a valid file"
  fi
}

