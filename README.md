# Claude Code Init Plugin (initplugins)

Sets up statusline display and configuration with a single command.

## Installation

```bash
/plugin marketplace add https://github.com/gattinocole-bit/my-marketplace.git  
/plugin install initplugins@my-marketplace --scope user
```

## Usage

Run any of these commands to initialize:

```bash
/initialize
/init
/setup
```

This will create `~/.claude/statusline.sh` and configure `~/.claude/settings.json` with metrics display and fast mode.
