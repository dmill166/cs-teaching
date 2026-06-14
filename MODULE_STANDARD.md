# Module Standard

> **Applies to every module in every course** of the cs-teaching initiative (CS 1050 today; CS 1030/2050/3810 later). The goal: a learner (or another instructor) can tell at a glance **what a module includes, what it deliberately leaves out, and why**. Transparency is a feature.

## Required sections (every module README)

A module's `README.md` must contain these, in this order:

1. **What's in this module (and what's not)** — up front. A short scope statement: the goal, what's covered, and what's intentionally *excluded* (and where it lives instead). Set expectations before the content.
2. **Core instructions / content** — the required, accessibility-first path. Assumes no prior experience; assumes nothing the course hasn't taught. This is what every student must do.
3. **Advanced Instructions (optional)** — clearly-optional depth for students with prior experience or curiosity (extra tooling, alternative setups, deeper dives). **Never required to pass.** Always labeled optional so a beginner can skip it without anxiety.
4. **FAQs & design decisions** — capture the *why* where students see it: why we chose X over Y, why something is or isn't included, common questions. This is the running record of intentional choices, in plain language.

Other sections (verify steps, troubleshooting, references) are welcome as the content needs.

## Principles

- **Transparency over mystery.** If a choice might make a student wonder "why this and not that?", answer it in the FAQ rather than leaving it implicit.
- **Accessibility-first core, optional depth.** The core path never assumes prior knowledge; everything that does goes under Advanced Instructions, opt-in.
- **Decisions live where they're felt.** Course-wide rationale belongs in `cs1050_design_rationale.md`; a *module-specific* decision belongs in that module's FAQ so the reader finds it in context.
- **Plain language.** Beginners are the audience. Define terms or skip them.
- **No third-party copyrighted content.** Modules cite and align to sources but never reproduce them. Non-negotiable — see [`COPYRIGHT_POLICY.md`](COPYRIGHT_POLICY.md).

## Template

Start new modules from [`templates/module_README_template.md`](templates/module_README_template.md).

## Why this standard exists

Requested by the maintainer (2026-06-14) for transparency about what each module contains and why — and so the structure is automatic, not re-negotiated per module. A consistent shape also makes the modules easier to turn into build-in-public posts: "what's in it / why" is already written.
