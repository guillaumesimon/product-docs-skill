Append the block below to `CLAUDE.md` (or `AGENTS.md`) at the repo root. Adapt the path if the documentation lives elsewhere. Keep the skill names exactly as written - they are what makes the skills trigger.

---

## Product documentation

The product documentation lives in `docs/product/index.html`. It explains what the product does, how its mechanisms work, the business rules and why they exist. Details are then explored in the code.

**Read it before changing an area you do not know.** Open the page, find the relevant section, follow its "where to enter the code" pointers. It is faster than reading the code cold and it tells you which choices are deliberate.

**Keep it true.** Before closing a task, ask one question: would someone who read the docs yesterday misunderstand the product today because of my change?

- No - do not touch the docs. Most commits do not.
- Yes - use the `product-docs-update` skill. It has the map of which change updates which pages, and the writing rules.

**The business card is different.** Five pages - pitch and mission and vision, personas, business model, market and competitors, objective and strategy - hold what the product is for and what it is optimising for. Nothing on them is in the code, so an agent can never verify them and must never quietly rewrite them.

Ask the second question **only when something was actually decided**, never on an ordinary commit: did this work settle who the product is for, how it makes money, what it is optimising for, or where it stands against a competitor? If so, say what you noticed and which page it changes, and wait for an explicit yes before editing. The closed trigger list is in the `product-docs-update` skill.

**One objective, always.** The strategy page carries a single objective - acquisition, activation, retention or revenue - and every spec says how it serves it, in a line and in one word on its own `data-objective`. The Roadmap reads that attribute into a column and filters on it. If a project cannot answer, say so rather than inventing a link.

**If `docs/product/index.html` does not exist**, use the `product-docs-bootstrap` skill to create it before going further, or tell me so I can decide.

**Golden rule: explain, do not copy.** Never write in the docs what can be read in the database, the configuration or the code - columns, event lists, prices, quotas, flag states, metric values, endpoints, environment variables. Explain the principle, then cite the file.

The documentation is part of the definition of done, in the same commit as the code.
