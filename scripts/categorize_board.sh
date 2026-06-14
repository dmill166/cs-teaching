#!/usr/bin/env bash
# Auto-set Track + Course on every item of the "CS Teaching — Build Board"
# (GitHub Projects v2), and drop the two ops gates into Stage = Now.
#
# Stable fields only: Track and Course don't change as work moves, so scripting
# them pays off; Stage you'll move by hand, except the two "do first" gates we
# seed into Now here.
#
# Idempotent: re-running just re-sets the same values. Safe to run more than once.
# Requires: gh authed as dmill166 with the `project` scope, plus jq.
set -euo pipefail

OWNER="dmill166"
TITLE_PREFIX="CS Teaching"   # matched by startswith to dodge em-dash encoding

command -v jq >/dev/null || { echo "ABORT: jq not installed (brew install jq)"; exit 1; }

echo ">> Locating project..."
PROJ_JSON=$(gh project list --owner "$OWNER" --limit 100 --format json)
NUM=$(echo "$PROJ_JSON" | jq -r --arg t "$TITLE_PREFIX" '.projects[] | select(.title|startswith($t)) | .number' | head -1)
PID=$(echo "$PROJ_JSON" | jq -r --arg t "$TITLE_PREFIX" '.projects[] | select(.title|startswith($t)) | .id'     | head -1)
[ -n "${NUM:-}" ] && [ -n "${PID:-}" ] || { echo "ABORT: project not found"; exit 1; }
echo "   project #$NUM ($PID)"

echo ">> Reading fields + options..."
FIELDS=$(gh project field-list "$NUM" --owner "$OWNER" --format json)
fid()    { echo "$FIELDS" | jq -r --arg f "$1" '.fields[] | select(.name==$f) | .id'; }
optid()  { echo "$FIELDS" | jq -r --arg f "$1" --arg o "$2" '.fields[] | select(.name==$f) | .options[] | select(.name==$o) | .id'; }
TRACK_F=$(fid Track); COURSE_F=$(fid Course); STAGE_F=$(fid Stage)

set_sel() {  # itemID  fieldID  optionID
  [ -n "$3" ] || return 0
  gh project item-edit --id "$1" --project-id "$PID" --field-id "$2" --single-select-option-id "$3" >/dev/null
}

echo ">> Categorizing items..."
gh project item-list "$NUM" --owner "$OWNER" --limit 100 --format json \
  | jq -r '.items[] | [.id, .title] | @tsv' \
  | while IFS=$'\t' read -r iid title; do
      track=""; course=""; stage=""
      case "$title" in
        *"section syllabus from Zhu/Mota"*) track=Ops;     course=CS1050; stage=Now ;;
        *"Decide term commitment"*)         track=Ops;     course=Cross;  stage=Now ;;
        Week*)                              track=Build;   course=CS1050 ;;
        *"Promote syllabus"*)               track=Build;   course=CS1050 ;;
        *autograding*)                      track=Build;   course=CS1050 ;;
        *"Launch:"*)                        track=Content; course=Cross  ;;
        *ABET*)                             track=Content; course=CS1050 ;;
        *aliasing*)                         track=Content; course=CS1050 ;;
        *) echo "   ?  unmatched: $title"; continue ;;
      esac
      printf '   -> %-7s %-7s %-4s | %s\n' "$track" "$course" "${stage:-—}" "$title"
      set_sel "$iid" "$TRACK_F"  "$(optid Track  "$track")"
      set_sel "$iid" "$COURSE_F" "$(optid Course "$course")"
      [ -n "$stage" ] && set_sel "$iid" "$STAGE_F" "$(optid Stage "$stage")"
    done

echo ">> Done. Open it:"
gh project view "$NUM" --owner "$OWNER" --web
