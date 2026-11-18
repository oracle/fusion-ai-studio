---
name: aistudio
description: Use for creating or modifying AI Studio app and workflow project resources, including agentic apps, Data Extracts, Ask Oracle plugins, workflows, business objects/BO nodes, policies, tools, connectors, approvals, document schemas, and function templates. Route requests, load the relevant bundled prompt references, and use the bundled aistudio CLI for local work.
---

# AI Studio

**Copyright:** Copyright (c) 2026 Oracle and/or its affiliates
**License:** UPL (Universal Permissive License)

Use this skill to create or modify AI Studio app and workflow project resources, including agentic apps and related local project resources.

## Start Here

1. Classify the requested artifact before choosing prompts or commands.
2. Before creating any new artifact, resolve package layout from the current project. If multiple app packages exist and the current user request did not explicitly name one, ask for the target app package and stop before any discovery, planning, generation, test sync, or create command. Prior turns, existing artifacts, and earlier package selections are not enough.
3. Read `references/prompts/index.md` to see available prompt references.
4. Load only the prompt files relevant to the task.
5. Keep the shell working directory at the AI Studio project root. Do not `cd` into the skill directory to run commands.
6. Run the bundled CLI by path, for example `node .agents/skills/aistudio/scripts/aistudio.js <command> ...` from the project root. If the skill is installed elsewhere, use that skill directory's `scripts/aistudio.js` path while keeping cwd at the project root.
7. Treat prompt examples that start with `aistudio` as shorthand for the bundled script path. Do not search `PATH`, install a global CLI, or run `which aistudio` / `command -v aistudio` unless the user explicitly asks for global CLI setup.
8. Run `init` only when the user explicitly asks to initialize or scaffold a blank project. Do not run `init` as a prerequisite for creating apps, workflows, or other artifacts in an existing workspace.

## Artifact Identity Protection

- Treat an existing artifact's code or equivalent stable identity field as immutable. Preserve it exactly during every edit, rename, save, normalization, migration, or regeneration.
- Changing an artifact's name, display name, title, description, or purpose must never change its code, filename, or code-derived folder. Only change an existing artifact code when the current user request explicitly identifies the artifact and asks for that code change. Do not infer authority from a request to rename, improve, modify, regenerate, or fix an artifact.
- This rule applies to every AI Studio artifact type, including apps, workflows, Ask Oracle plugins, agents, Business Objects, tools, topics, deeplinks, connector definitions and instances, approval processes, policies, policy templates, document schemas, and functions. For artifact types whose stable platform identity uses another field name, preserve that equivalent identity field too.
- Creating a new artifact establishes its code. An explicitly requested change to an existing code is an identity migration: inspect dependent references, explain unsupported or ambiguous impacts, and update only the scope authorized by the user. This rule concerns artifact identity fields, not executable source code inside workflow nodes or functions.

## Artifact Routing

Natural-language artifact phrases are primary. File extensions, file paths, and explicit command names are override signals.

