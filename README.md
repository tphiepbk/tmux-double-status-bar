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

### Separator

```
# Set the separator style to "half_round" (default)
set-option -g @double-status-bar-separator-style 'half_round'

# Set the separator style to "triangle"
set-option -g @double-status-bar-separator-style 'triangle'

# Set the separator style to "slope"
set-option -g @double-status-bar-separator-style 'slope'
```

### CPU information

```
# Set the cpu information type to "used" (default)
set-option -g @double-status-bar-cpu-info-type 'used'

# Set the cpu information type to "idle"
set-option -g @double-status-bar-cpu-info-type 'idle'
```

### RAM information

```
# Set the memory information to "normal" (default)
set-option -g @double-status-bar-mem-info 'normal'

# Set the memory information to "verbose"
set-option -g @double-status-bar-mem-info 'verbose'

# Set the memory information type to "used" (default)
set-option -g @double-status-bar-mem-info-type" "used"

# Set the memory information type to "available"
set-option -g @double-status-bar-mem-info-type" "available"

# Set the memory information unit to "gb" (default)
set-option -g @double-status-bar-mem-info-unit" "gb"

# Set the memory information unit to "mb"
set-option -g @double-status-bar-mem-info-unit" "mb"

# Set the memory information unit to "kb"
set-option -g @double-status-bar-mem-info-unit" "kb"
```

### Disk information

```
# Set the disk information to "normal" (default)
set-option -g @double-status-bar-disk-info 'normal'

# Set the disk information to "verbose"
set-option -g @double-status-bar-disk-info 'verbose'

# Set the disk information type to "used" (default)
set-option -g @double-status-bar-disk-info-type" "used"

# Set the disk information type to "available"
set-option -g @double-status-bar-disk-info-type" "available"

# Set the disk information directory to "/home"
set-option -g @double-status-bar-disk-info-dir" "/home"
```

## License

[MIT](LICENSE)
