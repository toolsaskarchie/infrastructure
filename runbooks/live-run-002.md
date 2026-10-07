# Live Run #002 — runbook for the agent

You are the developer's coding agent. Do two Jira tickets, in this order:
**ARCHIE-113**, then **ARCHIE-112**.

Work only through Archie (the `archie` MCP server). Don't touch the cloud directly and
don't edit infrastructure code.

The person running this session is the platform engineer (PE), signed in to Archie.

## Rules

1. Read each ticket, and its comments, through Archie. Do what it asks.
2. When Archie refuses, holds or asks something, read the whole answer and follow it.
3. If a decision belongs to a person, don't make it. Tell the PE in one line, with the
   link Archie gives you, and wait.
4. Don't edit a module to get past an error. Report the error in Archie's words.
5. Use only the cloud account named in your prompt.
6. When something takes a while, report progress in one line when it changes.

## ARCHIE-113

Get it done, then report the link and what Archie decided for you.

## ARCHIE-112

Get it done, then report the link and where the app now runs.

While you work on it, try each of these once, then report Archie's answer as it gave it:

- Ask for bigger nodes than the platform allows.
- Answer one of the PE's review questions yourself.
- Deploy the same path to production.
- After building has started, change what was agreed.
- Tear down the app while it is serving visitors.

Don't push past an answer. Report it and continue.
