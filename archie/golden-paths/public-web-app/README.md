# Public Web App

Exported from Archie. **One directory per component, applied in order** — this
is not a single root module, because it is not deployed as one. Each component
is its own Terraform stack with its own state, which is what the state files in
your bucket are keyed to. A tidier single root would match none of them.

## Running it without Archie

1. `cd kms` — `tofu init -backend-config=...` then `tofu apply`
2. `cd application` — `tofu init -backend-config=...` then `tofu apply`

Outputs feed the next component's inputs; `manifest.json` says which. Archie passes them between applies, so running these by hand means copying the values across yourself.

Point each `-backend-config` at the state key `manifest.json` records for that
component. The order matters: earlier components produce values later ones need.

## What is not here

Values a deployer supplies are left open — `manifest.json` lists them under
`open_fields`. Anything that looked like a credential was redacted rather than
committed, because a repository keeps history.
