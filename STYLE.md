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

## Page furniture placement (decided 2026-07-03)

- **Instructor-facing collapsibles sit at the top of the page** — directly under the H1, before the student-facing content — never at the bottom. Collapsed, they cost students one gray line; buried, instructors never find them. Same rule for "How to read this page" notes on syllabus-type pages.
- **No item counts in headings** ("Content units (9)") — the count goes stale the moment the list changes. Counts live in prose, where editing the list means touching the sentence anyway.

## Clean page URLs (decided 2026-07-03)

Per-item pages (lectures, checkpoints, labs, assignments) are named **`index.md`** inside their folder, so the site URL is the folder alone (`/unit00_what_is_computation/`), never a doubled `/NN_topic/NN_topic/` segment. (Folder layout itself: [`COURSE_STRUCTURE.md`](COURSE_STRUCTURE.md).) The theme's `navigation.indexes` feature makes the folder title the clickable page. Known tradeoff, accepted: GitHub's folder view auto-renders `README.md` but not `index.md` — the site is the reading surface; the repo is the code surface.

## Code style (all published code — decided 2026-07-03)

Every file a student (or future Dakota) opens is a style exemplar, whether or not it was meant as one. So published code — including starters, self-checks, and grading scripts — follows industry standards:

- **Python: [PEP 8](https://peps.python.org/pep-0008/)** (79-character lines; 72 for comments/docstrings) plus **[PEP 257](https://peps.python.org/pep-0257/)** docstrings on every function, in **[Google style](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)** (decided 2026-08-02): `Args:` / `Returns:` / `Raises:` sections **where they add information** — non-obvious parameters, meaningful return values, deliberate raises. Trivial helpers and `test_*` functions keep honest one-liners; ceremonial sections on obvious functions are the docstring version of filler prose. Lint before shipping (`flake8`/`ruff`). *(Note the numbers precisely: PEP 8 says 79/72 — "80–100" is common industry relaxation (Black uses 88), not the official guide.)*
- **JavaScript: [JSDoc](https://jsdoc.app/)** headers on every function (`@param`/`@returns`) + section banners; inline `//` comments only where the code can't say it.
- **Never pluralize a type name in code font** — not "**ints**"; write "`int` values" or use the English word ("integers"). A pluralized identifier reads as a different identifier.

## Time estimates (decided 2026-07-21)

State effort estimates in Dakota's conversational register, and always as a **range**, never a single number:

- **Instructional pages** (guides, labs, setup): *"This could take you somewhere around 15–20 minutes."* — the standard sentence form.
- **Passing mentions** (nav pages, link blurbs): the compact form *"around 15–20 minutes"* is fine.
- **Avoid** the imperative "Budget X minutes" / "Allow X minutes" — reads like a syllabus, not like Dakota.

## Glossary vs. abbreviation tooltips (decided 2026-08-02)

Two different tools for two different readers:

- **Site-wide abbreviation tooltips** (`includes/abbreviations.md`) take **every acronym that appears on the site**, including instructor/accreditation jargon (ABET, CAC, OCW, CS2023). Cheap, hover-only, zero page real estate.
- **Glossary entries** (`docs/glossary.md`) are reserved for **student-facing vocabulary a learner actually needs to own** (IDLE, REPL, I/O, OOP, PATH). The glossary is a study surface, not an acronym dump — "ABET" does not belong next to "IDLE."
- Rule of thumb: every glossary-worthy acronym also gets a tooltip; the reverse is false. First in-prose use still spells terms out per the vocabulary convention.

## Version numbers (decided 2026-07-27)

- **Release lines are bare MAJOR.MINOR:** "Python 3.13 or newer," "3.11/3.12 also work." Never append `.x` — it's decoration, and python.org doesn't use it either.
- **Full MAJOR.MINOR.PATCH appears only in literal example output** ("you should see something like `Python 3.14.6`"), where showing a real version string is the honest illustration.
- Patch-level differences never drive course guidance; if one ever does, that's a special callout, not a version reference.

## Naming our own artifacts

- **Spell artifact names out; don't coin acronyms.** Course artifacts stay unabbreviated — "**Checkpoint 1**", not "CP1"; short is fine, acronyms are not. They collide with things you won't see coming.
- **If a short form is ever unavoidable, collision-check it first** (common abbreviations, slang, medical/legal terms). Two we dodged: **WUE** (Warm-Up Exercise) = *Western Undergraduate Exchange*; **CP** (Checkpoint) is a notorious abbreviation for child-abuse material **and** the medical abbreviation for Cerebral Palsy.
