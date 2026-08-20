#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/helpers.sh"

CPU_CACHE_FILE="${SCRIPT_DIR}/.cpu_cache"

function _calculate_cpu_info () {
    local TYPE="$1"
    # Format: cpu user nice system idle iowait irq softirq steal guest guest_nice
    # Leading "_" discards the "cpu" label, trailing "_ _" discards "guest" and "guest_nice" fields
    read -r _ current_user current_nice current_system current_idle current_iowait current_irq current_softirq current_steal _ _ < /proc/stat

    local result

    if [ -f "$CPU_CACHE_FILE" ]; then
        read -r prev_user prev_nice prev_system prev_idle prev_iowait prev_irq prev_softirq prev_steal < "$CPU_CACHE_FILE"

        # Reference of the calculation: https://stackoverflow.com/questions/23367857/accurate-calculation-of-cpu-usage-given-in-percentage-in-linux

        # Idle = idle + iowait
        prev_real_idle=$((prev_idle + prev_iowait))
        current_real_idle=$((current_idle + current_iowait))

        # Total = Idle + user + nice + system + irq + softirq + steal
        prev_total=$((prev_real_idle + prev_user + prev_nice + prev_system + prev_irq + prev_softirq + prev_steal))
        current_total=$((current_real_idle + current_user + current_nice + current_system + current_irq + current_softirq + current_steal))

        # Deltas
        d_total=$((current_total - prev_total))
        d_idle=$((current_real_idle - prev_real_idle))

        if [ "$d_total" -gt 0 ]; then
            if [[ "$TYPE" == "used" ]]; then
                result=$(( (d_total - d_idle) * 100 / d_total ))
            else
                result=$(( d_idle * 100 / d_total ))
            fi
        else
            result=0
        fi
    else
        result=0
    fi

    echo "$current_user $current_nice $current_system $current_idle $current_iowait $current_irq $current_softirq $current_steal" > "$CPU_CACHE_FILE"

    echo "$result%"
}

# TYPE should be: used, idle
TYPE="$1"
AVAILABLE_TYPES=("used" "idle")
if [[ -z "$TYPE" ]] || ! _contains "$TYPE" "${AVAILABLE_TYPES[@]}"; then
    IFS=,; echo "Invalid type, please use \"${AVAILABLE_TYPES[*]}\" !"
    exit 1
fi

_calculate_cpu_info "$TYPE"
