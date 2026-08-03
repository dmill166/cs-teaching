#!/usr/bin/env bash
# rename_board_courses.sh — one-shot migration: subject-first course names
# on the live "CS Teaching — Build Board" GitHub Project (2026-07-27).
#
# WHAT THIS SCRIPT DOES (the scriptable part):
#   Rewrites draft-issue TITLES and BODIES on the board, replacing the
#   compact course tokens with subject-first names:
#     CS1050 -> Computer Science 1        CS1030 -> Computer Science Principles
#     CS2050 -> Computer Science 2        CS3810 -> Database Systems
#   Deliberately does NOT touch spaced "CS 1050" etc. — those are
#   MSU-referential mentions (e.g., "Get current CS 1050 section syllabus
#   from Zhu/Mota") and stay per the naming rule.
#
# WHAT YOU DO MANUALLY (one minute, safer than the API):
#   Project settings -> field "Course" -> edit each option's TEXT in place:
#     CS1050 -> Computer Science 1, CS1030 -> Computer Science Principles,
#     CS2050 -> Computer Science 2, CS3810 -> Database Systems.
#   Editing option text in the UI preserves every item's assignment.
#   (The API path replaces the option list and risks orphaning values —
#   not worth it for four clicks.)
#
# Usage:
#   bash scripts/rename_board_courses.sh           # dry run — shows changes
#   bash scripts/rename_board_courses.sh --apply   # actually writes
# Requires: gh CLI authed with project scope, jq.
set -euo pipefail

OWNER="dmill166"
TITLE="CS Teaching — Build Board"
APPLY="${1:-}"

PROJ=$(gh project list --owner "$OWNER" --format json \
  | jq -r ".projects[] | select(.title==\"$TITLE\") | .number")
[ -n "$PROJ" ] || { echo "Board not found"; exit 1; }
echo ">> Project #$PROJ"

rename() {
  sed -e 's/CS1050/Computer Science 1/g' \
      -e 's/CS1030/Computer Science Principles/g' \
      -e 's/CS2050/Computer Science 2/g' \
      -e 's/CS3810/Database Systems/g'
}

gh project item-list "$PROJ" --owner "$OWNER" --format json --limit 200 \
  | jq -c '.items[] | select(.content.type=="DraftIssue")
           | {id: .content.id, title: .content.title, body: .content.body}' \
  | while read -r item; do
  id=$(jq -r '.id' <<<"$item")
  title=$(jq -r '.title' <<<"$item")
  body=$(jq -r '.body // ""' <<<"$item")
  new_title=$(rename <<<"$title")
  new_body=$(rename <<<"$body")
  if [ "$title" != "$new_title" ] || [ "$body" != "$new_body" ]; then
    echo "----------------------------------------"
    echo "ITEM:  $title"
    [ "$title" != "$new_title" ] && echo "  title -> $new_title"
    [ "$body" != "$new_body" ] && echo "  body  -> (course tokens renamed)"
    if [ "$APPLY" = "--apply" ]; then
      gh api graphql \
        -f draftId="$id" -f newTitle="$new_title" -f newBody="$new_body" \
        -f query='mutation($draftId: ID!, $newTitle: String!, $newBody: String!) {
          updateProjectV2DraftIssue(input: {
            draftIssueId: $draftId, title: $newTitle, body: $newBody
          }) { draftIssue { id } }
        }' > /dev/null
      echo "  APPLIED"
    fi
  fi
done

[ "$APPLY" = "--apply" ] || echo ">> Dry run only. Re-run with --apply to write."
