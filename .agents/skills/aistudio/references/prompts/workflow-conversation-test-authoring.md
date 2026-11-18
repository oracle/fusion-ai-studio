# Workflow Conversation Test Authoring

This guidance extends `workflow-test-authoring.md`. Follow every existing workflow-test rule unless this file explicitly defines conversation behavior. Conversation tests use the same workflow-test commands, source directory, suite runner, judge attachment, and report hierarchy.

Use this guidance only when the requested test needs at least two ordered interactions, conversation-history or session continuity, or HUMAN/WAIT suspension and resumption. Do not convert a one-invocation custom test into a conversation test merely because the workflow uses a chat trigger. A custom request that evaluates one final response without structural checks belongs to the single-turn contract in `workflow-test-authoring.md`.

You must run `get-workflow-conversation-test-context --file <workflow.wf>` before authoring or repairing a multi-turn or suspended workflow test. Do not generate the definition from the sync-plan summary alone. The command supplies workflow facts, supported suspension points, enabled resume actions, continuation nodes, retry targets, retry limits, and explicit unsupported topology reasons. You decide the conversation goal, messages, resume sequence, assertions, replay data, and selective judge contracts from that bounded context. Do not derive messages from workflow or node names.

Preserve every exact chat message and structured input supplied in the current user request. Run profiles and sync-plan suggestions are seeds for missing turns, not authority to rewrite authored conversation steps. A current step path binding proves only that step's exact input, current workflow definition, replay data, and preceding conversation prefix. If one step input changes, rerun or record that step and every dependent suffix step; do not invalidate or rewrite an unchanged prefix. Apply the same rule to custom and sync-plan conversation tests. This is an execution-evidence rule and does not require persisted input-origin metadata.

Every conversation definition must include explicit scenario provenance; the CLI rejects a missing `scenario` or `scenario.custom`. When actively satisfying an interaction returned by `conversationCoverage.missingInteractions`, find the same interaction in the conversation context's `requiredInteractions`, copy its `scenarioId` exactly, and use `scenario.custom: false`, `scenario.source: "sync-plan"`, and `scenario.kind: "conversation"`. Supply a concise business `scenario.intent`, but never invent or rewrite the scenario ID. Use `scenario.custom: true` and `scenario.source: "user"` for an explicitly user-requested standalone conversation journey, even when parts of that journey overlap automatic coverage. Custom conversation scenarios do not carry an id or kind.

Persist one workflow test with `conversation.mode: "scripted"` and at least two ordered interaction steps. Give every step a stable, descriptive, user-facing `stepId` with at least two meaningful lowercase kebab-case words, such as `request-topic-readiness`, `resume-after-initial-wait`, or `report-readiness-timeout`. The ID appears throughout reports and must describe that step's business interaction or outcome. Never use opaque shorthand or ordinal placeholders such as `q`, `a`, `r1`, `step-1`, or `turn-2`. Give every step a clear business `intent`, deterministic output assertions, required `pathAssertions`, required `executionAssertions`, an optional judge, and step-scoped test data. For a pending `record-now` or `record-later` step, author only route anchors known from the requested interaction and deliberate exclusions supported by workflow evidence. Do not classify every omitted node as `mustNotExecute`. Live recording always lets the workflow execute naturally. A sync-plan recording can finalize its provisional route from observed evidence; a custom recording preserves the user's authored route and reports any mismatch without rewriting that contract. A ready model-generated step must still classify every assertable node exactly once. A `chat` step has `input`. A `resume` step has `resume.waitStepId`, `resume.action`, and feedback `content` only when the action is `feedback`. `contextStepIds` identifies prior steps relevant to judging and data lineage. It never changes execution order or permits a later step to run after invalid runtime state.

The custom single-turn path-assertion relaxation does not apply to conversation steps. A custom conversation test may let authoring and live recording derive the route, so the user does not need to supply node lists manually, but every persisted ready step must retain its path and execution contracts for step-scoped replay binding and continuation validation. Never remove those contracts to create a final-response-only conversation artifact.

