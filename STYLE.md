# Editorial Style

> Conventions for public-facing wording across all Dakota Learns courses and the site (dakotalearns.com). Grows as conventions are set. See also the per-topic [Module Standard](MODULE_STANDARD.md) and [Copyright Policy](COPYRIGHT_POLICY.md).

## Naming external institutions

Refer to an institution by the name **it** asks to be called — courtesy and accuracy (and, for us, nothing to do with affiliation; we're independent — see each repo's affiliation note and the site [Disclaimers](https://dakotalearns.com/disclaimers/)).

### Metropolitan State University of Denver

Per MSU Denver's **Editorial Standards** (2024-03-08, §"Using Our Name"):

- **First / formal reference:** the full name **Metropolitan State University of Denver**.
- **Subsequent references:** **MSU Denver** (or "the University").
- **Never** the acronyms **"MSU"** or **"MSUD"** alone — *verbatim from the policy.* (Applies to possessives: "MSU Denver's," not "MSU's.")
- **No "the"** before the full name; **no "of"** in the short form (not "MSU of Denver").
- **Never** "Metro" or "Metro State"; **never** "University of Denver" standalone for MSU Denver (watch for line breaks that read "University of Denver").

**Our practical application:** use **"MSU Denver"** for alignment references; reserve the full name for the formal affiliation/disclaimer statements we already carry. We don't otherwise adopt MSU Denver's internal house style (degree formatting, "Dr." usage, etc.) — we're independent — though the doc is a useful AP-aligned reference if we ever want it.

*Source:* held privately at `dakotalearns/_local/MSUDenver_EditorialStandards_240308.pdf` (their copyrighted doc — not redistributed); public: [Brand Central](https://www.msudenver.edu/brandcentral/).

## Writing for the dual audience (decided 2026-07-03)

Course content serves **two readers at once**: students in a formal university section, and self-learners who found the site on their own. Rules:

- **Self-learners are the default reader.** Anything true for everyone is written plainly; anything section-specific gets conditional framing — "Enrolled in a course section that uses this material? … Self-learning? …" — never bare "submit through the LMS" / "bring it to class."
- **Watch-list phrases** that assume enrollment: LMS/Canvas, "in class," "office hours," "your instructor," "this section," due-date mechanics. They're allowed *inside* the conditional framing, not outside it.
- **Pacing language is relative** ("this week," "before your first week ends"), so self-paced learners get honest rhythm cues. Absolute dates live only in the per-term schedule overlay, referenced as a term-scoped parenthetical: *"(In Fall 2026, that means before Monday, Aug 24 — see the schedule.)"*

## Clean page URLs (decided 2026-07-03)

Per-item pages (lectures, checkpoints, labs, assignments) are named **`index.md`** inside their `NN_topic/` folder, so the site URL is the folder alone (`/lectures/00_what_is_computation/`), never a doubled `/NN_topic/NN_topic/` segment. The theme's `navigation.indexes` feature makes the folder title the clickable page. Known tradeoff, accepted: GitHub's folder view auto-renders `README.md` but not `index.md` — the site is the reading surface; the repo is the code surface.

## Code style (all published code — decided 2026-07-03)

Every file a student (or future Dakota) opens is a style exemplar, whether or not it was meant as one. So published code — including starters, self-checks, and grading scripts — follows industry standards:

- **Python: [PEP 8](https://peps.python.org/pep-0008/)** (79-character lines; 72 for comments/docstrings) plus **[PEP 257](https://peps.python.org/pep-0257/)** one-line docstrings on every function. Lint before shipping (`flake8`/`ruff`). *(Note the numbers precisely: PEP 8 says 79/72 — "80–100" is common industry relaxation (Black uses 88), not the official guide.)*
- **JavaScript: [JSDoc](https://jsdoc.app/)** headers on every function (`@param`/`@returns`) + section banners; inline `//` comments only where the code can't say it.
- **Never pluralize a type name in code font** — not "**ints**"; write "`int` values" or use the English word ("integers"). A pluralized identifier reads as a different identifier.

## Naming our own artifacts

- **Spell artifact names out; don't coin acronyms.** Course artifacts stay unabbreviated — "**Checkpoint 1**", not "CP1"; short is fine, acronyms are not. They collide with things you won't see coming.
- **If a short form is ever unavoidable, collision-check it first** (common abbreviations, slang, medical/legal terms). Two we dodged: **WUE** (Warm-Up Exercise) = *Western Undergraduate Exchange*; **CP** (Checkpoint) is a notorious abbreviation for child-abuse material **and** the medical abbreviation for Cerebral Palsy.
