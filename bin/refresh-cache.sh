#!/usr/bin/env bash
# Refresh local API cache for tunes, packs, and prompts.
# Usage:
#   refresh-cache.sh                        # refresh all if stale (>24h)
#   refresh-cache.sh --force                # refresh all regardless of age
#   refresh-cache.sh tunes                  # refresh only tunes.json
#   refresh-cache.sh prompts                # refresh only prompts.json
#   refresh-cache.sh packs                  # refresh only packs.json
#   refresh-cache.sh --workspace 123        # refresh cache for workspace 123
#   refresh-cache.sh --workspace all packs  # refresh packs cache across all workspaces

set -euo pipefail

MAX_AGE=86400  # 24 hours

FORCE=false
RESOURCE=""
WORKSPACE_TARGET="${WORKSPACE_ID:-personal}"

while [ "$#" -gt 0 ]; do
  case "$1" in
    --force)
      FORCE=true
      shift
      ;;
    --workspace)
      [ "$#" -lt 2 ] && echo "Missing value for --workspace" >&2 && exit 1
      WORKSPACE_TARGET="$2"
      shift 2
      ;;
    --workspace=*)
      WORKSPACE_TARGET="${1#*=}"
      shift
      ;;
    tunes|prompts|packs)
      RESOURCE="$1"
      shift
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 1
      ;;
  esac
done

WORKSPACE_SLUG="$(echo "$WORKSPACE_TARGET" | tr -c '[:alnum:]_.-' '_')"
DIR=".cache/ws_${WORKSPACE_SLUG}"
mkdir -p "$DIR"
REFRESHED_AT="$DIR/_refreshed_at"

fetch() {
  local name="$1"
  local jq_filter=""
  case "$name" in
    tunes) jq_filter='map({ id, title, name, orig_images })' ;;
    prompts) jq_filter='map({ id, text, num_images, images, aspect_ratio, resolution, input_image, input_video })' ;;
    packs) jq_filter='map({ id, title, slug, main_class_name, multiplier, multiplier_api })' ;;
    *) jq_filter='.' ;;
  esac

  local curl_args=(
    -s
    -H "Authorization: Bearer $ASTRIA_AUTH_TOKEN"
  )

  [ "$WORKSPACE_TARGET" != "personal" ] && curl_args+=(-H "X-Workspace-Id: $WORKSPACE_TARGET")

  curl "${curl_args[@]}" "$ASTRIA_BASE_URL/$name" | jq "$jq_filter" > "$DIR/$name.json"
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
