#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DESIGN_DIR="$CURRENT_DIR/design"

# shellcheck source=/dev/null
source "$DESIGN_DIR/colors.sh"
# shellcheck source=/dev/null
source "$DESIGN_DIR/icons.sh"

setup_window() {
    set_tmux_option "window-status-separator" " ${WINDOW_ICON}  "
    set_tmux_option "window-status-current-format" "\
    #[${GREEN_ON_BLACK}]${OPEN_ICON}\
    #[${YELLOW_ON_GREEN}]#I:#W#F\
    #[${GREEN_ON_BLACK}]${CLOSE_ICON}\
    "
}

main() {
    setup_window
}
