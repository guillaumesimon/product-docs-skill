---
name: product-docs-bootstrap
description: Create the living product documentation for a codebase - a single browsable HTML page at docs/product/index.html that explains what the product does, how its mechanisms work, the business rules and why they exist, the roadmap, one page per spec, and the business card - pitch, mission and vision, personas, business model, market and competitors, and the single objective the company is optimising for. Use this skill whenever a repository has no docs/product/index.html and the user asks for product documentation, a product knowledge base, product docs, a doc produit, an onboarding doc for the codebase, a place to keep specs and business rules, or says the project has no documentation and something should be written down. Also use it when starting a new project from scratch and setting up its documentation, and whenever another skill or CLAUDE.md instruction reports that the product documentation is missing. Do not use it to update documentation that already exists - use product-docs-update for that.
---

# Bootstrap product documentation

Create `docs/product/index.html`: one self-contained HTML page, versioned with the code, that a product manager or an agent can read to understand the product without reading the whole codebase.

The hard part is not the HTML. The template does that. The hard part is that a codebase contains the *what* and the *how* but almost never the *why*, and a docs page full of plausible invented reasons is worse than no docs at all. So the work runs in passes, with the user in the loop for anything the code cannot tell you.

Two things in that page cannot be read anywhere in the repository. The *why* behind the rules, and the **business card**: who this is for, how it makes money, what it is optimising for. Both come from the user, and both are what makes the rest readable.

## The one rule that shapes everything

**Explain, do not copy.** Anything that can be obtained with a database query or by opening a file does not belong in the docs: column lists, event lists, prices, quotas, flag states, metric values, endpoints, environment variables, exact constants. Explain the principle, the reason and the pitfalls, then cite the file where the detail lives.

The test for a page: after reading it, someone knows which file to open and understands what they read there. Copying makes the docs stale within a week and adds nothing a `grep` would not give.

## Pick the path

**Existing codebase** (the usual case): run the inventory pass, get it reviewed, then write. Go to "Path A".

**New project, nothing built yet**: there is nothing to inventory, so the content comes from an interview. Read `references/greenfield.md` and follow it.

If unsure which applies, look: is there source code beyond a scaffold? Then it is Path A.

## Path A: existing codebase

### Pass 1 - inventory, write nothing but the inventory

Explore the repository and produce `docs/product/INVENTORY.md`. Do not touch the template yet.

A single agent reading a whole repository loses precision as the context fills, and the last territory explored is always the thinnest. Fan out instead: one agent per domain, in parallel, each writing a fragment you merge. Read `references/agent-teams.md` for the prompts and the rules that keep the fragments usable. Where subagents are not available, do the same passes in sequence.

Cover, across the team:

1. The product in one sentence, its surfaces, its scope (does / does not do).
2. Domain concepts and their name in the code.
3. Capabilities as the user perceives them, one line each.
4. Three to eight non-obvious mechanisms - the ones that span several files: background jobs, webhooks, state machines, syncs, calculations, retries.
5. Candidate business rules: every place the code decides something on the user's behalf. For each: the file, and the test if one exists.
6. External dependencies and what happens to the user when each one is down.
7. Internal tooling: scripts, admin screens, scheduled tasks.
8. What the product says about itself: landing and marketing copy, pricing page, plan configuration, import features. Candidates for the business card, never conclusions.
9. Which template pages are not relevant to this project.

Separate what you **observed in the code** from what you **infer**. Then end the inventory with the questions only a human can answer, the "why" questions first. Read `references/page-catalog.md` for what each page needs and where to look for it in a repo.

Tell the user the inventory is ready and ask them to correct it. This review is where most of the value is: thirty minutes of their time here prevents a plausible but wrong documentation.

### Pass 1b - the business card

The five business card pages - pitch and mission and vision, personas, business model, market and competitors, objective and strategy - carry the context every other page is written against. A feature only means something against a promise, and a roadmap can only be argued against an objective.

None of it is in the repository, so it comes from an interview. Run it now, after the exploration and before writing: the Positioning explorer has just produced candidates, and people correct a wrong draft far better than they fill a blank form. Read `references/business-card.md` for the interview, the market research and the guard rails.

The rule here is the mirror image of the one that governs the rest of these docs. Everywhere else the danger is copying the code; here nothing is in the code and the danger is invention. Anything the user did not actually say stays marked `Unconfirmed` and its page stays `check`. An empty section is fine; a plausible one is not.

One thing to hold the line on: **a single objective**, from acquisition, activation, retention and revenue. The request to have two is constant, and two objectives is no objective - every project serves one of them and nothing can be refused.

### Pass 2 - write, in batches

Copy `assets/template.html` to `docs/product/index.html` and replace the example content (a fictional invoicing product called Bordereau). Keep the structure, the styles and the script; they generate the navigation, the search, the health register and the spec index from the page metadata.

Write in this order and stop after each batch so the user can react:

- **Batch 0**: the five business card pages, written from the interview
- **Batch 1**: Overview, Glossary, Features
- **Batch 2**: Key mechanisms, Business rules
- **Batch 3**: Data model, Architecture, Integrations
- **Batch 4**: everything else that applies

Batch 0 goes first because it changes how the rest is written - which capability reads as central, which limitation is worth apologising for. Batches 1 and 2 then carry most of the understanding. If the user wants something useful fast, do 0, 1 and 2 and stop.

