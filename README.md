# cs-teaching

Open computer-science course materials, **built in public** and aligned to MSU Denver's CS curriculum, ABET CAC student outcomes, and the ACM/IEEE-CS CS2023 knowledge areas.

This is the **index repo** — it ties together one repo per course. Each course is its own pair of repositories:

- a **public** repo with student-facing materials (notes, slides, lab & assignment prompts, starter code, outcomes map), and
- a **private** sibling with instructor-only materials (solution keys, exams, rubrics, grading scripts).

That split is deliberate: it keeps everything open **except** what would compromise assessment if published.

## Courses

| Course | Title | Public repo | Status |
|---|---|---|---|
| **CS 1050** | Computer Science 1 (Python) | [`msudenver-cs1050`](https://github.com/dmill166/msudenver-cs1050) | 🟢 pilot — scaffolded |
| CS 1030 | Computer Science Principles | _planned_ | ⚪ parked |
| CS 2050 | Computer Science 2 / Data Structures | _planned_ | ⚪ parked |
| CS 3810 | Principles of Database Systems | _planned_ | ⚪ parked |

> The **CS 1050** pilot is built end-to-end first; its structure and lessons then template the other three. Repos live under the `dmill166` GitHub account.

## Why build in public

1. **Teaching prep.** The repos *are* the teaching materials — adjunct-ready and reusable.
2. **Accessibility.** Free CS materials anyone can read and learn from (noncommercial, with attribution).
3. **Portfolio.** A public, ABET-mapped body of work that doubles as a tested-experience artifact.

## Content engine

Each finished module produces:

- **1 LinkedIn post** — the concept in plain language + a link to the repo, and
- **1 WordPress long-form** — the lecture rewritten as an article.

Cadence: 1–2 per week once there's material to show. Series framing: **"Teaching CS1 in public."** The repo is the single backlog — content is written once and reused, never twice.

## Licensing

- **Course content:** [CC BY-NC-ND 4.0](LICENSE-CONTENT.md) — read/share, noncommercial, attribution, no derivatives.
- **Code:** [PolyForm Noncommercial 1.0.0](LICENSE) — noncommercial use.

For commercial use or adaptations, [contact for permission](https://github.com/dmill166). These licenses cover original work only and grant no rights to third-party materials a course references — see [COPYRIGHT_POLICY.md](COPYRIGHT_POLICY.md).

## Repo + project conventions

- **One repo per course** (not a monorepo) + this index — each course can be linked, posted about, and graduated independently.
- Tracking the work *across* repos (the build backlog, content calendar, what's shipped) is best handled by a **GitHub Project (v2) board** at the user/org level — a board spans repos; it doesn't replace the repo split. See the build state in `life-os` (`01_career/teaching/active_state_teaching.md`) for the canonical next-steps list.
