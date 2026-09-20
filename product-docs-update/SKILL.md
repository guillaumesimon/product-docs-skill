---
name: product-docs-update
description: Keep the product documentation at docs/product/index.html true after a code change, and audit it against the code. Use this skill whenever work in a repository that has docs/product/index.html changes how the product is understood - a business rule, a mechanism or background job, a capability, plan or permission logic, an external dependency, an AI component, a metric, an experiment, a structuring decision, a roadmap priority. Also for the business card - pitch, mission and vision, personas, business model, market and competitors, the single objective and the strategy - when the company pivots, changes who it serves, how it charges or what it optimises for, or those pages are missing. Also when a project has shipped, a rollout gate is removed or a spec is out, to move that spec into the living pages. Also when the user asks to review, audit or refresh the docs, to add a spec page or a decision, or a page is flagged stale. If docs/product/index.html does not exist, use product-docs-bootstrap instead.
---

# Update the product documentation

The documentation at `docs/product/index.html` describes the present state of the product. This skill keeps it that way: small, surgical edits in the same commit as the code, and a periodic audit that catches what slipped through.

Start by checking the file exists. If it does not, this is a bootstrap job, not an update: use `product-docs-bootstrap`.

## First, decide whether to touch it at all

One question: **would someone who read the docs yesterday misunderstand the product today because of this change?**

If no, stop. Most commits change values, columns, events, styling or implementation without changing how the product is understood, and the docs are deliberately silent about all of that. Editing them anyway trains everyone to skim a page that changes for no reason.

If yes, find the pages with `references/change-map.md` and edit those, only those.

**A second question, and only when something was decided.** Did this work settle who the product is for, how it makes money, what it is optimising for, or where it stands against a competitor? If so, the business card is in scope. That question has a closed trigger list and a rule about never editing those pages without an explicit yes - both in `references/business-card.md`. Do not ask it on an ordinary commit; a prompt that fires every time is a prompt everyone learns to dismiss.

**One case answers yes on its own: the change ships a spec.** If the code in front of you makes a spec's behaviour real - a feature flag or a rollout gate removed, a branch that becomes unconditional, a job that starts running - or if someone tells you a project is out, that spec's content has to move into the living pages now. Read `references/handover.md` and run it. This is the single most common way these docs go stale: the feature is live, Features still says planned, and Key mechanisms never heard of it.

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

**A spec's future changelog.** Every spec carries one, in a `<div class="release">` right after the expected outcome: the announcement users will read on release day, written before the build. A title and two or three lines, emoji, benefits rather than features, no internal vocabulary. It is also the benefit test - a project nobody can announce in three lines is a project whose value is not settled, and the spec is not ready. Keep it up to date when the scope moves.

**Handover lines.** Inside each spec, a `<ul class="handover">` with one `<li data-page="...">` per page the project will have to feed, and `data-done="<date>"` once the content is actually there. The badges, the tally in the spec header, the debt table on the home page and the counter in the top bar are all generated from it, so ticking a line means moving the content, never the reverse. `references/handover.md` is the procedure.

**Roadmap rows.** One `<tr>` per live project inside `<tbody data-roadmap>`, in priority order, with `data-spec` pointing at the spec page and `data-horizon` set to now, next or later. Rank, project name and spec status are filled in automatically - write only the problem, the metric and the horizon. Reordering the rows is how priority changes. A shipped or dropped project loses its row.

**A shipped spec.** Work the handover line by line: for each one, move the content into its target page in that page's own shape, tick it with today's date, and set that page's `data-verified` and `data-status`. When every line is ticked, and only then, set `data-spec-status="shipped"`, copy the future changelog into the Changelog as the version's entry, remove the roadmap row and stop editing the spec. An open line keeps the spec `in-progress`; if the user says the feature is live anyway, mark it shipped and leave the line open - the home register will carry the debt under the project's name. Full procedure in `references/handover.md`. The spec becomes a record of what was decided and promised at the time; the living pages win if they disagree.

## The business card

Five pages - pitch and mission and vision, personas, business model, market and competitors, objective and strategy - behave unlike everything else here, and `references/business-card.md` is the procedure for all of it.

What makes them different, in one line each: their trigger is the conversation rather than the diff, since a pivot never shows up in a diff; they cannot be verified against anything except the person who said it, so the audit marks them *old* rather than false; and they are never edited without an explicit yes, because an agent quietly rewriting a mission has changed something the team owns.

The page that does real work is `Objective and strategy`. It carries one objective - acquisition, activation, retention or revenue - on `data-objective`, and every live spec carries a line saying how it serves it. That pair is what makes the roadmap checkable, so keep it singular: replacing the objective is a Decision, and adding a second is not an option.

If the documentation has no business card at all - it was written before these pages existed - that is an update job, not a bootstrap one. The reference says how to add the group; the interview itself is in `product-docs-bootstrap/references/business-card.md`.

## The audit pass

When asked to review or refresh the docs, or on a schedule, the job is to ask of every page: is what this page claims still true of the code it points at? Not whether the wording could be nicer - leave meaning-preserving rewrites alone.

Each page carries its own `data-sources`, so each can be checked independently. Fan out: one agent per page, then two cross-page agents that catch what per-page checks cannot - contradictions between pages, and what a newcomer still cannot answer. Read `references/audit-team.md` for the prompts and the rules. Without subagents, run the same checks yourself, starting with the pages already marked `check` or `stale`.

You apply the findings, never the agents: set each page's `data-verified` to today and `data-status` to its verdict, or `check` with the gap described in one sentence at the top. Where an agent reports a page as false, read the code yourself before believing it - it may have followed a different path than the one the page describes.

Open a pull request rather than pushing, and report as a list: page, verdict, what changed. Surface separately the unanswerable newcomer questions and any contradiction between pages, since that usually means the team holds two mental models of the same thing. The home page register is the dashboard: every page with its status, review date and trigger.

The business card pages need their own three questions, since checking them against code is meaningless: how old is the confirmation, does the product still match its own pitch, and does the roadmap still serve the stated objective. That last one is where these pages earn their place - report it as a question to the team, never as a correction to apply.

Do not use a team for a single-change update. Reading one page and editing one entry is faster done directly.

## Reference

- `references/change-map.md` - which change updates which pages, plus the full writing rules and the edit checklist
- `references/handover.md` - shipping a spec: recognising it shipped, moving each line into the living pages, what blocks the shipped status
- `references/business-card.md` - the business card: the closed trigger list, what is not a trigger, changing the objective, adding the pages to docs that lack them
- `references/audit-team.md` - the audit team: per-page and cross-page prompts, verdicts, how to apply the findings
