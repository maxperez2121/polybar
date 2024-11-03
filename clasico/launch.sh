#!/bin/bash

# Terminar la instancia de polybar que se esta ejecutando
killall -q polybar

# Esperar hasta que los procesos se hayan cerrado
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Lanzar Polybar, usando la ruta de configuración predeterminada ~/.config/polybar/config
# polybar master &
#polybar -c ~/.config/polybar/config.ini eDP1 &
#polybar -c ~/.config/polybar/config.ini HDMI1 &
polybar LVDS1 &
polybar eDP1 &
polybar HDMI1 &

echo "Polybar launched..."
