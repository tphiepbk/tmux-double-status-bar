#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/design/colors.sh"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/design/icons.sh"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/utils/helpers.sh"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/utils/dependencies.sh"

function setup_window() {
    set_tmux_option "window-status-separator" " ${COLOR_WINDOW_SEP}${WINDOW_ICON}  "
    set_tmux_option "window-status-current-format" "${COLOR_WINDOW_ACTIVE_SEP}${OPEN_ICON}${COLOR_WINDOW_ACTIVE_TEXT}#I:#W#F#{?pane_synchronized,(SYNC),}${COLOR_WINDOW_ACTIVE_SEP}${CLOSE_ICON}"
    set_tmux_option "window-status-format" "#I:#W#F#{?pane_synchronized,(SYNC),}"
}

function setup_first_left_status_bar() {
    local tmux_version_part
    tmux_version_part="${COLOR_TMUX_VERSION_TEXT} #($(cmd_get_tmux_version)) ${COLOR_TMUX_VERSION_SEP}${CLOSE_ICON}"
    local hostname_part
    hostname_part="${COLOR_HOSTNAME_SEP}${OPEN_ICON}${COLOR_HOSTNAME_TEXT} #(hostname) ${COLOR_HOSTNAME_SEP}${CLOSE_ICON}"
    local session_name_part
    session_name_part="${COLOR_SESSION_SEP}${OPEN_ICON}${COLOR_SESSION_TEXT} #($(cmd_get_session_name)) ${COLOR_SESSION_SEP}${CLOSE_ICON}"

    local left_icon_separator_1
    left_icon_separator_1=" ${COLOR_ICON_SEP}${GEAR_ICON}  "
    local left_icon_separator_2
    left_icon_separator_2=" ${COLOR_ICON_SEP}${HOUSE_ICON}  "
    local left_icon_separator_3
    left_icon_separator_3=" ${COLOR_ICON_SEP}${BRIEFCASE_ICON}"

    set_tmux_option "status-left-length" "100"
    set_tmux_option "status-left-style" "default"
    set_tmux_option "status-left" "${tmux_version_part}${left_icon_separator_1}${hostname_part}${left_icon_separator_2}${session_name_part}${left_icon_separator_3}"
}

function setup_first_right_status_bar() {
    local cpu_usage_part
    cpu_usage_part="${COLOR_CPU_SEP}${OPEN_ICON}${COLOR_CPU_TEXT} CPU #(bash ${UTILS_DIR}/get_cpu_stat.sh used) ${COLOR_CPU_SEP}${CLOSE_ICON}"
    local ram_usage_part
    ram_usage_part="${COLOR_RAM_SEP}${OPEN_ICON}${COLOR_RAM_TEXT} RAM #(bash ${UTILS_DIR}/get_mem_stat.sh used gb) "

    local right_icon_separator_1
    right_icon_separator_1="${COLOR_ICON_SEP}${MICROCHIP_ICON}  "
    local right_icon_separator_2
    right_icon_separator_2=" ${COLOR_ICON_SEP}${MEMORY_ICON}  "

    # Call the "continuum_save.sh" from "tmux-continuum" plugin to allow autosave feature work correctly
    local continuum_save_part
    continuum_save_part="$(get_continuum_save_indicator)"

    set_tmux_option "status-right-length" "100"
    set_tmux_option "status-right-style" "default"
    set_tmux_option "status-right" "${right_icon_separator_1}${cpu_usage_part}${right_icon_separator_2}${ram_usage_part}${continuum_save_part}"
}

function setup_second_line_status_bar() {
    local left_time_part
    left_time_part="#[align=left]${COLOR_TIMEZONE_SIDE_LABEL} AUSTRALIA/Melbourne ${COLOR_ICON_SEP}${GLOBE_ICON} ${COLOR_TIMEZONE_SIDE_VALUE} #( bash ${UTILS_DIR}/get_time.sh AU static)"
    local middle_time_part
    middle_time_part="#[align=centre]${COLOR_TIMEZONE_CENTER_SEP}${OPEN_ICON}${COLOR_TIMEZONE_CENTER_LABEL} Central European Time (CET) ${COLOR_TIMEZONE_CENTER_ICON}${GLOBE_ICON} ${COLOR_TIMEZONE_CENTER_VALUE} #(bash ${UTILS_DIR}/get_time.sh CET static) ${COLOR_TIMEZONE_CENTER_SEP}${CLOSE_ICON}"
    local right_time_part
    right_time_part="#[align=right]${COLOR_TIMEZONE_SIDE_LABEL} VIETNAM/Ho Chi Minh City ${COLOR_ICON_SEP}${GLOBE_ICON}  ${COLOR_TIMEZONE_SIDE_VALUE}#(bash ${UTILS_DIR}/get_time.sh VN static) "

    set_tmux_option "status-format[1]" "${left_time_part}${middle_time_part}${right_time_part}"
}

function main() {
    set_tmux_option "status-interval" "1"
    set_tmux_option "status" "2"
    set_tmux_option "status-style" "${COLOR_BACKGROUND}"

    setup_window
    setup_first_left_status_bar
    setup_first_right_status_bar
    setup_second_line_status_bar
}

main
