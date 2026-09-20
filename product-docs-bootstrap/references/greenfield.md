# New project, nothing built yet

There is no code to inventory, so everything comes from the user. The risk is the mirror image of the existing-codebase case: instead of a doc full of copied implementation, you get a doc full of aspiration. Guard against it by writing down only what has actually been decided, and by leaving the rest visibly empty.

## What a day-one documentation is for

Two things, and only two.

It stops the same decisions being re-taken every week. A greenfield project changes its mind constantly, which is healthy, but a decision that is not written down gets silently reversed by whoever touches the code next - increasingly, an agent.

And it gives the coding agents a place to write what they learn. From the first feature onwards, they have somewhere to record a business rule instead of burying it in an `if`.

## The interview

Ask these in conversation, not as a form. Four or five questions per exchange at most. Stop when you have enough for the day-one pages; the rest fills in as the project moves.

**Start with the business card.** On a greenfield project it is not one pass among several - it is most of what there is to write, and it is the only thing that will still be true in six months when the code has been rewritten twice. Run the interview in `business-card.md` first, with two adjustments for a project that does not exist yet:

- Skip the Positioning explorer. There is no product copy to react to, so this one really is a blank page. It is slower; accept that rather than filling it in for them.
- Expect the strategy page to be thin and let it be. A project with no users has no retention problem, and the honest objective is usually activation or "we do not know yet, we are looking for the first ten users". Write that. An invented objective on day one will misdirect every prioritisation for a year.

The market research is worth doing properly even here, and it is the one part where an agent adds more than it does later: the founder has usually looked at two competitors and not at the category.

Then continue with what the business card does not cover.

**The product**
- In one sentence, what does it do and for whom? (If the pitch is already written, this is done - do not ask twice.)
- What is deliberately out of scope for the first version? This one matters more than the scope itself.
- What surfaces: web, mobile, API, something else?

**The vocabulary**
- What are the three to six central concepts? Write them down now: the glossary is cheap on day one and expensive to retrofit once three synonyms are in the code.

**The rules already decided**
- Is there anything the product will decide on the user's behalf that is already settled? Legal constraints, a non-negotiable behaviour, something the founder feels strongly about.
- Each of these is a business rule with a reason, even before a line of code exists.

**The structuring choices**
- Which technical or product choices are already made and would be costly to revisit? Stack, hosting, a payment provider, a decision not to build something.
- These are the first decision entries. They are the highest-value thing you can write on day one.

**The first projects**
- What are you building first, and which problem does each solve?
- These become roadmap rows and, for the one starting now, a spec page.
- For each, ask what you would announce the day it ships, in three lines a user would be happy to read. That future changelog goes in the spec, and it is the cheapest way to find out whether a project is worth starting.

**Measurement**
- How will you know the first version works? One metric is enough, with its exact definition.
- Check it against the objective you just wrote down. If the metric and the objective point in different directions, one of the two is wrong, and finding that out on day one is worth the whole interview.

## What to write on day one

Create `docs/product/index.html` from `assets/template.html` and keep only:

- **The five business card pages** - written first, with whatever is genuinely settled and the rest visibly empty
- **Overview** - the sentence, the surfaces, the scope, with "does not do" filled in
- **Glossary** - the central concepts
- **Business rules** - only the ones actually decided; an empty rules page with the format visible is fine and honest
- **Decisions** - the structuring choices, with their reasons while they are fresh
- **Roadmap** - the first projects in priority order
- **Specs** - one page for the project starting now, future changelog included
- **Metrics and tracking** - the one metric and its definition
- **Maintaining these docs** - kept as it ships

Delete the rest. Key mechanisms, Data model, Architecture, Integrations, Runbooks, Known limitations, Support: they have no content yet, and an empty page invites invention. They get created by `product-docs-update` the day the first real mechanism, entity or dependency appears - which is exactly what the CLAUDE.md block tells agents to do.

The business card pages are the one exception, and they are never deleted for being thin. There, an empty section says "not settled", which is the single most useful thing a day-one documentation can record - and the thing a founder is most likely to have quietly forgotten they never decided.

Set `data-status="ok"` and `data-verified` to today on what you write. Say plainly, in the Overview, that the project has not shipped yet.

## Then wire the maintenance immediately

On a greenfield project this matters more than the content you just wrote, because the content is thin and the code is about to move fast. Append `assets/claude-md-block.md` to `CLAUDE.md` before writing any feature code. From then on, every agent that adds a rule, a mechanism or a dependency has instructions to record it, and the documentation grows with the product instead of being reconstructed a year later.
