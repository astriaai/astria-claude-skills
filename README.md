# Astria Claude Skills

Claude Code skills and system prompt for working with the [Astria](https://www.astria.ai) API — image generation, fine-tuning, prompt writing, and more.

## Quick Start

```bash
git clone https://github.com/astriaai/astria-claude-skills.git
cd astria-claude-skills

# Set your API credentials
export ASTRIA_AUTH_TOKEN="your-api-key"
export ASTRIA_BASE_URL="https://api.astria.ai"
export GEMINI_TUNE_ID="3618064"
export SEEDREAM_TUNE_ID="3691308"
# export WORKSPACE_ID="your-workspace-id"  # optional

# Run Claude Code with the system prompt
claude --append-system-prompt "$(cat SYSTEM_PROMPT.md)"
```

Claude will automatically load skills from `.claude/skills/` as needed.

## Skills

| Skill | Description |
|-------|-------------|
| **astria-api** | API reference for tunes, prompts, packs, Gemini/Seedream |
| **navigation** | Astria app sitemap and navigation routes |
| **packs-guide** | Pack templates, categories, and photoshoot workflows |
| **prompt-writing** | Prompt syntax, parameters, and tips |
| **support-faq** | Billing, accounts, plugin troubleshooting |

## Directory Structure

```
.claude/
  skills/
    astria-api/SKILL.md
    navigation/SKILL.md
    packs-guide/SKILL.md
    prompt-writing/SKILL.md
    support-faq/SKILL.md
CLAUDE.md           # Project config (env vars, skill loading)
SYSTEM_PROMPT.md    # Core assistant behavior and examples
```

## API Key

Get your API key at [astria.ai/users/edit/api](https://www.astria.ai/users/edit/api).
