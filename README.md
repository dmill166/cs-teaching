# cs-teaching

Open, beginner-first computer-science course materials, **built in public** — aligned to recognized CS outcomes (ABET CAC, ACM/IEEE-CS CS2023) and, for alignment only, university course objectives.

**Public home:** [dakotalearns.com](https://dakotalearns.com) (source: [`dmill166/dakotalearns`](https://github.com/dmill166/dakotalearns)) — the readable front door; these course repos are the canonical source of materials.

> **Affiliation:** Independent materials by Dakota Hollmann. **Not affiliated with, endorsed by, or sponsored by Metropolitan State University of Denver.** MSU Denver course codes and objectives are referenced for curriculum alignment only.

This is the **index repo** — it ties together one repo per course. Each course is its own pair of repositories:

- a **public** repo with student-facing materials (notes, slides, lab & assignment prompts, starter code, outcomes map), and
- a **private** sibling with instructor-only materials (solution keys, exams, rubrics, grading scripts).

That split is deliberate: it keeps everything open **except** what would compromise assessment if published.

## Courses

| Course | Public repo | Status |
|---|---|---|
| **Computer Science 1** (Python) | [`computer-science-1`](https://github.com/dmill166/computer-science-1) | 🟢 pilot — scaffolded |
| Computer Science Principles | _planned_ | ⚪ parked |
| Computer Science 2 / Data Structures | _planned_ | ⚪ parked |
| Database Systems | _planned_ | ⚪ parked |

> The **Computer Science 1** pilot is built end-to-end first; its structure and lessons then template the other three. Repos live under the `dmill166` GitHub account.

## Why build in public

1. **Teaching prep.** The repos *are* the teaching materials — adjunct-ready and reusable.
2. **Accessibility.** Free CS materials anyone can read and learn from (noncommercial, with attribution).
3. **Portfolio.** A public, ABET-mapped body of work that doubles as a tested-experience artifact.

## Content engine

Each finished module produces a short **LinkedIn post** — the concept in plain language, linking back to the lesson on [dakotalearns.com](https://dakotalearns.com).

Cadence: 1–2 per week once there's material to show. Series framing: **"Teaching CS1 in public."** The lesson itself is never rewritten for the site — it's authored once in the course repo and rendered on dakotalearns.com via build-time sync. One source, never two.

## Licensing

- **Course content:** [CC BY-NC-ND 4.0](LICENSE-CONTENT.md) — read/share, noncommercial, attribution, no derivatives.
- **Code:** [PolyForm Noncommercial 1.0.0](LICENSE) — noncommercial use.

For commercial use or adaptations, [contact for permission](https://github.com/dmill166). These licenses cover original work only and grant no rights to third-party materials a course references — see [COPYRIGHT_POLICY.md](COPYRIGHT_POLICY.md).

## Repo + project conventions

- **One repo per course** (not a monorepo) + this index — each course can be linked, posted about, and graduated independently.
- Tracking the work *across* repos (the build backlog, content calendar, what's shipped) is best handled by a **GitHub Project (v2) board** at the user/org level — a board spans repos; it doesn't replace the repo split.
