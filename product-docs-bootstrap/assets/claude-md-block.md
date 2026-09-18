Append the block below to `CLAUDE.md` (or `AGENTS.md`) at the repo root. Adapt the path if the documentation lives elsewhere. Keep the skill names exactly as written - they are what makes the skills trigger.

---

## Product documentation

The product documentation lives in `docs/product/index.html`. It explains what the product does, how its mechanisms work, the business rules and why they exist. Details are then explored in the code.

**Read it before changing an area you do not know.** Open the page, find the relevant section, follow its "where to enter the code" pointers. It is faster than reading the code cold and it tells you which choices are deliberate.

**Keep it true.** Before closing a task, ask one question: would someone who read the docs yesterday misunderstand the product today because of my change?

- No - do not touch the docs. Most commits do not.
- Yes - use the `product-docs-update` skill. It has the map of which change updates which pages, and the writing rules.

**If `docs/product/index.html` does not exist**, use the `product-docs-bootstrap` skill to create it before going further, or tell me so I can decide.

**Golden rule: explain, do not copy.** Never write in the docs what can be read in the database, the configuration or the code - columns, event lists, prices, quotas, flag states, metric values, endpoints, environment variables. Explain the principle, then cite the file.

The documentation is part of the definition of done, in the same commit as the code.
