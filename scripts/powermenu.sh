#!/usr/bin/env bash

dir="~/.config/polybar/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up /Tiempo activo: /g' -e 's/hours,/horas y/g' -e 's/minutes/minutos/g')

rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Opciones
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $dir/confirm.rasi
}

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "$uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
		ans=$(confirm_exit &)
		systemctl poweroff
        ;;
    $reboot)
		ans=$(confirm_exit &)
		systemctl reboot
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock ]]; then
			i3lock
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $suspend)
		ans=$(confirm_exit &)
		mpc -q pause
		amixer set Master mute
		systemctl suspend
        ;;
    $logout)
		ans=$(confirm_exit &)
		if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
			openbox --exit
		elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
			bspc quit
		elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
			i3-msg exit
		fi
        ;;
esac