| User intent | Artifact | Primary reference |
| --- | --- | --- |
| workflow, workflow node, step, edge, connect, wire, tool node, add a tool to a workflow | `.wf` workflow | `workflow-vibe.md`; node details in `workflow-node-prompts/` |
| app, agentic app, app panel, app communication, app template, app action | `.app` app | `app-ingestion.md`, `app-best-practices.md`, `app-vibe-master.md` plus app-specific prompts |
| Data Extract, database extract, PL/SQL extract, REF CURSOR export, `ora_int_dbextract_*` | `.app` app plus a matching PL/SQL package procedure | `data-extracts.md`; also read app references when other app configuration changes |
| Ask Oracle plugin, agentic home plugin, `.aoplugin`, plugin selection criteria, linked plugin application | `.aoplugin` Ask Oracle plugin | `ask-oracle-plugin.md`; load app/workflow references only when a linked artifact must be created or changed |
| Fusionclaw, autonomous settings, goals, skills, capabilities, additional autonomous agents, example tasks | `.app` app for settings/linkage plus `.wf` workflow for capability definitions | `fusionclaw-configuration.md`; always also `workflow-vibe.md` for capability authoring |
| business object | `.bo` Business Object | `business-object-builder.md` |
| business object tool, BO tool, deeplink tool, document tool, email tool, external REST tool, MCP tool, connector tool | `.tool` Tool | `tools-builder.md` |
| deeplink or deep link source artifact | `.dl` Deeplink | `artifact-conventions.md` plus CLI help |
| topic or instructions | `.topic` Topic | `artifact-conventions.md` plus CLI help |
| agent | `.agent` Agent | `artifact-conventions.md` plus CLI help |
| connector definition or generated connector from OpenAPI/MCP spec | `.connectorDefinition` Connector Definition | `connector-definition-cli-compat.md` |
| connector instance or configured connector | `.connectorInstance` Connector Instance | `connector-instance-cli-compat.md` |
| approval process | `.approval` Approval Process | `approval-process-builder.md` |
| policy or policy store | `.policy` Policy Store | `policy-store-builder.md` |
| policy template | `.policyTemplate` Policy Template | `policy-store-builder.md` and `policy-store-cli-compat.md` |
| document schema | `.documentSchema` Document Schema | `document-schema-builder.md` |
| function template or reusable function | `.function` Function Template | `function-builder.md` |
| migrate, copy, move, or merge a legacy AI Studio workspace into an app package and module | local AI Studio source and test artifacts | `workspace-migration.md` plus `artifact-conventions.md` |
| fetch, copy or duplicate an app from an environment | `.app` / `.apps` Agentic App | `app-best-practices.md` (including skill-transfer policy) plus `artifact-conventions.md` |

If wording could still mean more than one artifact, ask one targeted question: Tool artifact, source artifact, or workflow node?

## Workflow And App Boundary

Before building or modifying a workflow, decide whether it is standalone or app-backed.

- Standalone workflow intent: the user asks for a workflow, automation, node, or debug flow without mentioning an app.
- App-backed workflow intent: the user says the workflow is for an app, app agent, app panel, app communication, app template, target agent, app query value filter, dynamic starter queries, `InitDisplay`, `InitActions`, `InitCommunications`, `InitSampleQueries`, `FillParameters`, `SendCommunication`, `QueryFilterValues`, AI Apps, Agentic App, or app-compatible workflow.
- For standalone workflows, read `workflow-vibe.md` and the relevant `workflow-node-prompts/*` files. Do not add app-stage routing or `aiAppsCompatibleFlag`.
- For app-backed workflows, read both workflow references and `app-vibe-master.md` / `app-vibe-templates.md` as needed. App configuration determines which app-stage paths are required.
- Only set or change `aiAppsCompatibleFlag` when app intent is explicit.
- When app intent is explicit, the workflow is incomplete until the required app-stage paths are real and routable. See the app prompt references for `InitDisplay`, `InitActions`, `InitCommunications`, `InitSampleQueries`, `FillParameters`, and `SendCommunication` requirements.
- For app-backed workflows, route actual app stages on `$context.$app.$OraMessageHint` in the graph, usually with a `SWITCH` node. Workflow capability calls are the exception: split them through `$context.$triggers.isCapabilityCall` before app-only routing. Do not put multiple app-stage branches into one LLM/AGENT prompt.
- For app-backed workflows with shared recordable data, shared fetch/guard nodes must run before the app-stage router; only terminal LLM/AGENT nodes need to be stage-specific.
- A single-node app-backed workflow is invalid when it must handle more than one app message hint. For `InitDisplay` plus `Query`, create separate terminal nodes behind the `OraMessageHint` router.

## Reference Loading

