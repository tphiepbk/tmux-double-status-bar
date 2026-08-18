#!/bin/bash

function get_continuum_save_indicator() {
    CONTINUUM_SAVE_SCRIPT="$HOME/.tmux/plugins/tmux-continuum/scripts/continuum_save.sh"
    test -f "${CONTINUUM_SAVE_SCRIPT}" && echo "#(bash ${CONTINUUM_SAVE_SCRIPT})"
}

