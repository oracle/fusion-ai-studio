# Actions (App Builder)

This section defines how **actions** work in the Agentic App Framework app specification, and how to safely add/modify/delete them.

## What an action is

An action is an app-defined workflow that can be invoked by runtime output (e.g. `ora.Invoke("someActionCode", payload)`), and executes a sequence of **steps**.

Actions live at:

- `appConfig.actions: Action[]`

Each action has:

- `id` (string, required): stable internal identifier.
- `code?` (string): the name used by `ora.Invoke("...")` to find the action. **Do not ask the user to provide this.** In App Builder, action codes should be auto-generated and treated as stable identifiers.
- `displayName?` (string): user-facing label.
- `description?` (string): optional description.
- `events?`: map of event name → steps list. Today the main event is `onInvoke`.

Most action editing focuses on the stored field:

- `events.onInvoke: ActionSteps[]`

Tooling note:

- The stored schema field is `events.onInvoke`.
- The preferred tool argument is `onInvokeSteps`.
- Compatibility alias: the tools also accept `events.onInvoke` when mirroring the persisted schema directly.
- For `do-add-action`, the initial steps payload must be an array.
- For `do-modify-action`, the steps payload may be either:
  - an array (replace), or
  - `{ mode: "append" | "upsert" | "replace", steps: [...] }`

Each step has:

- `id` (string, required): stable step identifier.
- `type` (string, required): one of the supported step types.
- `params` (object): step parameters (strings, booleans, string arrays).

## Supported step types (events.onInvoke)

These are the supported `step.type` values and their parameters:

1) `preserveAction`
   - Params: none
   - Meaning: keep the originating UI action visible after running.

2) `navigateToAgenticApp`
   - Params:
     - `appCode` (string, required)
     - `passPayloadAsContext` (boolean)
     - `context` (string)
   - Meaning: navigate to another agentic app; optionally pass the invoke payload as app context.
   - Editor behavior:
     - when `passPayloadAsContext: true`, the editor hides `context`; omit it.

3) `agentCommand`
   - Params:
     - `sendPayloadAsContext` (boolean)
     - `command` (string)
     - `doNotAutoRefresh` (boolean)
   - Meaning: send a command to an agent; optionally use the invoke payload as context; optionally suppress auto-refresh.
   - Rule:
     - If the corresponding `ora.Invoke(...)` includes a payload/context, set `sendPayloadAsContext: true` and omit `command`.
     - If the corresponding `ora.Invoke("actionCode")` has NO payload/context, do NOT set `sendPayloadAsContext: true`; instead provide a concrete `command` string on the step.
   - Editor behavior:
     - when `sendPayloadAsContext: true`, the editor hides `command`; omit it.

4) `refreshAgents`
   - Params:
     - `agentCodes` (string[], optional)
     - `panelTargets` (string[], optional): use `section:<containerId>` for a top-level section panel or `additional:<containerId>:<panelName>` for an additional content panel.
     - `refreshPriorityActions` (boolean)
     - `refreshSummary` (boolean)
   - Meaning: refresh one or more agents by agent **code**, and/or refresh specific section/additional panels without refreshing the whole app; optionally also refresh priority actions and rebuild the summary from only selected `agentCodes`.
   - Prefer `panelTargets` over `switchAppContext.refreshApp` when the user asks to refresh only a cart panel, detail section, or other specific visible panel after an action.

5) `downloadFile`
   - Params:
     - `endpoint` (string, required): same-origin endpoint that returns downloadable file bytes.
     - `method` (`GET` | `POST`): prefer `POST` when sending an invoke payload.
     - `usePayloadAsBody` (boolean): when true, send the `ora.Invoke(...)` payload as the JSON request body.
     - `filename` (string): fallback filename when the response does not provide one.
     - `contentType` (string): optional expected MIME type, such as `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`.
   - Meaning: native file download action that is backed by an application endpoint returning a blob.

6) `showMedia`
   - Params:
     - `title` (string)
     - `usePayloadAsUrl` (boolean)
     - `src` (string)
   - Meaning: show media in the UI; optionally use the invoke payload as the URL.
   - Editor behavior:
     - when `usePayloadAsUrl: true`, the editor hides `src`; omit it.

7) `switchAppContext`
   - Params:
     - `usePayloadAsContext` (boolean)
     - `context` (string)
     - `refreshApp` (boolean)
   - Meaning: update the app context; optionally refresh the app afterwards.
   - Editor behavior:
     - when `usePayloadAsContext: true`, the editor hides `context`; omit it.

