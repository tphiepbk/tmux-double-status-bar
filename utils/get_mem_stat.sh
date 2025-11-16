#!/bin/bash

TOTAL_MEM_MB=
TOTAL_MEM_MB=$(top -bn 1 | grep "MiB Mem" | cut -d "," -f 1 | sed 's/[a-zA-Z: ]//g; s/+//g')

TOTAL_MEM_GB=
TOTAL_MEM_GB=$(awk "BEGIN {printf \"%.1f\", $TOTAL_MEM_MB/1024}")

function _get_used_mem () {
    local USED_MEM_MB=
    USED_MEM_MB=$(top -bn 1 | grep "MiB Mem" | cut -d "," -f 3 | sed 's/[a-zA-Z: ]//g; s/+//g')
    local USED_MEM_GB=
    USED_MEM_GB=$(awk "BEGIN {printf \"%.1f\", $USED_MEM_MB/1024}")

    local PERCENT_USED=

    if [[ "$1" == "mb" ]]; then
        PERCENT_USED=$(awk "BEGIN {printf \"%.0f\", $USED_MEM_MB / $TOTAL_MEM_MB * 100}")
        echo "${USED_MEM_MB}M/${TOTAL_MEM_MB}M ($PERCENT_USED%)"
        return 0
    elif [[ "$1" == "gb" ]]; then
        PERCENT_USED=$(awk "BEGIN {printf \"%.0f\", $USED_MEM_GB / $TOTAL_MEM_GB * 100}")
        echo "${USED_MEM_GB}GB / ${TOTAL_MEM_GB}GB ($PERCENT_USED%)"
        return 0
    else
        echo "Invalid period ! Please use \"mb\" or \"gb\""
        return 2
    fi
}

function _get_free_mem () {
    local FREE_MEM_MB=
    FREE_MEM_MB=$(top -bn 1 | grep "MiB Mem" | cut -d "," -f 2 | sed 's/[a-zA-Z: ]//g; s/+//g')
    local FREE_MEM_GB=
    FREE_MEM_GB=$(awk "BEGIN {printf \"%.1f \", $FREE_MEM_MB/1024}")

    local PERCENT_FREE=

    if [[ "$1" == "mb" ]]; then
        PERCENT_FREE=$(awk "BEGIN {printf \"%.0f\", $FREE_MEM_MB / $TOTAL_MEM_MB * 100}")
        echo "${FREE_MEM_MB}M/${TOTAL_MEM_MB}M ($PERCENT_FREE%)"
        return 0
    elif [[ "$1" == "gb" ]]; then
        PERCENT_FREE=$(awk "BEGIN {printf \"%.0f\", $FREE_MEM_GB / $TOTAL_MEM_GB * 100}")
        echo "${FREE_MEM_GB}GB / ${TOTAL_MEM_GB}GB ($PERCENT_FREE%)"
        return 0
    else
        echo "Invalid period ! Please use \"mb\" or \"gb\""
        return 2
    fi

}

TYPE="$1"
PERIOD="$2"

RETCODE=

if [[ "$TYPE" == "free" ]]; then
    FREE_MEM_PART=
    FREE_MEM_PART=$(_get_free_mem $PERIOD)
    RETCODE="$?"
    echo "${FREE_MEM_PART}"
elif [[ "$TYPE" == "used" ]]; then
    USED_MEM_PART=
    USED_MEM_PART=$(_get_used_mem $PERIOD)
    RETCODE="$?"
    echo "${USED_MEM_PART}"
else
    RETCODE=1
    echo "Invalid type ! Please use \"free\" or \"used\""
fi

exit "$RETCODE"