Apply the named-assertion rules from `workflow-test-authoring.md` to every new conversation assertion. Use one artifact-wide unique ID and a short business-facing name for output, path, node, semantic rubric, expected wait, execution order, node count, and wait lifecycle assertions. Every new or changed step-level or conversation-level semantic rubric item must include `id`, `name`, and `criterion`; never use numbered placeholders such as `Semantic criterion 1` or `Criterion 2`. Human-facing reports show the name and keep the ID internal. When the user asks to rename, strengthen, or remove a visible check, read the current test, resolve the name within its conversation step and assertion category, and preserve the matching ID. If the name is still ambiguous, ask which step or check the user means. Existing legacy string and unnamed conversation assertions remain valid and must not be rewritten during unrelated updates.

When the current active user request explicitly requests an AI-unit budget, place `aiUnitAssertions` at the test root, not on individual conversation steps, and pass `--ai-unit-assertion-intent explicit-user-request`. The budget covers the aggregate model usage of the complete scripted conversation and is evaluated once after all executed steps. Do not infer a conversation budget from earlier turns, prior tests, reports, or ordinary sync-plan regeneration. Follow the defaults, authorization, preservation, and lifecycle rules in `workflow-test-authoring.md`.

Do not use a bare number such as `"4"` in `assertions.contains`. Use a context-bearing phrase such as `"4 instructions"`, exact whole-output equality when the complete response is numeric, or a step-level `nodeAssertion` with a numeric or collection operator.

Author `executionAssertions.orderedNodeCodes` as the smallest meaningful ordered subsequence for that interaction phase. Include repeated node codes when repeated execution is the behavior under test. Add exact, minimum, or maximum `nodeCounts` only where count is meaningful. For a reference-block child, use step-level or conversation-level `referenceNodeCounts` with `callerNodeCode` and child `nodeCode`; this distinguishes separate callers of the same reusable block without persisting `referenceBlockCode`. For HUMAN and WAIT conversation tests, counts are meaningful for suspension nodes, retry targets, and terminal continuation nodes; do not leave all count collections empty when a step proves one of those behaviors. Use `exact: 1` when the node should execute once in that step, and use `waitLifecycles` for conversation-total retry counts instead of duplicating those totals. Do not list every runtime plumbing event. The CLI records the complete observed order and counts, compares them mechanically, and reports the first divergence.

Treat a suspension as a retry lifecycle only when its context entry has `loopBackNodeCode`. Copy that value to `retryTargetNodeCode` and copy `maxIterations` to `configuredRetryLimit`; never infer either value from names, messages, or expressions. A retry lifecycle must declare one initial attempt, the authored retry count, suspension and resumption counts, and the expected exhaustion state. Every expected wait in that lifecycle must declare zero-based `expectedCurrentIterationCount` and `expectedMaxIteration`. A suspension with no `loopBackNodeCode` is one-shot: omit retry target, retry limit, initial-attempt, and retry-count fields. The report displays those metrics as N/A.

A chat step that is expected to suspend must declare `expectedWait` with the exact HUMAN or WAIT node code, node type, CHAT channel for HUMAN, and the actions this test intends to use. A later resume step must reference that chat or resume step by `waitStepId`. Every non-final expected wait must be resumed; the final step may intentionally end at an asserted suspension when the waiting-state response is the business outcome under test. Use `approve`, `reject`, or `feedback` for CHAT HUMAN and `timeout` for WAIT. ATLAS maps those values to the runtime resume protocol; never persist a runtime job ID, callback token, message instance ID, or conversation ID in the test file.

Use this interaction shape inside the normal conversation test definition:

