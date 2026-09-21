# Personas

The Personas page has its own reference because it is the one business card page an agent will
confidently get wrong. The others fail by being empty; this one fails by being full - four
defensible profiles that describe nobody, written from the only material a repository actually
contains.

What follows is what goes on the page, how to get it out of a person, and what to do when there is
nobody to ask.

## The four failures

Every rule below exists because of one of these. If you take nothing else from this file, take the
four.

### 1. It produces the company's own staff

Reading roles out of a codebase gives you `admin`, `owner`, `member`, `moderator`, `support`. Those
are the roles the code has most of, so they dominate, and the team opens its own documentation to
find its back office described as its customers.

> **A persona is someone outside the company who receives the value or pays for it.**

A role in the code is a permission, not a person. The company's own staff never count - support,
ops, moderation, back office - not even when the repository holds more code for them than for
anybody else. The one exception: when the back office **is** the product being sold, its operator is
somebody else's customer, and is outside the company again.

Two questions settle almost every case: *does this person work for the company whose repository this
is?* and *if they disappeared, would the business lose revenue or use?*

### 2. It segments by product surface, not by people

The important one, and the hardest to see, because the output looks thorough.

A quiz app produced *the evening player* and *the practice player* - two game modes - then *the
inviter* and *the invited friend* - two ends of a funnel. Four personas, all defensible, all useless:
a map of the product with people's names on it. The team reads them and learns nothing it did not
already know.

> **Two people who use different parts of the product for the same reason are one persona. Two
> people who use the same part for different reasons are two.**

The same app's real set: someone who plays to win, someone who plays to learn, someone who plays to
be with friends, someone who plays to fill four minutes. They want different things from the same
screen, and that is what makes them four people.

The test, before writing anybody down: *would this person still exist if the product shipped a
different feature tomorrow?* If not, you have described a surface.

The cause is worth naming, because it is the rule you would otherwise have written yourself.
Everywhere else in this documentation the instruction is to derive everything from the material and
take nothing from your own knowledge of the category. Follow that here and you have nothing to
reason from but the screens. The order on this page runs **from what the product is, to who wants
such a thing** - and who wants it is a judgement about people that no file contains.

### 3. It asks questions instead of making claims

An agent that is unsure writes *"Unknown: are students part of the audience?"* and files it as a
persona. The team opens its documentation and finds homework.

> **Never a question. When you do not know, write what you believe, marked
> `<span class="tag t-check">Guess</span>`, and keep the page at `check`.**

A claim gets rejected in one sentence; a question has to be answered by typing. This is the one rule
here that a real product would enforce in code, at the write, rather than in a prompt - there is no
validator in a documentation page, so it has to be enforced by the two things that can carry it: the
shape on the page, which has a `Needs` line that a question cannot be written into without looking
wrong, and the critic below, whose first job is to find questions wearing a persona's clothes.

This does **not** relax the rule that governs the rest of the business card. An unconfirmed persona
is still unconfirmed and still holds the page at `check` until a human says otherwise. What changes
is its grammar: a marked guess rather than an open question.

### 4. It hedges into uselessness

Told to ground everything in evidence, an agent writes *"users who want to save time"* - which cannot
be wrong, which is why it is worthless.

> **Split each persona into a sketch and a claim, and judge only the claim.**

The **sketch** - a first name, an epithet, an age *range*, two or three dispositions - is a
**handle**. It exists so that a spec review can ask "would Claire care about this?" and get a
straight answer. No repository has ever contained it. Never cut it for being unsourced, and never
water it down into demographics: *35-45, urban, tech-savvy* settles no argument.

The **claim** is the `Needs` line: the reason this person is here. Judge that hard, along with what
they do instead today and how much of the business they are.

Two named people with a need each is what a persona set looks like. Four cautious paragraphs about
*users* is what one looks like when nobody would commit to a claim.

## Before inventing anybody, look for personas already written

Search the repository and the team's own documents first: a `personas.md`, research notes, a README
section that says who it is for, an exported interview corpus, a Dovetail or Notion link in the
contributing guide.

If the team has already written theirs, **those are the personas.** Keep their names and their
words, mark them as confirmed with whoever wrote them, and put them in the shape below rather than
improving them.

This is not politeness, it is provenance, and it should show on the page: what came from the team is
not handed back to them for confirmation, and what you worked out is.

## The shape

One entry per persona, in the template's `.entry` markup. Keep it to what fits on one screen; a cap
that fits a paragraph gets a paragraph.

| On the page | What it holds | Cap |
|---|---|---|
| `<h3>` | The first name and the epithet: *Claire, three years in* | 60 characters |
| `.face` | One emoji from the set below, never a face and never a photo | one glyph |
| `.who` | Age range, then two or three dispositions | 200 characters |
| `.needs` | The need in one line, **written to follow the word "Needs"** | 160 characters |
| `What brings them` | The moment they reach for it - the event, not the general urge | one sentence |
| `Instead of us` | What they do now for the same reason: a rival, or a habit that is no product at all | one sentence |
| `What loses them` | The thing that makes them close the tab and not come back | one sentence |
| `How much of us` | How much of the business they are, coarsely. "Most of it" is an answer | one sentence |
| `Evidence` | What the claim rests on: interviews, funnel, support volume, a spec | one sentence |
| `.entry.main` + `<span class="tag is-north">Main persona</span>` | Exactly one persona carries it | one per page |
| `<span class="tag t-check">Guess</span>` | On any line the team did not actually say | as needed |

