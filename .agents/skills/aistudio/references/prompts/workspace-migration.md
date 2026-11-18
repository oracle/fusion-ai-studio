# Legacy Workspace To App Package Migration

Use this reference when the user asks to copy, move, merge, or migrate AI Studio artifacts from a legacy workspace into a source-controlled app package and module. This is a local source-control migration. It does not publish, save, delete, or otherwise change remote AI Studio artifacts.

## Scope Boundary

Only supported AI Studio artifact files recursively contained under the legacy workspace's top-level `src/` directory, and supported ATLAS files recursively contained under its top-level `test/` directory, are eligible for migration. Ignore every other source path, even when it appears related to AI Studio.

- Recursively skip every file or directory whose name starts with `.`, including dot-prefixed paths inside `src/` or `test/`.
- Skip temporary files, scaffolding, generated output, reports, caches, logs, archives, screenshots, editor state, dependencies, and build output.
- Do not copy root files such as `package.json`, lock files, `env.properties`, shell scripts, README files, CI/CD files, or workspace configuration.
- Do not copy anything merely because another artifact references it. Report a dependency outside `src/` or `test/` instead of expanding migration scope.
- Skip unrecognized files under `src/` or `test/` and account for them in the final summary. Do not copy an unknown extension or directory as a presumed AI Studio artifact.

## Required Inputs

Resolve these values from the current request before changing files:

- Legacy workspace root.
- Destination repository root.
- Destination app package.
- Destination module.

If the request supplies all four, proceed without asking for internal folder names. If one is missing or multiple packages or modules make the destination ambiguous, ask one targeted question. Never select a package or module from directory order, display-name similarity, prior turns, or existing unrelated artifacts.

## Preflight

1. Verify the source is a legacy workspace: it has source-controlled AI Studio content under `src/` and no app package marker that owns those artifacts.
2. Verify the destination package through `<package>/sources/app-package.json`. The package may live under `app-pkg/` or directly under the destination repository root.
3. Verify the named module under `<package>/sources/ai/self/<module>`. If the package exists and the user explicitly named a new module, create only that module's source and test roots. Do not run `init-app-package` over an existing package.
4. Inspect git status in both workspaces. Preserve unrelated changes and never clean, reset, or revert either workspace.
5. Build a complete inventory of supported files under `src/` and `test/` before copying anything. Parse JSON artifacts with structured JSON handling and use the artifact identity described below, not the source filename, to determine destination folders.
6. Build the proposed destination manifest and collision list. Do not write files until every source artifact and test has exactly one destination or an explicit skip reason.

## Migration Behavior

- Copy by default. Do not delete or move the legacy source unless the user explicitly asks for source cleanup after validating the migrated package.
- Preserve artifact codes, IDs, references, specifications, prompts, expressions, and behavior. This is a layout migration, not a workflow or app redesign.
- Preserve code-based cross-artifact references. Do not rewrite workflow, app, BO, tool, topic, agent, or plugin codes merely because files move.
- Normalize only known local source-control representation differences required by the destination layout. Do not perform speculative schema upgrades.
- Keep model judgment focused on artifact identity, dependency mapping, and conflict resolution. Use filesystem and CLI operations only for mechanical reads, writes, and validation.

## Source Mapping

Use `artifact-conventions.md` and the CLI artifact layout as the authoritative path and normalized-shape references. These are all supported source artifact mappings:

| Legacy source | App-package destination under `sources/ai/self/<module>/` |
| --- | --- |
| `src/workflows/**/*.wf` | `workflows/<lowercase-workflow-code>/<file>.wf` |
| `src/apps/**/*.app` | `applications/<lowercase-app-code>/<file>.apps` |
| `src/askOracle/**/*.aoplugin` | `askOracle/<lowercase-plugin-code>/<file>.aoplugin` |
| `src/agents/**/*.agent` | `agents/<lowercase-agent-code>/<file>.agent` |
| `src/signals/**/*.signal` | `signals/<lowercase-signal-code>/<file>.signal` |
| `src/businessObjects/**/*.bo` | `businessObjects/<lowercase-object-code>/<file>.bo` |
| `src/deeplinks/**/*.dl` | `deepLinks/<lowercase-deeplink-code>/<file>.deeplink` |
| `src/topics/**/*.topic` | `topics/<lowercase-topic-code>/<file>.topic` |
| `src/tools/**/*.tool` | `tools/<lowercase-tool-code>/<file>.tool` |
| `src/approvals/**/*.approval` | `approvalProcesses/<lowercase-module-identifier>/<file>.approvalProcess` |
| `src/policies/**/*.policy` | `policies/<lowercase-policy-code>/<file>.policy` |
| `src/policyTemplates/**/*.policyTemplate` | `policyTemplates/<lowercase-template-code>/<file>.policyTemplate` |
| `src/documentSchemas/**/*.documentSchema` | `documentSchemas/<lowercase-schema-code>/<file>.documentSchema` |
| `src/functions/**/*.function` | `functions/<lowercase-function-code>/<file>.function` |
| `src/connectorDefinitions/**/*.connectorDefinition` | `connectorDefinitions/<lowercase-definition-name>/<file>.connectorDefinition` |
| `src/connectorInstances/**/*.connectorInstance` | `connectorInstances/<lowercase-instance-code>/<file>.connectorInstance` |