```json
{
  "conversation": {
    "mode": "scripted",
    "goal": "Verify a submitted request continues after approval.",
    "steps": [
      {
        "stepId": "submit-request",
        "type": "chat",
        "intent": "Submit the request.",
        "input": { "message": "Submit my request for approval.", "messageSource": "model-derived" },
        "expectedWait": {
          "id": "request-awaits-review",
          "name": "Request waits for manager review",
          "nodeCode": "REVIEW_REQUEST",
          "nodeType": "HUMAN",
          "channelType": "CHAT",
          "allowedActions": ["approve"]
        },
        "assertions": { "contains": [], "notContains": [] },
        "pathAssertions": {
          "mustExecute": [{ "id": "review-request-reached", "name": "Review request is reached", "nodeCode": "REVIEW_REQUEST" }],
          "mustNotExecute": [
            { "id": "approval-not-yet-returned", "name": "Approval response is not returned yet", "nodeCode": "RETURN_APPROVED" },
            { "id": "rejection-not-yet-returned", "name": "Rejection response is not returned yet", "nodeCode": "RETURN_REJECTED" }
          ]
        },
        "executionAssertions": {
          "orderedNodeCodes": { "id": "submission-node-order", "name": "Submission reaches review in order", "nodeCodes": ["REVIEW_REQUEST"] },
          "nodeCounts": { "REVIEW_REQUEST": { "id": "single-review-suspension", "name": "Review suspends once", "exact": 1 } }
        },
        "testData": { "status": "pending", "capturePolicy": "record-later", "nodes": {} }
      },
      {
        "stepId": "approve-request",
        "type": "resume",
        "intent": "Approve the pending request.",
        "contextStepIds": ["submit-request"],
        "resume": { "waitStepId": "submit-request", "action": "approve" },
        "assertions": {
          "contains": [{ "id": "approval-confirmed", "name": "Approval is confirmed", "value": "approved" }],
          "notContains": []
        },
        "pathAssertions": {
          "mustExecute": [{ "id": "approval-response-returned", "name": "Approval response is returned", "nodeCode": "RETURN_APPROVED" }],
          "mustNotExecute": [
            { "id": "review-does-not-repeat", "name": "Review does not repeat", "nodeCode": "REVIEW_REQUEST" },
            { "id": "rejection-response-skipped", "name": "Rejection response is skipped", "nodeCode": "RETURN_REJECTED" }
          ]
        },
        "executionAssertions": {
          "orderedNodeCodes": { "id": "approval-node-order", "name": "Approval response follows the resume", "nodeCodes": ["RETURN_APPROVED"] },
          "nodeCounts": { "RETURN_APPROVED": { "id": "single-approval-response", "name": "Approval response is returned once", "exact": 1 } }
        },
        "testData": { "status": "pending", "capturePolicy": "record-later", "nodes": {} }
      }
    ],
    "executionAssertions": {
      "waitLifecycles": [{
        "id": "manager-review-lifecycle",
        "name": "Manager review suspends and resumes once",
        "waitNodeCode": "REVIEW_REQUEST",
        "expectedSuspensions": 1,
        "expectedResumptions": 1
      }]
    }
  }
}
```

For HUMAN approval coverage, create separate conversation tests for approve and reject so each outcome remains independently understandable and reportable. When feedback is enabled, use a feedback resume with business-relevant content, expect the HUMAN node to wait again, then add the next resume action. For action variants that share the same initial message, pre-suspension path, and HUMAN node, author and validate one representative test first. Reuse that test's exact initial input, step-scoped test data, path assertions, execution order, and node counts in the other variants; change only the resume sequence and action-specific assertions or judges. Use different initial data only when the business scenario intentionally requires it. Never copy `pathBinding` between files: each test must establish its own current binding through deterministic file replay. Stop at the authored maximum useful exchange; do not fabricate retries beyond the workflow's exposed iteration contract. For WAIT, resume with `timeout` immediately in the test runner. Tests never sleep for the configured wall-clock duration. A context entry with `loopBackNodeCode` and `maxIterations: 2` means one initial target-node attempt plus at most two retries. Author expected wait iterations 0, 1, and 2 when the test proves exhaustion.

For a detailed user request, preserve each supplied message exactly, including whitespace and line breaks, and set definition-only `input.messageSource` to `user-provided`. For a message you synthesize from a broad business goal, set it to `model-derived`; keep it user-facing and exclude internal prompts, assertions, judge text, and test data. The CLI removes `messageSource` before writing the test file. Fill only missing metadata. Ask the user only for missing secrets, environment values, or required business identifiers.

Treat a pending conversation route as a model hypothesis until live recording validates it. If a model-derived message reaches the wrong route, use the observed path and conversation context to revise that message, with at most two total recording attempts for the scenario. After the second mismatch, stop retrying, preserve the evidence, and report the scenario as unable to generate or blocked. Never rewrite a user-provided message to force another route. Report the mismatch against that exact message and ask the user whether the scenario or workflow behavior should change.