Batches can be written in parallel, one agent each, but no agent writes into `index.html` - they produce fragments that you assemble, otherwise concurrent edits silently drop content. See `references/agent-teams.md`.

### Pass 2b - critique the draft before showing it

A draft written from an inventory always contains four defects the writer cannot see: content copied from the code, reasons that sound plausible but trace back to nothing, gaps that only show up when someone reads the page without the repository in front of them, and work in flight that does not serve the objective the user just stated. Run a critique pass on the assembled draft before the user sees it - a copy detector, a reason auditor, a newcomer test and a strategy-fit check, none of them allowed to edit. The prompts are in `references/agent-teams.md`. Without subagents, do the four checks yourself on the finished draft, which still catches most of it.

Fix the copied content and the invented reasons before showing the draft. Report the rest rather than fixing it: the questions a newcomer still cannot answer point at the thin pages, and often at a real gap in the team's understanding of its own product; and a project in flight that serves no stated objective is either a deliberate exception or a sign the stated objective is not the real one. Neither is yours to resolve.

While writing:

- Never invent a reason. If a "why" is not in the reviewed inventory, write `Why: to be confirmed` and set that page's `data-status="check"`.
- Set `data-title`, `data-desc`, `data-group`, `data-status`, `data-verified` (today), `data-trigger` and `data-sources` on every page.
- Delete the pages that do not apply, and their example content. An empty page is worse than a missing one.
- Point the Overview's business card row at the new pages rather than restating the mission there, and give every live spec its "Serves the objective" line. A spec already in flight that cannot answer it is a finding worth reporting, not a documentation gap.
- Roadmap, Specs and Decisions cannot be derived from code. Leave the structure, fill what the user told you, and say plainly what is left for them.
- Delete `INVENTORY.md` at the end.

### Pass 3 - wire the maintenance

Docs that nothing maintains go stale in a fortnight. Do all three, and tell the user what you did:

1. Append the block in `assets/claude-md-block.md` to `CLAUDE.md` (or `AGENTS.md`) at the repo root, adapting the path. Create the file if it does not exist.
2. Add one line to the pull request template: `Does this change how the product is understood? If so, docs updated.`
3. Mention that a weekly review can be scheduled, and that `product-docs-update` handles both the per-change updates and that review.

## How to write a page

Get the register straight: the docs describe the **present**. History lives in Changelog and Decisions, the future in Roadmap and Specs. One piece of information lives in exactly one page; everywhere else, a link.

**A mechanism** is one screen: in short / how it unfolds / special cases / why it is built this way / where to enter the code. If it runs past a screen, you are copying the implementation.

**A business rule** has a stable identifier (BR-001), the intent in one verifiable sentence, the why, the file, the test. Never reuse an identifier; a retired rule stays, marked as retired.

**A spec** is one page per project, `<section class="page" data-parent="specs">`, with `data-spec-id`, `data-spec-status`, `data-target`, `data-updated`. The index on the Specs page and the rows on the Roadmap read from it, so a project's name and status are written once. Each one also carries a line saying how it serves the single objective, or why it is the exception - that line is what makes the roadmap arguable.

**A spec's handover** is the list of pages the project will have to feed when it ships, in a `<ul class="handover">`: one `<li data-page="features">` per target, saying what moves there, ticked with `data-done="<date>"` the day the content actually lands. Written with the spec, not on release day. An open line on a shipped spec shows up as debt on the home page, which is how these docs stop drifting the moment a feature goes live.

**A spec's future changelog** is the announcement users will read on release day, written before the build, in a `<div class="release">`: a title and two or three lines, emoji, benefits rather than features - never internal vocabulary. It doubles as the benefit test: if it cannot be written, the value of the project is not settled. On shipping it becomes the Changelog entry.

**A business card page** is the one place where the golden rule inverts. Nothing on those five pages is in the code, so the danger is not copying, it is invention: anything the user did not actually say carries `<span class="tag t-check">Unconfirmed</span>` and keeps its page at `check`, and `data-sources` names a person and a date rather than a file. An empty section is fine and is itself information - it says this is not settled. Never delete one of these pages for being thin.

**The roadmap** is one table in priority order. Each row points at its spec page with `data-spec` and sets `data-horizon`; rank, project name and spec status are filled in automatically.

Watch for the three failure modes. The first is copying, because the code is what you are looking at: if a page grows long lists, you have drifted. The second is promoting implementation details to business rules - format validations, technical defaults. A business rule is something a user or support could argue about. The third only happens on the business card, and it is the reverse: filling a gap with something plausible because the page looked empty.

## Language

Write the documentation in English by default, whatever language the conversation is in. It is read by agents and by people who may not share the team's language. If the user asks for another language, follow them and say so in the maintenance block so later updates stay consistent.

## Files in this skill

- `assets/template.html` - the page to copy, filled with a worked example that shows the expected depth and tone
- `assets/claude-md-block.md` - the block to append to CLAUDE.md
- `references/page-catalog.md` - each page: purpose, what belongs, what does not, where to find it in a repo
- `references/agent-teams.md` - the exploration, writing and critique teams: prompts, rules, what to do with what comes back
- `references/business-card.md` - the business card interview, the market research and the guard rails for pages the code cannot verify
- `references/greenfield.md` - the interview for a project that does not exist yet
