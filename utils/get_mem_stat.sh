#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/helpers.sh"

# TYPE should be: used, available
TYPE="$1"
AVAILABLE_TYPES=("used" "available")
if [[ -z "$TYPE" ]] || ! _contains "$TYPE" "${AVAILABLE_TYPES[@]}"; then
    IFS=,; echo "Invalid type, please use \"${AVAILABLE_TYPES[*]}\" !"
    exit 1
fi

# UNIT should be: kb, mb and gb
UNIT="$2"
AVAILABLE_UNITS=("kb" "mb" "gb")
if [[ -z "$UNIT" ]] || ! _contains "$UNIT" "${AVAILABLE_UNITS[@]}"; then
    IFS=,; echo "Invalid unit, please use \"${AVAILABLE_UNITS[*]}\" !"
    exit 1
fi
UNIT_INDICATOR="${UNIT^^}"

# Read from /proc/meminfo, result in KB
MEM_TOTAL=$(grep -E "^MemTotal:" /proc/meminfo | awk '{print $2}')

# Use MemAvailable to calculate instead of adding up MemFree and Cached
# Referece: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e431b0ae398fc54ea69ff85ec700722c9da773
MEM_AVAILABLE=$(grep -E "^MemAvailable:" /proc/meminfo | awk '{print $2}')
MEM_USED=$(( MEM_TOTAL - MEM_AVAILABLE ))

# MEM_BUFFERS=$(grep -E "^Buffers:" /proc/meminfo | awk '{print $2}')
# MEM_CACHED=$(grep -E "^Cached:" /proc/meminfo | awk '{print $2}')
# MEM_SRECLAIMABLE=$(grep -E "^SReclaimable:" /proc/meminfo | awk '{print $2}')
# MEM_FREE=$(grep -E "^MemFree:" /proc/meminfo | awk '{print $2}')
# MEM_USED=$(( MEM_TOTAL - MEM_FREE - MEM_BUFFERS - MEM_CACHED - MEM_SRECLAIMABLE ))

if [[ "$UNIT" == "mb" ]]; then
    MEM_TOTAL=$(( MEM_TOTAL / 1024 ))
    MEM_AVAILABLE=$(( MEM_AVAILABLE / 1024 ))
    MEM_USED=$(( MEM_USED / 1024 ))
elif [[ "$UNIT" == "gb" ]]; then
    MEM_TOTAL=$(( MEM_TOTAL / 1024 / 1024 ))
    MEM_AVAILABLE=$(( MEM_AVAILABLE / 1024 / 1024 ))
    MEM_USED=$(( MEM_USED / 1024 / 1024 ))
fi

# TARGET_MEM could be USED_MEM or AVAILABLE_MEM
case "$TYPE" in
    "used")
        TARGET_MEM=${MEM_USED}
    ;;
    "available")
        TARGET_MEM=${MEM_AVAILABLE}
    ;;
esac

mem_info=$(get_tmux_option "@double-status-bar-mem-info" "normal")

if [[ "$mem_info" == "verbose" ]]; then
    PERCENTAGE=$(( TARGET_MEM * 100 / MEM_TOTAL ))
    echo "${TARGET_MEM}/${MEM_TOTAL} ${UNIT_INDICATOR} ($PERCENTAGE%)"
else
    echo "${TARGET_MEM}/${MEM_TOTAL} ${UNIT_INDICATOR}"
fi
