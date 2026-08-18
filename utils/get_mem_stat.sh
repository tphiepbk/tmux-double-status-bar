#!/bin/bash

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
if [[ ! "${AVAILABLE_TYPES[*]}" =~ $TYPE ]]; then
    echo "Invalid type !"
    exit 1
fi

# UNIT should be: b, kb, mb and gb
UNIT="$2"
AVAILABLE_UNITS=("b" "kb" "mb" "gb")
if [[ ! "${AVAILABLE_UNITS[*]}" =~ $UNIT ]]; then
    echo "Invalid unit !"
    exit 1
fi

UNIT_INDICATOR="${UNIT^^}"
TOTAL_MEM=$(_parse_free_command "total" "$UNIT")
# TARGET_MEM could be USED_MEM or AVAILABLE_MEM
TARGET_MEM=$(_parse_free_command "$TYPE" "$UNIT")
PERCENTAGE=$(awk "BEGIN {printf \"%.0f\", $TARGET_MEM / $TOTAL_MEM * 100}")

echo "${TARGET_MEM}${UNIT_INDICATOR} / ${TOTAL_MEM}${UNIT_INDICATOR} ($PERCENTAGE%)"
