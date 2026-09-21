# Page catalog

For each page of the template: what it is for, what belongs in it, what must stay out, and where to look for the material in a repository. Pages marked *optional* are deleted when they do not apply.

Every page carries `data-trigger` (the kind of change that forces an update) and `data-sources` (where the detail lives). Those two attributes are what makes the docs maintainable, so never leave them empty.

The **Business card** group is the exception to everything below. Its five pages cannot be sourced from the repository at all, so `data-sources` names a person and a date instead of a file, and "where to look" is an interview. The full procedure is in `business-card.md`; what follows here is only what belongs on each page.

---

## Business card

The context the rest of the documentation is written against. Never deleted for being thin: unlike an optional technical page, an empty section here is itself information - it says this is not settled.

### Pitch, mission and vision
**For:** giving anyone, human or agent, the promise a feature is supposed to serve.
**In:** the elevator pitch; the positioning frame (for / who / this is / unlike / because); the mission in the present tense, with why that wording and not the obvious one; the vision, explicitly labelled as a direction rather than a plan.
**Out:** anything the team has not actually said. A mission assembled from landing-page adjectives will be quoted in meetings for a year.
**Where to look:** the user. The landing hero and the README's first paragraph give a candidate to react to, never an answer.

### Personas
**For:** settling arguments about design choices. A persona that cannot settle an argument is decoration.
**In:** people from outside the company, sorted by why they come rather than by which screen they use, as many as the product has reasons for being used and never more than five. Each one a sketch - first name, epithet, age range, dispositions, a temperament emoji - and a claim: the *Needs* line, the moment that brings them, what they do instead today, what loses them, how much of the business they are, the evidence. Exactly one carries the main persona tag. Then the "not our user" table - who asks for the product and is deliberately not served, why, and what would make us revisit.
**Out:** demographics, which decide nothing; roles out of the code, which are permissions and not people; a persona that is a product surface with a first name; and questions - where nobody knows, the page carries a claim marked `Guess`, never *"Unknown: do we serve students?"*.
**Where to look:** personas the team has already written, first - keep their words rather than improving them. Then the user, and any interview or support corpus they have. The interface's empty states and example data often reveal who the product silently assumes. Full procedure, including what to do when there is nobody to interview, in `personas.md`.

### Business model
**For:** arguing a feature against how the company actually makes money.
**In:** who pays for what and why that shape rather than the obvious alternative; where the paywall sits and what that choice says; what makes an account stick; what we could charge for and deliberately do not; what it costs to serve someone, coarsely.
**Out:** prices, quotas, tiers. The grid is in the billing config and the split logic is on Plans and permissions.
**Where to look:** the pricing page and plan configuration for a candidate - the code is often a better witness than the team on where the paywall really sits. The reasons come from the user.

### Market and competitors
**For:** knowing what a user is comparing us against, so a spec can be argued from where we win rather than from what is missing.
**In:** the category as a buyer would name it; what is moving in it; three to five competitors with what they are best at, where we win, where they win, and the month each row was checked; what we are explicitly not competing with; what would change the picture.
**Out:** a feature matrix, funding, headcount. A matrix is stale the month it is written and it pulls the roadmap towards parity.
**Where to look:** the web, then the user. A search returns the loudest, not the closest - always ask what is missing, and include the non-consumption option, which never appears in a search result and is usually the real incumbent.

### Objective and strategy
**For:** making it possible to say no. This is the page that does real work.
**In:** exactly one objective - acquisition, activation, retention or revenue - with the metric it moves and why this one; a table of why not the other three and what would promote each; two to four bets, each saying what would prove it wrong; what we are deliberately not doing; when this gets revisited.
**Out:** a second objective. Two objectives is no objective. Also out: the metric's definition, which lives on Metrics and tracking and is written there only.
**Where to look:** the user, and only the user. Set `data-objective` on the section so an agent can check a spec against it - every spec carries the same attribute, and the Roadmap's Objective column highlights the ones that match this page.

## Understand

### Overview
**For:** letting a newcomer, human or agent, place the product in two minutes.
**In:** one sentence on what the product does and for whom; stage; surfaces; repository; scope as "does" and "does not do".
**Out:** mission, vision, personas, market, strategy - those are the Business card pages above; link to them rather than summarising them here. Version numbers, which go stale.
**Where to look:** README, package manifest, route list, landing page copy, the deploy config for surfaces.

