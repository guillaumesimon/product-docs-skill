# Change map and writing rules

## Which change updates which pages

Find the row that matches what you just changed. If several match, all of them apply. If none match, the docs stay untouched.

| If the change | Update |
|---|---|
| Starts a project, reshapes its scope or changes its priority | Its spec page (copy an existing one), and its row on the Roadmap in the right position |
| Adds or removes a capability for the user | Features, User journeys if affected, the spec's status, Roadmap, Changelog |
| Changes what the product decides on the user's behalf | Business rules, Glossary if there is a new term |
| Changes how a mechanism unfolds, or adds a non-obvious one | Key mechanisms |
| Changes the logic behind plans or roles | Plans and permissions |
| Introduces a concept, a relationship or an invariant | Data model, Glossary |
| Adds a component or a background job | Architecture |
| Adds an external dependency, or changes what happens during an outage | Integrations and API, Architecture, Security if personal data is involved |
| Adds an AI component or changes its guardrails | AI components |
| Redefines a metric or the tracking convention | Metrics and tracking |
| Starts or concludes an experiment | Experiments and flags |
| Adds a script, a command or an admin screen | Internal tooling |
| Changes an environment or the deploy process | Environments and runbooks |
| Resolves an incident | Environments and runbooks (a runbook), Known limitations |
| Discovers or lifts a limitation, or takes a deliberate shortcut | Known limitations and debt |
| Collects a new kind of personal data, or changes retention | Security and personal data |
| Settles a structuring choice, product or technical | Decisions |
| Surfaces a recurring user misunderstanding | Support and feedback |
| Is visible to the user | Changelog |
| Only changes values, columns, events, prices, quotas, flag states, styling or implementation | Nothing |

If the page a change points at does not exist yet - the first background job in a project that had none, the first external dependency - create it. Copy the structure of a neighbouring page and fill in `data-title`, `data-desc`, `data-group`, `data-status`, `data-verified`, `data-trigger` and `data-sources`. It appears in the navigation and the health register by itself.

## Page metadata

| Attribute | Meaning |
|---|---|
| `data-title` | Title shown in navigation, header and search |
| `data-desc` | The page in one sentence, shown under the title and in search |
| `data-group` | Navigation group. Omit it and set `data-parent` for a child page such as a spec |
| `data-status` | `ok`, `check` or `stale` |
| `data-verified` | ISO date of the last review against the code |
| `data-trigger` | The kind of change that forces an update of this page |
| `data-sources` | Where the detail lives - files, folders, tools, comma separated |

A page's `data-trigger` is its contract. If your change matches it, the page is in scope. If you find yourself editing a page whose trigger has nothing to do with your change, you are probably putting the information in the wrong place.

Spec pages additionally carry `data-spec-id`, `data-spec-status`, `data-target` and `data-updated`.

## Writing rules in full

**Explain, do not copy.** The line between the two:

| In the docs | In the code, the database or the tool |
|---|---|
| The intent of a rule and its reason | Exact constants, thresholds and formats |
| Concepts and how they relate | Tables, columns and types |
| How a mechanism unfolds, its special cases | The step-by-step implementation |
| A metric's definition and why it matters | Its value, the list of events and properties |
| The logic behind the plans | Prices and quotas |
| Hypotheses tested and what was learned | The live state of flags |
| Why we depend on a service, what happens if it goes down | Endpoints, keys and environment variables |

**Shape of a mechanism** - one screen, no more: in short / how it unfolds / special cases / why this way / where to enter the code. Past one screen you are transcribing the implementation, which the code already does better.

**Shape of a business rule** - identifier, intent in one verifiable sentence, why, code file, test, since when. The rule states the behaviour; the exact numbers live in the cited file. Beware of promoting implementation to a rule: format validation and technical defaults are not business rules. The test is whether a user or support could argue about it.

**Shape of a decision** - identifier, title written as a statement, date, context, options ruled out, consequences. Never edit a decision; supersede it with a new one and mark the old one superseded. This is what stops an agent silently undoing a deliberate choice.

**Shape of a runbook** - symptom, what to check in order, what to do, last occurrence. Write it right after the incident, while the detail is fresh.

**Changelog entries** are written from the user's point of view, grouped as added, changed, fixed, removed, with a link to the rule or spec involved.

## Checklist before closing

- The change actually alters how the product is understood - otherwise nothing was edited
- Every page the change map points at was edited, and no others
- Nothing copied that a query or a file would give
- Every new explanation ends with a file, a test or a dashboard
- No invented reason; anything uncertain is `Why: to be confirmed`
- New concepts added to the Glossary
- `data-verified` = today and `data-status` = `ok` on every edited page, or `check` with the gap described
- A shipped spec had its content moved to the living pages, its status set to shipped, its roadmap row removed and a Changelog entry added
- The edit is in the same commit as the code
