# Agent teams

Three steps of this skill are better done by a team than by one agent working alone: exploring the repository, writing the batches, and critiquing the result. What follows is when to fan out, what to send each agent, and what to do with what comes back.

One step is deliberately **not** a team job: the business card interview. It is a conversation with the user, and it does not parallelise. The only part of it an agent touches is the Positioning explorer below, which produces candidates to react to.

If the environment has no subagents, everything below still works in sequence - do the same passes yourself, one after another. It is slower but the structure is what matters, not the parallelism. The critique pass in particular is worth doing even alone, with fresh eyes on a finished draft.

## Rules that apply to every agent you spawn

**No agent writes into `docs/product/index.html`.** Several agents editing one file is how content gets silently dropped. Agents write fragments into a scratch directory; you are the only one who assembles them.

**Every agent returns observed and inferred separately.** An explorer that hands back a confident paragraph mixing both is worse than one that hands back half as much, clearly labelled. Say this explicitly in each prompt.

**No agent invents a reason.** The "why" is almost never in a repository. An agent that finds a rule but not its reason must say so, not produce a plausible one. Make this a line in every prompt - it is the single most common failure.

**Give each agent the golden rule**, because it is the one thing that makes this documentation different from generated docs: explain, do not copy; anything obtainable with a query or by opening a file stays out, replaced by a pointer to that file.

## Step 1 - exploration team

Spawn one agent per domain, in the same turn. Seven is a good default; drop the ones that do not apply to the project.

| Agent | Territory |
|---|---|
| Surfaces | Routes, screens, user-facing capabilities, journeys, e2e tests |
| Domain | Business rules, guards, validators, state machines, domain services and their tests |
| Mechanisms | Background jobs, queues, crons, webhooks, retries, idempotency, calculations, syncs |
| Data | Migrations, models, invariants, isolation, soft deletes, money and date handling |
| Dependencies | External services, what each is for, outage behaviour, public API, AI components |
| Operations | Scripts, admin screens, CI, environments, alerting, TODO and FIXME clusters |
| Positioning | Landing and marketing copy, README, pricing page, plan configuration, interface strings, import and migration features |

Prompt for each, adapted to its territory:

```
Explore this repository within your territory: <territory>.
Do not write any documentation and do not modify any file except your own output.

Return markdown with these sections:
- Observed: what you verified by reading code. Cite file paths.
- Inferred: what you believe but did not verify. Say what would confirm it.
- Open questions: what only a human can answer, why-questions first.

Rules:
- Explain, do not copy. No column lists, no event lists, no prices, no quotas,
  no endpoints, no environment variable names, no exact constants. Give the
  principle and the file where the detail lives.
- Never invent a reason. If you find a rule but not why it exists, list it under
  Open questions.
- For anything non-obvious, name the file someone should open to understand it.

Write your output to <scratch>/inventory-<territory>.md and return a summary
of at most ten lines.
```

The Positioning explorer gets a different prompt, because it is not looking for how the product works but for what it says about itself. It produces candidates for the business card interview, and it is the one explorer whose output must never be written into the docs unreviewed:

```
Explore this repository for what the product says about itself: landing and
marketing copy, the README's opening, the pricing page, the plan configuration,
interface strings and empty states, and any import or migration feature.

Return CANDIDATES ONLY, never conclusions. For each one, quote or cite where it
came from so a human can agree or disagree in one glance:
- A candidate pitch, in the product's own words.
- Who the copy addresses: the examples, the empty states, the defaults.
- How it charges, and WHERE THE PAYWALL ACTUALLY SITS in the code - which is
  often not what the pricing page says it is. Flag any difference; it is the
  single most useful thing you can find.
- Competitors named anywhere: comparison pages, and especially what the product
  can import from, since you import from the tool you are replacing.
- What the instrumentation and the onboarding appear to optimise for.

Do not write a mission, a vision, a persona or a strategy. None of those is in a
repository and a plausible one is worse than none. Do not list prices or quotas.

Write your output to <scratch>/inventory-positioning.md and return a summary of
at most ten lines.
```

Then merge the fragments yourself into `docs/product/INVENTORY.md`: deduplicate across territories, resolve contradictions by reading the code yourself rather than picking a side, and consolidate the open questions into one ordered list with the why-questions first. Contradictions between two explorers are a signal - usually the same concept under two names, which the glossary then has to fix.

## Step 2 - writing team

Only after the user has reviewed the inventory. Spawn one agent per batch, in the same turn, each producing HTML fragments in the scratch directory.

**Batch 0, the business card, is not given to an agent.** You write it yourself from the interview answers, because the only source is a conversation you just had and an agent that has not had it will fill the gaps. Write it before spawning the others, and give every writing agent the pitch and the objective as context - it changes which capability reads as central.

