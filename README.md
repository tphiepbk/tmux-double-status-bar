# tmux-double-status-bar

Polished double status bar

![image_1](images/screenshot1.png)

## Installation with Tmux Plugin Manager (recommended)

Add plugin to the list of TPM plugins:

```
set -g @plugin 'tphiepbk/tmux-double-status-bar'
```

Use `prefix` + <kbd>I</kbd> to install it.

## Options

```
# Set the separator style to "half_round" (default)
set-option -g @double-status-bar-separator-style 'half_round'

# Set the separator style to "triangle"
set-option -g @double-status-bar-separator-style 'triangle'

# Set the separator style to "slope"
set-option -g @double-status-bar-separator-style 'slope'

# Set the memory information to "verbose"
set-option -g @double-status-bar-mem-info 'verbose'

# Set the disk information to "verbose"
set-option -g @double-status-bar-disk-info 'verbose'
```

## License

[MIT](LICENSE)
