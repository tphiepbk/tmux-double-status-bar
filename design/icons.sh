#!/usr/bin/env bash

CURRENT_DIR=$(dirname "${BASH_SOURCE[0]}")

UTILS_DIR="${CURRENT_DIR}/../utils"

# shellcheck source=/dev/null
source "${UTILS_DIR}/helpers.sh"

# Define icons
# { left = '', right = '' }
HALF_ROUND_OPEN_ICON="$(echo -e '\ue0b6')"
HALF_ROUND_CLOSE_ICON="$(echo -e '\ue0b4')"
# { left = '', right = '' }
TRIANGLE_OPEN_ICON="$(echo -e '\ue0b2')"
TRIANGLE_CLOSE_ICON="$(echo -e '\ue0b0')"
# { right = '', left = '' }
SLOPE_OPEN_ICON="$(echo -e '\ue0ba')"
SLOPE_CLOSE_ICON="$(echo -e '\ue0b8')"

separator_style=$(get_tmux_option "@double-status-bar-separator-style" "half_round")
case $separator_style in
    half_round)
        OPEN_ICON="${HALF_ROUND_OPEN_ICON}"
        CLOSE_ICON="${HALF_ROUND_CLOSE_ICON}"
    ;;
    triangle)
        OPEN_ICON="${TRIANGLE_OPEN_ICON}"
        CLOSE_ICON="${TRIANGLE_CLOSE_ICON}"
    ;;
    slope)
        OPEN_ICON="${SLOPE_OPEN_ICON}"
        CLOSE_ICON="${SLOPE_CLOSE_ICON}"
    ;;
    *)
        echo "Invalid separator style"
        exit 1
    ;;
esac;

WINDOW_ICON="$(echo -e '\uf2d2')"

TROPHY_ICON="$(echo -e '\uf091')"
HOUSE_ICON="$(echo -e '\uf015')"
MUG_SAUCER_ICON="$(echo -e '\uf0f4')"
MICROCHIP_ICON="$(echo -e '\uf2db')"
DATABASE_ICON="$(echo -e '\uf1c0')"
GLOBE_ICON="$(echo -e '\uf0ac')"

