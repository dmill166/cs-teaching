#!/usr/bin/env bash
# One-off board corrections after locking Fall 2026 + adding Module 0:
#   1. Repurpose the "section syllabus from Zhu/Mota" gate -> optional cross-check, Stage=Backlog
#   2. Mark the "Decide term commitment" item RESOLVED (Fall 2026), Stage=Shipped
#   3. Add a "Module 0 — environment setup" build item (already built), Stage=Review
#
# gh quirk handled here: editing a DRAFT item's TITLE needs the draft-content id
# (DI_...), while setting FIELD values needs the project-item id (PVTI_...) plus
# --project-id. We read both; title edits are best-effort, field edits are exact.
#
# Requires: gh authed as dmill166 with `project` scope, plus jq. Run once.
set -euo pipefail

OWNER="dmill166"
TITLE_PREFIX="CS Teaching"
command -v jq >/dev/null || { echo "ABORT: jq not installed (brew install jq)"; exit 1; }

echo ">> Locating project..."
PJSON=$(gh project list --owner "$OWNER" --limit 100 --format json)
NUM=$(echo "$PJSON" | jq -r --arg t "$TITLE_PREFIX" '.projects[] | select(.title|startswith($t)) | .number' | head -1)
PID=$(echo "$PJSON" | jq -r --arg t "$TITLE_PREFIX" '.projects[] | select(.title|startswith($t)) | .id'     | head -1)
[ -n "${NUM:-}" ] && [ -n "${PID:-}" ] || { echo "ABORT: project not found"; exit 1; }
echo "   project #$NUM ($PID)"

FIELDS=$(gh project field-list "$NUM" --owner "$OWNER" --format json)
optid() { echo "$FIELDS" | jq -r --arg f "$1" --arg o "$2" '.fields[] | select(.name==$f) | .options[] | select(.name==$o) | .id'; }
fid()   { echo "$FIELDS" | jq -r --arg f "$1" '.fields[] | select(.name==$f) | .id'; }
TRACK_F=$(fid Track); COURSE_F=$(fid Course); STAGE_F=$(fid Stage)

# PVTI item id + DI content id for the first item whose title contains $1
ids_for() { gh project item-list "$NUM" --owner "$OWNER" --limit 100 --format json \
  | jq -r --arg s "$1" '.items[] | select(.title|contains($s)) | [.id, (.content.id // "")] | @tsv' | head -1; }

set_sel()  { [ -n "$3" ] || return 0; gh project item-edit --id "$1" --project-id "$PID" --field-id "$2" --single-select-option-id "$3" >/dev/null; }
retitle()  { # DIid  newtitle  (best-effort; draft content id may not be exposed)
  if [ -z "$1" ]; then echo "   (rename skipped — no DI_ content id available)"; return 0; fi
  if gh project item-edit --id "$1" --title "$2" >/dev/null 2>&1; then echo "   renamed."; else echo "   (rename non-fatal failure — left title as-is)"; fi
}

echo ">> 1. Repurpose the section-syllabus gate..."
IFS=$'\t' read -r SYL_PVTI SYL_DI < <(ids_for "section syllabus from Zhu/Mota") || true
if [ -n "${SYL_PVTI:-}" ]; then
  set_sel "$SYL_PVTI" "$STAGE_F"  "$(optid Stage Backlog)"
  set_sel "$SYL_PVTI" "$TRACK_F"  "$(optid Track Ops)"
  set_sel "$SYL_PVTI" "$COURSE_F" "$(optid Course CS1050)"
  retitle "${SYL_DI:-}" "Optional cross-check: design vs a live MSU section syllabus"
  echo "   -> Backlog (optional)."
else echo "   (not found — already changed?)"; fi

echo ">> 2. Mark term decision resolved (Fall 2026)..."
IFS=$'\t' read -r TERM_PVTI TERM_DI < <(ids_for "Decide term commitment") || true
if [ -n "${TERM_PVTI:-}" ]; then
  set_sel "$TERM_PVTI" "$STAGE_F" "$(optid Stage Shipped)"
  retitle "${TERM_DI:-}" "Term locked: Fall 2026 (decided 2026-06-14)"
  echo "   -> Shipped."
else echo "   (not found — already changed?)"; fi

echo ">> 3. Add Module 0 build item..."
NEW=$(gh project item-create "$NUM" --owner "$OWNER" \
  --title "Week 0 / Module 0 — Environment setup (per-OS Python install)" \
  --body "Track: Build / Course: CS1050. Built 2026-06-14: resources/setup/ — macOS/Windows/Linux install, IDLE-first, verify, troubleshooting. Pending: final review + use in week 1." \
  --format json | jq -r '.id')
set_sel "$NEW" "$TRACK_F"  "$(optid Track Build)"
set_sel "$NEW" "$COURSE_F" "$(optid Course CS1050)"
set_sel "$NEW" "$STAGE_F"  "$(optid Stage Review)"
echo "   added -> Review."

echo ">> Done. Open it:"
gh project view "$NUM" --owner "$OWNER" --web