A **need** is what they are trying to get done, never a feature request. *"Wants the invoice list to
load faster"* is a thing to build; the need underneath it is what they would still want if that
feature never shipped. If the `Needs` line names a screen, a button or a feature, it is not a need
yet.

**The identifier is `P-01`, never the name.** Names get refined - *Claire, three years in* becomes
*Claire, whose money arrives late* - and every link into the page would break. Identifiers are
permanent and never reused, like every other identifier in these docs: a retired persona keeps its
number.

**Keep the caps consistent with each other.** If the sketch is allowed 200 characters and the entry
is meant to be read at a glance, the two have to be able to both be true at once. A budget handed out
in one place and refused in another is not a budget, it is a trap.

## The picture

A fixed set, chosen from and never improvised, so the page never carries a broken glyph or a stock
photo. Prefer temperaments over occupations - a persona is cut by why somebody is here.

| | | | |
|---|---|---|---|
| 🎯 wants to win, or to get it exactly right | ⏱️ has minutes, not hours | 🌱 new to this, afraid of getting it wrong | 🧭 knows the goal, not the way |
| 🔁 does this on a routine, every week or month | 🤝 here because other people are | 📚 here to learn the thing itself | 🔍 checks everything, sceptical by default |
| 💸 pays for it, may barely use it | 🛟 arrives when something has gone wrong | 🧰 power user, wants the lid off | ⚖️ answerable to someone else - a client, a regulator, a boss |

**Never generate a photoreal face.** A persona is a guess you are asking to have confirmed, and a
photograph of somebody who does not exist makes a fiction look like evidence. An emoji in a small
pale square, tilted a couple of degrees like a photo on an identity card, reads as a stand-in at a
glance and costs nothing. Keep it free of gender and skin tone: the sources say what somebody
*does*, never what they look like.

## How many, and which one is the main one

**Let the number fall out.** As many as the product has reasons for being used, and not one more.
Two is a real answer for a product that does one thing; five is real for one picked up for five
reasons. Never ask the team for three, and never pad a set to look thorough - a ceiling of five, no
target. If the page is about to carry six, two of them are the same person.

**Exactly one is the main persona** - not the largest group, not the best evidenced, the one the
product exists to serve. It is the same discipline as the single objective one page along, and for
the same reason: every design argument gets weighed against somebody, and "all of them equally" is
not an answer anybody can act on. If the team refuses to choose, ask which one they would keep if
the product could only serve one, and write the answer.

## Getting it out of a person

The questions, in the order that works. Four or five per exchange, and stop when the answers go
vague rather than pushing for completeness - a vague answer written down becomes a fact within a
week.

- Who are the two or three people you build for? **Can you name a real one for each?**
- What is the day that brings them - the specific event, not the general need?
- What do they use today instead? This is the real competitor, and it is usually a spreadsheet or
  nothing at all.
- What would make them leave?
- If you could only serve one of them, which one? *(That answer is the main persona. Ask it plainly;
  the reflex is to refuse, and the refusal is itself worth writing down.)*
- **Who asks for the product that you deliberately do not serve, and why?** Nobody volunteers this
  one, and it produces the most useful half of the page - the "not our user" table.

Two follow-ups earn their place. When an answer comes back as a job title or a segment, ask *what
are they trying to get done that day?* - the job title is where surface-segmentation hides in human
form. And when two personas start sounding alike, ask *do those two want the same thing from us?* If
yes, they are one person and the page is better for saying so.

## When there is nobody to ask

Solo projects, a repository handed over, a team that will answer next week and wants a draft now.
The set still has to be written, and this is where the naive version does its worst. Two agents,
pulling against each other, and a third thing that writes.

- **A drafter**, optimising for **usefulness**: a set precise enough to decide with, covering
  everyone including whoever pays.
- **A critic**, optimising for **truth**: cutting what rests on nothing, what is two names for one
  person, and what is a product surface wearing a first name.
- **You, the coordinator, and the only writer.** Neither agent edits the documentation. Nothing
  reaches the page that the critic has not ruled on, and **a persona the critic never ruled on is not
  published either** - silence is not a pass.

The tension is the mechanism. Alone, the drafter invents vivid detail with nothing under it - *her
name is Léa and she drives a Prius*; alone, the critic writes three exact lines nobody can use. The
prompts for both are in `agent-teams.md`.

**A format checker is not worth a third agent.** Shape is deterministic - check it yourself when you
assemble. What an agent reviewer is good at is the thing no check can do: is this true, is it
distinct, is it usable.

Everything produced this way is a guess. It goes on the page marked
`<span class="tag t-check">Guess</span>`, the page stays at `check`, and `data-sources` says it was
derived from the repository on a date rather than confirmed with a person.

## Log what was cut

What the critic removed, and why, is the reason the pair exists. If the run ends with a finished page
and nothing else, the team has to take it on faith and you cannot debug it either.

Report, in the message that hands over the draft: what was proposed, each cut with its reason, and
the final count. This pays for itself immediately - when a set comes out feature-driven, the reason
is visible in the drafter's own notes the moment they are written down.
