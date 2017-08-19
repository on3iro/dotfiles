# alias to .config/awesome
alias cdga="cd ~/.config/i3/"

# Common Aliases
alias aptdate="sudo apt-get update"
alias aptgrade="sudo apt-get upgrade"

# vim bundles
alias vindle="~/.vim/bundle"

# Edit vimrc
alias vimrc="vim ~/.vimrc"

# Edit rc.lua
alias luarc="vim ~/.config/awesome/rc.lua"

# Edit .Xresources
alias xres="vim ~/.Xresources"

# Go to projects
alias proj="cd ~/projects/2016/"

## Current Project
alias curPr="cd ~/projects/2016/python/rp_course_2/flask-bdd"

# Doc Aliases
alias ba="cd ~/Dokumente/BA/5.Semester"

# Watch processes
alias watchproc="watch 'ps aux | sort -rk 3,3 | head -n 12'"

# Show network channels
alias netchannel="sudo iwlist wlan0 scan | grep Frequency | sort | uniq -c | sort -n"

# Softwarearchitektur
#alias sa16="~/projects/2016/python/softwareArchitektur"

# python
alias python="/usr/bin/python3"

# pip
#alias pip="/usr/bin/pip3"

# Flask cookiecutter
alias flaskcookie="cookiecutter git@github.com:on3iro/cookiecutter-flask.git"

# net_probe
alias net_probe="sudo rmmod rtl8192ce && sudo modprobe rtl8192ce"

# htdocs on win
alias htdocs="/mnt/d/programme/xampp/htdocs"

# d:// on win
alias diskD="/mnt/d"

# c:// on win
alias diskC="/mnt/c"

# keyboardSwitch
alias keySwitch="setxkbmap -layout us,de -option grp:alt_shift_toggle"
alias capsOff="setxkbmap -option caps:none"

# xrandr commands
alias beamerRight="xrandr --output VGA1 --mode 1024x768 --right-of LVDS1"
alias beamerLeft="xrandr --output VGA1 --mode 1024x768 --left-of LVDS1"
alias beamerClone="xrandr --output VGA1 --mode 1024x768 --same-as LVDS1"
alias beamerOff="xrandr --output VGA1 --off"
