---
title: cs-teaching — Repo Rules for Agents
scope: repo-local — adds to (and inside this repo, overrides) ~/agents/AGENTS.md
---

<!-- author_status: assistant-shared | section: full page (agent instructions written to Dakota's rules; pending his read) -->

# cs-teaching — Repo Rules for Agents

The **index repo** for Dakota's open, built-in-public CS course initiative. It ties together
one public/private repo pair per course. Public front door: [dakotalearns.com](https://dakotalearns.com).

## This repo owns the standards, not the materials

Course content lives in the per-course repos. What lives here is the rulebook, and these files
are the SSOT — read the relevant one before changing anything downstream:

| File | Governs |
|---|---|
| `COPYRIGHT_POLICY.md` | What may and may not appear in a public course repo |
| `MODULE_STANDARD.md` | Required shape of every module README |
| `STYLE.md` | Prose and formatting conventions |
| `COURSE_STRUCTURE.md` | Repo-pair architecture, naming |
| `voice_provenance.md` | How authorship is tracked in the materials |
| `a11y.md`, `interactive_checks.md` | Accessibility and interactive-content gates |

## Hazards

- **Copyright is a hard line.** Never reproduce third-party copyrighted material in a public
  course repo — align to and cite published outcomes, write original examples. `COPYRIGHT_POLICY.md`
  is the SSOT; when in doubt, don't.
- **Affiliation disclaimer is load-bearing.** These materials are independent and NOT affiliated
  with, endorsed by, or sponsored by MSU Denver. Course codes are referenced for alignment only.
  Never write anything that implies otherwise.
- **Voice.** Student-facing prose is Dakota's, per `~/agents/rules/voice.md`. The agent scaffolds,
  edits, and offers options; it does not ghost-write.
- **Numerals.** Arabic by default in titles, including module and unit numbers.
