#!/usr/bin/env bash

function cmd_get_tmux_version() {
    echo "tmux -V | awk '{ print toupper(\$0) }'"
}

function cmd_get_session_name() {
    echo "tmux display-message -p '#S'"
}

function set_tmux_option() {
    local option="$1"
    local value="$2"
    tmux set-option -gq "$option" "$value"
}

function get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value
    option_value=$(tmux show-option -gqv "$option")
    if [[ -z "$option_value" ]]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

