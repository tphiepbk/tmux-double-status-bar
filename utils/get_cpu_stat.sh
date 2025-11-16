#!/bin/bash

PERCENT_FREE=
PERCENT_FREE=$(top -bn 1 | grep "%Cpu(s):" | cut -d "," -f 4 | sed 's/[a-z ]*//g')

PERCENT_USED=
PERCENT_USED=$(printf '%3.1f\n' "$(bc<<<100-"${PERCENT_FREE}")")

TYPE="$1"

if [[ "$TYPE" == "free" ]]; then
    echo "${PERCENT_FREE}%"
    exit 0
elif [[ "$TYPE" == "used" ]]; then
    echo "${PERCENT_USED}%"
    exit 0
else
    echo "Invalid type ! Please use \"free\" or \"used\""
    exit 1
fi

