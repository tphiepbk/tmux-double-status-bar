#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/helpers.sh"

function _parse_df_command () {
    local MOUNTED_ON="$1"
    # TYPE should be: size, used, available, use_percentage
    local TYPE="$2"

    case "$TYPE" in
        "size")
            TYPE=2
        ;;
        "used")
            TYPE=3
        ;;
        "available")
            TYPE=4
        ;;
        "use_percentage")
            TYPE=5
        ;;
    esac

    local cmd="df -h ${MOUNTED_ON} | awk 'NR==2 {print \$$TYPE}'"
    number_with_unit=$(eval "$cmd")
    number="${number_with_unit:0:-1}"
    echo "$number"
}

# MOUNTED_ON should be available in "df" command output
MOUNTED_ON="$1"

# TYPE should be: used, available
TYPE="$2"
AVAILABLE_TYPES=("used" "available")
if [[ -z "$TYPE" ]] || ! _contains "$TYPE" "${AVAILABLE_TYPES[@]}"; then
    IFS=,; echo "Invalid type, please use \"${AVAILABLE_TYPES[*]}\" !"
    exit 1
fi

disk_info=$(get_tmux_option "@double-status-bar-disk-info" "normal")

USE_PERCENTAGE_DISK=$(_parse_df_command "${MOUNTED_ON}" "use_percentage")
UNIT_INDICATOR="GB"
TOTAL_DISK=$(_parse_df_command "${MOUNTED_ON}" "size")
case "$TYPE" in
    "used")
        USED_DISK=$(_parse_df_command "${MOUNTED_ON}" "used")
        if [[ "${disk_info}" == "verbose" ]]; then
            echo "${USED_DISK}/${TOTAL_DISK}${UNIT_INDICATOR} (${USE_PERCENTAGE_DISK}%)"
        else
            echo "${USED_DISK}/${TOTAL_DISK} ${UNIT_INDICATOR}"
        fi
    ;;
    "available")
        AVAILABLE_DISK=$(_parse_df_command "${MOUNTED_ON}" "available")
        if [[ "${disk_info}" == "verbose" ]]; then
            echo "${AVAILABLE_DISK}/${TOTAL_DISK}${UNIT_INDICATOR} ($(( 100 - USE_PERCENTAGE_DISK ))%)"
        else
            echo "${AVAILABLE_DISK}/${TOTAL_DISK} ${UNIT_INDICATOR}"
        fi
    ;;
esac
