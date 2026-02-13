# Astria API Configuration

API credentials and config are available as environment variables:
- $ASTRIA_AUTH_TOKEN — Bearer token for API calls
- $ASTRIA_BASE_URL — API base URL (default: https://api.astria.ai)
- $GEMINI_TUNE_ID — Gemini (Nano-Banana Pro) tune ID
- $SEEDREAM_TUNE_ID — Seedream 4.5 tune ID
- $WORKSPACE_ID — Current workspace ID (include in all API calls)

Use these in all curl commands:
```
curl -s -H "Authorization: Bearer $ASTRIA_AUTH_TOKEN" -H "X-Workspace-Id: $WORKSPACE_ID" $ASTRIA_BASE_URL/...
```

Skills in .claude/skills/ load automatically when relevant (API reference, navigation, packs, prompt writing, support FAQ).
