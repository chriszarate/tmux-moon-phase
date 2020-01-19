# Tmux Moon Phase

Put a description of the current lunar phase in your tmux status bar.

## Usage

Add `#{moon_phase}` and/or `#{moon_phase_text}` to your `status-left` or
`status-right`:

```
set -g status-right '#{moon_phase} #{moon_phase_text}'
```

This results in:

```
🌘 waning crescent
```

## Installation

1. Install [Tmux Plugin Manager][tpm].

2. Add this plugin to your `~/.tmux.conf`:

```
set -g @plugin 'chriszarate/tmux-moon-phase'
```

3. Press [prefix] + `I` to install.


[tpm]: https://github.com/tmux-plugins/tpm
