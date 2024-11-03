#!/usr/bin/env bash
#  _                        _           _
# | | __ _ _   _ _ __   ___| |__    ___| |__
# | |/ _` | | | | '_ \ / __| '_ \  / __| '_ \
# | | (_| | |_| | | | | (__| | | |_\__ \ | | |
# |_|\__,_|\__,_|_| |_|\___|_| |_(_)___/_| |_|

# Finaliza el proceso polybar en caso de que ya exista un proceso polybar corriendo
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar monitor1 2>&1 | tee -a /tmp/polybar1.log & disown
#polybar monitor2 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."
