#!/usr/bin/env bash

dir="$HOME/.config/polybar"
themes=(`ls --hide="launch.sh" $dir`)

launch_bar() {
	# Terminar la instancia de polybar que se esta ejecutando
	killall -q polybar

	# Esperar hasta que los procesos se hayan cerrado
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	polybar LVDS1 -c "$dir/$style/config.ini" &
	polybar VGA1 -c "$dir/$style/config.ini" &
	polybar eDP1 -c "$dir/$style/config.ini" &
	polybar HDMI1 -c "$dir/$style/config.ini" &
	#polybar -q eDP1 -c "$dir/$style/config.ini" &
	#polybar -q HDMI1 -c "$dir/$style/config.ini" &

	echo "Polybar launched..."
}

if [[ "$1" == "--clasico" ]]; then
	style="clasico"
	launch_bar

elif [[ "$1" == "--shades" ]]; then
	style="shades"
	launch_bar

else
	cat <<- EOF
	Use : launch.sh --theme
		
	Temas disponibles:
	--clasico	--colorblocks    --cuts      --docky		--classic
	--forest    --grayblocks     --hack      --material
	--panels    --pwidgets       --shades    --shapes
	EOF
fi