Derive code folders from the structured artifact identity: `workflowCode`, app `code`, plugin `code`, `agentCode`, signal `code`, `objectCode`, `deepLinkCode`, `topicCode`, `toolCode`, approval `moduleIdentifier`, policy/template/schema/function `code`, connector definition `name`, or connector instance `code`. If a required identity is missing or ambiguous, report the artifact as invalid and do not invent one from its filename.

The only required representation changes are `.app` to `.apps`, `deeplinks` to `deepLinks` with `.dl` to `.deeplink`, and `approvals` to `approvalProcesses` with `.approval` to `.approvalProcess`. Preserve parsed JSON content unless the destination loader requires an established normalized local shape. Do not migrate arbitrary application skill directories from outside the supported legacy artifact files; legacy skill metadata embedded in an application remains part of that application JSON.

## Test Mapping

Copy supported test files found under `test/` while preserving their semantic test contract. Recorded data, assertions, conversation steps, masking metadata, AI-unit assertions, and scenario identity are fields inside those test files; they are not additional migration sources:

| Legacy test source | App-package destination under `tests/ai/self/<module>/` |
| --- | --- |
| `test/workflows/<workflow>/<test>.json` | `workflows/<workflow>/<test>.json` |
| `test/apps/<app>/<test>.json` | `applications/<app>/<test>.json` |
| `test/masking-profiles/<profile>.json` | `masking-profiles/<profile>.json` |

ATLAS has standalone source-controlled test files only for workflows and applications. BOs, tools, topics, agents, plugins, and the other source artifact types are exercised through workflow or app tests; they do not have separate legacy test roots to migrate.

For migrated workflow tests, retain `workflow.workflowCode` and remove a legacy `workflow.file` path only when it points into the old workspace. This is the only permitted test-content cleanup. Do not add `workflow.status` or `workflow.version`. Preserve every other field, including user-authored inputs and all stable assertion metadata. Do not regenerate recorded data merely because the file moved.

## Exclusions

The `src/` and `test/` allowlist already excludes all other workspace content. Within those roots, do not copy generated or machine-local content, including:

- `test-reports/`
- `.debug/`
- `env.properties`
- `.agents/` or `.codex/` installed skill copies
- `node_modules/`
- downloaded skill ZIPs
- temporary logs, caches, screenshots, and build output

Skip every other dot-prefixed, temporary, generated, or scaffolding path even when it is not listed above.

The destination repository owns its package marker, package scripts, ignore rules, branch configuration, and CI/CD configuration. Do not replace them with files from the legacy workspace.

## Collision Rules

- If the destination path is absent, create it.
- If source and destination are semantically identical JSON or byte-identical non-JSON content, report it as already migrated and leave it unchanged.
- If the same canonical artifact code exists at a different destination path, treat that as a collision even when filenames differ.
- If source and destination differ, do not overwrite or mechanically deep-merge them. Present the exact artifact code, both paths, and a concise semantic difference summary. Ask whether to keep destination, replace it, or perform an explicit reviewed merge.
- Never resolve a collision by generating a new artifact code or duplicating the artifact under another name.

## Validation

After copying:

1. Re-inventory the destination and reconcile source counts, copied counts, already-present items, explicit skips, and unresolved collisions.
2. Parse every migrated JSON file.
3. Run the applicable local AI Studio validators for migrated artifacts. Prettify and validate workflows without changing their behavior.
4. Verify every migrated workflow and app is discovered from the selected package and module, and that linked workflow codes resolve within the destination repository or are reported as external dependencies.
5. Verify migrated workflow and app tests load from the package-local test roots. Run read-only sync plans to identify genuine workflow or app drift; do not silently regenerate tests or recorded data as part of the layout migration.
6. Do not run remote saves, publishes, live recording, or test execution unless the user explicitly asks for them and the destination workspace is authenticated.
7. Present a migration summary with source and destination roots, package, module, artifact counts by type, test counts, validation results, collisions, skipped generated files, and remaining actions.

Migration is complete only when every eligible file inventoried under `src/` and `test/` is accounted for and the destination package can discover and validate the migrated content. Do not report success while collisions, parse failures, invalid destination paths, or unresolved local dependencies remain.
