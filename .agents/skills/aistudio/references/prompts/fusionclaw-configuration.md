# Fusionclaw Configuration

Use this reference when the user mentions Fusionclaw, autonomous settings, goals, skills, capabilities, additional autonomous agents, or example tasks for an Agentic App.

## Command Naming

- Read-only commands use `get-*` or `list-*`.
- Mutating commands use `do-*`, matching App Builder tool naming.
- Use `do-set-goals` only for the scalar goals field.
- Use `do-add-*`, `do-modify-*`, and `do-remove-*` for collection items.
- Use `list-*` for collections; do not use `do-list-*`.
- Do not use bare `set-*` command names.
- Use dedicated autonomy commands instead of hand-editing `.app` JSON when they cover the change.
- Run mutating commands serially for a single `.app` file and treat the updated file as source of truth before the next command.

## Goals

Goals are configured with `get-goals` and `do-set-goals`.

- Read goals: `aistudio get-goals --file <app-file>`
- Set goals: `aistudio do-set-goals --file <app-file> --args '{"goals":"..."}'`
- Preview changes: add `--dry-run`.

Example:

`aistudio do-set-goals --file src/apps/customer_success.app --args '{"goals":"Monitor customer health, explain renewal risk, and recommend next best actions."}'`

## Additional Autonomous Agents

Additional autonomous agents are configured with `list-additional-autonomous-agents`, `get-additional-autonomous-agent`, `do-add-additional-autonomous-agent`, `do-modify-additional-autonomous-agent`, and `do-remove-additional-autonomous-agent`.

Rules:

- Additional autonomous agents use workflow codes in `workflowCode`.
- Set `useDraftWorkflowWhileDeveloping` to `true` when the additional agent should resolve its draft workflow during app development; otherwise it resolves the published workflow.
- Do not add them to runtime app panels or ordinary app agent configuration.
- Do not duplicate an existing runtime app agent workflow code.

Commands:

- List agents: `aistudio list-additional-autonomous-agents --file <app-file>`
- Get one agent: `aistudio get-additional-autonomous-agent --file <app-file> --args '{"workflowCode":"RENEWAL_AGENT"}'`
- Create one agent: `aistudio do-add-additional-autonomous-agent --file <app-file> --args '{"workflowCode":"RENEWAL_AGENT","title":"Renewal Agent","description":"Handles renewal analysis.","useDraftWorkflowWhileDeveloping":true}'`
- Update one agent: `aistudio do-modify-additional-autonomous-agent --file <app-file> --args '{"workflowCode":"RENEWAL_AGENT","patch":{"title":"Renewal Specialist","useDraftWorkflowWhileDeveloping":false}}'`
- Remove one agent: `aistudio do-remove-additional-autonomous-agent --file <app-file> --args '{"workflowCode":"RENEWAL_AGENT"}'`
- Preview changes: add `--dry-run`.

## Workflow Capabilities

Ordinary authored capabilities are owned by workflows, not by Agentic App configuration. Author every new or edited ordinary capability in exactly one top-level workflow trigger whose `type` is `"CAPABILITY"`; its `inputs` contain the workflow's capability definitions. Apps discover those definitions automatically from workflows referenced by `agents[*].agent` and `additionalAutonomousAgents[*].workflowCode`.

PL/SQL Data Extract capabilities are the platform-generated exception. When the request is for a Data Extract or an `ora_int_dbextract_*` capability, read `data-extracts.md` and use the dedicated app commands. Do not create a workflow capability or External REST Tool for the package procedure.

Rules:

- User-authored app-level capability fields are retired and are not managed by the generic capability CLI. Existing app specifications may retain them unchanged. Dedicated Data Extract commands alone may reconcile their derived `ora_int_dbextract_*` entries.
- A canonical workflow capability input contains `name`, `description`, `category: "Generic"`, explicit `readOnly`, explicit `requiresCompute`, and a serialized JSON Schema string in `typeSpecification`.
- The workflow implements the capability through `$context.$triggers.isCapabilityCall`, `$context.$triggers.CAPABILITY.$input.capabilityName`, and `$context.$triggers.CAPABILITY.$input.capabilityPayload`.
- Do not create a `$context.$app.$OraMessageHint == "InvokeCapability"` branch and do not use `$context.$app.$OraAction` or `$context.$app.$OraActionPayload` for a newly authored capability.
- Application skills reference workflow capabilities with the full exposed identifier `{{capabilityName__fingerprint}}`. The fingerprint is the first three characters of the unpadded Base64URL-encoded SHA-256 of the trimmed, uppercase workflow code encoded as UTF-8. The trigger input stores only the unqualified `capabilityName`.
- A workflow capability alone does not require AI Apps compatibility. Set `aiAppsCompatibleFlag` only when the workflow also implements actual app stages.
- In an app-compatible workflow, use `$context.$app.appSettings.autonomousEnabled` to branch on whether autonomous activities are enabled for the invoking Agentic App. This expression is invalid in workflows without `aiAppsCompatibleFlag: true`.

CLI workflow-capability commands:

- Inspect the target workflow first: `aistudio get-workflow-capabilities --file <workflow-file>`
- Add a capability: `aistudio do-modify-workflow-capability --file <workflow-file> --args '{"action":"add","capability":{"name":"summarize_account","description":"Summarize account health and recommended next actions.","readOnly":true,"requiresCompute":false,"typeSpecification":"{\"type\":\"object\",\"properties\":{\"accountId\":{\"type\":\"string\"}},\"required\":[\"accountId\"],\"additionalProperties\":false}"}}'`
- Update a capability: `aistudio do-modify-workflow-capability --file <workflow-file> --args '{"action":"update","capabilityName":"summarize_account","capability":{"description":"Summarize account health, risks, and recommended next actions."}}'`
- Delete a workflow capability: `aistudio do-modify-workflow-capability --file <workflow-file> --args '{"action":"delete","capabilityName":"summarize_account"}'`
- Preview any workflow-capability mutation by adding `--dry-run` only when the user asks for an exact diff preview.

The mutation command changes trigger metadata only. Use the workflow node and edge commands separately to implement or migrate the capability handler.

## Skills

Application skills are configured through CLI commands. Do not hand-edit skill storage fields when these commands cover the change.

For app fetch/copy restrictions and unavailable remote skill-content operations in 2610, read `app-best-practices.md`, section "Fetching and copying apps".

Rules:

- Inline skills require `name`, `description`, and `text` or `prompt`.
- Packaged-skill upload and replacement preserve the legacy FND upload/attach flow by default. Enable the staged CI path with `aistudio.betaFeatures = skillsInfrastructure` in the workspace-root `env.properties` file.
- With `skillsInfrastructure` enabled, new packaged skills use Skills Infrastructure and a canonical `applications/<appCode>/skills/<code>/` source resolved through the artifact layout. CI-specific create/import/update/pull/adopt/delete/migrate commands fail with enablement guidance while the flag is off.
- Skill packages may contain root `SKILL.md` or exactly one wrapper directory containing it. Preserve scripts, resources, and arbitrary safe nested files.
- `SKILL.md` requires a lowercase hyphenated `name`, plain-string `description`, and non-empty Markdown instructions. `code` is the caller-selected immutable Skills Infrastructure `ciCode` and the stable local folder name. A successful first sync checkpoints `syncState: synced`; it never renames the folder or replaces the code with a record/document/version identifier.
- Keep inline skills working; this migration applies to uploaded/FND-backed skills.
- `--dry-run` performs no local or remote mutations. It may perform read-only validation and remote reads.
- Never automatically migrate or delete a legacy `source: uploaded` FND attachment. Use `migrate-skill` and accept any reported normalization explicitly.
- Runtime and upload compatibility are source-driven rather than flag-driven: `source: uploaded` continues to use FND, while `source: skills-infrastructure` continues to use CI. Remote downloading follows the app fetch/copy restrictions above.
- Application skills reference workflow capabilities as `{{capabilityName__fingerprint}}`.
- When migrating an inline skill, replace each exact `{{legacyCapabilityId}}` token with `{{legacyCapabilityId__fingerprint}}` only after the target trigger exists, using the resolved workflow's fingerprint.
- When migrating a legacy uploaded skill, use `migrate-skill`; the FND attachment remains rollback material.