- Workflow authoring: read `workflow-vibe.md`; for node work, also read `workflow-node-prompts/index.md` and the relevant node prompt files. When a workflow is created or materially edited, also read `workflow-test-authoring.md` before concluding so the post-authoring test-impact inspection and automatic generated-test synchronization run as one completed transaction.
- Workflow debugging: read `workflow-debug.md`.
- Workflow test authoring: read `workflow-test-authoring.md`. For scripted multi-turn creation, editing, recording, execution, or diagnosis, also read `workflow-conversation-test-authoring.md`; it extends rather than replaces the single-turn contract. The semantic judge section owns the model-authored judge flow and the read-only `get-workflow-test-judge-context` contract retrieval command. Treat `needs-model-test-data` as a nonterminal continuation and complete its compaction/apply flow before continuing workflow or app sync.
- Distinguish preview from execution. Requests like "show", "inspect", "preview", "display", "what would be generated", or "get the sync plan" are read-only plan requests: run only the relevant `get-*-test-sync-plan` command and explain the plan. Requests like "run", "execute", "generate", "regenerate", "sync", "create/update the tests", or "complete the sync plan" are execution requests: complete the workflow or app test sync loop from the relevant prompt reference. Do not stop after printing a plan when executable missing or out-of-sync actions remain and no user decision is required.
- Final-response checkpoint for test-sync execution requests: a latest workflow plan with `finalSummaryAllowed: false`, `requiredContinuation.blocking: true`, or `coverageExecution.nextActionIds`, or a latest app plan with required backing workflow actions or continuations, prohibits a final response. Execute the listed next action or required workflow command instead. A summary of pending counts is not a valid execution result. Follow the detailed completion and blocker rules in `workflow-test-authoring.md` and `app-test-authoring.md`.
- Workflow optimization: when the user asks about model costs, token usage, model comparison, cost reduction, BO payload size, prompt verbosity, or which model to use on a node, read `workflow-test-authoring.md` for the optimization command reference. Do not run optimization commands automatically during normal workflow creation or editing.
- App intake for new app work, material app edits, and app-backed workflow creation: read `app-ingestion.md` before asking questions or starting implementation. A confirmed BO or other data source does not complete intake by itself.
- App authoring: read `app-best-practices.md` and `app-vibe-master.md`; add `app-vibe-plan.md`, `app-vibe-actions.md`, `app-vibe-templates.md`, or `app-vibe-widgets.md` only when relevant. For forms and post-submit action requests, load both `app-vibe-widgets.md` and `app-vibe-actions.md`; also load `workflow-vibe.md` when the backing workflow must change.
- Fusionclaw/autonomous settings: when the user mentions Fusionclaw, autonomous settings, goals, skills, capabilities, additional autonomous agents, or example tasks, read `fusionclaw-configuration.md`. For every capability authoring request, also read `workflow-vibe.md` and the relevant workflow node prompts.
- Data Extracts: when the user mentions a Data Extract, database extract, PL/SQL extract, REF CURSOR export, or `ora_int_dbextract_*`, read `data-extracts.md`. Treat its generated app capability as the documented platform exception; do not route it through workflow-capability authoring or External REST Tool authoring.
- Ask Oracle plugins: read `ask-oracle-plugin.md`. Load app or workflow references only when creating or changing a linked dependency.
- Explicit plugin, application, or workflow save with dependencies: read `artifact-save-with-dependencies.md` completely and use its shared local inventory, dependency-first save order, existing per-artifact safeguards, and consolidated summary. Individual saves remain single-artifact operations; a save-only request does not trigger authoring review or tests.
- App test authoring: after creating or materially editing an app with at least one top-level agent container, read `app-test-authoring.md`, inspect Test Impact, and automatically complete the generated app and backing-workflow test sync unless the user explicitly requested preview, impact-only, defer, or skip behavior.
- ATLAS test and economic authoring scratch belongs only in the owning artifact's namespaced `.debug/atlas/...` directory. Do not create a top-level `.authoring` directory for test definitions, judge repairs, prepared test data, Economic Profile drafts, or proposal receipts. This restriction is scoped to ATLAS test and economic work; general app and workflow authoring scratch remains governed by its own guidance.
- Business Objects: read `business-object-builder.md`; for workflow BO nodes, read `workflow-node-prompts/bo-function.md`.
- Tools: read `tools-builder.md`.
- Connector Definitions: read `connector-definition-cli-compat.md`.
- Connector Instances: read `connector-instance-cli-compat.md`.
- Approval Processes: read `approval-process-builder.md`.
- Policy Store / Policy Templates: read `policy-store-builder.md` and `policy-store-cli-compat.md`.
- Document Schemas: read `document-schema-builder.md`.
- Functions: read `function-builder.md`.
- General file conventions: read `artifact-conventions.md` when you need local file paths, extension mapping, or normalized-file reminders.
- Legacy workspace migration: read `workspace-migration.md` and `artifact-conventions.md`. Treat migration as a local, non-destructive source-control operation; do not publish or delete the legacy source.