### Glossary
**For:** one word per concept, in the interface, the code, the specs and support.
**In:** term, definition, name in code, what it is not to be confused with.
**Out:** every type in the codebase. Ten to twenty terms that carry meaning, not a type dump.
**Where to look:** domain types, table names, the vocabulary in the UI strings. Watch for the same thing under two names - that is exactly what this page fixes.

## Product

### Features
**For:** answering "does the product do X?".
**In:** one row per capability as the user perceives it, what they can do, a coarse status (live / beta / partial rollout / being retired), and a link to the mechanism or rule that explains it.
**Out:** rollout percentages, plan names, quotas. Status stays coarse on purpose.
**Where to look:** route and screen inventory, feature folders, flag config, the marketing pages.

### User journeys
**For:** the three to six paths that carry the value.
**In:** intent, the steps in one sentence each, where it gets stuck, and the end-to-end test that is the reference.
**Out:** a screen-by-screen script. The e2e test is executable and therefore always right; point at it.
**Where to look:** e2e tests, onboarding code, funnel events.

### Key mechanisms
**For:** the things you cannot guess from the interface or from a single file. This is usually the most valuable page of the whole doc.
**In:** three to eight mechanisms, one screen each: in short / how it unfolds / special cases / why this way / where to enter the code.
**Out:** the step-by-step implementation.
**Where to look:** background jobs, cron, queues, webhook handlers, state machines, anything with retries or idempotency, money or date calculations, sync between two systems. A good signal: a file that several unrelated features import.

### Business rules
**For:** everything the product decides on the user's behalf, with the reason.
**In:** identifier, intent in one verifiable sentence, why, file, test, since when.
**Out:** the exact constants - the cited file wins. Also out: input format validation and technical defaults, which are implementation, not business rules.
**Where to look:** guards, validators, domain services, and the tests around them - a test name often states the rule better than the code. The "why" is almost never in the repo: ask.

### Plans and permissions *(optional)*
**For:** the logic of the split between plans and between roles.
**In:** what each plan is for, what happens at the limit, the roles and why there are not more.
**Out:** prices, quotas, the full permission matrix.
**Where to look:** plan config, permission middleware, the billing integration.

## Direction

### Roadmap
**For:** one ordered list of everything intended, most important first.
**In:** one row per live project: problem, target metric, objective, horizon, link to its spec.
**Out:** dates, unless they are external constraints.
**Check:** the order should be defensible against the single objective on Objective and strategy. A row that serves no objective is allowed, but it should be visibly exceptional - the Objective column is what makes it visible, since it greys out anything that is not the current objective.
**Objective column:** read from the spec's `data-objective`, or from the row's own when it has no spec. Each objective has its own emoji and colour - 📈 acquisition, ⚡ activation, 🔁 retention, 💰 revenue, ⚪ no objective - and the current objective is the only one ringed, so a roadmap that has drifted shows it before anyone reads a word. It comes with two filters, by objective and by spec status, which is how a long roadmap gets read one lever at a time. Filtering hides rows and never renumbers them: the rank is the priority.
**Where to look:** not in the repo. Ask, or point the page at the tracker and keep only the prioritisation logic.

### Specs
**For:** changes to come, one page per project, before they are built.
**In:** per spec page - problem with evidence, expected outcome, how it serves the single objective, future changelog, behaviour, acceptance criteria, out of scope, handover, open questions with an owner.
**Serves the objective:** one line per spec tying it to the objective on Objective and strategy - or saying why this project is the exception. It is what makes the roadmap checkable. A project that cannot answer is a project that has not been argued.
**One objective per spec, on `data-objective`:** acquisition, activation, retention, revenue, or `none` when the project deliberately serves none. One, not two - a project that serves everything prioritises nothing. It is the same answer as the "Serves the objective" line, in a form the Roadmap column and its filters can read, so the two are written to agree.
**Future changelog:** the announcement users will read on release day, written before the build - a title and two or three lines, emoji, benefits rather than features. It is the benefit test: a project nobody can announce in three lines is a project whose value is not settled. On shipping it becomes the Changelog entry.
**Handover:** one line per page the project will have to feed when it ships, each naming what moves there, ticked with `data-done` once it has. Written with the spec. A shipped spec with open lines is counted as debt on the home page - this is what stops Features and Key mechanisms drifting behind the code.
**Out:** anything about the present state; that belongs in the living pages. Once shipped, a spec is frozen and points at them.
**Where to look:** tracker, design docs, PR descriptions of work in flight.