If conversation recording returns `needs-route-review`, read the exact route review request and resolve only its named step. Run its exact `judgeContextCommand` for that observed step. For `proven-semantic`, replace the step judge for the reported owners. For `model-review-required`, provide `judgeOwnership.steps.<stepId>` with `source: model-decision` and replace the step judge only when `judgeable` is true. For `not-semantic`, use deterministic step evaluation and do not retain stale semantic judging. The model then chooses `retry-input` with a materially different model-derived step input, or `accept-observed` with one complete replacement conversation whose target step contains the observed path and refreshed output, node, execution, and evaluation contracts. Preserve every other step and all conversation ordering, context, HUMAN, WAIT, feedback, and resume contracts. Never rewrite a user-provided message, silently weaken a custom expectation, or copy the internal review payload into the test file. After the update, restart recording from step 1 so runtime conversation state is rebuilt consistently.

When history or conversation variables matter, include a behavioral continuity proof. A later message must rely on a stable fact supplied only in an earlier step, without repeating that fact, and its assertion or judge must verify correct use. For cache behavior, also assert the cache path and non-execution of the original recordable fetch. ATLAS has no direct runtime history-load signal, so describe a failed proof as a probable conversation-state restoration problem, not confirmed history-load telemetry.

Use literal assertions only for stable values available from authored input or deterministic replay evidence. A terminal step must have meaningful deterministic output assertions, a semantic judge, or both. Waiting phases can rely on wait, path, order, and count assertions when they produce no terminal output. Use a step or conversation judge for dynamic references, pronoun resolution, and semantic continuity. Never invent `${step...}` or `{{step...}}` placeholders.

Ground every model-derived output or node assertion in the current recording evidence. For an intermediate node assertion, retrieve the full node contract when needed, inspect the recorded node value, select the correct occurrence, and use a JSON Pointer relative to the selected input or output. Use `decode: "json"` or `decode: "json-array-items"` only when the recorded value is serialized JSON. Match operators to the selected value type: string and array containment only, collection length operators only, and object key operators only. Do not apply `contains` to a whole object or invent a path or expected value that is absent from the recording.

Run every ordinary chat step with the same conversation identity and no `jobId`. A resume step uses only the suspended runtime state established by its referenced `expectedWait` step. A retry restarts the complete sequence from step 1 with a fresh identity. Live retries repeat earlier BO, REST, workflow, and other side-effecting calls. Use a suitable non-production environment or file/model-generated fixtures when repetition is unacceptable. Do not add an approval pause after the user has requested recording.

Review `possibleSideEffectNodes` from the conversation context before live recording. These are conservative warnings based on operation metadata, not automatic blockers. Tell the user which possible write or business-action nodes will run, avoid unnecessary re-recording, and include executed warnings in the result. Do not silently replace requested live recording with synthetic data.

Continue after output, node, path, execution-order, execution-count, or semantic judge failures when the runtime still returned valid conversation state. These are evaluation failures, not runtime controls. Halt later steps only after runtime or authentication errors, missing replay fixtures or replay bindings, unexpected suspension, expected-wait contract failure, or invalid or consumed resume state. Mark remaining dependent steps `skipped-due-to-dependency`. Continue unrelated test files in the suite.

Recording uses one conversation identity for all steps and writes step-scoped fixtures. Persist fixtures only for recordable nodes that actually executed in that step. Preserve each recorded node input exactly; compact or synthesize the response without replacing a resolved input with `null` or a different identifier. The same node may have different fixtures in different steps. A recordable child inside a reference block uses the shared caller-scoped `testData.referenceNodes` contract in that step; preserve both `callerNodeCode` and child `nodeCode` through coordinated preparation. When any step needs compaction or generated data, prepare one coordinated payload keyed by `stepId`, preserve cross-turn identifiers and relationships, and apply the complete payload atomically. File replay must never fall through to a live recordable node that lacks a fixture for the current step.

If recording returns `needs-assertion-review`, the runtime route and replay data were captured but one or more output, node, path, order, or count assertions conflict with live evidence. Read the returned assertion review artifact and current test data. For a sync-plan test, repair only unsupported model-authored assertions. For a custom test, preserve the user's exact messages and business expectations; surface a genuine expectation mismatch instead of weakening it or replacing it with the observed route. Run deterministic file replay after an approved assertion correction. Do not re-record solely to change an assertion.

