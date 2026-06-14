#!/usr/bin/env bash
# Scaffold the "CS Teaching — Build Board" GitHub Project (v2) for dmill166.
# One-time setup. Requires: gh CLI authed, and the `project` scope:
#   gh auth refresh -s project,read:project
# Idempotency: this script CREATES; re-running makes duplicates. Run once.
set -euo pipefail

OWNER="dmill166"
TITLE="CS Teaching — Build Board"

echo ">> Creating project..."
PROJ=$(gh project create --owner "$OWNER" --title "$TITLE" --format json | jq -r '.number')
echo "   Project #$PROJ created."

echo ">> Adding custom fields..."
# A workflow Stage (the kanban columns), a Track (build vs content vs ops), and Course.
gh project field-create "$PROJ" --owner "$OWNER" --name "Stage" \
  --data-type SINGLE_SELECT \
  --single-select-options "Backlog,Now,In progress,Review,Shipped"
gh project field-create "$PROJ" --owner "$OWNER" --name "Track" \
  --data-type SINGLE_SELECT \
  --single-select-options "Build,Content,Ops"
gh project field-create "$PROJ" --owner "$OWNER" --name "Course" \
  --data-type SINGLE_SELECT \
  --single-select-options "CS1050,CS1030,CS2050,CS3810,Cross"

echo ">> Seeding items (draft issues)..."
add() { gh project item-create "$PROJ" --owner "$OWNER" --title "$1" --body "$2"; }

# --- Ops (do first) ---
add "Get current CS 1050 section syllabus from Zhu/Mota" \
    "Track: Ops. Current edition + schedule + grading split. Refines the design; does not block."
add "Decide term commitment: Fall 2026 (stretch) vs Spring 2027 (primary)" \
    "Track: Ops. Drives the build clock. See active_state_teaching.md timeline."

# --- Build: weeks 1-5 teachable spine (per cs1050_design_rationale.md) ---
add "Week 1 — Unit 0+1: What is computation; values, types, variables, I/O" \
    "Track: Build / Course: CS1050. Slides + finger exercise + lab + assignment a01. Private: solution+rubric."
add "Week 2 — Units 2+3: Decisions (branching) and Iteration (loops)" \
    "Track: Build / Course: CS1050. Slides + finger exercise + lab + assignment a02. Private: solution+rubric."
add "Week 3 — Unit 4: Strings & sequence basics" \
    "Track: Build / Course: CS1050. Slides + lab + assignment a03. Private: solution+rubric."
add "Week 4 — Unit 5: Functions, decomposition, abstraction, scope" \
    "Track: Build / Course: CS1050. Slides + lab + assignment a04. Private: solution+rubric."
add "Week 5 — Unit 6: Lists, tuples, mutability & ALIASING [CS2 bridge ***]" \
    "Track: Build / Course: CS1050. Highest-leverage CS2 prep. Extra examples + dedicated assessment."

# --- Build: foundational artifacts ---
add "Promote syllabus v1 -> official MSU section syllabus" \
    "Track: Build / Course: CS1050. Add MSU boilerplate (disability/Title IX/drop dates), finalize grading weights & AI policy."
add "Set up CI autograding on public repo (student-runnable tests only)" \
    "Track: Build / Course: CS1050. Public tests in repo; hidden tests in -solutions/grading."

# --- Content (build-in-public) ---
add "Post 1 — Launch: 'Teaching CS1 in public' (intro + repo link)" \
    "Track: Content. LinkedIn + WordPress. Frame the series and the accessibility goal."
add "Post 2 — 'How I mapped CS1 to ABET CAC + CS2023 outcomes'" \
    "Track: Content. Use outcomes_map_abet_cs2023.md as the backbone."
add "Post 3 — 'The CS1 topic that makes or breaks CS2: aliasing'" \
    "Track: Content. Pull from the design rationale's CS2-readiness bridge."

echo ">> Done. View it:"
gh project view "$PROJ" --owner "$OWNER" --web
echo
echo "Note: items land in the default view; set Stage (Backlog/Now/...) by dragging,"
echo "or script it later with: gh project item-edit --id <itemID> --field-id <fieldID> --single-select-option-id <optID>"
