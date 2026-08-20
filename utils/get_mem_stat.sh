#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/helpers.sh"

function _parse_free_command () {
    # TYPE should be: total, used, available
    local TYPE="$1"
    # UNIT should be: b, kb, mb and gb
    local UNIT="-${2:0:1}"

    case "$TYPE" in
        "total")
            TYPE=2
        ;;
        "used")
            TYPE=3
        ;;
        "available")
            TYPE=7
        ;;
    esac

    local cmd="free $UNIT | awk '/Mem:/ {print \$$TYPE}'"
    eval "$cmd"
}

# TYPE should be: used, available
TYPE="$1"
AVAILABLE_TYPES=("used" "available")
if [[ -z "$TYPE" ]] || ! _contains "$TYPE" "${AVAILABLE_TYPES[@]}"; then
    IFS=,; echo "Invalid type, please use \"${AVAILABLE_TYPES[*]}\" !"
    exit 1
fi

# UNIT should be: b, kb, mb and gb
UNIT="$2"
AVAILABLE_UNITS=("b" "kb" "mb" "gb")
if [[ -z "$UNIT" ]] || ! _contains "$UNIT" "${AVAILABLE_UNITS[@]}"; then
    IFS=,; echo "Invalid unit, please use \"${AVAILABLE_UNITS[*]}\" !"
    exit 1
fi

UNIT_INDICATOR="${UNIT^^}"
TOTAL_MEM=$(_parse_free_command "total" "$UNIT")
# TARGET_MEM could be USED_MEM or AVAILABLE_MEM
TARGET_MEM=$(_parse_free_command "$TYPE" "$UNIT")
PERCENTAGE=$(( TARGET_MEM * 100 / TOTAL_MEM ))

echo "${TARGET_MEM}/${TOTAL_MEM}${UNIT_INDICATOR} ($PERCENTAGE%)"