Commands:

- List skills: `aistudio list-skills --file <app-file>`
- Scaffold local skill: `aistudio create-skill --file <app-file> --skill-code account_summary --name account-summary --description "Summarizes account health."`
- Import/sync local skill: `aistudio import-skill --file <app-file> --skill-code account_summary` (the selected code remains authoritative)
- Unavailable in 2610: `adopt-skill` and `pull-skill` (remote package reads).
- Update remote draft: `aistudio update-skill --file <app-file> --skill-code <stored-code>`
- Unlink only: `aistudio unlink-skill --file <app-file> --skill-code <stored-code>`
- Delete local only: `aistudio delete-local-skill --file <app-file> --skill-code <stored-code>`
- Explicit remote delete: `aistudio delete-remote-skill --file <app-file> --skill-code <stored-code> --confirm-code <stored-code>`
- Unavailable in 2610: `migrate-skill` (remote legacy package read).
- Get one skill: `aistudio get-skill --file <app-file> --args '{"skillId":"skill_account_summary"}'`
- Create an inline skill: `aistudio do-add-skill --file <app-file> --args '{"skillId":"skill_account_summary","name":"Account Summary","description":"Summarizes account health.","text":"Use {{summarize_account__abc}} before drafting the summary."}'`
- Import a package through the compatibility command: `aistudio do-add-skill --file <app-file> --args '{"skillId":"skill_uploaded","filePath":"./skills/account-summary.zip"}'`
- Update an inline skill: `aistudio do-modify-skill --file <app-file> --args '{"skillId":"skill_account_summary","patch":{"text":"Use {{summarize_account__abc}} and include renewal risks."}}'`
- Replace a CI package through the compatibility command: `aistudio do-modify-skill --file <app-file> --args '{"skillId":"skill_uploaded","patch":{"filePath":"./skills/account-summary.zip"}}'`
- Remove one skill: `aistudio do-remove-skill --file <app-file> --args '{"skillId":"skill_account_summary"}'`
- Preview changes: add `--dry-run`.

`do-add-skill` fails if `skillId` or derived provisional `code` already exists. `do-modify-skill` never implicitly migrates a legacy FND skill. `do-modify-skill` and `do-remove-skill` require an existing `skillId`; inline modify preserves omitted fields.

## Example Tasks

Autonomous example tasks are configured with `list-examples`, `get-example`, `do-add-example`, `do-modify-example`, and `do-remove-example`.

Rules:

- Examples are selected by the 1-based `exampleIndex` returned from `list-examples`.
- `text` is the user-facing example prompt. `title` is optional but recommended.
- `category` is optional and should be one of `Research`, `Actions`, `Reports`, `Presentations`, or `Spreadsheets`.

Commands:

- List examples: `aistudio list-examples --file <app-file>`
- Get one example: `aistudio get-example --file <app-file> --args '{"exampleIndex":1}'`
- Create one example: `aistudio do-add-example --file <app-file> --args '{"title":"Review renewal risk","text":"Review account renewal risk and recommend next steps.","category":"Research"}'`
- Update one example: `aistudio do-modify-example --file <app-file> --args '{"exampleIndex":1,"patch":{"text":"Review account renewal risk and draft a next-step plan.","category":"Actions"}}'`
- Remove one example: `aistudio do-remove-example --file <app-file> --args '{"exampleIndex":1}'`
- Preview changes: add `--dry-run`.

After material workflow changes, run `do-prettify-workflow` and `validate-workflow`, then reproduce any returned `testImpact.summaryText` verbatim. Once the requested capability edit is complete, automatically complete the generated workflow test sync and configured-mode execution unless the user explicitly requested preview, impact-only, defer, or skip behavior. After material app changes, run `validate-app` and apply the same automatic policy to the generated app and backing-workflow tests for an app with a testable top-level agent container. Never mutate an Economic Profile, allocation, or accepted baseline without explicit user approval.