```
Write the following pages of a product documentation: <pages>.

Sources, in this order of authority:
- <scratch>/INVENTORY.md, reviewed and corrected by the user - this is the truth
- the repository, for detail and file paths
Never contradict the reviewed inventory. If the code disagrees with it, say so
in your summary instead of choosing.

Model your output on <template path>, which contains a worked example
(a fictional invoicing product). Match its structure, depth and tone. Write in English.

For each page produce one <section class="page"> with data-title, data-desc,
data-group, data-status, data-verified (today), data-trigger and data-sources.

Rules:
- Explain, do not copy. If your page grows lists of columns, events, prices or
  endpoints, you have drifted.
- A mechanism is one screen: in short / how it unfolds / special cases / why this
  way / where to enter the code.
- A business rule is: identifier, intent in one verifiable sentence, why, file,
  test. Do not promote format validation or technical defaults to business rules.
- A spec, if you write one, carries its future changelog: the announcement users
  will read when it ships, a title and two or three lines, emoji, benefits not
  features. Write it from the problem, never from the implementation.
- A spec also carries one line saying how it serves the single objective stated
  on the business card, or why it is the exception, and the same answer in one
  word on data-objective: acquisition, activation, retention, revenue, or none
  for a project that deliberately serves none. If you cannot write that line from
  the inventory, say so rather than inventing a link or guessing the attribute.
- Every explanation ends with a file, a test or a dashboard.
- If a "why" is not in the inventory, write "Why: to be confirmed" and set that
  page's data-status to "check". Never invent one.

Write to <scratch>/pages-<batch>.html and return a summary of at most ten lines,
listing anything you could not source.
```

Assemble the fragments into `index.html` yourself, in the template's page order.

## Step 3 - critique team

Run this on the assembled draft before showing it to the user, and again after their corrections if the changes were substantial. Four agents, same turn, none of them allowed to edit.

**Copy detector**

```
Read <docs path>. For every page, find content that is copied rather than
explained: lists of columns, events, prices, quotas, flag states, metric values,
endpoints, environment variables, or exact constants that duplicate what a file
already says.

For each finding: the page, the passage, and the one-line explanation that should
replace it. Do not edit the file.
```

**Reason auditor**

```
Read <docs path> and <scratch>/INVENTORY.md.

List every claim about WHY something works the way it does - every reason,
rationale or justification - and check whether it traces back to the inventory or
to a user answer. Flag any that does not: those are invented and must become
"Why: to be confirmed".

Also flag reasons that merely restate the behaviour ("because that is how invoices
work") - they look like reasons but carry no information. Do not edit the file.
```

**Newcomer test** - the one that catches what the other two cannot, because it measures whether the documentation is actually useful rather than merely correct:

```
Read ONLY <docs path>. Do not open the repository.

Then answer these questions and, for each, say which file you would open to see
the detail:
1. What does this product do, and what does it deliberately not do?
2. <a question about the most important mechanism>
3. <a question about a business rule a support agent would face>
4. <a question about what happens when a dependency is down>
5. Where would I add a new business rule, and what would I have to write?

Then list what you could not answer, and anything you found confusing, ambiguous
or apparently contradictory. Do not edit the file.
```

**Strategy fit** - only once the business card exists:

```
Read <docs path>. Do not open the repository. Do not edit anything.

Read the "Objective and strategy" page and note its single objective. Then read
every live spec page and the Roadmap.

Report:
1. Specs whose "Serves the objective" line is missing.
2. Specs whose line is hand-waved - it restates the expected outcome, or claims a
   link to the objective that the spec's own content does not support.
3. Roadmap rows, in priority order, that do not serve the objective.
4. Anything on Features or Personas that contradicts the pitch.

This is a report, not a correction. A project that does not serve the stated
objective may be a deliberate exception, or it may be a sign that the stated
objective is not the real one. Say which you think it is and why; do not resolve it.
```

Apply the findings yourself. Copy findings and invented reasons get fixed before the user sees the draft. Unanswerable newcomer questions are the more interesting output: they tell you which page is thin, and they are worth reporting to the user even when you have filled the gap, because the gap is often a real one in the product's own understanding of itself.

## What to report

Tell the user what the teams found, not that you used teams. Four things are worth surfacing: contradictions between explorers that revealed a naming problem, reasons that could not be sourced and are now marked to be confirmed, questions a newcomer still cannot answer from the docs, and any project in flight that does not serve the objective the user just stated. That last one is uncomfortable to raise and it is usually the most valuable output of the whole pass.
