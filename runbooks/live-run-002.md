# Live Run #002 — runbook for the agent

You are the developer's coding agent. ARCHIE-99 is already done: the quotes page is live as a function with its own URL.
Two tickets need doing, in this order: **ARCHIE-113 → ARCHIE-112**. Each builds on the last.
(For a full rehearsal from scratch, do ARCHIE-99 first using the section below.)

You work **only through Archie** (the `archie` MCP server). You never touch the cloud
directly and never edit infrastructure code by hand. Archie decides what gets built,
holds the organisation's rules, and tells you what to do next.

The person running this session is the **platform engineer (PE)**. They are signed in
to Archie's web app. Some decisions are theirs alone; when you reach one, **stop, say
so in one line, and wait** (marked ⏸ below).

---

## Rules for the whole run

1. **Read the ticket through Archie first.** Do what it asks — no more.
2. **Archie's answer is the instruction.** When Archie refuses, holds or asks, read
   the whole answer and follow its `next` step. Don't work around a refusal.
3. **Never answer a question that belongs to a person.** If Archie says
   `a_person_answers`, relay the question and the review link, then wait.
4. **Never edit a module to make an error go away.** If a check fails, report it
   with Archie's words.
5. **Use the cloud account named below**, and only that one.
6. **After each ticket, report in 3 lines:** what's live, the URL, what Archie
   decided for you.

**Cloud account:** `<ACCOUNT LABEL — fill in on the day>`

---

## Ticket 1 — ARCHIE-99: put the quotes app online

1. Read ARCHIE-99 through Archie.
2. Ask Archie for what the ticket needs. Archie reads the ask and files a **reading**:
   its understanding of what to build.
3. ⏸ **The PE reviews the reading** in Archie and confirms or corrects it.
   Wait. Don't confirm it yourself, even if the PE says "looks good" in chat.
4. Once it's confirmed, Archie composes and deploys. Follow its steps until the app
   is serving.
5. Report the URL. Done when it answers in a browser.

> **Presenter:** this is the simplest path — one function, one public URL. Show the
> reading, then the feed card turning green.

## Ticket 2 — ARCHIE-113: give it a real address

1. Read ARCHIE-113 through Archie.
2. This **adds to the app from ticket 1**. Ask Archie to add what the ticket needs to
   that app; don't start a new one.
3. The domain's DNS lives in a different account. Archie knows that; follow what it
   says about where the record goes.
4. ⏸ If Archie asks a person anything (certificate, domain, public exposure), relay
   it and wait.
5. Report the HTTPS URL. Done when `https://quotes.askarchie.io` answers.

> **Presenter:** show the cross-account DNS answer — Archie works out where the
> record must go without anyone telling it.

## Ticket 3 — ARCHIE-112: move it onto Kubernetes, with no downtime

1. Read ARCHIE-112 through Archie.
2. Ask Archie for what the ticket needs. It files a **reading** (expect a cluster,
   a NEW network — there is no shared one yet — an encryption key, durable storage
   and the app).
3. ⏸ **The PE confirms the reading.**
4. Archie composes a **golden path**. Say out loud what Archie added on its own,
   especially the **AWS Load Balancer Controller**: it gives the app a Network Load
   Balancer (NLB) instead of the legacy Classic one. Clear the items Archie marks as
   yours; relay the ones it marks as the PE's.
5. ⏸ **The PE reviews and publishes the path.** Publishing runs a smoke test: Archie
   builds it for real in the sandbox, checks it serves, and tears it down.
6. Deploy the path to **dev** for the quotes app. The cluster takes ~15–20 minutes;
   Archie reports progress, so report it in one line each time something moves.
7. When the new app serves, ask Archie to move the public address over to it. The
   ticket says no request may fail during the move.
8. Report: the URL (unchanged), where it now runs, and that the old function was
   left alone or retired, per Archie.

### Governance moments — show these (ask Archie, report its answer, don't push)

Each one is a real rule. Try it once, read Archie's answer aloud, and move on.

- **A size the org didn't approve:** ask Archie to use a bigger node size than the
  approved list. → Archie refuses and names the approved sizes.
- **A person's question:** try to answer one of the PE's review questions yourself.
  → Archie refuses (`a_person_answers`) and gives you the link for the PE.
- **Production:** ask to deploy the same path to production. → Archie holds it for
  a human's approval.
- **Changing your mind too late:** after the PE confirmed the reading and compose
  started, ask to edit the reading. → Archie refuses (`reading_already_composing`).
- **Pulling the plug on something live:** ask to tear down the app while it is
  serving traffic. → Archie says it needs a second human.

> **Presenter:** this is the point of the episode. The agent moves fast; Archie keeps
> the guardrails — sizes, people's decisions, production, live traffic.

---

## If something goes wrong

- **Archie refuses or holds:** that's working as designed. Read the answer, do its
  `next` step, or relay it to the PE.
- **A deploy fails:** report Archie's error word for word. Don't retry more than once
  without asking the PE. A failed smoke test **keeps what it built**; re-running
  continues from there.
- **You're unsure whose decision it is:** it's the PE's. Ask.
