# Ask Oracle Plugin Authoring

Use this reference only when creating, editing, validating, fetching, saving, or deleting an Ask Oracle plugin (`.aoplugin`). Ask Oracle plugins are source-controlled DRAFT artifacts that compose inline skills, linked applications, and direct workflow agents.

## Layout And Lifecycle

Resolve package layout before creating the plugin. Use the same package-selection rules as every other AI Studio artifact.

- Legacy: `src/askOracle/<code>.aoplugin`
- App package: `app-pkg/<package>/sources/ai/self/<module>/askOracle/<code>/<code>.aoplugin`

Create locally with `do-create-ask-oracle-plugin`. Do not save remotely unless the user explicitly asks.

```text
aistudio do-create-ask-oracle-plugin --name "Sales Oracle" --description "Helps sellers plan and act on account insights."
aistudio validate-ask-oracle-plugin --file <plugin.aoplugin>
aistudio do-save-ask-oracle-plugin --file <plugin.aoplugin>
```

Server lifecycle commands are:

- `list-ask-oracle-plugins [--query] [--status] [--limit] [--offset]`
- `do-fetch-ask-oracle-plugin --code <code> [--status DRAFT|PUBLISHED] [--force]`
- `do-save-ask-oracle-plugin --file <plugin.aoplugin> [--force]`
- `do-delete-ask-oracle-plugin --file <plugin.aoplugin> [--remote true] [--dry-run]`

A PUBLISHED fetch creates a local DRAFT seed without the published record id. A DRAFT fetch retains its id. Save creates or updates only the remote DRAFT and refuses validation errors while allowing warnings. Delete removes only the local file unless `--remote true` is explicit; the remote form deletes the matching DRAFT first. Clone, publish, published deletion, and runtime plugin testing are not supported by this CLI version.

## Plugin Shape

Keep `selectionCriteria` at the top level and non-empty. Keep local `status` as `DRAFT`. Store authored skills under `specification.skills.default`.

Do not place app-only fields in the plugin specification: `goals`, `capabilities`, `autonomyCapabilities`, `exampleTasks`, or nested `selectionCriteria`. Unknown specification keys and non-default skill categories are persistence-compatible but have no authoring commands in this version.

Use these plugin-specific commands:

- `get-selection-criteria` and `do-set-selection-criteria`
- `list-linked-applications`, `get-linked-application`, `do-add-linked-application`, `do-modify-linked-application`, and `do-remove-linked-application`
- `list-inherited-skills`
- `list-ask-oracle-plugin-skills`, `get-ask-oracle-plugin-skill`, `do-add-ask-oracle-plugin-skill`, `do-modify-ask-oracle-plugin-skill`, and `do-remove-ask-oracle-plugin-skill`
- `list-ask-oracle-plugin-workflow-agents`, `get-ask-oracle-plugin-workflow-agent`, `do-add-ask-oracle-plugin-workflow-agent`, `do-modify-ask-oracle-plugin-workflow-agent`, and `do-remove-ask-oracle-plugin-workflow-agent`

Ask Oracle plugin authoring has a separate CLI surface from FusionAI/Fusionclaw application authoring. Never pass a `.aoplugin` file to `list-skills`, `get-skill`, `do-add-skill`, `do-modify-skill`, `do-remove-skill`, any additional-autonomous-agent command, or `list-configured-workflow-agents`; those commands remain `.app`-only. The Ask Oracle plugin skill commands edit only `specification.skills.default` and preserve other categories. The Ask Oracle plugin workflow-agent mutation commands edit only direct plugin workflow references.

Plugin skill upload is not supported. Create and edit inline skills with `name`, `description`, and `text`/`prompt`. Existing uploaded metadata is preserved during round trips, but do not add or replace it.

## Applications And Workflows

Use `list-ask-oracle-plugin-workflow-agents --file <plugin.aoplugin>` to inspect both direct plugin workflows and workflows inherited from locally linked apps. The result identifies the source, effective DRAFT/PUBLISHED status, and resolved local file path.

When the plugin needs a new or changed linked app:

1. Read `app-ingestion.md`, `app-best-practices.md`, and the relevant app authoring references.
2. Create or edit the app in the same selected app package as the plugin.
3. Complete app validation and the app test flow from `app-test-authoring.md` before plugin validation.
4. Add or update the plugin link.

When the plugin needs a new or changed workflow:

1. Read `workflow-vibe.md`, `workflow-node-prompts/index.md`, the relevant node references, and `workflow-test-authoring.md`.
2. Create or edit the workflow in the same selected app package as the plugin.
3. Implement plugin-callable behavior through top-level `CAPABILITY` triggers. Do not create legacy app-owned capability definitions.
4. Set `requiresCompute: false` for every capability referenced by a plugin skill.
5. Complete workflow prettification, validation, and the workflow test sync flow before plugin validation.

Do not load app or workflow prompt references merely to edit plugin metadata, selection criteria, or inline skill prose.

## Draft Development Flags

Application links use `useDraftApplicationWhileDeveloping`. Workflow references use `useDraftWorkflowWhileDeveloping`.

- An explicit flag always wins.
- When omitted from a plugin mutation command, the CLI sets it to `true` if the referenced artifact exists in the plugin's same resolved local layout; otherwise it sets it to `false`.
- When a local dependency exists but its flag is false, validation warns that runtime resolution will use the PUBLISHED server version.
- Validation never makes a network call to prove that a remote-only app or workflow exists.

Use DRAFT dependencies during coordinated local development. Change a flag to false only when the plugin should deliberately consume the published server artifact.

## Skills, Inheritance, And Capabilities

Linked applications contribute their inline skills and configured workflows. Uploaded app skills are not inherited. Workflow-owned capabilities are aggregated from direct plugin workflows and workflows exposed by linked apps.

Capability references in plugin skill prompts use the exposed capability name returned by validation or dependency inspection. The exposed name includes the workflow fingerprint, preventing collisions between workflows. A locally resolved capability with `requiresCompute: true` is invalid when referenced by a plugin skill. An unresolved remote-only capability token is a warning because local validation performs no server lookup.

## Validation Order

Before an explicitly requested remote plugin save:

1. Validate and test every locally changed workflow dependency.
2. Validate and test every locally changed linked application and its backing workflows.
3. Run `validate-ask-oracle-plugin --file <plugin.aoplugin>`.
4. Fix every error. Review warnings, especially published-resolution and unresolved-remote warnings.
5. Run `do-save-ask-oracle-plugin` only after the dependency and plugin checks pass.

Plugin validation returns path-based errors and warnings plus resolved application, workflow, inherited-skill, and capability summaries. Treat the plugin file as the source of truth after every mutation.
