---
name: initialize
description: Setup Claude Code statusline, settings, workspace configuration, and MCP servers
keywords: [setup, statusline, init, config, workspace, mcp, atlassian, datadog, playwright]
---

# Initialize Claude Code Workspace

This skill configures Claude Code with a custom statusline that displays:
- **Workspace**: Current working directory name
- **Git Branch**: Active git branch (if in a git repo)
- **Model**: Current AI model (Opus/Sonnet/Haiku)
- **Tokens**: Input/Output token usage in real-time
- **Cost**: Estimated session cost
- **Context**: Read/Write token breakdown
- **Usage**: Context window percentage

## What it does

1. Creates `~/.claude/statusline.sh` (custom metrics script)
2. Updates `~/.claude/settings.json` (global config):
   - Enable the statusline with workspace/branch info
   - Enable fast mode for quicker responses
   - Keep `CLAUDE.md` under 200 lines (truncate if needed)
   - Enable auto-memory for `MEMORY.md` (persistent across conversations)
   - Configure MCP servers (Atlassian, Datadog, Playwright)
3. Prompts for Atlassian configuration:
   - Jira project key
   - Confluence spaceId
   - CloudId URL
4. Creates/updates `~/.claude/AGENTS.md` with Atlassian Rovo MCP settings
5. Verifies configuration

## Usage

```bash
/initialize
```

## Output

After running, your Claude Code CLI will display:
```
claudeWorkspace (main) | Haiku 4.5 | 0K↑ 3K↓ | $0.0036 | [W:0K R:21K] | 89%
```

## Manual setup (if skill fails)

1. Create `~/.claude/statusline.sh`:
```bash
#!/bin/bash
echo "Claude Code Status"
```

2. Update `~/.claude/settings.json`:
```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  },
  "fastMode": true,
  "claudeMdMaxLines": 200,
  "autoMemory": {
    "enabled": true,
    "memoryPath": "MEMORY.md"
  },
  "mcpServers": {
    "atlassian": {
      "type": "http",
      "url": "https://mcp.atlassian.com/v1/mcp/authv"
    },
    "datadog": {
      "type": "http",
      "url": "https://mcp.datadoghq.com/api/unstable/mcp-server/mcp"
    },
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["@modelcontextprotocol/server-playwright"]
    }
  }
}
```

3. Make script executable:
```bash
chmod +x ~/.claude/statusline.sh
```

4. Create/update `~/.claude/AGENTS.md` with Atlassian configuration:
```markdown
# AGENTS.md

## Atlassian Rovo MCP

When connected to atlassian-rovo-mcp:
- **MUST** use Jira project key = "YOUR_PROJECT_KEY"
- **MUST** use Confluence spaceId = "YOUR_SPACE_ID"
- **MUST** use cloudId = "YOUR_CLOUD_ID"
- **MUST** use `maxResults: 10` or `limit: 10` for ALL Jira JQL and Confluence CQL search operations.
```

Replace `YOUR_PROJECT_KEY`, `YOUR_SPACE_ID`, and `YOUR_CLOUD_ID` with your actual values.

## Files modified

- `~/.claude/settings.json` — Global config with statusLine, fastMode, CLAUDE.md line limit, auto-memory, and MCP servers
- `~/.claude/statusline.sh` — created/updated with workspace/branch display
- `~/.claude/AGENTS.md` — created/updated with Atlassian Rovo MCP configuration (Jira project key, Confluence spaceId, cloudId)
- `CLAUDE.md` — truncated to 200 lines max (in local project)
- `MEMORY.md` — auto-created and enabled for persistent context (in local project)

## MCP Servers

Configured: Atlassian, Datadog, Playwright

## Requirements

- Claude Code CLI installed
- Permissions to write to `~/.claude/`
- macOS/Linux (script is bash-based)

---

## Configuration Prompts

When you run `/initialize`, you'll be asked for:

1. **Jira Project Key** — e.g., "MYPROJ"
2. **Confluence Space ID** — alphanumeric ID from your workspace
3. **Atlassian Cloud ID** — e.g., "https://yourcompany.atlassian.net"

These are saved to `~/.claude/AGENTS.md` for global use.

## Next steps

1. Run `/initialize` to set up your workspace
2. Provide your Atlassian credentials when prompted
3. Check the statusline to verify workspace/branch display
4. View MCP server status with `claude settings view mcpServers`
