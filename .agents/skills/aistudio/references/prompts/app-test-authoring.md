# App Test Authoring

Use this reference after creating or materially editing an Agentic App. App tests validate the app panel contract, not only the backing workflow.

## When To Run App Test Sync

After a successful app create or material app edit, finish the complete app authoring transaction and validate or save it. When the app has at least one top-level agent container, automatically run the complete app sync loop: synchronize every affected generated test for its backing workflows, execute and judge those workflow tests, synchronize the generated panel tests, execute and judge the app suite, and present `Validation and Insights`. Do not ask for a separate test-synchronization approval. Preserve custom workflow and app tests unchanged. If the user explicitly asks to skip, defer, preview, inspect, or only report test impact, run the plan read-only and stop without mutating or executing tests.

Run:

```text
node .agents/skills/aistudio/scripts/aistudio.js get-app-test-sync-plan --file <app-file>
```

Mode and scope selection matter. A completed app create or material edit defaults to app-wide automatic execution. A user request to show, inspect, preview, display, or get the app test sync plan is read-only: run only `get-app-test-sync-plan --file <app-file>` and stop after explaining it. Do not run backing workflow sync, `do-sync-app-tests`, app test generation, app test runs, or judge attachment for an explicit preview request.

For an execution request, determine scope from the current user request before acting:

- **App-wide execution:** use this only when the user asks for the app itself, the complete app test sync plan, all panels, or all app tests. Complete every required backing workflow loop, materialize every listed app create or update action, run `do-sync-app-tests`, and finish with `get-app-test-final-summary --file <app-file>`.
- **Targeted workflow-and-panel execution:** use this when the user names one panel, one app test, or one backing workflow together with its panel. Complete only that backing workflow's sync loop and the matching app-panel action. Run only the matching app test with `run-app-test --test-file <target-app-test>`, attach only its judge result when needed, and present only the targeted workflow and panel outcome. Do not call `do-sync-app-tests` or `get-app-test-final-summary` for this scope.
- **Workflow-only execution:** when the user names only a workflow and does not request its app panel, follow `workflow-test-authoring.md` and do not run app commands.

Use `synchronizationKind` for generated app and backing-workflow update actions. Execute `evidence-refresh` actions by rerunning the existing test with path-binding refresh enabled; preserve all contract fields. Execute `contract-update` actions through the normal scoped update flow, changing only fields justified by the drift codes. Never rewrite custom tests. For app panel tests, file replay is the default evidence source; use live execution only when runtime validation or recording is required. App tests remain single-turn panel contracts. Scripted multi-turn behavior belongs to their backing workflow tests and follows the workflow conversation rules.

Automatic app test synchronization may use fresh completed reports for a read-only Economic Health evaluation. It must never create, rewrite, rebaseline, or change an app or workflow Economic Profile, accepted outcome volume, allocation policy, baseline, or control-plane allocation. Preserve every Economic Setup or Economic Health recommendation for explicit user action.

The word `complete` does not widen an explicitly named workflow-and-panel request. For example, `complete the sync for Alpha Team Performance Review Planner and its panel` is targeted; `complete the sync for Alpha Team Performance Command Center` is app-wide.

Scope examples:

- `Run the complete app sync for Alpha Team Performance Command Center` is app-wide.
- `Regenerate Alpha Team Performance Review Planner and its panel test` is targeted.
- `Run the Performance Review Planner panel test` is targeted.
- `Run all panel tests` is app-wide.

In app-wide execution mode, an app plan that lists `Required backing workflow sync loops`, reports non-zero backing workflow missing or out-of-sync actions, or prints a `Required command` is an instruction to make the next tool call. In targeted execution mode, select only the matching backing-workflow and panel actions from that plan; unrelated actions remain outside the request and do not block targeted completion. Do not answer with a progress summary or pending counts for work inside the selected scope. Continue its action-driven loop until no selected executable action remains or a concrete blocker prevents progress.

If the sync plan returns only `NO_CONTAINERS`, stop and report that the app shell has no testable panels yet. Do not fabricate app tests for an empty app shell. App tests start once the app has a top-level agent container wired to a workflow.

## What App Tests Prove

Phase 1 app tests target `InitDisplay` for each top-level app panel.

They prove:

- the selected app panel resolves to the intended workflow agent
- the workflow has an `InitDisplay` app-stage route
- the debug request uses the app-stage input shape
- required path assertions execute for that app-stage route
- recordable workflow nodes can replay from stored data in file mode
- returned `oraInfoDisplay` widgets match the panel's stored widget contract
- malformed widget JSON is treated as a deterministic failure

They do not replace workflow tests. Workflow tests still cover workflow-level branches, Query/Summary app-stage paths, and boundary scenarios.

## Test Files

App tests are JSON files.

Legacy layout:

```text
test/apps/<app-code-folder>/<test-name>.json
```

App-package layout:

```text
app-pkg/<package>/tests/ai/self/<module-name>/applications/<app-code-folder>/<test-name>.json
```

The app code folder follows workflow test folder style: use the lowercased artifact code folder name and preserve underscores. Example:

```text
FABS_ANNUAL_TEAM_PERFORMANCE_DASHBOARD -> fabs_annual_team_performance_dashboard
```

There is no panel directory level. The panel segment is stored in JSON metadata and used in the test name, reports, and filters.

App test JSON must not depend on app or workflow source file paths, app versions, workflow versions, or runtime status. The stable identities are `app.appCode`, `panel.containerId` or `panel.panelId`, and `workflow.workflowCode`. File paths, current versions, runtime status, and app agent keys belong in command output and reports, not in the source-controlled test definition.

Use optional root-level `aiUnitAssertions` for an app test only when the current active user request explicitly asks for an AI-unit budget, cost guardrail, reporting threshold, or CI gate. Earlier conversation turns, existing or deleted tests, reports, runtime metrics, optimization work, and ordinary app sync do not authorize a budget. Pass `--ai-unit-assertion-intent explicit-user-request` only to add, change, or remove a budget requested in the current operation. Never use that option to bypass an authorization error during ordinary app test generation; remove accidental budget metadata and retry without it. Preserve an existing budget during unrelated updates by omitting `aiUnitAssertions`. Use the same shape, defaults, preservation, removal, evaluation, and missing-evidence rules as workflow tests; do not create app-specific budget metadata. The budget measures the backing workflow execution for that app-panel test. It does not replace widget, path, node, output, or semantic assertions and must not suppress judging.

App tests use the same local AI-unit overage analysis continuation as workflow tests. After local app judge attachment is complete, prepare and attach analysis only for individual app reports whose configured budget was exceeded. If local app judge attachment returns one or more `aiUnitAnalysisRequest` entries, complete every returned request before the final summary or next package. Use each returned request, result, and attach path directly instead of calling the prepare command again. Never do this for absent or passing budgets, remote judge runs, or CI/FABS runs, and never rerun the app test or suite after analysis attachment.

