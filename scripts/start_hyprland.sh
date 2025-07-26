#!/bin/bash

LOG="$HOME/.config/hypr/scripts/log"
echo "$(date +"%Y-%m-%d_%H-%M-%S")" > $LOG

./gen_configs.sh $LOG

echo "starting Hyprland..." >> $LOG
if [ -e /run/bootmode/marker/powersaver ]; then
  runner="intel-run"
else
  runner="nvidia-run"
fi

exec env WLR_DRM_NO_ATOMIC=1 "$runner" Hyprland

