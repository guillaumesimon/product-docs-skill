# Shipping a spec: the handover

The failure this prevents: a project ships, the feature is live, and Features still
says "planned" while Key mechanisms has never heard of it. The spec knew what would
have to change - it said so months earlier - and nobody reopened it on release day.

So the spec carries a **handover**: one line per page it will have to feed, written
while the spec is being written, ticked one by one when it ships. The docs render it,
count what is still open, and show unfinished handovers on shipped specs as debt on
the home page. Nothing else in these docs is allowed to stay red.

## The markup

```html
<ul class="handover">
  <li data-page="mechanisms">Collection by payment link, end to end</li>
  <li data-page="BR-003" data-done="2026-09-18">The rule that stops the sequence, and why</li>
</ul>
```

`data-page` is the id of the target - a page (`features`, `mechanisms`) or an entry
inside one (`BR-003`, `M-collection`). The text says what moves there, not what the
project is. `data-done` is the day the content actually landed in that page; until
then the line is open. The badges, the tally in the spec header, the debt table on the
home page and the counter in the top bar all come from this.

## Recognising that a spec has shipped

Two signals, both of which start the routine below:

- **The code says so.** The change in front of you makes a spec's behaviour real: a
  feature flag or a rollout gate is removed, a branch becomes unconditional, a job
  goes from disabled to scheduled, an endpoint stops returning 404. When a change
  touches code a spec points at, open that spec before closing the task.
- **Someone says so.** "S-031 is out", "we released the customer import". Take it at
  face value and run the routine.

A spec whose status is already `shipped` but whose handover still has open lines is
the same job, late. Run it too.

## The routine

Do the moves, then report. This is documentation work in the same commit as the code,
not a proposal to be approved line by line.

1. **Read the spec.** The behaviour section says what is now true; the handover says
   where each part belongs.
2. **For each open line, open the target page.** Read what is there first - most of
   the time you are amending a sentence, not adding a section. Two mechanisms that
   describe the same thing are worse than one that is slightly out of date.
3. **Write it in the target page's own shape**, in the present tense, as if the spec
   had never existed: a mechanism is one screen (in short / how it unfolds / special
   cases / why this way / where to enter the code), a business rule is identifier,
   intent, why, file, test, a feature is a line with its state. Never paste the
   spec's prose: a spec argues for a change, a living page states what is.
4. **Point at the code.** The spec cited intentions; the page cites the file, the test
   or the dashboard that exists now.
5. **Tick the line** with `data-done="<today>"`, and set the target page's
   `data-verified` to today and `data-status` to `ok` - or `check` with the gap in one
   sentence if you had to leave something unsaid.
6. **When every line is ticked**, and only then, set `data-spec-status="shipped"`,
   copy the spec's future changelog into the Changelog as the version's entry, remove
   the spec's roadmap row, and stop editing the spec.

## What blocks what

- **An open line blocks the shipped status.** If you cannot source a line - the metric
  does not exist yet, nobody can tell you why a choice was made - leave the line open
  and leave the spec `in-progress`. Do not tick a line by writing something plausible.
- **If the user says the feature is live anyway**, set it to `shipped` and leave the
  open lines. The home register will carry the debt with the project's name on it,
  which is the honest outcome. Say so in your report.
- **If a target page does not exist**, create it with the same metadata shape as its
  neighbours (`data-title`, `data-desc`, `data-group`, `data-status`, `data-verified`,
  `data-trigger`, `data-sources`) rather than dropping the content somewhere close.

## Writing the lines, at spec time

A handover written the day of the release is a handover written from memory. Write the
lines while the spec is being written, when the impact is obvious:

- One line per page, phrased as what the reader of that page will gain - "how the
  reminder sequence unfolds", not "update mechanisms".
- If a spec has no handover lines at all, it either changes nothing a reader would
  ever look up, or it has not been thought through. It is almost always the second.
- Reshaping the scope means reopening the handover, same as the future changelog.

## Report format

After the moves, tell the user in a few lines:

- what moved, and into which page
- what you left open, and what you would need to close it
- what you changed in a living page that contradicted the spec - the code wins, and
  the spec may have been written before a late decision