App Economic Profiles use the same resource-level schema and lifecycle as workflow profiles and remain separate from per-test `aiUnitAssertions`. The accepted app profile is the exact reserved file `economic-profile.json` beside the owning app tests, for example `test/apps/<app-code>/economic-profile.json` or the equivalent module-scoped `applications/<app-code>/economic-profile.json`. Backing workflow evidence may come from another module, but the profile remains app-owned. Never treat the reserved file as an app test or use `economic-profile` as a test name. Create one only on an explicit user request. Start with `get-economic-profile-authoring-context --file <app-file>`. A new profile defaults to fresh measurement. The phrases "fresh", "brand new", "from scratch", "recreate", and "fresh regression run with rebaselining" also require `measurementPolicy: "fresh"`. An ordinary review of an existing profile defaults to `reuse-current`; honor an explicit request to use current or existing evidence. Preserve the exact fresh-cycle `evidenceNotBefore` returned by authoring context. App panel tests validate display contracts and are not economic evidence. Define each production outcome as an app interaction backed by one or more representative AI-consuming tests from the app's locally available backing workflows. Positive authoritative runtime AI Unit evidence remains eligible without node attribution, but it must be labeled runtime-metered rather than model-backed and must not support node optimization claims. Set `invocationsPerInteraction` for every workflow contribution so an interaction that calls several workflows, or calls one workflow repeatedly, includes that fan-out. Classify unused backing-workflow tests with a reason. Explicit user volumes take precedence. When planning is delegated without traffic evidence, distribute exactly 1,000 total monthly app interactions across selected outcomes and explain the split; do not treat that number as 1,000 workflow invocations. Use an available control-plane allocation for a new profile. User-defined and model-recommended allocations are provisional fallbacks only when the control plane is missing or unsupported. Never change accepted outcome selection, fan-out, or volume without explicit user intent.

Before assigning app production volumes, inspect the app's top-level `pageConfig.agentContainers` and the containers rendered by its layout. Treat every rendered top-level panel as eagerly initialized unless explicit app configuration or authoritative runtime evidence proves that the panel is lazy, conditional, or user-triggered. Model eager startup as one composite app-opening production outcome, not as separate panel-opening outcomes. Its existing `backingWorkflowOutcomes` array must include the representative `init-display` test for every eager panel's backing workflow with `invocationsPerInteraction: 1`. When the same workflow and `init-display` route backs multiple eager panels, set `invocationsPerInteraction` to the number of those panel invocations instead of counting the workflow once. Assign one monthly app-opening volume to the composite outcome; never give eager top-level `init-display` routes different model-recommended volumes. Keep Query, Summary, and other user-triggered operations as separate outcomes. The delegated 1,000 total remains the sum of app interactions across production outcomes, while workflow invocations may exceed 1,000 because the composite app-opening outcome fans out. Show that startup fan-out explicitly in the Representative Outcomes table and rationale. Use different initialization volumes only when the proposal cites the concrete lazy or conditional evidence. Represent this rule with the existing `backingWorkflowOutcomes` and `invocationsPerInteraction` fields; do not introduce new profile metadata.

When `Economic Setup` reports `ECONOMIC PROFILE NOT CONFIGURED`, a user request to proceed starts the complete app Economic Profile proposal flow. If the same advisory says the control-plane allocation is missing, expired, stopped, or unavailable, do not satisfy that request with a standalone allocation recommendation based on existing reports. Collect the proposal's required fresh replay and live backing-workflow measurements first, account for app interaction fan-out, project production usage, and then present the resulting control-plane allocation option for explicit approval. For a supported API with a missing, expired, or stopped allocation, selecting the proposal action is proposal approval only and never authorizes a control-plane mutation. Follow the separate control-plane confirmation state below; only the final explicit yes immediately following that compact confirmation authorizes the ordered transaction to update the control plane, verify the dashboard readback, create the app profile from the verified response, and continue baseline establishment. Use the standalone allocation command only when the user explicitly asks to manage allocation without creating a profile.

Before presenting an app Economic Profile for approval, run `get-economic-profile-creation-proposal` with the complete draft and the exact measurement policy and cutoff returned by authoring context. While `measurementPlan.actions` is nonempty, do not present `summaryText` and do not stop. Execute every replay and live action sequentially against its named backing workflow test, complete required semantic judging, then run the exact `measurementPlan.regenerateCommand`. Shared backing workflow tests appear once even when multiple app outcomes reference them. A current-cycle replay failure is terminal for that attempt: still complete the corresponding live attempt, then let the regenerated proposal move the complete app outcome into the existing `excludedTests` array as a temporary coverage exclusion. Never loop on the same failed replay. A provisional app profile is approvable only when its passing outcomes cover at least 70% of planned app interaction volume. Present the exact app interaction volume, backing workflow fan-out, replay and live evidence, allocation authority, projected usage, and budget fit only after measurement actions are complete. Wait for explicit approval before saving.

Before saving, write the complete proposed app profile only under its namespaced `.debug/atlas` directory and run `get-economic-profile-creation-proposal --file <app-file> --profile @<draft-profile>`. Authoring context and draft calculations are discovery only. Follow the returned `guidanceNextStep`: present a compact, faithful version of the latest proposal, beginning with `**Economic Profile Proposal:**` as bold, normal-size body text. Preserve every section, material value, mode distinction, required acknowledgement, allocation-period operation, the complete Representative Outcomes table, every Outcome Planning Rationale entry, and every available choice while removing repetitive prose. Never turn the title into a Markdown heading. Never display fingerprints, receipts, or command fields. Stop for explicit proposal approval. Proposal approval and control-plane confirmation are two separate conversational states. State 1 is proposal approval: when the user selects any proposal choice that changes the control plane, including a response such as `Approve the allocation and create the profile`, treat that response only as selection of the proposed action. Present only the matching compact `confirmation.controlPlaneChange` summary. Stop without running `applyAndCreateCommand`, `applyOnlyCommand`, or any other mutating command. State 2 is control-plane confirmation: ask a direct confirmation question after that compact summary and wait for a new user response. Run the selected apply command only when the immediately preceding assistant message was that compact confirmation and the immediately following user response explicitly confirms it. Never carry proposal approval forward as control-plane confirmation, infer confirmation from wording used to select a proposal choice, or combine both states in one user response. If this adjacency check is not satisfied, display the compact confirmation and stop. Use `applyAndCreateCommand` for the combined update-and-create request and `applyOnlyCommand` when the user requested allocation only. The allocation-only command leaves the app profile unchanged and returns a separate compact profile-creation confirmation. If post-update economics materially change, show only the returned deltas and ask again. When no control-plane change is involved, use the exact `confirmation.saveCommand` immediately after proposal approval without adding a second confirmation. Do not reconstruct arguments. A failed or mismatched update leaves the profile absent or unchanged. Then continue the economic regression plan without rerunning the evidence just collected for the proposal. Never create a profile first and disclose its allocation, outcome selection, or volumes afterward.