## Resources

- App samples live under `resources/app-samples/`. Read `resources/app-samples/index.md` before using app samples; it lists each available sample file and what it demonstrates.
- For app-backed workflow authoring, use `resources/app-samples/` only as examples of well-built workflow structure, data-source retrieval, app-stage routing, panel-specific behavior, and action wiring. Do not use samples directly, copy them exactly, or transplant their ids, BO choices, prompts, or wiring into new work.

## Global CLI Rules

- Prefer bundled CLI commands over direct JSON edits when a command supports the requested operation.
- Invoke the bundled CLI by path from the project root, such as `node .agents/skills/aistudio/scripts/aistudio.js <command> ...`. Bare `aistudio <command>` examples in references are shorthand only.
- Never use `npm run` or `npm test` to execute workflow tests, optimization sweeps, or any aistudio command. The `app-pkg/package.json` and root `package.json` npm scripts are for CI/CD pipelines only. Always invoke the CLI binary directly.
- Never pass `--judge-provider remote` to `run-workflow-test`, `run-workflow-tests`, or any optimization sweep command unless the user explicitly requests remote judging. This applies regardless of workspace type; the presence of `app-pkg/package.json` with remote-judge npm scripts does not change this default.
- Treat data source and evaluation mode as independent. A user request for file mode means pass `--data-source file` only. For an ordinary test run, omit `--evaluation-mode` so each test uses its configured mode, and omit `--judge-provider` so local judging remains the default. Pass `--evaluation-mode deterministic` only when the user explicitly requests deterministic-only execution or when test-authoring guidance requires transient validation of one affected test. Never use deterministic execution as a final confirmation after local judge attachment.
- When an authenticated AI Studio command, including a normal draft save, fails while sandboxed and the host keystore or credential store may be unavailable, do not conclude that authentication or the operation failed. Retry the same command outside the sandbox so it can access the host credential store, requesting escalation if required. Enter the `AUTH_REQUIRED` recovery flow only if the unsandboxed retry also returns `AUTH_REQUIRED`.
- For basic/dev-mode pre-production or PD environments, normal artifact commands never prompt for the FA password. If any CLI command returns JSON with `code: "AUTH_REQUIRED"`, do not treat that JSON as the final result and do not simply report the manual command. Pause the original command and recover authentication first:
  - In a real foreground terminal, run the returned `interactiveCommand` so the user can type into the hidden prompt, then retry the original command.
  - In background terminal UIs that cannot expose hidden password prompts, say: "This UI cannot expose the hidden password prompt." Then present both recovery choices: the user can run the returned `interactiveCommand` in their own terminal, or the user can explicitly authorize passing a password they provide to the returned `agentCommand` using `--password-stdin`.
  - Do not choose the manual terminal path on the user's behalf when `agentCommand` is available. Ask which recovery path they want. Use `--password-stdin` only after explicit user confirmation, and never write raw or base64 password values into `env.properties`, command arguments, files, or logs. After `configure-basic-auth` succeeds, retry the original command once.
