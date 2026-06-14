#!/usr/bin/env bash
# Add the website/platform work items to the "CS Teaching — Build Board".
# Track=Ops for infra, Content for the post migration; Course=Cross.
# Idempotent-ish: re-running creates duplicates — run once.
# Requires: gh authed as dmill166 with `project` scope, plus jq.
set -euo pipefail

OWNER="dmill166"
TITLE_PREFIX="CS Teaching"
command -v jq >/dev/null || { echo "ABORT: jq not installed (brew install jq)"; exit 1; }

PJSON=$(gh project list --owner "$OWNER" --limit 100 --format json)
NUM=$(echo "$PJSON" | jq -r --arg t "$TITLE_PREFIX" '.projects[] | select(.title|startswith($t)) | .number' | head -1)
PID=$(echo "$PJSON" | jq -r --arg t "$TITLE_PREFIX" '.projects[] | select(.title|startswith($t)) | .id'     | head -1)
[ -n "${NUM:-}" ] && [ -n "${PID:-}" ] || { echo "ABORT: project not found"; exit 1; }
echo "project #$NUM"

FIELDS=$(gh project field-list "$NUM" --owner "$OWNER" --format json)
fid()   { echo "$FIELDS" | jq -r --arg f "$1" '.fields[] | select(.name==$f) | .id'; }
optid() { echo "$FIELDS" | jq -r --arg f "$1" --arg o "$2" '.fields[] | select(.name==$f) | .options[] | select(.name==$o) | .id'; }
TRACK_F=$(fid Track); COURSE_F=$(fid Course); STAGE_F=$(fid Stage)
set_sel() { [ -n "$3" ] || return 0; gh project item-edit --id "$1" --project-id "$PID" --field-id "$2" --single-select-option-id "$3" >/dev/null; }

add() {  # title  body  track  stage
  local id
  id=$(gh project item-create "$NUM" --owner "$OWNER" --title "$1" --body "$2" --format json | jq -r '.id')
  set_sel "$id" "$TRACK_F"  "$(optid Track  "$3")"
  set_sel "$id" "$COURSE_F" "$(optid Course Cross)"
  set_sel "$id" "$STAGE_F"  "$(optid Stage  "$4")"
  printf '  + [%s/%s] %s\n' "$3" "$4" "$1"
}

add "Site: register dakotalearns.com (Cloudflare)" \
    "Cloudflare Registrar, ~\$10/yr. Owns the canonical home for all content." Ops Now
add "Site: push dakotalearns repo + enable GitHub Pages" \
    "git init/push dmill166/dakotalearns; Settings -> Pages -> Source: GitHub Actions. See DEPLOY.md." Ops Now
add "Site: wire Cloudflare DNS -> Pages + HTTPS" \
    "Apex+www CNAME -> dmill166.github.io (DNS only/grey); set custom domain; enforce HTTPS. See DEPLOY.md." Ops Backlog
add "Site: set LinkedIn URL (mkdocs.yml + about.md)" \
    "Replace CHANGEME / 'coming soon' with the real LinkedIn profile URL." Ops Backlog
add "Site: migrate 2 Python install posts -> /guides/install-python" \
    "Supersede the 2023/2024 WordPress install guides; add 'updated version' note linking forward. See DEPLOY.md tracker." Content Backlog

echo "Done."
gh project view "$NUM" --owner "$OWNER" --web