Keep control-plane API availability separate from allocation state. Classify observations as active, future, expired, stopped, missing, unusable, unsupported, or unavailable. A zero allocation inside an active interval keeps that interval for an approved update unless the control plane explicitly marks it `NO_ALLOCATION`; that state receives a new period. Preserve a future configured interval unless the user explicitly replaces it. An expired, stopped, missing, `NO_ALLOCATION`, or unusable interval receives a proposed period beginning on the current local date, using fixed lengths of 1, 7, 30, or 365 days. Display proposal dates in the user's local timezone while keeping API and persisted timestamps in UTC.

Persist one top-level `allocationPolicy` shared by live and file evaluation. Preserve an existing policy unless the user explicitly approves a change. For a new profile, use only an active normalized control-plane allocation as existing authority. Expired and stopped values are historical context. When the API is supported but allocation is missing, expired, stopped, or an explicitly proposed active-period value differs, calculate the recommendation from the representative app projection with at least 20% headroom above projected usage and enough capacity to remain below the first warning threshold. Show the exact dated update and let the approved save apply and verify it before writing the profile. Use a user-defined fallback only when explicitly supplied. Use a visible model-recommended fallback only when the API is unavailable or unsupported and planning was delegated. Never put budgets under `economicModes`. The control plane owns allocation and enforcement. Allocation-only operations do not change the profile. `get-economic-regression-plan` performs a non-mutating allocation preflight and reports drift or recommends an explicit switch; all verdicts continue to use the profile's persisted allocation until an explicitly approved profile refresh is completed.

File replay and live execution retain independent accepted baselines. Live results compare directly with the persisted allocation. File results translate each current replay outcome to production-equivalent economics using accepted outcome-level live/replay evidence and compare the translated total with the same allocation. Replay reports derive a transient Replay mode budget and an exact replay-normalized current projection for mode-native presentation; neither is persisted as a second allocation. For an explicit app Economic Regression Test request with no mode, omit `--data-source` on the initial plan call. Execute every profile-selected backing workflow test in the file `executionScope` phase exactly once, refresh with `--data-source file`, and follow `nextAction` until the replay report exists. Then execute every selected test in the live phase exactly once, refresh with `--data-source live`, and follow `nextAction` until the live report exists. Finally refresh the default both-mode plan and complete evaluation or baseline actions, without rerunning either phase, until both reports are current; a newly accepted live baseline may require the replay report to be recalculated. For an explicit file or live request, pass that exact mode, execute its single phase once, and complete only that report. Do not re-execute an `executionScope` phase while refreshing its plan. A passing execution that proves no AI-consuming node ran is valid `verified-zero-consumption` evidence. When `nextAction.action` is `resolve-live-evidence`, inspect the failed live diagnostic, passing replay evidence, replay metering coverage, and comparable live-to-replay ratio supplied by the plan. Choose `ratio-adjusted-replay` when replay passed with complete metering, the live failure is only an environment-state or path mismatch, and a comparable ratio exists; choose `replay-proxy` under the same conditions when no ratio exists. Use `model-estimate` only when supplied evidence supports a grounded nonnegative estimate and neither direct replay option is suitable. Immediately call the exact `do-resolve-economic-live-evidence` command with a concise rationale and confidence, refresh the plan, and continue from its new `nextAction`; do not stop at an interim blocked summary. Stop only when replay also fails, the live diagnostic exposes a real app, workflow, assertion, or replay defect, or required evidence is missing. Never remove the outcome or reduce its production volume merely because the live environment cannot reproduce its state. Preserve accepted baselines during ordinary edits and require explicit rebaseline after the user reviews measured change impact. Detailed economic reports remain at the app resource report directory. The generic package test runner adds compact Economic Profile gate results and report links to package and FABS summaries; it never runs local model analysis in CI.

When an app Economic Profile exists, app panel tests remain presentation checks and do not become economic evidence. Economic Health for the app is built only from the backing-workflow tests selected by its profile, including their invocation fan-out. An ordinary app-scoped backing-workflow run evaluates only the mode that just ran. It generates a full app comparison when every selected reference is fresh and an incremental comparison when only selected references are fresh, using accepted baseline evidence for untouched outcomes. It never runs the other mode implicitly. Failed, missing, wrong-mode, or pending-judge profile evidence must produce `Action Required: Economic Regression Evidence Incomplete` and must not expose an older report as current. The app sync plan treats every backing workflow's blocking canonical-suite or judge-attachment continuation as unfinished work even when its test-definition action count is zero. A changed app, backing workflow, selected production outcome, or representative backing-workflow test contract makes the accepted app economic comparison out of date. Preserve the returned `Action Required: Economic Validation Out of Date` or economic-impact block prominently with its action label in bold, normal-size body text rather than a Markdown heading, synchronize the affected backing workflow tests, and offer the exact prompt for an explicit fresh file replay and live execution economic cycle. Do not rebaseline or mutate the profile or allocation without the user's request and approval. For unchanged contracts, use the persisted allocation and matching baseline without refreshing the dashboard or mutating either one. Preserve the material CLI-returned `Economic Health` content: keep live execution and file replay metrics in their separate bold mode sections, retain the single bold action-required line for warnings or failures, and do not merge the mode results. Optimization analysis and Model Optimization Sweep remain explicit follow-up actions and never use remote judging.

Economic budget calculations use fixed planning periods of 1, 7, 30, and 365 days for daily, weekly, monthly, and yearly budgets. Round AI units and utilization up to whole numbers. A new model-recommended app proposal must remain below its first warning threshold before it can be approved. Baseline establishment preserves the approved allocation. If accepted evidence differs materially from proposal evidence, report it and recommend an explicitly approved profile revision instead of rewriting the allocation automatically.

Utilization warnings are an ordered list of one to three percentages. Preserve every usable percentage returned by the control plane, including a partial list; do not invent missing levels. For user-defined or model-recommended policies, preserve explicitly requested levels. When no usable warning percentage exists, use the single ATLAS default of 80%. Budget exhaustion always begins at 100%, independently of warning configuration. `evaluationPolicy.enforcement: "warn"` is an advisory CI economic gate that reports findings without changing the command exit; `"fail"` makes an Economic Regression Test status of FAILED fail the command.

Generated app tests use the same model-agnostic metadata vocabulary as workflow tests:

```json
{
  "scenario": {
    "custom": false,
    "source": "sync-plan",
    "id": "APP_CODE:panel-container:InitDisplay",
    "kind": "app-panel",
    "intent": "Verify the panel InitDisplay response and widget contract.",
    "appStage": "InitDisplay"
  },
  "app": { "appCode": "APP_CODE" },
  "panel": {
    "containerId": "panel-container",
    "title": "Panel title",
    "pathSegment": "panel_title",
    "displayPromptHash": "..."
  },
  "workflow": { "workflowCode": "WORKFLOW_CODE" },
  "authoring": {
    "source": "model-authored",
    "createdAt": "...",
    "userPrompt": "What this test verifies"
  },
  "widgetAssertions": {
    "source": "panel-widget-list",
    "allowedLayoutIds": [],
    "allowedPatternIds": [],
    "requiredPatternIds": [],
    "forbiddenPatternIds": []
  }
}
```

