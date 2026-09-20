# Keeping the business card true

The five business card pages - pitch and mission and vision, personas, business model, market and competitors, objective and strategy - behave differently from every other page in this documentation, in three ways that decide how they are maintained.

**Their trigger is the conversation, not the diff.** A pivot does not show up in a diff. It shows up in someone saying "actually our real users are the agencies" in the middle of a task about something else. Watching the code for business card changes catches almost nothing; watching what gets decided catches almost everything.

**They cannot be verified.** Every other page can be checked against the code it cites. These cannot be checked against anything except the person who said it. So the audit never marks a business card page false - it marks it *old*, which is a different and more honest verdict.

**They are never edited without an explicit yes.** Everywhere else, an agent that improves a page is being helpful. Here, an agent that quietly rewrites a mission has changed something the team owns, and nobody will notice until it is quoted back at them.

## The trigger list, and it is closed

Propose a business card update **only** when one of these happens. The list is deliberately short. An agent that raises the business card at every commit produces a prompt everyone learns to dismiss, which is worse than not raising it at all - the same reason this skill's first question exists.

| What happened | Page |
|---|---|
| A new way of charging appears, or something free becomes paid, or paid becomes free | Business model |
| A group of users is served on purpose for the first time, or one is dropped | Personas |
| The metric the team says it is optimising for changes | Objective and strategy |
| A strategic bet is settled - proved right, proved wrong, or abandoned | Objective and strategy |
| A decision is recorded that names a competitor, an audience or a positioning | Market, Personas or Pitch, plus the Decision itself |
| The product's promise changes - a new surface, a new category, a scope change large enough to alter the pitch | Pitch, mission and vision |
| A competitor materially moves, or a new one starts costing deals | Market and competitors |

Two of these are worth recognising in their disguised form, because they rarely announce themselves:

- **A paywall moving** is a business model change even when the diff is one line in a config. What changed is not the flag, it is what the company charges for.
- **The first feature built for a group that "not our user" excludes** is a persona change. Somebody decided something; the page should say so before the product drifts there by accident.

## What is not a trigger

Say this plainly to yourself before raising anything:

- A new feature. Features serve the strategy, they do not change it.
- A price, a quota or a plan limit moving. That is the billing config and `Plans and permissions`.
- A metric's value moving, in either direction. The objective changes when the *choice* changes, not when the number does.
- A competitor shipping something. Only a competitor changing position matters here.
- A conversation about strategy that did not conclude. A discussion is not a decision.
- A user asking for a feature that a persona does not cover. One request is not a segment.

## When a trigger fires

1. **Say what you noticed and what it would change**, in two sentences, naming the page. "We just put the export behind Pro. That changes what Business model says we charge for - want me to update it in this commit?"
2. **Wait for an explicit yes.** Silence is not a yes, and "sure, whatever you think" is worth one clarifying question on these pages.
3. **Edit narrowly.** One paragraph, not a rewrite. The business card is quoted; wholesale rewrites destroy the shared phrasing people have memorised.
4. **Set `data-verified` to today** and update the confirmation in `data-sources` - it names a person and a date, so both move.
5. If the change is structuring - the objective, the audience, the model - **record a Decision too**, with what was ruled out. The business card says what is true now; the Decision says why it changed, and it is the Decision that stops the same debate reopening.

If the answer is no, or the user does not engage, leave the page alone and do not raise it again for the same change. Once is a service, twice is nagging.

## Changing the objective

The single objective on `Objective and strategy` is the one field in this documentation that has to stay singular, and the pressure to let it become two is constant.

- Replacing it is a Decision. Write the new objective, move the old one into the "why not the other three" table with what would promote it again, and record the Decision with the evidence that triggered the change.
- Adding a second is not an option. If the user genuinely wants two, say what it costs - nothing can be refused against two objectives - and if they confirm, write both and set the page to `check` with one sentence saying the choice is unresolved. Do not present two objectives as a settled state.
- Update `data-objective` on the section. It is what an agent reads to check a spec against.
- Then re-read the roadmap: a change of objective usually means some rows no longer serve it, and that is the moment to say so rather than at the next audit.

## The other pages, page by page

**Pitch, mission and vision.** Almost never changes, and that is the point. When it does, it is a pivot and deserves a Decision. Watch for the slow version: the pitch quietly drifting to describe whatever got built last. If the pitch no longer predicts the roadmap, one of the two is wrong - say which you think it is, and let the user decide.

