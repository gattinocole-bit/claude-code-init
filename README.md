# Claude Code Init Plugin (@claudecode/claudeinit)

Automated initialization plugin for Claude Code. Sets up statusline display, configuration, and workspace defaults with a single command.

## Features

✨ **One-command setup** — Initialize entire Claude Code workspace
📊 **Real-time metrics** — Display tokens, cost, context usage in CLI
⚙️ **Auto-configuration** — Updates settings.json with optimal defaults
🔄 **Smart backups** — Backs up existing config before modifying
✅ **Verification** — Tests setup and displays confirmation

## Installation

### From npm registry (when published)
```bash
claude plugin install @claudecode/claudeinit
```

### From GitHub (development)
```bash
git clone https://github.com/yourusername/claude-code-init-plugin.git
cd claude-code-init-plugin
npm install
npm run build
claude plugin install ./
```

## Usage

### Quick Start
```bash
/initialize
```

This single command will:
1. Create `~/.claude/statusline.sh` (metrics display script)
2. Update `~/.claude/settings.json` with statusline config
3. Enable fast mode for optimal performance
4. Verify all changes
5. Display test output

### Alternative Triggers
```bash
/init
/setup
```

## Statusline Output

After initialization, every Claude Code command displays:
```
claudeWorkspace | Haiku 4.5 | 0K↑ 3K↓ | $0.0036 | [W:0K R:21K] | 89%
```

**Breakdown:**
- `claudeWorkspace` — Current working directory
- `Haiku 4.5` — Active Claude model
- `0K↑` — Input tokens this session
- `3K↓` — Output tokens received
- `$0.0036` — Estimated session cost
- `[W:0K R:21K]` — Write/Read token breakdown
- `89%` — Context window usage percentage

## Configuration Files

### Created/Modified

| File | Purpose |
|------|---------|
| `~/.claude/statusline.sh` | Bash script that generates metrics display |
| `~/.claude/settings.json` | Claude Code configuration (statusline + fastMode) |
| `~/.claude/settings.json.backup` | Backup of original settings (created if exists) |

### Manual Configuration

If the plugin fails or you want to configure manually:

#### 1. Create statusline script
```bash
mkdir -p ~/.claude
cat > ~/.claude/statusline.sh << 'EOF'
#!/bin/bash
echo "Claude Code Status: $(date '+%H:%M:%S')"
EOF
chmod +x ~/.claude/statusline.sh
```

#### 2. Update settings.json
```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  },
  "fastMode": true
}
```

## Troubleshooting

### "Permission denied: ~/.claude/statusline.sh"
```bash
chmod +x ~/.claude/statusline.sh
```

### "jq not found" warning
- macOS: `brew install jq`
- Linux: `apt install jq` (Ubuntu/Debian) or `yum install jq` (RedHat)
- Windows: Use WSL or manually edit `~/.claude/settings.json`

### Settings not applying
1. Restart Claude Code CLI
2. Check file permissions: `ls -la ~/.claude/`
3. Verify JSON syntax: `jq . ~/.claude/settings.json`

### Want to revert changes
```bash
# Restore backup
mv ~/.claude/settings.json.backup ~/.claude/settings.json

# Remove statusline script
rm ~/.claude/statusline.sh
```

## Plugin Structure

```
claudeinit/
├── package.json              (npm package metadata)
├── plugin.json               (Claude Code plugin registration)
├── README.md                 (this file)
├── LICENSE                   (MIT license)
├── skills/
│   └── initialize/
│       ├── SKILL.md          (skill documentation)
│       ├── manifest.json     (skill manifest)
│       └── initialize.sh     (executable handler)
├── dist/                     (compiled TypeScript, if used)
└── src/                      (TypeScript sources, optional)
```

## Development

### Build
```bash
npm run build
```

### Watch mode (auto-rebuild)
```bash
npm run dev
```

### Test locally
```bash
bash skills/initialize/initialize.sh
```

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

MIT License — See [LICENSE](./LICENSE) file for details.

## Support

- 📖 [Claude Code Documentation](https://claude.ai/docs)
- 🐛 [Report Issues](https://github.com/yourusername/claude-code-init-plugin/issues)
- 💬 [Discussions](https://github.com/yourusername/claude-code-init-plugin/discussions)

## Changelog

### v1.0.0 (2026-05-19)
- Initial release
- Statusline initialization
- Settings.json configuration
- Backup and verification

---

**Made with ❤️ for Claude Code**