Do not write obsolete top-level `scenarioKind` or `appStage`, `agent`, `authoring.createdBy`, panel-level widget lists, or `expectedWorkflowLayoutIds`. A custom test uses `scenario.custom: true`, `scenario.source: "user"`, and an optional `scenario.intent`; its test name is user-owned identity. Keep `scenario.appStage` equal to the app-stage value encoded by `input.parameters.appHint` or legacy `input.parameters.OraMessageHint`.

## Panel And Test Naming

Generated init display tests use:

```text
init_display_<panel_segment>
```

Panel segment precedence:

1. normalized panel title
2. normalized panel id
3. normalized container id

Normalize by trimming, lowercasing, replacing non-alphanumeric runs with `_`, collapsing repeated `_`, and trimming leading/trailing `_`.

If sibling panels collide, suffix every member of the collision group with `__<last-8-container-id-chars>`.

## Sync Loop

Before step 1, finish app and workflow authoring. Complete every pending node, edge, panel, agent-reference, prompt, input, and metadata change; validate every created or materially changed workflow and the app; then save or normalize each changed DRAFT once. Do not request an app or workflow test sync plan while authoring or repair commands are still in progress. Test plans must describe the final validated artifact definitions, not an intermediate graph.

1. Run `get-app-test-sync-plan --file <app-file>` to discover the app panels and referenced backing workflow files.
2. For app-wide execution, process every workflow listed under `Required backing workflow sync loops` or `Required app-related workflow coverage` sequentially in the app plan's order. For targeted workflow-and-panel execution, process only the explicitly named backing workflow and ignore unrelated workflow actions for this request. Never request plans, generate tests, record data, run tests, or judge results for two backing workflows concurrently. Within a workflow, issue at most one mutating generate, update, record, apply, or save command at a time; never start a second command for the same test or workflow artifact while the first is running. Complete each selected workflow through the single-action Sync Execution Contract in `workflow-test-authoring.md`: execute each focused authoring action, complete its required data work, validate that affected test deterministically, and immediately refresh with `get-workflow-test-sync-plan --recommended-batch-only true --format focused-json`. When the plan reports `validation-required`, run its exact canonical suite command. When it reports `judge-attachment-required`, complete and attach its local judge results once. Refresh after each state and move to the next workflow only when the latest plan reports `finalSummaryAllowed: true`. Use the suite report rebuilt by attachment directly and do not run a separate full deterministic suite or confirmation suite. In app-wide scope, move to the next workflow only after that completion or after recording a concrete unrecoverable primary blocker for the current workflow. This means all selected executable actions and canonical validation are accounted for, not that every generated test passed. A completed failing test is reported and does not trigger repeated full-suite runs. Selected workflows listed under `Current backing workflow sync loops` or `Current app-related workflow coverage` are already current; do not rerun their suites to prove completion.

Passing or failing one test, completing one workflow phase, having pending selected workflow or app tests, substantial elapsed time, an estimate that little execution time or context remains, or useful partial progress do not complete the selected execution scope. A Codex task that starts a selected app sync scope owns that scope until its completion condition is met or a concrete blocker prevents the next action. Do not switch that task to an unrelated app or workflow while recording, model compaction, apply, validation, judging, or plan refresh remains in the selected scope. Parallel Codex tasks may process different artifacts because CLI scratch paths are artifact-scoped; each task must still complete its own selected scope before changing artifacts. For app-wide execution, return control only after the app final summary is available. For targeted workflow-and-panel execution, return control only after the selected workflow suite and selected app test are complete and their targeted reports are current. A concrete command, authentication, missing-file, or required-input failure may prevent the next selected action; the user may also explicitly ask to stop. Keep any host-required progress update concise and continue with the next tool call rather than turning it into a partial handoff.

Every auxiliary workflow or app context payload and every internal model-work request inherits this ownership rule. Complete its requested review, local judge, or analysis, run the returned attach command when present, and resume the owning app or workflow plan. Never treat an auxiliary payload as permission to stop or provide the final response.

When the app plan prints a required workflow command inside the selected scope, execute it instead of handing it to the user. If a selected backing workflow was newly created or materially changed, save and normalize it once before its test loop. The confirmed app authoring transaction authorizes this prerequisite without another save prompt, even when the remote DRAFT does not exist yet. Do not save it again for test generation, judging, report refresh, or a completed suite unless the workflow itself changed afterward. Preserve normal confirmation for a newer remote DRAFT and stop on authentication or backend failures. An explicit preview, local-only, defer, or skip request does not authorize the save. Record concrete unrecoverable workflow failures under that workflow with the failed scenario, observed fallback or command failure, dependent pending tests, and corrective action. Continue the next independent backing workflow only in app-wide scope.

Workflow app-stage input and test-data decisions belong to `workflow-test-authoring.md`. Preserve trigger envelopes, provide meaningful stage-specific semantic input, and do not treat an empty Query message as semantic Query coverage unless the test explicitly targets empty-message smoke behavior. After the backing workflow sync completes, refresh the app plan. When its app-panel action supplies a current live-proven backing workflow `suggestedInput`, pass that exact value as the app test definition input so the panel and backing workflow use the same invocation. If the selected action still reports unresolved `inputDependencies`, do not create an empty app test shell: complete the backing workflow input from the user request or bounded routing context, or ask for the missing value. Existing app test input remains authoritative during unrelated updates. Do not create workflow tests from app panel names, titles, widgets, or app test names; those contracts belong under `test/apps`. In app-wide scope, cover every required workflow and supported app-stage action rather than stopping after the first workflow, InitDisplay coverage, or workflows that already have app tests. In targeted scope, cover every required scenario for the selected workflow and only the matching panel action.

When a backing workflow app-stage route traverses a supported LOOP, keep the normal app-stage scenario and follow its `scenario.coverage.loopReplay` facet from `workflow-test-authoring.md`. Boundary replay belongs to the existing app-stage workflow test. A resolved PARALLEL route can contribute multiple LOOP boundaries to that one contract; do not create one app-stage test per branch. Generate only the dedicated single-iteration LOOP-internals scenario selected by the workflow sync plan; do not multiply LOOP tests across panels or app stages.

