#!/bin/bash
set -x

# Output names
LAPTOP="eDP-1"
LEFT_MON="DP-3"
RIGHT_MON="DP-2"

# Native resolution
WIDTH=2560
HEIGHT=1440
LAPTOP_RES="1920x1200"

# Custom mode name for DP-3
CUSTOM_MODE_NAME="2560x1440_60.00"

# Generate modeline for DP-3 (if not present)
if ! xrandr | grep -q "$CUSTOM_MODE_NAME"; then
    echo "Creating new modeline for $LEFT_MON"
    MODELINE=$(cvt $WIDTH $HEIGHT 60 | grep -oP '(?<=Modeline ).*')
    xrandr --newmode $MODELINE
    xrandr --addmode $LEFT_MON \"$CUSTOM_MODE_NAME\"
fi

# Apply monitor layout (quotes around mode names are *critical*)
echo "Applying layout..."
xrandr \
  --output "$LEFT_MON" --mode \"$CUSTOM_MODE_NAME\" --pos 0x0 --primary \
  --output "$RIGHT_MON" --mode "2560x1440" --pos ${WIDTH}x0 \
  --output "$LAPTOP" --mode "$LAPTOP_RES" --pos ${WIDTH}x${HEIGHT}

echo "Layout applied."

