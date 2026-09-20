# The business card

Five pages - pitch and mission and vision, personas, business model, market and competitors, objective and strategy - that carry the context the rest of the documentation is written against. They are set up once, at bootstrap, before anything else is written.

## Why this comes first

A feature only means something against a promise. Written after the product pages, the business card becomes a summary of what got built, which is the wrong direction: the point is that it should have been able to predict what got built. Written first, it changes the wording of every page that follows - which capability is described as central, which limitation is worth apologising for, which spec gets ranked.

It also gives the docs a way to say no. A roadmap can only be argued against an objective.

## The rule here is the opposite of the rule everywhere else

Everywhere else in this documentation the danger is copying: the code is right there and it is tempting to transcribe it. Here **nothing is in the code**, and the danger flips. What you get instead is aspiration - a mission assembled from landing-page adjectives, three personas that describe nobody, a competitor table built from whoever ranks highest on Google.

So the discipline is:

**Only what the user actually said gets written unmarked.** Anything you inferred - from the landing copy, the pricing config, a web search - carries `<span class="tag t-check">Unconfirmed</span>` next to it and keeps its page at `data-status="check"` until a human confirms it.

**An empty section is fine. A plausible one is not.** A mission invented by an agent will be quoted in meetings for a year and nobody will remember where it came from. If the team has not settled its vision, write that the vision is not settled.

**`data-sources` on these pages names a person and a date**, not a file: `Confirmed with <who> on <date>`. That is genuinely where the detail lives, and it tells the next reader how old the agreement is.

## Step 1 - get a first draft out of the repository

Do not start from a blank page. People correct far better than they produce, and a wrong first draft gets corrected faster than an empty form gets filled.

The exploration team (see `agent-teams.md`) includes a **Positioning** explorer for this. It reads the landing and marketing copy, the README, the pricing page, the plan configuration, the interface strings and any `about`, `press` or `manifesto` content, and returns candidates - never conclusions:

| Candidate | Usually found in |
|---|---|
| A pitch | The landing hero, the README's first paragraph, the app store description |
| Audience clues | Who the copy addresses, the examples in the empty states, the language and currency defaults |
| The model | The pricing page, the plan configuration, where the paywall actually sits in the code |
| Competitors | Comparison pages, migration or import features (you import from the tool you are replacing) |
| An implicit objective | Which funnel is instrumented most heavily, what the onboarding optimises for |

Two of these deserve attention because the code is a better witness than the team: **where the paywall actually sits** often differs from what the team says it charges for, and **the import features** name the competitors that really cost deals.

Present these as "here is what your product says about itself" and let the user react. That reaction is the interview's first question.

## Step 2 - the interview

Conversation, not a form. Four or five questions per exchange, one page at a time, and stop when the answers get vague rather than pushing for completeness - a vague answer written down becomes a fact within a week.

Say at the start what you are doing and why: five short pages, half an hour, and they will change how everything else in the documentation is written. People answer differently when they know the answer will be quoted back at them.

### Pitch, mission, vision

- In one sentence, what does the product do and for whom? If two sentences come out, ask which one they would drop.
- Fill the positioning frame out loud: *For* … *who* … *this is* … *unlike* … *because* …. The last line is the one people skip and the only one that is hard.
- Why does the company exist? That is the mission - present tense, true this morning.
- If this works, what does the world look like in five years? That is the vision, and it is allowed to be unreasonable.

**What a bad answer looks like:** a mission and a vision that say the same thing, or a mission made of adjectives ("simple, modern, powerful"). Push once: *what would be worse for your users if you did not exist?*

### Personas

- Who are the two or three people you build for? Can you name a real one for each?
- What is the day that brings them to you - the specific event, not the general need?
- What do they use today instead? This is the real competitor and it is usually a spreadsheet or nothing.
- What would make them leave?
- **Who asks for the product that you deliberately do not serve, and why?**

That last question produces the most useful half of the page. Ask it explicitly; nobody volunteers it.

**What a bad answer looks like:** demographics. "35-45, urban, tech-savvy" settles no argument. A persona is useful when it decides a design choice.

### Business model

- Who pays, for what, and when?
- Why that shape rather than the obvious alternative - per use, per seat, a cut, ads?
- What makes an account grow or stick, beyond paying?
- What could you charge for and deliberately do not? Why?

Do not let prices or quotas into this page. They are in the billing config and on `Plans and permissions`. This page explains why money changes hands where it does.

### Market and competitors

- What category is this in, from the buyer's point of view? How would they describe what they were looking for?
- Who do you actually lose to? Not who you admire - who you lose to.
- What is changing in this market that you are not in control of?

Then run the research below and bring it back to them.

### Objective and strategy

- Of acquisition, activation, retention and revenue - which one, right now?
- If two are named, ask: *which failure would hurt most over the next two quarters?* Then write the other under "why not the other three", with what would promote it. That table is often the most useful thing on the page.
- How do you think you get there? Two to four bets.
- For each bet: **what would prove it wrong?** A bet nobody can lose is a slogan, and it will be used to justify anything.
- When do you revisit this?

**Hold the line on one objective.** It is the whole point of the page, and the request to have two is constant. Two objectives is no objective: every project serves one of them and nothing can be refused.

## Step 3 - the market research

Search the web. This is the one part of the documentation with a genuine external source, and it needs its own guard rails.

**What to look for**: the category as buyers name it, the three to five products a user would realistically compare, what each is best at, and what is changing in the category - regulation, a platform shift, a large entrant.

**What to bring back**, per competitor: what they are best at, where we win, where they win. Nothing else. Not funding, not headcount, not a feature matrix - a feature matrix is out of date the month it is written and it pulls the roadmap towards parity, which is the one thing the objective exists to prevent.

**Rules:**

- Every row carries the month it was checked and where the claim came from. A row with no source is a rumour.
- Never state a price, a funding round or a customer count as fact from a single page. If it matters, mark it `Unconfirmed`.
- A search returns the loudest, not the closest. **Bring the list back to the user and ask what is missing** - the competitor that actually costs deals is often one that does no marketing.
- Include the non-consumption option. For most products the real incumbent is a spreadsheet, a manual process, or nothing at all, and it never appears in a search result.
- `data-verified` on this page means less than elsewhere. Say in the maintenance note that it wants a look every six months, whatever the code does.

## Step 4 - write, then link

Write the five pages as batch 0, before Overview, using `assets/template.html` as the model. Then two links, both cheap and both load-bearing:

1. **Overview** points at the business card instead of repeating it. The template's Overview already carries the row; fill it in rather than restating the mission there.
2. **Each spec** gets its "Serves the objective" line. On an existing codebase you are writing specs for work already in flight - write the line for each, and when one of them cannot be answered, say so to the user. A project already underway that serves no stated objective is a finding, not a documentation gap.

## What to leave empty

| Situation | What to write |
|---|---|
| No vision settled | Say the vision is not settled, and that the mission is what holds for now. Do not extrapolate one from the other. |
| A solo project, no market research done | Keep the category paragraph and the non-consumption row, drop the competitor table, set the page to `check`. |
| Pre-revenue, model undecided | Write what is decided - free, who it is for - and name the open question. An undecided model is a fact worth recording. |
| The team genuinely has two objectives | Write both, say plainly that this is unresolved, set the page to `check`, and do not pretend one was chosen. A documented disagreement is more useful than a fabricated consensus. |

Never delete a business card page because it is thin. Unlike the optional technical pages, an empty section here is information: it says this is not settled, which is exactly what someone reading the docs in three months needs to know.
