#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DESIGN_DIR="${CURRENT_DIR}/design"
UTILS_DIR="${CURRENT_DIR}/utils"

# shellcheck source=/dev/null
source "${DESIGN_DIR}/colors.sh"
# shellcheck source=/dev/null
source "${DESIGN_DIR}/icons.sh"
# shellcheck source=/dev/null
source "${UTILS_DIR}/helpers.sh"

function setup_window() {
    set_tmux_option "window-status-separator" " ${WINDOW_ICON}  "
    set_tmux_option "window-status-current-format" "${GREEN_ON_BLACK}${OPEN_ICON}${YELLOW_ON_GREEN}#I:#W#F${GREEN_ON_BLACK}${CLOSE_ICON}"
}

function setup_first_left_status_bar() {
    local tmux_version_part
    tmux_version_part="${CYAN_ON_PURPLE} #($(cmd_get_tmux_version)) ${PURPLE_ON_BLACK}${CLOSE_ICON}"
    local hostname_part
    hostname_part="${ORANGE_ON_BLACK}${OPEN_ICON}${WHITE_ON_ORANGE} #(hostname) ${ORANGE_ON_BLACK}${CLOSE_ICON}"
    local session_name_part
    session_name_part="${RED_ON_BLACK}${OPEN_ICON}${YELLOW_ON_RED} #($(cmd_get_session_name)) ${RED_ON_BLACK}${CLOSE_ICON}"

    local left_icon_separator_1
    left_icon_separator_1="${WHITE_ON_BLACK} ${TROPHY_ICON}  "
    local left_icon_separator_2
    left_icon_separator_2="${WHITE_ON_BLACK} ${HOUSE_ICON}  "
    local left_icon_separator_3
    left_icon_separator_3="${WHITE_ON_BLACK} ${MUG_SAUCER_ICON}"

    set_tmux_option "status-left-length" "100"
    set_tmux_option "status-left-style" "default"
    set_tmux_option "status-left" "${tmux_version_part}${left_icon_separator_1}${hostname_part}${left_icon_separator_2}${session_name_part}${left_icon_separator_3}"
}

function setup_first_right_status_bar() {
    local cpu_usage_part
    cpu_usage_part="${PINK_ON_BLACK}${OPEN_ICON}${YELLOW_ON_PINK} CPU #(bash ${UTILS_DIR}/get_cpu_stat.sh used) ${PINK_ON_BLACK}${CLOSE_ICON}"
    local ram_usage_part
    ram_usage_part="${DARK_RED_ON_BLACK}${OPEN_ICON}${YELLOW_ON_DARK_RED} RAM #(bash ${UTILS_DIR}/get_mem_stat.sh used gb) "

    local right_icon_separator_1
    right_icon_separator_1="${WHITE_ON_BLACK} ${MICROCHIP_ICON}  "
    local right_icon_separator_2
    right_icon_separator_2="${WHITE_ON_BLACK} ${DATABASE_ICON}  "

    set_tmux_option "status-right-length" "100"
    set_tmux_option "status-right-style" "default"
    set_tmux_option "status-right" "${right_icon_separator_1}${cpu_usage_part}${right_icon_separator_2}${ram_usage_part}"
}

function setup_second_status_bar() {
# Format the second line of status bar
set -g status-format[1] "#[align=left]#[bg=color16, fg=color118] AUSTRALIA/Melbourne \
#[bg=color16, fg=color15]${GLOBE_ICON}  \
#[bg=color16, fg=color14]#( bash ~/.tmux/scripts/tmux_get_time.sh AU static)"
set -ag status-format[1] "#[align=centre]#[fg=color18,bg=color16]${OPEN_ICON}\
#[bg=color18, fg=color118] Central European Time (CET) \
#[bg=color18, fg=color15]${GLOBE_ICON}  \
#[bg=color18, fg=color226]#( bash ~/.tmux/scripts/tmux_get_time.sh CET static) \
#[fg=color18,bg=color16]${CLOSE_ICON}"
set -ag status-format[1] "#[align=right]#[bg=color16, fg=color118] VIETNAM/Ho Chi Minh City \
#[bg=color16, fg=color15]${GLOBE_ICON}  \
#[bg=color16, fg=color14]#( bash ~/.tmux/scripts/tmux_get_time.sh VN static) "

}

function main() {
    setup_window
    setup_first_left_status_bar
    setup_first_right_status_bar
}

main

