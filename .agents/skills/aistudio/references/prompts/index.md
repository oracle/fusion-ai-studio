# AI Studio Prompt References

Read these files directly from the bundled skill when artifact authoring guidance is needed.
Load only the prompt files relevant to the current task.
For an explicit plugin, application, or workflow save with dependencies, read `artifact-save-with-dependencies.md` completely. Ordinary saves do not cascade.
The packaged CLI is `scripts/aistudio.js`; keep cwd at the project root and run commands by script path, for example `node .agents/skills/aistudio/scripts/aistudio.js <command> ...`. Treat `aistudio <command>` examples as shorthand, do not search PATH for a global executable, and run `init` only when the user explicitly asks to initialize or scaffold a blank project.
For workflow node creation or modification, read `workflow-node-prompts/index.md` and then the relevant node prompt files.
For workflow test authoring, read `workflow-test-authoring.md`.
For scripted multi-turn workflow tests, also read `workflow-conversation-test-authoring.md`.
For app test authoring after app creation or material app edits, read `app-test-authoring.md`.
For app-backed workflow work, read the workflow references plus the app references needed for the app-stage contract.
For Agentic App sample references, read `resources/app-samples/index.md` before opening individual sample files.

- `artifact-save-with-dependencies.md`: Explicit local dependency saves for plugins, applications, and workflows: reference inventory, existing save behavior, ordering, skips, and confirmed outcomes.
- `artifact-conventions.md`: General local artifact file conventions and normalized file shape reminders.
- `workspace-migration.md`: Non-destructive legacy-workspace to app-package migration, mapping, collision, test, and validation guidance.
- `workflow-vibe.md`: Workflow authoring system prompt plus CLI compatibility guidance. For node details, read workflow-node-prompts/index.md and the relevant node prompt files.
- `workflow-debug.md`: Workflow debugger system prompt plus CLI compatibility guidance.
- `workflow-debug-plan.md`: Workflow debugger PLAN-mode prompt.
- `workflow-test-authoring.md`: Workflow test generation, sync, recording, evaluation, reporting, and self-healing guidance.
- `workflow-conversation-test-authoring.md`: Scripted multi-turn workflow test authoring, continuity, recording, replay, judging, and failure guidance.
- `app-test-authoring.md`: App test generation, sync, recording, evaluation, reporting, widget validation, and self-healing guidance.
- `workflow-cli-compat.md`: CLI/tool parity guidance for workflow prompts.
- `business-object-builder.md`: Business Object builder system prompt plus CLI compatibility guidance.
- `business-object-cli-compat.md`: CLI/tool parity guidance for Business Object artifacts.
- `approval-process-builder.md`: Approval-process builder system prompt plus CLI compatibility guidance.
- `approval-process-cli-compat.md`: CLI/tool parity guidance for approval-process prompts.
- `tools-builder.md`: Tools Builder system prompt plus CLI compatibility guidance.
- `tools-cli-compat.md`: CLI/tool parity guidance for Tools Builder prompts.
- `policy-store-builder.md`: Policy Store builder system prompt plus CLI compatibility guidance.
- `policy-store-cli-compat.md`: CLI/tool parity guidance for Policy Store prompts.
- `document-schema-builder.md`: Document Schema builder system prompt plus CLI compatibility guidance.
- `document-schema-cli-compat.md`: CLI/tool parity guidance for Document Schema prompts.
- `function-builder.md`: Function Builder system prompt plus CLI compatibility guidance.
- `function-cli-compat.md`: CLI/tool parity guidance for Function Builder prompts.
- `connector-definition-cli-compat.md`: CLI/tool parity guidance for Connector Definition artifacts.
- `connector-instance-cli-compat.md`: CLI/tool parity guidance for Connector Instance artifacts.
- `app-vibe-master.md`: App Builder master system prompt plus CLI compatibility guidance.
- `app-ingestion.md`: Agentic App intake questions and defaults to use before starting a new app or material redesign.
- `app-best-practices.md`: Agentic App CLI authoring best practices for app structure, workflow contracts, widgets, actions, communications, and validation.
- `fusionclaw-configuration.md`: Fusionclaw autonomous settings guidance for goals, knowledge, capabilities, skills, additional autonomous agents, example tasks, and capability-backed workflow routing.
- `data-extracts.md`: PL/SQL Data Extract app metadata, generated capability, package procedure contract, CLI lifecycle, and verification guidance.
- `ask-oracle-plugin.md`: Ask Oracle plugin lifecycle, linked app/workflow composition, inline skill, draft dependency, capability, and validation guidance.
- `app-vibe-plan.md`: App Builder PLAN-mode system prompt.
- `app-vibe-actions.md`: App Builder actions system prompt.
- `app-vibe-templates.md`: App Builder templates system prompt.
- `app-vibe-widgets.md`: App Builder widgets system prompt.
- `workflow-node-prompts/index.md`: Index of workflow node-specific prompt files.
