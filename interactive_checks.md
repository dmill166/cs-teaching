# Interactive Self-Checks — Data Format

> How quiz and Parsons self-checks are authored in course repos and rendered on dakotalearns.com. Companion to [`a11y.md`](a11y.md) (interaction requirements) and the [Module Standard](MODULE_STANDARD.md). Adopted 2026-07-03 (the "D3" decision — renderer built in Phase 0 of the CS1 one-shot).

## The split (matches the site↔course sync architecture)

- **Data** lives in the **course repo's markdown**, as fenced ` ```quiz ` / ` ```parsons ` JSON blocks — plain text, so it rides the normal `*.md` content sync with no glob changes, and stays readable as code on GitHub.
- **Renderer** lives in the **site repo**: `dakotalearns/docs/javascripts/quiz-parsons.js` (+ styles in `docs/stylesheets/extra.css`, fence registration in `mkdocs.yml`). One renderer, every course.
- **Progressive enhancement:** if JavaScript fails or the JSON is malformed, the raw block stays visible — degraded but readable, never a blank hole. A bad block logs a console warning and is left as-is.

## Quiz block (single-answer multiple choice)

````markdown
```quiz
{
  "title": "Check yourself",
  "questions": [
    {
      "prompt": "What type is the value `4.3`?",
      "options": ["`int`", "`float`", "`str`", "`bool`"],
      "answer": 1,
      "explain": "The decimal part is the giveaway — a whole number like `650` is an `int`."
    }
  ]
}
```
````

- `answer` is the zero-based index into `options`.
- `explain` (optional but strongly encouraged) shows on a correct answer — reinforce *why*, don't just congratulate.
- Prompts/options/explanations support a deliberate markdown subset: `` `code` `` and `**bold**` only. Everything else is escaped.
- Learners can retry until correct; a wrong answer never reveals the answer.

## Parsons block (order the lines)

````markdown
```parsons
{
  "title": "Build the program",
  "prompt": "Drag the lines (or use the arrow buttons) into the order that works.",
  "code": true,
  "lines": [
    "dash_time = 4.3",
    "print(dash_time)",
    "print(type(dash_time))"
  ]
}
```
````

- `lines` are written in the **correct** order in the source; the renderer shuffles on load (and guarantees the shuffle isn't accidentally correct).
- `"code": true` renders lines in monospace (code exercises); omit for prose steps.
- The check is **exact-order**, so the prompt must force a single valid order (e.g., "print the value, *then* print its type"). If two orders would genuinely both work, rewrite the exercise — don't ship an exercise that marks a correct program wrong.
- No distractor lines in v1 (the single-list reorder model can't "leave one out"). If distractors are ever needed, extend the renderer first.

## Authoring rules

- Per the lecture framework (P6): every lecture ships ≥1 retrieval quiz and ≥1 Parsons problem.
- Feedback wording is part of the voice surface — keep it encouraging, never snarky. The renderer's fixed strings ("Correct!", "Not quite — try again.") are intentionally neutral-warm.
- Accessibility is the renderer's job (native inputs, keyboard move buttons, `aria-live` feedback, icon + words + color); the *author's* job is prompts that don't rely on color or position language ("the green one", "the line above").
- Static `??? question` collapsible blocks remain valid for prose Q&A the widget model doesn't fit (open-ended "explain in your own words" prompts). Use the widget for anything self-scorable.
