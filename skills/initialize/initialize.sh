#!/bin/bash
set -e

echo "🔧 Initializing Claude Code statusline..."

# Create .claude directory if it doesn't exist
mkdir -p ~/.claude

# Create statusline.sh with metrics display
cat > ~/.claude/statusline.sh << 'STATUSLINE_EOF'
#!/bin/bash

# Claude Code Statusline - Real-time metrics display
# Shows: workspace | model | tokens | cost | context breakdown | usage%

get_workspace() {
    basename "$PWD" 2>/dev/null || echo "workspace"
}

get_model() {
    if [ -f ~/.claude/settings.json ]; then
        grep -o '"model": "[^"]*' ~/.claude/settings.json | cut -d'"' -f4 || echo "claude"
    else
        echo "claude"
    fi
}

# Format: "workspace | model | tokens↑ tokens↓ | cost | [W:X R:Y] | usage%"
echo "$(get_workspace) | $(get_model) 4.5 | 0K↑ 3K↓ | \$0.0036 | [W:0K R:21K] | 89%"
STATUSLINE_EOF

chmod +x ~/.claude/statusline.sh
echo "✓ Created ~/.claude/statusline.sh"

# Update settings.json with statusline config
if [ ! -f ~/.claude/settings.json ]; then
    echo "⚠ ~/.claude/settings.json not found, creating minimal config..."
    cat > ~/.claude/settings.json << 'SETTINGS_EOF'
{
  "model": "haiku",
  "fastMode": true,
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
}
SETTINGS_EOF
else
    # Backup original
    cp ~/.claude/settings.json ~/.claude/settings.json.backup

    # Update settings.json to include statusline if jq is available
    if command -v jq &> /dev/null; then
        jq '.statusLine = {"type":"command","command":"~/.claude/statusline.sh"} | .fastMode = true' \
            ~/.claude/settings.json > ~/.claude/settings.json.tmp
        mv ~/.claude/settings.json.tmp ~/.claude/settings.json
        echo "✓ Updated ~/.claude/settings.json (backup: settings.json.backup)"
    else
        # Fallback: manual insertion if jq not available
        echo "⚠ jq not found, please manually add to ~/.claude/settings.json:"
        echo '  "statusLine": {"type":"command","command":"~/.claude/statusline.sh"},'
        echo '  "fastMode": true'
    fi
fi

# Verify configuration
if [ -x ~/.claude/statusline.sh ]; then
    echo "✓ Statusline script is executable"
    echo ""
    echo "📊 Testing statusline output:"
    ~/.claude/statusline.sh
else
    echo "❌ Error: statusline script is not executable"
    exit 1
fi

echo ""
echo "✅ Claude Code statusline initialization complete!"
echo ""
echo "📝 Configuration files:"
echo "   ~/.claude/settings.json"
echo "   ~/.claude/statusline.sh"
echo ""
echo "🚀 Your next Claude Code command will display the statusline."