For the app panel test on that same InitDisplay route, preserve the normal `app-panel` scenario and its `appStage`; LOOP coverage remains a `scenario.coverage` facet. Use `boundary-output` only. During app recording, capture the complete output of every listed LOOP boundary, including boundaries from separate resolved PARALLEL branches, and exclude recordable descendants inside those LOOPs from app `testData.nodes`. Preserve complete under-budget raw LOOP evidence exactly. If a LOOP boundary or correlated source response exceeds its budget, use the emitted workflow-backed consistency group to compact every mutable artifact together without changing unrelated raw evidence. During file replay, require the deterministic `loopReplayBinding` check before judging widgets or semantic usefulness. Do not create an additional app-level single-iteration test; LOOP internals are covered by the workflow test selected by the workflow sync plan.
3. Before live app runtime execution for a newly created or materially changed app, save and normalize the app DRAFT once with `do-save-app --file <app.app>`. The confirmed app authoring transaction authorizes this runtime prerequisite without another save prompt. Do not save every backing workflow as a routine app-sync preflight. Workflow saves belong to the workflow sync loop before workflow test generation/recording/runs when the workflow was newly created or materially changed, and to the workflow debug runner's safe `FAI-40300` recovery path. Do not overwrite a newer remote DRAFT without the normal version safety checks, and do not save for an explicit preview, local-only, defer, or skip request.

App-test scratch definitions and model-authored judge definitions must be written inside the owning artifact and test directory. Use `.debug/atlas/apps/<app>/<test>/...` in legacy workspaces and `.debug/atlas/app-packages/<package>/<module>/applications/<app>/<test>/...` in app-package workspaces. Use `applications`, not `apps`, in the app-package hierarchy. Transient recording, masking, and judge files must use the exact operation-scoped paths returned by the CLI.
During ATLAS app-test authoring, do not create a top-level `.authoring` directory or keep duplicate test definitions, judge repairs, or prepared test data outside the owning `.debug/atlas/...` namespace. Remove ad hoc test helper files after the owning command succeeds. Keep operation evidence only while its test is failed, interrupted, or awaiting judge work. This rule does not govern general app or workflow authoring scratch files.
4. Materialize app `create` or `update` actions inside the selected scope after their selected backing workflow actions are complete. Read `judgeAuthoringContext.ownership.status` for every selected action. For `proven-semantic`, author the judge directly. For `model-review-required`, make one bounded decision from the supplied path and node context, pass transient `judgeOwnership` with `source: "model-decision"`, and include a judge only when `judgeable` is true. Do not delegate clear terminal semantic ownership back to the model, and do not treat an unrelated upstream semantic node as proof that it owns the panel response. When a judge is required, author only `judge.minimumScore`, `judge.expectedOutcome`, and `judge.rubric` from the scenario intent, widget contract, selected semantic owners, grounding nodes, and LOOP boundary nodes when present. Every new or changed rubric item must be an object with a stable lowercase kebab-case `id`, a concise business-facing `name`, and its `criterion`; never use numbered placeholders such as `Semantic criterion 1` or `Criterion 2`. Keep `judge.expectedOutcome` and `judge.rubric` logically equivalent. Before authoring them, make an internal inventory of mandatory final-output requirements from the scenario intent, user request, effective panel display prompt, widget contract, and explicit output contract. Treat contributing terminal semantic-node prompts and system prompts as supporting implementation context, not independent authority for adding mandatory final-output requirements. Map every mandatory requirement to both the expected outcome and exactly one rubric criterion; the rubric must neither weaken nor strengthen that requirement. Keep each rubric criterion atomic and independently judgeable. Do not combine grounding, unsupported-claim avoidance, evidence-gap handling, recommendation quality, or other distinct obligations into one criterion. Preserve conjunction and alternatives exactly; the rubric must preserve `and` versus `or`, so an outcome requiring `A and B` cannot be represented by a criterion allowing `A or B`. Preserve conditional requirements as conditional: require evidence gaps to be identified when supplied evidence has gaps, but do not require an explicit no-gap statement unless the user-facing contract explicitly requires a status statement even when none exist. Do not turn general internal prompt guidance into an unconditional final-output requirement. Before calling the generate or update command, verify internally that each rubric criterion has a required source and a matching expected-outcome requirement. Do not persist this authoring checklist in the test file. Apply this rule when creating or explicitly refreshing a judge contract; preserve an existing judge during unrelated updates. Pass that compact judge definition to `do-generate-app-test` or `do-update-app-test`. Do not author `judge.authoring`, scenario identity, app stage, panel identity, workflow identity, path assertions, or widget assertions merely to satisfy judge authoring; the CLI owns and injects that structural metadata and judge provenance. For LOOP boundary app tests, require the judged final response to remain grounded in the recorded complete LOOP output as well as the widget contract. Do not use the generic fallback judge when model authoring context is available. Rerun the app sync plan after materializing the selected actions to confirm those actions are current; unrelated app actions do not block targeted completion.

For judge grounding, treat the scenario invocation as authoritative trigger evidence and recorded nodes or LOOP boundaries as replay evidence. Do not claim recorded-data grounding when `judgeAuthoringContext.grounding` identifies no replay source.

Honor an app evaluation override only when the user explicitly requests it and supplies meaningful assertion or judge intent. Persist `authoring.evaluationOverride` with `source: "explicit-user"` and mode `deterministic`, `hybrid`, or `semantic-focused`; never infer it during normal app sync. Deterministic overrides keep widget, path, node, and output checks but disable semantic judging. Hybrid and semantic-focused overrides require a substantive judge; semantic-focused omits model-generated final-output assertions while preserving structural app checks. Use `judgeOwnership.source: "explicit-user"` only when that explicit semantic override also requires an ownership selection.

For **app-wide execution**, run `do-sync-app-tests --file <app-file>` only after the latest app plan has no remaining required backing workflow actions or continuations and no app create or update action remains. Accounted workflow test failures and deferred scenarios may remain in reports, but they do not replace this reconciliation check. A defensive `authoring-required` response means semantic actions were skipped: execute its listed `do-generate-app-test` or `do-update-app-test` continuations, refresh the plan, and continue without asking the user. `do-sync-app-tests` does not generate, record, or run workflow tests. When the resulting app suite has pending local judge requests, read every exact judge request path returned by the CLI, write `judge-result.json` beside its request, and attach all results once with `do-attach-app-test-judge-results`; judge attachment refreshes the app-scoped app suite and app-scoped consolidated report, so do not rerun the suite. After the app suite and any judge attachment are complete, run `get-app-test-final-summary --file <app-file> --format json` exactly once. Compose the final response with your concise creation, update, or run summary first, then add a section named exactly `Validation and Insights` based on `summaryText`. The command output is authoritative evidence, not mandatory prose: you may compact and deduplicate it, but you must preserve all material meaning and render every `requiredReportLinks` entry exactly once. This includes the app-scoped consolidated report, app-scoped app suite report, and every backing workflow suite report. Within each summary preserve Test Summary first, conditional `Action Required`, conditional `Metrics:`, `Optimization:`, conditional `Economic Setup:`, and conditional `Economic Health` in that order. Section content is data-driven and may contain multiple concise lines. Do not add diagnostic token telemetry or a complete-coverage recap that the command omitted. Preserve the Economic Setup block's exact bold action or advisory line and suggested natural-language prompt, and never execute it automatically. Test synchronization actions have precedence; do not add or infer Economic Setup work while the app summary is incomplete. Never substitute a workspace-wide aggregate report for either app-scoped report unless the user explicitly requested workspace-wide or package-wide test results. Preserve compact issue and next-step guidance when present. All test and report details belong under `Validation and Insights`, not in the creation summary. Do not return the `do-sync-app-tests` marked block as the final user-facing answer. If `get-app-test-final-summary` fails, report that command failure and the exact command instead of writing a substitute validation summary.

