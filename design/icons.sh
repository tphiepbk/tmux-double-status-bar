#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/../utils/helpers.sh"

# Define icons
HALF_ROUND_OPEN_ICON="$(echo -e '\ue0b6')"
HALF_ROUND_CLOSE_ICON="$(echo -e '\ue0b4')"

TRIANGLE_OPEN_ICON="$(echo -e '\ue0b2')"
TRIANGLE_CLOSE_ICON="$(echo -e '\ue0b0')"

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

WINDOW_ICON="$(echo -e '\uf454')"

GEAR_ICON="$(echo -e '\uf013')"
HOUSE_ICON="$(echo -e '\uf015')"
BRIEFCASE_ICON="$(echo -e '\uf0b1')"

MICROCHIP_ICON="$(echo -e '\uf2db')"
MEMORY_ICON="$(echo -e '\uefc5')"
DATABASE_ICON="$(echo -e '\uf1c0')"

GLOBE_ICON="$(echo -e '\uf0ac')"
