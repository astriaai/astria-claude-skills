#!/usr/bin/env bash
# Refresh local API cache for tunes, packs, and prompts.
# Usage:
#   refresh-cache.sh              # refresh all if stale (>24h)
#   refresh-cache.sh --force      # refresh all regardless of age
#   refresh-cache.sh tunes        # refresh only tunes.json
#   refresh-cache.sh prompts      # refresh only prompts.json
#   refresh-cache.sh packs        # refresh only packs.json

set -euo pipefail

DIR=".cache/ws_${WORKSPACE_ID:-personal}"
mkdir -p "$DIR"
REFRESHED_AT="$DIR/_refreshed_at"
MAX_AGE=86400  # 24 hours

FORCE=false
RESOURCE=""
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=true ;;
    tunes|prompts|packs) RESOURCE="$arg" ;;
  esac
done

fetch() {
  local name="$1"
  local jq_filter=""
  case "$name" in
    tunes) jq_filter='map({ id, title, name, orig_images })' ;;
    prompts) jq_filter='map({ id, text, num_images, images, aspect_ratio, resolution, input_image, input_video })' ;;
    packs) jq_filter='map({ id, title, slug, main_class_name, multiplier, multiplier_api })' ;;
    *) jq_filter='.' ;;
  esac

  curl -s -H "Authorization: Bearer $ASTRIA_AUTH_TOKEN" \
       -H "X-Workspace-Id: ${WORKSPACE_ID:-}" \
       "$ASTRIA_BASE_URL/$name" | jq "$jq_filter" > "$DIR/$name.json"
}

# Single-resource refresh (used after mutations)
if [ -n "$RESOURCE" ]; then
  fetch "$RESOURCE"
  date +%s > "$REFRESHED_AT"
  exit 0
fi

# Full refresh — skip if cache is fresh enough (unless --force)
if [ "$FORCE" = false ] && [ -f "$REFRESHED_AT" ]; then
  last=$(cat "$REFRESHED_AT")
  now=$(date +%s)
  age=$(( now - last ))
  if [ "$age" -lt "$MAX_AGE" ]; then
    exit 0
  fi
fi

fetch tunes &
fetch packs &
fetch prompts &
wait
date +%s > "$REFRESHED_AT"