8) `editArtifact`
   - Params: none.
   - Invoke payload shape:
     - `id` (stable editor instance id)
     - `type` (`pdf` | `richText` | `structuredRichText` | `text` | `url`)
     - optional `title`
     - optional `url` (PDF or URL artifact)
     - optional `mediaType` (`binary` | `base64`) for PDF URLs
     - optional `useApplicationSecurity` (`true` for PDF URLs that require application security credentials)
     - optional `value` (for `text` / `richText`)
     - optional `sections` (for `structuredRichText`): array of `{ name, locked, text }`
     - optional `highlightText`
     - optional `commitText`
     - optional `metadata` (arbitrary JSON; passed back unchanged on commit)
     - optional `parameters`: array of `{ id, type: "text", defaultValue, displayName? }`
     - only `type: "text"` is currently supported for parameters
     - do not invent `parameters`; only include them when they are explicitly specified in the user request or prompt instructions
     - `displayName` is optional and only affects the viewer label
   - `type: "url"` is always read-only and renders the supplied `url` in an iframe.
   - Commit return shape for text / richText edits:
     - `<oraFormSubmit id="{id-or-artifact}">{"newValue":"...","parameters":[{"id":"...","value":"..."}],"metadata":{...}}</oraFormSubmit>`
     - `artifactPreviewWidget` saves include `metadata.artifactId` so the workflow can identify which preview item was edited.
   - `structuredRichText` currently opens in the rich text editor by flattening all section `text` values top-to-bottom into one editable document.
   - When the editor was opened from `artifactPreviewWidget`, the app updates the matching preview card in place after save.
   - Meaning: agent-driven artifact editing behavior; configure the widget/insight invoke payload, not step params.

## Safety rules

- `action.code` should be stable; changing it can break existing `ora.Invoke("code")` references in prompts/insights.
- Do not ask the user for `action.code`. Prefer auto-generated action codes.
- Step ids should be stable; only replace a step id if the user explicitly wants a “new” step.
- Be careful with steps list editing:
  - Replacing `events.onInvoke` overwrites the entire action flow.
  - Prefer “append/upsert” behaviors when the user asked to add a step/section.

## When to use which tool

- Inspect all actions: list the action inventory.
- Inspect one action: fetch by id.
- Add an action: create an entry in `appConfig.actions`.
- Modify an action: patch an existing entry (including step edits).
- Remove an action: remove an entry from `appConfig.actions`.

## Default behavior (don’t ask for steps)

When the user requests behavior that clearly implies an action (e.g. “when the user clicks…”, “add a button that…”, “invoke an action that…”), and you can infer a safe implementation, you should:

1) Create/modify the action with the needed `onInvokeSteps` immediately (this writes the stored field `events.onInvoke`).
2) Wire the widget/insight to call the action via `ora.Invoke(...)`.

Exception: if the click should create an Autonomous Outcomes plan preview, do not create an app action. Wire the widget/insight directly to `ora.InvokeAsync({"mode":"Research"}, "task text")`. Supported modes are `Quick`, `Research`, `Act`, and `Full Auto`; the first argument must be a strict JSON object, and the second argument is the task text. The user still reviews the generated plan preview and clicks Start.

Do NOT ask the user to design step-by-step action flows when the intent is clear. Only ask a clarifying question when:

- The requested behavior is ambiguous (multiple plausible step sequences), or
- It is high-stakes / has side effects (navigation, context switching, external links), or
- Required information is missing (e.g. target `appCode` for `navigateToAgenticApp`).

### Common inferred action patterns

- “Click an item to ask the same agent for details about that item”:
  - Add an action with a single `agentCommand` step using `sendPayloadAsContext: true`.
  - Ensure the `ora.Invoke("actionCode", payload)` payload includes the instruction and the item identifier(s), because `command` is ignored in payload-as-context mode.

### Successful form submission followed by refresh

Natural-language requests such as "after save", "once the form succeeds", "refresh this section after submit", or "show the updated records after the change is complete" describe an existing cross-artifact pattern. Do not invent a `recordWidget` post-submit hook or report that platform support is missing.

Use this sequence:

1. Let the editable `recordWidget` submit its normal `oraFormSubmit` message to the backing workflow.
2. In the workflow, validate the submission and complete the requested business operation.
3. Create an app action whose `events.onInvoke` contains a `refreshAgents` step. Use `panelTargets: ["section:<containerId>"]` for a top-level section or `panelTargets: ["additional:<containerId>:<panelName>"]` for additional content.
4. From the workflow's confirmed success terminal only, return an `oraImmediateInsight` whose `followUpCommand` is `ora.Invoke("<actionCode>")`.
5. Return an ordinary validation or failure response without `oraImmediateInsight` when validation, workflow execution, or the business operation fails.

The user's request for an automatic refresh after confirmed success is the explicit authorization required for the immediate action. Prefer the targeted `refreshAgents` action over `switchAppContext.refreshApp` when only one section or panel needs fresh content. Do not attach the refresh action directly to the widget's Submit control, and omit the immediate insight on validation, workflow, or business failure.
