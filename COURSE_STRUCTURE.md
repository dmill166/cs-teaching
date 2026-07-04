# Course Repository Structure — Unit-First

> **Applies to every course repo** (computer-science-1 today; every later course). Unit-first decided 2026-07-03 (Dakota's call, replacing the earlier type-bucket layout after one week of real content); flat root layout (no `units/` container) refined 2026-07-04 (also Dakota's). Companion to the [Module Standard](MODULE_STANDARD.md), [STYLE.md](STYLE.md) (clean URLs, page furniture), and [a11y.md](a11y.md).

## The principle

**Structure by what content *is*; schedule by when it *happens*.** The course's logical atom is the **unit** (the design-rationale topic spine), so the repo is a tree of units — each one containing everything unit-scoped. Weeks, terms, and session pacing live only in the swappable per-term schedule overlay (`syllabus/schedule.md`), never in the folder structure. A self-learner paces by units ("Unit 1 this week"); an instructor maps units onto any calendar.

## Public course repo layout

```
<course>/
  syllabus/                 course-level: syllabus (index.md), sample schedule,
                            design rationale, outcomes map
  unitNN_topic/             one folder per unit, AT THE REPO ROOT (no units/
    index.md                  container — see "Why not the alternatives");
    lab/                     zero-padded numbers = teaching order everywhere.
      index.md              ← the lecture (clean URL: /unitNN_topic/)
      starter/              lab/ = that unit's practice session (only when the
    checkpoint/                unit warrants one — absence is intentional)
      index.md              checkpoint/ = the unit's low-stakes graded check
      starter/                 (numbered by unit)
    assignment/             assignment/ = lives in the LAST unit it covers; its
      index.md                 header states the span ("covers Units 1–2")
      starter/
  resources/                course-wide reference ONLY (e.g. environment setup).
                            Anything unit-scoped belongs in its unit folder.
```

- **Numbering:** unit folders, labs, and checkpoints are all numbered by **unit** (Checkpoint 1 = Unit 1's), never by week. Zero-padding makes alphabetical order = teaching order, so nav and sync can include units by glob (`unit*`) with no hand-kept list.
- **Nav:** each unit folder is one collapsible section (`.nav.yml` title `"Unit N · Topic"`), ordered lecture → lab → checkpoint → assignment. Page files are `index.md` (clean URLs; `README.md` is repo-facing and excluded from the site sync).
- **Cross-unit exceptions:** genuinely course-spanning artifacts (e.g. the research-paper + oral-presentation communication thread) get a course-level home when built — don't force them into a unit.

## Private solutions repo mirrors the public paths

```
<course>-solutions/
  solutions/unitNN_topic/{checkpoint,lab,assignment}/
  rubrics/unitNN_topic/…
  exams/                    course-level, private-only
  grading/
```

Path-mirroring keeps the integrity firewall's write-routing deterministic: a grader (or scanner) maps public ↔ private by substituting the repo root, nothing else.

## Site sync

Two rules per course (`from: syllabus` + the glob `from: "unit*"`), `*.md` + `.nav.yml` only, `README.md` excluded — unit-count-agnostic, matching the global nav's course glob. Starter code never syncs — students get it from the repo (ZIP) per the Using GitHub guide.

## Why not the alternatives

- **Type buckets** (`lectures/ labs/ assignments/`): librarian convenience — a unit's materials scatter across three folders, and nothing in the tree answers "what belongs together?" (the original layout; replaced).
- **A `units/` container folder** (`units/NN_topic/`): a filler path element — it lengthens every URL, adds a breadcrumb and a nav level that mean nothing, and the zero-padded `unitNN_` prefix already does the grouping and ordering (Dakota's refinement, 2026-07-04; the container's only real benefit was a single sync rule, solved by the sync glob).
- **Week folders** (`week01/`): bakes one term's pacing into the portable design — retargeting a different semester/school would mean restructuring the repo and breaking every URL instead of swapping the one schedule file. Units spanning week boundaries (or weeks with no unit, like a midterm) make it lie immediately.