- Do not add or restore `aistudio.basic-auth.passphrase` in `env.properties`. `configure-basic-auth` stores the Basic Auth encryption passphrase in the local secret store and writes only the encrypted Basic Auth value. For headless/CI or keychain-less environments, use `AISTUDIO_FA_PASSWORD` for basic/dev-mode auth instead of persisting Basic Auth.
- Do not run `init` unless the user explicitly asks to initialize or scaffold the project.
- Before creating any new artifact, identify AI Studio app packages by `<package>/sources/app-package.json`, whether packages are under `app-pkg/` or directly under the workspace root. If no marker exists, use the legacy `src` layout. If exactly one package exists, use it. If more than one exists, the current user request must explicitly name the package. If both container layouts coexist, require an explicit app-package root. See `prompts/artifact-conventions.md` for path rules.
- Never pass `--dir src/...` to create artifacts in a repo that has app packages. Use `--app-package <name>` only after the current user request names the package or the user answers the package question, and let the CLI choose the package-local directory.
- In a multi-module app package, omit `--modulename` for a package-wide workflow or app suite so every module is discovered. Scope follow-up local judge attachment to the exact package and module reported by the suite. Treat modules with no applicable tests as accounted skips, and use the reports rebuilt by attachment without rerunning a suite merely to refresh parent counts.
- Keep generated artifacts local unless the user explicitly asks to save, push, publish, fetch, pull, load, or refresh remote state. The only narrow exception is the automatic post-authoring test transaction: after the user confirms creation or a material edit of a workflow or app, save and normalize each newly created or materially changed remote DRAFT once when required to synchronize and execute its generated tests. This exception never authorizes publish, delete, overwrite of a newer remote DRAFT, Economic Profile mutation, rebaselining, or control-plane allocation changes.
- Never publish workflows from the CLI. Do not change a workflow status to `PUBLISHED` and post it from the CLI, and do not use hidden commands, helper APIs, custom scripts, or direct backend calls as a workaround.
- Use server fetch commands only when the user explicitly asks for server state. If a fetch says the local file differs from the server version, stop and ask before using `--force`.
- Use `--dry-run` only when the user wants an exact diff preview before writing.
- Apply mutating commands serially per artifact file. After each mutation, treat the updated file as the source of truth before issuing the next mutating command.
- Do not run mutating CLI commands in parallel against the same `.app`, `.aoplugin`, `.wf`, `.approval`, `.bo`, `.dl`, `.topic`, `.agent`, `.tool`, `.connectorDefinition`, `.connectorInstance`, `.policy`, `.policyTemplate`, `.documentSchema`, or `.function` file.
- Treat IDs and sample values in CLI help, prompts, tests, and checked-in examples as syntax examples only, not reusable live data.
- Do not inspect unrelated AI Studio framework/app source code, bundled implementation files, or minified assets to infer hidden contracts unless the user explicitly asks for source-level investigation.
- If the CLI, prompt references, and current project files do not make a contract clear, stop and ask instead of reverse-engineering internals.

## Local Layout

| Artifact | Default location |
| --- | --- |
| Workflow | `src/workflows/*.wf` |
| App | `src/apps/*.app` |
| Ask Oracle Plugin | `src/askOracle/*.aoplugin` |
| Agent | `src/agents/*.agent` |
| Business Object | `src/businessObjects/*.bo` |
| Deeplink | `src/deeplinks/*.dl` |
| Topic | `src/topics/*.topic` |
| Tool | `src/tools/*.tool` |
| Connector Definition | `src/connectorDefinitions/*.connectorDefinition` |
| Connector Instance | `src/connectorInstances/*.connectorInstance` |
| Approval Process | `src/approvals/*.approval` |
| Policy Store | `src/policies/*.policy` |
| Policy Template | `src/policyTemplates/*.policyTemplate` |
| Document Schema | `src/documentSchemas/*.documentSchema` |
| Function Template | `src/functions/*.function` |

`init` is for explicit blank-project setup only; artifact creation commands write their own target files and should not be preceded by `init` in an existing project.

## Verification