When `conversationCoverage.pendingReplayValidation` includes `testDataContinuation`, live recording has already completed. Do not record the conversation again. Read its exact `requestPath`, prepare all step fixtures as one coordinated payload, write only to `temporaryTestDataPath`, and run the exact `applyCommand`. After coordinated data is applied, follow the exact next action returned by `do-apply-workflow-test-data`: run one deterministic file replay with `--refresh-conversation-path-bindings`. The sync plan keeps `conversationCoverage` in `replay-validation-required` while any step lacks a current file-replay binding. A successful recording or binding refresh replaces the authored prediction with the complete observed path partition: executed assertable nodes become `mustExecute`, and every other assertable node becomes `mustNotExecute`. Preserve the existing path assertion `id` and `name` when a node remains in the same bucket; create a new identity only for a newly observed node or a node that changes buckets. The CLI writes path bindings only when every path, execution-order, execution-count, HUMAN or WAIT lifecycle, and output check passes. Do not author, repair, or copy `pathBinding` manually. Never change the workflow to accept a test-specific replay shape; repair the test data or report the replay defect.

When file replay reports `conversationReplayPathDrift`, keep the recorded `mustExecute` and `mustNotExecute` contract unchanged. Compare the named failed nodes with the live recording evidence, repair replay data or report a runtime replay defect, and do not relax the path merely to make the file run pass.

Author judges selectively from terminal output ownership, not from the presence of an upstream semantic node. Apply the shared ownership statuses from `workflow-test-authoring.md` independently to every completed step. Clear semantic ownership is automatic. For a `model-review-required` step, send its bounded decision under `judgeOwnership.steps.<stepId>` and include a step judge only when `judgeable` is true. A step ending in an expected HUMAN or WAIT suspension is `unsupported-suspension` even when an LLM or AGENT ran earlier: its runtime final output is a suspension marker, and the waiting-state `initialMessage` is not a supported judge target. Cover suspension steps with deterministic output, path, suspension, resumption, order, and count assertions.

Set `defaults.evaluationMode` to `hybrid` when at least one completed step has proven or model-selected semantic ownership. Add an overall conversation judge only when at least one step exposes such an output and the goal requires cross-turn semantic evaluation. When aggregate ownership is ambiguous, send the bounded decision under `judgeOwnership.conversation`; the CLI persists only compact judge provenance, including the judged step IDs. Hybrid enables semantic evaluation for the conversation; it does not require a judge on every eligible step. The same test-level `authoring.evaluationOverride` contract applies to custom and sync-plan conversation tests. Never infer it: honor it only when the user explicitly requests deterministic, hybrid, or semantic-focused evaluation and supplies meaningful intent. A CLI `--evaluation-mode deterministic` run is only a transient replay and path-validation pass for an already hybrid conversation test. Local judging returns one composite result bundle and attaches it once.

Conversation tests remain distinct source artifacts and are listed and run by normal workflow suites. The workflow sync plan reports HUMAN/WAIT requirements under `conversationCoverage`; it suppresses invalid single-turn substitutes for those suspension paths and considers coverage complete only when the required node/action interactions are represented. Read `conversationCoverage.contextCommand`, then let the model author the smallest useful conversation for `missingInteractions`. The CLI must not infer business messages or assertions from node names.

Support is intentionally limited to root workflow CHAT HUMAN and root workflow WAIT nodes. Do not author HUMAN or WAIT workflow tests for EMAIL channels, APPROVAL_PROCESS, nested workflow jobs, PARALLEL branches, or HUMAN/WAIT nodes inside LOOP or WHILE containers. Report the `suspensionPoints.supportReason` instead of guessing. This support applies to workflow tests, not app panel tests.

Natural-language edits replace the complete `conversation` object and identify steps by `stepId`, never array index. Read the current test first, preserve unchanged steps, and send `mode: "scripted"` plus the full steps array. When renaming a step, update every matching `contextStepIds` and `resume.waitStepId` reference in that same definition. Do not send partial array patches or include `workflow` in the update definition. Do not convert an existing single-turn file in place; create the intended conversation test separately.