For **targeted workflow-and-panel execution**, never call `do-sync-app-tests`. If the matching app test needs recording, run `do-record-app-test-data --test-file <target-app-test>` directly and complete any `needs-model-test-data` continuation with `do-apply-app-test-data`. Then run `run-app-test --test-file <target-app-test>` without overriding its configured evaluation mode or the default local judge provider. If the targeted run needs a local judge result, read its exact judge request path, write `judge-result.json` beside that request, and attach it with `do-attach-app-test-judge-results --report-path <target-result.json> --result-path <target-judge-result.json> --cleanup-scratch true`. Both `run-app-test` and targeted judge attachment refresh the individual app report, app suite, and app-scoped consolidated report from existing results; they do not execute unrelated app or workflow tests. Do not run a confirmation app suite afterward.

For either scope, a recording result with `status: needs-model-test-data` is not complete. If an app sync update includes `testDataContinuation`, live recording has already completed; do not call `do-record-app-test-data` again. Read its exact `requestPath`, copy `replayDataPayloadTemplate` exactly, write the prepared payload only to `temporaryTestDataPath`, and run the exact `applyCommand`. Otherwise use the recording result's `testDataRequestPath` and `temporaryTestDataPath`. Fill every node or LOOP artifact named by `consistencyGroups`. Treat each group as one atomic data decision so source collections, LOOP outputs, identifiers, counts, and parent-child relationships remain coherent. Preserve every `rawArtifactsToPreserve` entry exactly and never add artifact codes outside the template. Do not create another raw scratch file or put raw values in command arguments, logs, reports, or judge files. The apply command removes the managed operation after success or failure. Do not invent a fallback scratch path. Never copy a backend-truncated `.....` preview into testData. In app-wide scope, if `do-sync-app-tests` returns `status: recording-required` with `pendingTestData`, execute every printed `do-record-app-test-data` command and rerun `do-sync-app-tests` after every listed test has ready and validated test data. In targeted scope, record and apply only the matching app test, then run that test directly. Do not rerun backing workflow suites, resave workflows, or return control merely because selected app test recording or model compaction is pending. Treat the selected flow as blocked only after an attempted app recording, compaction, or apply operation fails for a concrete reason.

If app recording returns `needs-route-review`, read the exact `routeReviewRequestPath` and resolve it before continuing app sync. Run its exact `judgeContextCommand` for the observed workflow route. For `proven-semantic`, replace the judge for the reported owners. For `model-review-required`, provide `judgeOwnership` with `source: model-decision` and replace the judge only when `judgeable` is true. For `not-semantic`, use deterministic evaluation and do not retain stale semantic judging. The model decides whether the successful observed route still satisfies the panel scenario and widget contract. Use `retry-input` with materially different app input when it does not. Use `accept-observed` only for an ATLAS-managed provisional route, and submit one complete `do-update-app-test` definition containing the request fingerprint, observed path, output assertions, node assertions, execution assertions, widget assertions, and evaluation contract. Preserve the app stage, panel identity, LOOP coverage, and other protected scenario constraints. Record that app test once more after the update; do not run unrelated app or backing workflow suites while this continuation is pending.
5. For each selected app `create` action, run `do-generate-app-test --file <app-file> --panel-segment <panelSegment> --data-capture-policy record-later --definition @<judge-definition-file>`. Omit `--definition` only when the action needs neither a model-authored judge nor an explicit evaluation override.
6. For each selected app `update` action, run `do-update-app-test --file <app-file> --test-file <testFile> --definition @<judge-definition-file>` when refreshing its semantic judge contract or applying an explicit evaluation override. An unrelated explicit edit may omit the judge and preserves the existing judge unchanged.

Apply the named-assertion identity rules from `workflow-test-authoring.md` to app output, path, node, widget, and semantic assertions. Human-facing reports show concise assertion names and keep machine IDs in structured test and result JSON. When a user refers to a visible assertion name, read the current app test, resolve that name within its assertion category plus panel, widget, or node context, preserve the matching ID, and update only that assertion. If the name remains ambiguous, ask which visible check the user means. Never replace an assertion ID merely because the user referenced its report name.

App tests use the same optional root-level `executionAssertions` contract and evaluator as ordinary workflow tests. Add meaningful `nodeCounts` or caller-scoped `referenceNodeCounts` only when the user request or panel scenario makes execution multiplicity part of the contract; do not add them to every app sync-plan test. Preserve existing counts during unrelated updates, use concise named assertions, and use `executionAssertions: null` only for an explicit removal request. The individual app report shows these checks after Widget Assertions and before Path Assertions. Do not add count details to app suite, module, package, or consolidated reports.
7. For each selected app `review` action, stop and report the review reason. Do not rename or overwrite custom tests automatically.
8. During manual app-test authoring or repair, or during targeted workflow-and-panel execution, validate only the affected test. A transient deterministic run may be used before the final configured-mode targeted run. This does not apply to an ordinary direct suite request or post-judge confirmation:

```text
node .agents/skills/aistudio/scripts/aistudio.js run-app-test --test-file <target-app-test> --data-source file --evaluation-mode deterministic
```

9. Repair app, workflow, test data, path assertions, or widget expectations based on deterministic failures.
10. Run a final app suite without overriding evaluation mode only for app-wide execution when `do-sync-app-tests` is not being used or failed before producing app reports. Never run this suite for targeted workflow-and-panel execution:

```text
node .agents/skills/aistudio/scripts/aistudio.js run-app-tests --app-code <APP_CODE>
```

11. For app-wide execution, if local app judge requests are produced, create every matching judge result JSON file and attach them once:

```text
node .agents/skills/aistudio/scripts/aistudio.js do-attach-app-test-judge-results --report-root-dir test-reports/apps --app-code <app-code> --cleanup-scratch true
```

Use app-package report roots when the CLI prints package-local paths.

In a multi-module app package, omit `--modulename` from a package-wide app suite so every module is discovered. Attach pending local app judge results separately for each module using that module's application report root together with the exact app-package and module selectors printed by the CLI. A module with no app tests is an accounted skip. The attachment command refreshes the module reports and package aggregate from existing results, so do not run a confirmation app suite to propagate judge status.