**Personas.** Changes when the answer to "who do we build for" changes, which includes the "not our user" table. That table is what stops the product drifting into everyone's product, so a new exclusion is as worth recording as a new persona.

**Business model.** The logic only. Prices, quotas and tiers stay in the billing config; the split logic stays on `Plans and permissions`. If this page starts growing numbers, it has drifted into being a pricing page.

**Market and competitors.** Ages faster than any other page in the documentation, on a clock the code knows nothing about. Every row carries the month it was checked and its source. When you touch it, re-check the rows you are near rather than only the one that changed, and never write a competitor claim you have not sourced. If the page has not been looked at in six months, say so even if nothing prompted it.

## Adding a business card to docs that do not have one

Documentation written before these pages existed will not have them, and `product-docs-bootstrap` will refuse to run on a repository that already has `docs/product/index.html`. So this is an update job.

Create the group rather than a single page: add `data-group="Business card"` sections for the five pages, placed after the Understand group and before Product, and add the group's description to the `GROUPS` map in the page's script - the navigation builds itself from there. On those five pages `data-sources` names a person and a date rather than a file, and `Objective and strategy` also carries `data-objective`. The interview is below; if `product-docs-bootstrap` is also installed, its `references/business-card.md` has the long form.

Then two links: point the Overview's business card row at the new pages instead of at an external tool, and add the "Serves the objective" line to every live spec. Expect at least one spec that cannot answer it. That is a finding worth reporting.

### The interview, short form

Conversation, not a form. Four or five questions per exchange, one page at a time, and write each page as its answers come rather than holding everything to the end. Do not start from a blank page: read the landing copy, the README's opening, the pricing page and the plan configuration first, and open with "here is what your product currently says about itself". People correct a wrong draft far better than they fill an empty one. Two things the code knows better than the team: **where the paywall actually sits**, which is often not what the pricing page claims, and **what the product can import from**, since you import from the tool you are replacing.

*Pitch, mission and vision.* What does it do and for whom, in one sentence? Fill the frame out loud: for … who … this is … unlike … because …; the last line is the one people skip and the only hard one. Why does the company exist - present tense, true this morning? If it works, what does the world look like in five years? A mission and a vision that say the same thing means one of the two is wrong.

*Personas.* Who do you build for - two or three, and can you name a real person for each? What is the day that brings them, the specific event? What do they use today instead, which is the real competitor and is usually a spreadsheet? What would lose them? And, asked explicitly because nobody volunteers it: **who asks for the product that you deliberately do not serve, and why?** That last answer is the most useful half of the page.

*Business model.* Who pays, for what, when? Why that shape rather than per use, per seat, a cut, ads? What makes an account stick beyond paying? What could you charge for and deliberately do not?

*Market and competitors.* What category is this, in the buyer's words? Who do you actually lose to - not who you admire? What is changing that you do not control? Then search the web: the category, three to five products a user would realistically compare, what each is best at. Per competitor bring back only what they are best at, where we win, where they win, with the month checked and the source - never a feature matrix, which is stale the month it is written and pulls the roadmap towards parity. Include the non-consumption option, which never appears in a search result and is usually the real incumbent. Then hand the list back and ask what is missing.

*Objective and strategy.* Acquisition, activation, retention or revenue - which one, right now? If two are named, ask which failure would hurt most over the next two quarters, and write the other into the "why not the other three" table with what would promote it. Then two to four bets, and for each: **what would prove it wrong?** A bet nobody can lose is a slogan. When do you revisit?

Anything the user did not actually say stays marked `<span class="tag t-check">Unconfirmed</span>`, and its page stays `check`. An empty section is fine and is itself information; a plausible one is not, and it will be quoted back in meetings for a year.

## In the audit

Business card pages get their own treatment, because the per-page prompt - *is what this page claims still true of the code it points at* - has nothing to work with.

Ask three things instead:

1. **Is it old?** How long since the confirmation date in `data-sources`? Over six months on the market page, or over a year on any of them, is worth flagging on its own.
2. **Does the product still match the pitch?** Read `Features` and the pitch together. A product whose capabilities no longer fit its own positioning is the single most valuable thing an audit of these pages can find.
3. **Does the roadmap serve the objective?** One agent, reading `Objective and strategy` and every live spec's "Serves the objective" line. It reports projects that do not serve the objective and specs where the line is missing or hand-waved.

That third check is where the business card earns its place. Report it as a question to the team, never as a correction to apply: a project that does not serve the stated objective may be the exception that was argued and won, or it may be the first sign the stated objective is not the real one. Both are worth knowing and neither is an agent's call.
