# Voice & Provenance Markers

<!-- author_status: dakota-voice-draft | section: full page (new public standards doc, assistant-drafted 2026-07-09 — Dakota reviews framing before publish + promote to dakota-authored) -->

> **What this is:** the cross-course convention for `author_status` provenance markers — the paper trail behind a simple promise: **everything published here passes through Dakota's hands before it counts as his.** This doc is the single source of truth for the marker grammar; the enforcement scripts in each repo implement it.

## The principle

Let me be clear up front: this does **not** mean I don't use AI. I use it a ton — especially on the project-management side, where it plays to my gaps (my strong suit is solving complex problems, not organizing them). What it *does* mean is that AI never gets a blind push to the public: **I am the human provider, reviewer, and final approver of everything that goes out.** Some content I write entirely by hand; some starts as a draft shaped from my own recorded voice-core (my words, brain-dumped, then structured); all of it gets my review, my edits, and my final sign-off before it ships.

I believe strongly in trust — and in being able to *verify* where something came from, not just take my word for it. That's what these markers are: an auditable trail, in the page source itself, of who authored what. There is deliberately **no exempt class** of published prose (decided 2026-07-09): every public page — reference pages, syllabi, and repo READMEs included — gets my voice and my hand before it counts as mine.

## The marker

An HTML comment (invisible on the rendered page, greppable in source), placed at the top of a page or the start of a section:

```html
<!-- author_status: dakota-authored | section: Frame -->
```

| Value | Meaning |
|---|---|
| `dakota-authored` | Dakota wrote it, or reviewed/edited a shaped draft and approved it as his. The end state for all voice-bearing prose. |
| `dakota-voice-draft` | Assistant-drafted in Dakota's voice, **pending his review**. Must never publish — the site gate hard-fails on it. |
| `assistant-mechanical` | Mechanical content (objectives, quiz/Parsons data, key-term lists, summaries) drafted by the assistant per the collaboration model; Dakota reviews before ship. |
| `assistant-shared` | Shared authorship per the collaboration model — assistant structure with Dakota's substantive input (he seeds, narrates, or affirms the framing). On a **reviewed, finalized page** this is a permanent, honest end state, not a defect. During an active review cycle it can also mark content awaiting his affirmation — in that case the marker's inline note names the pending promote. |

Lecture pages carry a marker **per spine section** — deliberately, not messily: authorship genuinely varies section-by-section on a lecture (Dakota's frame and explanations vs. mechanical quiz data), the per-section trail is the strongest form of the authorship record, and keeping voice-core in its own marker-bounded blocks means regenerating a mechanical section can never disturb authored prose. Simpler pages (syllabi, guides, references) carry one **page-level** marker. Readers never see any of this — HTML comments are invisible on the rendered page. Any other value after `author_status:` is treated as a typo and fails the gate.

## Enforcement (two vendored halves)

- **Site side:** `dakotalearns/tools/check_content.py` runs post-sync/pre-build in deploy CI. Hard-fails any surviving `dakota-voice-draft` (the publish-lock) and any page with **no** valid marker (the coverage check). `docs/blog/` is excluded — the blog is Dakota's first-person journal by definition, and blog drafts are held by `draft: true`.
- **Course-repo side:** `<course>/tools/integrity_scan.py` (check iv) applies the same coverage rule to pages that never sync to the site (e.g. `resources/`, the repo README). Only `LICENSE*` files are skipped — third-party legal text, not authored prose.

The implementations are deliberately **vendored per repo** (no cross-repo CI dependency, same philosophy as the site's hand-rolled content sync). This doc is the SSOT for the grammar; if the two scripts and this doc ever disagree, this doc wins and the scripts get fixed. Revisit hoisting to shared code when a second course repo lands.

## Workflow

1. Assistant drafts → marks `dakota-voice-draft` (voice prose) or `assistant-mechanical`/`assistant-shared` (mechanical/shared).
2. Dakota reviews — edits, rewrites, or approves.
3. On approval, the marker flips to `dakota-authored` (the promote). Only then can the page deploy.
4. The gate makes step 3 unskippable: an unpromoted draft, or an unmarked page, blocks the build.