For app-wide execution, run `get-app-test-final-summary --file <app-file>` after judge attachment and use that command output as evidence for the final response section named exactly `Validation and Insights`. For targeted workflow-and-panel execution, use the selected workflow's `get-workflow-test-final-summary --file <workflow-file>` result plus the targeted `run-app-test` result and individual app report; do not call the app-wide final-summary command. Judge attachment already refreshes parent reports in either scope. Do not rerun `do-sync-app-tests`, an app suite, or workflow suites merely to refresh status or summary text.

For a direct test request spanning multiple app packages, follow the local-judge package sequence in the Direct Suite Execution section of `workflow-test-authoring.md`. File mode changes only the data source. Do not override evaluation mode, and do not run a deterministic confirmation suite after app judge attachment.

## Pre-App-Sync Gate

This gate applies only to app-wide execution. Before running `do-sync-app-tests`, read the latest app sync plan and reconcile every backing workflow. For each workflow, retain its code, file, latest sync-plan state, and current suite report. A required workflow is accounted only when its latest workflow plan reports `finalSummaryAllowed: true` with no create or update action in `coverageExecution.nextActionIds` and its final suite is current for the unchanged workflow and test state. Current workflows remain current without another suite run. If any required workflow still has an action, unfinished continuation, or stale or missing final suite, resume that workflow's sequential loop; do not run app sync yet. A targeted workflow-and-panel request reconciles only the selected workflow and does not use this app-wide gate.

Do not treat `Ready panels` in the app sync plan as permission to run app sync while backing workflow actions remain missing or out of sync. `Ready panels` only means app panel test definitions can exist; it does not mean backing workflow coverage is complete. Do not treat existing pending app test files as progress that replaces workflow sync. Do not ask the user to run the printed workflow commands; execute them yourself unless blocked by authentication, remote conflict, destructive action approval, explicit synthetic-data approval, missing live data, invalid workflow or app runtime behavior, or another concrete blocker.

If `do-sync-app-tests` reports incomplete backing workflow sync, refresh the app plan, resume the first required workflow's authoritative focused action, validate only the affected test, and continue the sequential workflow loop. Do not try to clear the gate by repeatedly running workflow suites while create or update actions remain. A workflow suite becomes stale only when the workflow, a test definition, or test data changed after its last valid run; judge attachment refreshes reports and does not require another suite run. Do not run both `run-workflow-tests --workflow-code <workflow-code>` and `run-workflow-tests --app-file <app-file>` for the same gate, and never use an app-scoped workflow suite to clear it. Use `--app-file` only for an explicit app-scoped workflow-suite request or a user-requested multi-workflow model comparison.

## Final Response Checkpoint

Before answering the user after an app test flow, verify the final response includes a concise action summary followed by a section named exactly `Validation and Insights`. For app-wide execution, base that section on `summaryText` from the latest `get-app-test-final-summary --file <app-file> --format json` output and render every `requiredReportLinks` entry exactly once. For targeted workflow-and-panel execution, base it on the selected workflow final summary plus the targeted app test result and individual report; include only the selected workflow and panel counts and do not enumerate unrelated panel tests or backing workflow suites. For app creation or app modification, the action summary may include app and workflow names, file paths, panels created, and implemented behavior. For existing-app test generation, summarize only the test refresh work. For run-only requests, summarize what was run and do not use creation language. Preserve conditional `Action Required` before conditional `Metrics:` and `Optimization:`. When the final-summary command returns an `Economic Setup:` block, preserve its material summary, exact bold action or advisory line, and suggested natural-language prompt inside `Validation and Insights`; do not execute it automatically. When it returns an `Economic Health` block for an existing profile, preserve its allocation, scope, gate status, projection, regression, utilization, driver, and actions as its own subsection instead of mechanically rebuilding that summary. Do not duplicate test counts, report links, conditional `Metrics:`, `Optimization:`, economic-profile guidance, Economic Health, or next steps outside `Validation and Insights`.

Before returning the final response, scan the authoritative final-summary `summaryText` for the literal `Economic Setup:` and `Economic Health` section labels. Maintain a final section checklist covering Test Summary, report links, conditional `Action Required`, conditional `Metrics:`, `Optimization:`, conditional `Economic Setup:`, and conditional `Economic Health`. Every conditional section present in `summaryText` is non-droppable and must appear exactly once as its own bold, normal-size subsection under `Validation and Insights`, even when surrounding prose is compacted. Do not finish with `Metrics:` or `Optimization:` while dropping a returned economic section. Never reconstruct an economic section that the authoritative final summary omitted.

If a concrete primary blocker prevents app-suite creation or leaves no valid final-summary artifact, do not omit the outcome or fabricate report data. Use the latest app and workflow sync plans to state which workflows were completed, which primary scenario failed, the observed fallback or command failure, which dependent workflow or app tests remain pending, and one natural-language corrective action. Preserve any valid suite links, metrics, and optimization information that does exist for independent completed workflows.

## Reports

App test runs write the same three report formats as workflow tests:

```text
result.json
result.md
result.html
suite-result.json
suite-result.md
suite-result.html
```

App reports should foreground app-specific signal: widget assertions, panel contract, returned widgets, judge result, deterministic app checks, final output, and then workflow path diagnostics. Path assertions remain useful, but they are secondary in app reports.

After final backing workflow and app suites run for one app, use that app's scoped consolidated report:

```text
test-reports/apps/<app-code>/consolidated-suite-result.html
```

Use the app-scoped app suite for panel-test-only results:

```text
test-reports/apps/<app-code>/suite-result.html
```

For app-package layout, use the package-local app-scoped application suite and consolidated report paths printed by the CLI. Workspace-wide package reports are for explicit package-wide test requests only.

## Final Summary Rules

After app-wide `do-sync-app-tests`, an app-wide `run-app-tests`, or an app-package test run for one app, use `get-app-test-final-summary --file <app-file> --format json` as the authoritative evidence source for the final section named exactly `Validation and Insights`. Compose the final app-facing response yourself, with creation, update, refresh, or run information first when applicable. You may compact and deduplicate `summaryText`, but preserve all material meaning and render every `requiredReportLinks` entry exactly once. Do not drop app test counts, conditional `Action Required`, conditional `Metrics:`, `Optimization:`, or any conditional `Economic Setup:` or `Economic Health` section returned by the command. Never expose raw orchestration fields such as `finalSummaryAllowed`, `syncLoopState`, `requiredContinuation`, `coverageExecution.nextActionIds`, command fields, fingerprints, or receipt paths in the user-facing response. Do not invent omitted sections, diagnostic token telemetry, or a complete-coverage recap. Preserve Economic Setup action lines exactly and do not execute them automatically. Do not include or substitute workspace-wide reports unless the user explicitly requested workspace-wide or package-wide results. Preserve compact issue and next-step guidance when present. Do not wrap the section in a fenced code block and do not hand assemble metrics from report JSON.

After targeted workflow-and-panel execution, do not call `get-app-test-final-summary` because it is app-wide. Present the selected workflow's summary and suite report plus the targeted app test status and individual HTML report. Parent app suite and consolidated reports may be refreshed and linked when useful, but do not present their app-wide counts as the targeted execution count and do not list unrelated backing workflows or panel tests.

