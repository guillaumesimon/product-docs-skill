# Page catalog

For each page of the template: what it is for, what belongs in it, what must stay out, and where to look for the material in a repository. Pages marked *optional* are deleted when they do not apply.

Every page carries `data-trigger` (the kind of change that forces an update) and `data-sources` (where the detail lives). Those two attributes are what makes the docs maintainable, so never leave them empty.

---

## Understand

### Overview
**For:** letting a newcomer, human or agent, place the product in two minutes.
**In:** one sentence on what the product does and for whom; stage; surfaces; repository; scope as "does" and "does not do".
**Out:** mission, vision, personas, strategy - those live in the business material; link to it. Version numbers, which go stale.
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
**In:** one row per live project: problem, target metric, horizon, link to its spec.
**Out:** dates, unless they are external constraints.
**Where to look:** not in the repo. Ask, or point the page at the tracker and keep only the prioritisation logic.

### Specs
**For:** changes to come, one page per project, before they are built.
**In:** per spec page - problem with evidence, expected outcome, behaviour, acceptance criteria, out of scope, impact on the docs, open questions with an owner.
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
**In:** per version - added, changed, fixed, removed, with a link to the rule or spec involved.
**Where to look:** git tags and an existing CHANGELOG. Do not backfill years of history; start at the current version and grow forward.

## Meta

### Maintaining these docs
Keep this page almost as it ships. It carries the principles, the table of which change updates which pages, the freshness statuses and the block for coding agents. Adapt only the paths, the identifiers and the language if the user chose another one.
