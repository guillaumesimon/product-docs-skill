---
name: product-docs-update
description: Keep the living product documentation at docs/product/index.html true after a code change, and audit it against the code. Use this skill whenever work in a repository that has docs/product/index.html changes how the product is understood - a new or modified business rule, a new mechanism or background job, a new capability, a changed plan or permission logic, a new external dependency, a new AI component, a redefined metric, a concluded experiment, a resolved incident, a structuring decision, a new or shipped spec, a change of priority on the roadmap. Also use it when the user asks to review, audit or refresh the product docs, to check whether they still match the code, to add a spec page or a decision, or when a page is flagged as needing review or stale. If docs/product/index.html does not exist, use product-docs-bootstrap instead.
---

# Update the product documentation

The documentation at `docs/product/index.html` describes the present state of the product. This skill keeps it that way: small, surgical edits in the same commit as the code, and a periodic audit that catches what slipped through.

Start by checking the file exists. If it does not, this is a bootstrap job, not an update: use `product-docs-bootstrap`.

## First, decide whether to touch it at all

One question: **would someone who read the docs yesterday misunderstand the product today because of this change?**

If no, stop. Most commits change values, columns, events, styling or implementation without changing how the product is understood, and the docs are deliberately silent about all of that. Editing them anyway trains everyone to skim a page that changes for no reason.

If yes, find the pages with `references/change-map.md` and edit those, only those.

## Make the edit

Read the target page before editing it, and edit in place. The page carries its own contract in its `data-trigger` and `data-sources` attributes: `data-trigger` tells you what that page is supposed to react to, `data-sources` tells you where the detail lives so you do not copy it.

Then, on every page you touched:

- `data-verified` = today's date
- `data-status` = `"ok"`

If you find a gap you cannot resolve - the code says one thing, the page says another, and you do not know which is right - set `data-status="check"` and describe the gap in one sentence at the top of the page, with a `<span class="tag t-check">Gap spotted</span>` marker. A flagged gap is useful; a silent one rots.

Keep the edit small. A change to one business rule is one entry, not a rewrite of the page.

## Writing rules

These are what keep the docs readable and maintainable. `references/change-map.md` has the full detail; the essentials:

**Explain, do not copy.** Anything obtainable with a query or by opening a file stays out. Explain the principle, then cite the file. If a page you are editing starts growing lists, you have drifted.

**One piece of information, one place.** Everywhere else, a link. If the fact already lives on another page, link to it rather than restating it.

**Present tense only.** History goes to Changelog and Decisions, the future to Roadmap and Specs. Never write "used to" or "will soon" in a living page.

**Every explanation ends with a door into the code.** A file, a test, a dashboard.

**Never invent a reason.** If the "why" is not established, write `Why: to be confirmed` rather than something plausible. A wrong reason is worse than a missing one, because it will be believed and defended later.

**Identifiers are permanent.** BR, D, S, RB numbers are never reused. A retired rule stays, marked as retired.

**Glossary terms, no synonyms.** If your change introduces a new concept, add it to the glossary in the same edit.

Write in the language the existing pages use - English unless the file says otherwise.

## The structural pieces

Three parts of the page generate themselves from metadata, so edit the source of truth rather than the rendering.

**Spec pages.** One page per project: `<section class="page" data-parent="specs">` with `data-spec-id`, `data-spec-status` (draft, ready, in-progress, shipped, dropped), `data-target`, `data-updated`. Create one by copying an existing spec page. The index on the Specs page builds itself, so never type a spec's title or status anywhere else.

**Roadmap rows.** One `<tr>` per live project inside `<tbody data-roadmap>`, in priority order, with `data-spec` pointing at the spec page and `data-horizon` set to now, next or later. Rank, project name and spec status are filled in automatically - write only the problem, the metric and the horizon. Reordering the rows is how priority changes. A shipped or dropped project loses its row.

**A shipped spec.** When a project ships, move its lasting content to the living pages - Features, Business rules, Key mechanisms, Metrics - then set `data-spec-status="shipped"` and stop editing the spec. Remove its roadmap row and add a Changelog entry. The spec becomes a record of what was decided at the time; the living pages win if they disagree.

## The audit pass

When asked to review or refresh the docs, or on a schedule, the job is to ask of every page: is what this page claims still true of the code it points at? Not whether the wording could be nicer - leave meaning-preserving rewrites alone.

Each page carries its own `data-sources`, so each can be checked independently. Fan out: one agent per page, then two cross-page agents that catch what per-page checks cannot - contradictions between pages, and what a newcomer still cannot answer. Read `references/audit-team.md` for the prompts and the rules. Without subagents, run the same checks yourself, starting with the pages already marked `check` or `stale`.

You apply the findings, never the agents: set each page's `data-verified` to today and `data-status` to its verdict, or `check` with the gap described in one sentence at the top. Where an agent reports a page as false, read the code yourself before believing it - it may have followed a different path than the one the page describes.

Open a pull request rather than pushing, and report as a list: page, verdict, what changed. Surface separately the unanswerable newcomer questions and any contradiction between pages, since that usually means the team holds two mental models of the same thing. The home page register is the dashboard: every page with its status, review date and trigger.

Do not use a team for a single-change update. Reading one page and editing one entry is faster done directly.

## Reference

- `references/change-map.md` - which change updates which pages, plus the full writing rules and the edit checklist
- `references/audit-team.md` - the audit team: per-page and cross-page prompts, verdicts, how to apply the findings