When app-wide app and workflow suites ran, `get-app-test-final-summary` must include the app-scoped app suite, the app-scoped consolidated report, and every backing workflow from the app sync plan. If it reports blockers or unavailable Metrics/Optimization, present those lines from the command output. Do not collapse multiple workflow sections into one blob. Do not turn bare directory paths (paths without a file extension, such as `test/apps/my_app` or `test/workflows/my_workflow`) into Markdown links. Only report files ending in `.html`, `.json`, or `.md` should be linked in final summaries.

Do not add a separate `Backing workflow suite reports` list when each workflow subsection already includes its own report link. Keep the app-scoped consolidated report and app-scoped app suite report at the app level; keep each workflow suite report inside that workflow's subsection.

Do not drop an `Optimization:` section because tests passed or because optimization was mentioned earlier. Preserve each `Suggested prompt:` action and make it workflow-specific when presenting a multi-workflow app summary. Replace ambiguous text such as `this workflow` with the bold workflow name from that subsection, for example `Run the model optimization sweep for Delta Team Calibration Intelligence`. If multiple backing workflows have optimization available, show separate next actions per workflow. If the user later asks only to run `the optimization sweep` and multiple workflows are eligible, ask which workflow unless the prior user prompt clearly named one. If the user asks to run it for all backing workflows, run sweeps one workflow at a time.

An app-wide final response is incomplete if it omits app test counts, the app-scoped consolidated or app-scoped app suite report links, any backing workflow's suite report, `Optimization:`, or any conditional section actually returned by the final-summary command. A targeted workflow-and-panel response is incomplete if it omits the selected workflow's test count and suite report or the selected app test's status and individual report. `appSuite.summaryText` is app-suite evidence only; it is not the authoritative final app-flow validation summary.

If the app suite passed, do not add unrelated caveats about git status, pre-existing untracked files, or sync-plan churn unless the CLI summary or report says user action is required. Report those only when they block the test run or require a follow-up decision.

If app tests run in hybrid mode and produce pending judge requests, create and attach the app judge results before the final user response unless a real blocker prevents judging. After attachment, use the refreshed app suite and consolidated report statuses. Do not quote the pre-attachment `needs-judge` status as the final result.

## Widget Expectations

Generation and sync derive widget expectations in this order:

1. nonempty panel or agent `displayWidgetList` or init display widget override
2. terminal workflow node `aiAppOutputSpecification.dataDisplay.layouts`
3. no widget contract

At run time, validation uses the stored `widgetAssertions.source`, `allowedLayoutIds`, `allowedPatternIds`, `requiredPatternIds`, and `forbiddenPatternIds` in the test JSON. It does not recompute expectations from the app or workflow during the run.

If both panel widget list and workflow terminal layouts are absent, the app test can still run but widget validation falls back to structural checks only.

## Tags

App test tags follow workflow test tag behavior.

- Creation: `do-generate-app-test --tags smoke,regression`
- Update add: `do-update-app-test --add-tags regression`
- Update remove: `do-update-app-test --remove-tags smoke`
- Update replace: `do-update-app-test --tags release-upgrade`

Tags are user-owned metadata. Preserve existing tags unless the user explicitly asks to change them.

## Economic Volume Planning

The delegated 1,000 monthly executions are a planning anchor for the whole app profile, not a per-outcome default. Before splitting them, inspect each candidate's test definition, scenario intent, scenario kind, app stage, invocation behavior, and production role. Form a usage hypothesis such as panel openings per session, follow-up queries, summaries, or actions. Allocate the total according to that hypothesis and state the assumptions and confidence in each outcome's `volumeRationale`. Do not mechanically favor `InitDisplay` or any other named stage.

In the final model-written summary, distinguish the persisted production allocation, live projection, measured file replay projection, outcome-translated production-equivalent projection, and derived Replay mode budget. In a replay evaluation, lead with the Replay budget projection, accepted replay baseline, Replay mode budget, replay utilization, and replay headroom. Present production allocation evidence second. Never present these values as interchangeable.

## Recorded Data Masking

App tests use the same named profiles, deterministic replacement, LOOP handling, compaction boundary, and replay validation as workflow tests. Do not create app-specific masking logic. Inspect `existingProfiles` before creating a profile, and reuse the backing workflow's suitable profile instead of creating an app-specific or differently named duplicate. When the user names fields, treat that list as authoritative and do not add similarly named fields or semantic variants. When the user supplies only business categories, resolve them to the smallest applicable concrete field set. Only when no field scope is supplied may you infer sensitive fields from available schemas. Reference the same named profile in every generated app test definition before `do-record-app-test-data`. Do not broaden an existing profile unless the user explicitly asks to change masking scope.

For a request that creates, changes, or reuses masking, finish profile setup before requesting an app or backing-workflow sync plan that may load tests referencing it. Inspect masking context and `existingProfiles`, reuse or create the profile, and only then request the sync plan. Do not parallelize masking-profile setup with sync-plan commands. This sequencing rule does not apply to ordinary unmasked app sync.

A profile rule may be absent from one panel or scenario. Preserve the profile reference and continue; never fabricate marker fields or alter replay data merely to create a match. A selected field identifies sensitive source values; replacing those values consistently in downstream locations does not broaden the profile scope. Partial model-data application may update only the requested nodes while preserving already masked values elsewhere. Use `do-mask-test-data --profile <name> --dry-run true` only for existing raw app test data that has never been masked, and let the command validate deterministic file replay before accepting the change. If an applied profile changed, use a two-step refresh: first update only the profile reference so the CLI clears old replay data, then record fresh app test data separately. Never submit old test data in the profile-changing update or mask existing replacement values again. Preserve app, panel, scenario, widget, path, and authoring metadata; only explicitly selected invocation or replay data and related assertion or judge text may change.

## Command Reference

Use these commands for app tests:

- `get-app-test-context --file <app-file>`
- `get-app-test-sync-plan --file <app-file>`
- `list-app-tests --app-code <APP_CODE>`
- `do-generate-app-test --file <app-file> --panel-segment <segment> --data-capture-policy record-later`
- `do-update-app-test --file <app-file> --test-file <test-file>`
- `do-record-app-test-data --test-file <test-file>`
- `do-apply-app-test-data --test-file <test-file> --test-data @<file> --cleanup-scratch true` (use the recording result's exact `temporaryTestDataPath` when present)
- `get-test-data-masking-context --test-file <test-file>`
- `do-mask-test-data --test-file <test-file> --profile <profile-name> --cleanup-scratch true`
- `run-app-test --test-file <test-file>`
- `run-app-tests --app-code <APP_CODE>`
- `do-attach-app-test-judge-results --report-root-dir <app-report-root> --app-code <app-code> --cleanup-scratch true`

Do not run bare `run-app-tests` for a focused app request unless the user explicitly asks for all app tests in the workspace.
