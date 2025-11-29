#!/bin/bash

LOG="$HOME/.config/hypr/scripts/log"
echo "$(date +"%Y-%m-%d_%H-%M-%S")" > $LOG

./gen_themes.sh $LOG

echo "starting Hyprland..." >> $LOG
# if [ -e /run/bootmode/marker/powersaver ]; then
#   exec env WLR_DRM_NO_ATOMIC=1 intel-run Hyprland
# else
#   exec env WLR_DRM_NO_ATOMIC=1 nvidia-run Hyprland
# fi
exec Hyprland
