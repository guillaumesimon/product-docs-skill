# Audit team

The audit asks one question of every page: is what this page claims still true of the code it points at? That is a naturally parallel job - each page carries its own `data-sources`, so each can be checked independently - and it is a job where a fresh reader beats the person who wrote the page.

Use a team for the audit. Do **not** use one for a single-change update: reading one page and editing one entry is faster done directly, and spawning agents for it adds latency and a chance of a stray edit.

If the environment has no subagents, run the same checks yourself, page by page, in the order of the register on the home page. Start with the pages already marked `check` or `stale`.

## Rules for every agent

**No agent edits `docs/product/index.html`.** They return findings and proposed wording; you apply them. Several agents editing one file loses content.

**No agent invents a reason.** If a page's stated reason cannot be confirmed, it is flagged, not replaced with something plausible.

**Rewording is not a finding.** The audit looks for claims that became false, not for prose that could be tighter. An agent that returns style suggestions is producing noise; say so in the prompt.

## Fan out by page

One agent per page, or per small group of related pages if there are many. Spawn them in the same turn.

```
Audit one page of a product documentation: <page title> in <docs path>.

That page declares data-sources: <the attribute's value>. Those files and tools
hold the detail; the page is supposed to explain, not repeat them.

Read the page, then read what it points at, and answer:
1. Claims that are now false: what the page says, what the code says, file path.
2. Claims that are unverifiable from the sources: flag them, do not guess.
3. Things that exist in the code and are missing from the page, but only if their
   absence makes the product harder to understand. A new column, event, endpoint
   or constant is NOT a gap - the page is not supposed to list those.
4. Copied content that should be a pointer to a file instead.
5. Whether the page's own data-trigger still describes what should force an
   update of it.

For each finding, propose the replacement wording, one or two sentences.
Ignore style, tone and phrasing. Do not edit any file.

Return: a verdict of ok / check / stale, then the findings.
```

Guidance on the verdict, which you should include in the prompt if the agents come back inconsistent:

- **ok** - everything the page claims still holds
- **check** - a specific, describable gap was found
- **stale** - the cited code has moved substantially and the page is broadly out of date, not wrong on one point

## Cross-page pass

Per-page audits miss what lives between pages. After they return, run two more agents in the same turn.

**Consistency**

```
Read <docs path>. Do not open the repository. Do not edit anything.

Find contradictions and duplication across pages:
- the same fact stated in two places, especially with different wording
- a concept used under two names, or a term used without being in the Glossary
- links that point at a page or an anchor that no longer exists
- a business rule contradicted by a mechanism description, or the reverse
- a spec marked shipped whose content never moved to the living pages
- a roadmap row whose spec is shipped or dropped
- an identifier (BR, D, S, RB) used twice

For each, say which page should hold the fact and what the others should link to.
```

**Newcomer test**

```
Read ONLY <docs path>. Do not open the repository.

Answer these questions, and for each say which file you would open for the detail:
1. What does this product do, and what does it deliberately not do?
2. <a question about the most important mechanism>
3. <a question about a business rule support would face>
4. <a question about what happens when a dependency is down>
5. Where would I add a new business rule, and what would I write?

Then list what you could not answer and anything you found ambiguous or
contradictory. Do not edit anything.
```

## Apply the findings

You apply them, one page at a time, then set each page's `data-verified` to today and its `data-status` to the verdict. Where a finding is a real gap you cannot resolve, `data-status="check"` with the gap described in one sentence at the top of the page - not a vague note, the actual discrepancy.

Resolve disagreements by reading the code yourself. An agent that reports a page as false is sometimes reading a different code path than the one the page describes.

Open a pull request rather than pushing, and report as a list: page, verdict, what changed. Surface separately the two things that matter more than the diff - the questions a newcomer still cannot answer, and any contradiction between pages, since that usually means the team holds two different mental models of the same thing.