- After material workflow edits, run `node .agents/skills/aistudio/scripts/aistudio.js do-prettify-workflow --file <workflow-file>` after structural batches, then run `node .agents/skills/aistudio/scripts/aistudio.js validate-workflow --file <workflow-file>`.
- For condition, switch, code, return, or other expression-bearing workflow node edits, use file-backed JSON patch inputs such as `--inputs-patch @<artifact-scoped-workflow-authoring-file>`; do not inline JSON containing empty-string literals, quotes, `$context`, `{{...}}`, comparison operators, or expression syntax through the shell. For condition guards, prefer quote-free existence checks such as `{{!!...}}` when equivalent. After modifying a guard expression, read back or validate the workflow before recording tests so shell quoting did not strip literals. If live recording reaches an unexpected fallback, inspect guard expressions before reporting an environment blocker.
- If either result contains `testImpact.summaryText`, reproduce that block verbatim as a prominent section before continuing under the applicable automatic or read-only policy. Preserve the surrounding `**` markers exactly and never turn the action label into a Markdown heading.
- After a successful workflow create or material workflow edit, finish validation, save and normalize the remote DRAFT once when the automatic test transaction requires runtime execution, then automatically run `get-workflow-test-sync-plan --file <workflow-file>` and complete the focused generated-test sync and configured-mode validation loop from `workflow-test-authoring.md`. This specialized transaction takes precedence over the general local-only lifecycle rule. Do not ask for separate save or test approval when the confirmed authoring scope already requires the generated tests. Respect an explicit skip, defer, preview, or impact-only request. Treat an explicit local-only request as an opt-out from remote save and runtime execution. Preserve custom tests and never mutate an Economic Profile, accepted baseline, or control-plane allocation automatically.
- After a successful app create or material app edit, automatically complete the app-wide generated-test sync loop from `app-test-authoring.md`, including affected backing workflows and panel tests. Save each newly created or materially changed backing workflow DRAFT once before its runtime-dependent test loop, then save the materially changed app DRAFT once before app runtime execution. This specialized transaction takes precedence over the general local-only lifecycle rule. Respect explicit preview, local-only, or opt-out requests. If the app is only an empty shell with no top-level agent containers, report that app tests become applicable after a panel is added.
- When standalone workflow tests finish, run the concrete `get-workflow-test-final-summary --format json` command returned by the focused sync plan and use its `summaryText` as the evidence source for the final response section named exactly `Validation and Insights`. When the user explicitly ran file replay or live execution, add the matching `--data-source file|live` option to this final-summary command; never summarize the other mode's suite or Economic Health report as current. You may compact and deduplicate prose, but preserve all material meaning and render every entry in `requiredReportLinks` exactly once. Keep Test Summary first, followed by conditional `Action Required`, conditional `Metrics:`, `Optimization:`, conditional `Economic Setup:`, and conditional `Economic Health` sections in that order. Section content remains data-driven and may contain multiple concise lines. Never expose raw orchestration fields such as `finalSummaryAllowed`, `syncLoopState`, `requiredContinuation`, `coverageExecution.nextActionIds`, command fields, fingerprints, or receipt paths. Never add diagnostic token telemetry or a complete-coverage recap that the command omitted. Preserve bold action lines as normal-size body text and never execute them automatically. Do not hand assemble metrics from suite JSON or rerun tests merely to refresh reports.
- When app-wide tests finish, run `node .agents/skills/aistudio/scripts/aistudio.js get-app-test-final-summary --file <app-file> --format json` and use its `summaryText` as the evidence source for the final response section named exactly `Validation and Insights`. You may compact and deduplicate prose, but preserve all material meaning and render every entry in `requiredReportLinks` exactly once, including the app-scoped consolidated report, app-scoped app suite report, and each backing workflow suite report. Keep conditional `Action Required`, conditional `Metrics:`, `Optimization:`, conditional `Economic Setup:`, and conditional `Economic Health` sections in their returned order. Section content remains data-driven and may contain multiple concise lines. Never expose raw orchestration fields such as `finalSummaryAllowed`, `syncLoopState`, `requiredContinuation`, `coverageExecution.nextActionIds`, command fields, fingerprints, or receipt paths. Never add diagnostic token telemetry or a complete-coverage recap that the command omitted. Preserve bold action lines as normal-size body text and never execute them automatically. For targeted workflow-and-panel execution, present only the selected workflow final summary and targeted app-test result and report; do not call the app-wide final-summary command or enumerate unrelated tests. Never substitute a workspace-wide report unless the user explicitly requested workspace-wide or package-wide results. Do not rerun workflow tests, app tests, or full sync merely to regenerate a final summary.
- After material app, Ask Oracle plugin, BO, deeplink, topic, agent, tool, connector, approval-process, policy, policy-template, document-schema, or function edits, run the matching `validate-*` command when available.
- Report backend failures plainly. Do not retarget saves, invent schemas, or fabricate missing example payloads just to pass validation.

## Scope

This is the base AI Studio skill. It should stay concise and point to bundled prompt references for artifact-specific details.