### Decisions
**For:** the memory of why, so the same debate is not reopened and an agent does not undo a deliberate choice.
**In:** identifier, title as a statement, date, context, options ruled out, consequences.
**Out:** edits. A decision is superseded by a new one, never rewritten.
**Where to look:** ADR folders, long PR discussions, comments that start with "we deliberately". Mostly: ask.

## Technical

### Architecture
**For:** the map of components at the level a PM needs.
**In:** each component's role and tech; background jobs with their schedule, role and failure behaviour.
**Out:** the internal structure of each component.
**Where to look:** infra folder, compose or deploy files, job definitions.

### Data model
**For:** the mental map - concepts, how they relate, and the choices you cannot guess from the schema.
**In:** prose on the entities and their relations, then the invariants and the non-obvious decisions (snapshots, money representation, soft deletes, isolation).
**Out:** tables and columns. The migrations are the schema.
**Where to look:** migrations, ORM models, row-level security policies.

### Integrations and API
**For:** what the product depends on outside, and what happens when it goes down.
**In:** per service - why we depend on it, user-visible behaviour during an outage, where to enter the code. For a public API, the principle and what it deliberately cannot do.
**Out:** endpoints, keys, environment variable names. Point at the OpenAPI file.
**Where to look:** integration folders, the env example file (for the list of services, not the variable names), webhook handlers.

### AI components *(optional, only if the product calls models)*
**For:** a prompt is a business rule in disguise, so it deserves the same traceability.
**In:** per component - what it does, what it must never do, how you know it works (evaluation set, tracked metric), where the prompt lives, behaviour when the model is unavailable.
**Out:** the prompt text, the model name and parameters.
**Where to look:** prompts folder, evals, the guardrails around the call.

## Measurement

### Metrics and tracking
**For:** exact definitions, so two people do not mean two things by "activation".
**In:** the north star and why it covers the promise, the input metrics with their exact definition and why each matters, the tracking conventions.
**Out:** values, and the list of events. Both go stale immediately; the typed events file is the reference list.
**Where to look:** analytics wrapper, event types file, dashboard names. Definitions usually need the user.

### Experiments and flags
**For:** keeping what the code does not remember - hypotheses tested and what was learned.
**In:** how flags are used in this team, and a log of experiments with verdict and takeaway, including the disproved ones.
**Out:** the live state of flags.
**Where to look:** flag config for the conventions; the log itself has to come from the user.

## Operations

### Internal tooling
**For:** everything the team uses that the user never sees. The most forgotten page, and the one whose absence costs most during an incident.
**In:** per tool - what it is for, where it lives, what to be careful about.
**Where to look:** scripts folder, admin routes, CI workflows, seed and migration commands.

### Environments and runbooks
**For:** where it runs, how it ships, what to do when it breaks.
**In:** environments with their data and deploy trigger; one runbook per recurring incident - symptom, what to check, what to do, last occurrence.
**Where to look:** deploy workflows, alerting config, incident history. Write a runbook right after an incident, while it is fresh.

## Quality

### Known limitations and debt
**For:** saying honestly what does not work well, so it is not rediscovered every quarter and support has an answer ready.
**In:** the limitation, its impact on the user, the workaround, whether it is planned.
**Where to look:** TODO and FIXME comments, debt-labelled issues, known-failure tests.

### Security and personal data
**For:** what data is held, why, for how long, who can access it.
**In:** per category of data - purpose, retention, where it is stored; then access controls and deletion behaviour.
**Out:** anything secret.
**Where to look:** row-level policies, retention jobs, the subprocessor list, the privacy policy.

### Support and feedback
**For:** what users do not understand, and what that reveals about the product.
**In:** recurring questions with the standard answer and what it reveals; request themes with the need behind them and where each stands.
**Out:** volumes and verbatims - they stay in the support tool.
**Where to look:** help centre, canned replies. Mostly from the user.

## History

### Changelog
**For:** what changed for the user, written from their point of view.
**In:** per version - the future changelog block of each spec that shipped, plus added, changed, fixed, removed for anything with no spec behind it, with a link to the rule or spec involved.
**Where to look:** git tags and an existing CHANGELOG. Do not backfill years of history; start at the current version and grow forward.

## Meta

### Maintaining these docs
Keep this page almost as it ships. It carries the principles, the table of which change updates which pages, the freshness statuses and the block for coding agents. Adapt only the paths, the identifiers and the language if the user chose another one.
