# Widgets (App Builder)

This section defines the **UI Library widgets** used in Agentic App Framework `<oraInfoDisplay>` outputs, and provides the canonical schemas + examples for configuring them.

## How widgets appear in agent outputs

Agents render structured UI widgets via:

- `<oraInfoDisplay key="..."> ...JSON... </oraInfoDisplay>`

The JSON payload typically contains:

- `patternId`: the widget type id (must match one of the supported widget types below)
- `properties`: the widget-specific configuration object (must match the widget's schema)

Do not put widget-specific data under a top-level `config` field in runtime `oraInfoDisplay` output. Some local preview tools may accept `config` as a legacy alias, but the Agentic App final render path reads `properties`.

## Writing `displayPrompt` vs producing widget output

This document is a reference for widget **schemas** and **configuration rules**.

When you are editing an agent’s `displayPrompt` or a container’s `initDisplayPromptOverride` in the app spec, you are writing a **prompt** (instructions to the runtime agent), not the final widget result.

- The `displayPrompt` should instruct the runtime agent to output one or more `<oraInfoDisplay>` blocks.
- Do **not** paste a pre-filled, concrete `<oraInfoDisplay>...</oraInfoDisplay>` output with “final” data into `displayPrompt`.
- Do **not** hardcode example metric values/timestamps unless the user explicitly asked for fixed sample data.
- Best practice: explicitly name the widget(s) you want (by `patternId` and/or by `displayWidgetList` id) so the widget override list can be kept in sync.
- **Chat output constraint:** when describing XML structure in chat, avoid bare angle-bracket tags like `<oraInfoDisplay>` (they may be stripped). Refer to element and field names in backticks (e.g. `oraInfoDisplay`, `patternId`, `properties`, `items`) and use placeholders like `{recordId}` or JSON-like sketches.

## Supported widget types (patternId)

Only use these `patternId` values:

- `cardWidget`
- `artifactPreviewWidget`
- `multiCardWidget`
- `changeListWidget`
- `chartWidget`
- `messageListWidget`
- `multiRecordWidget`
- `recordWidget`
- `sankeyWidget`
- `comparisonWidget`
- `toggleBarWidget`

`answerWidget` is reserved for Agentic Autonomous Outcome reports and is intentionally excluded from this list. Never use it in an Agentic App chat response, an agent `displayPrompt`, a panel `initDisplayPromptOverride`, `displayWidgetList`, or `initDisplayWidgetListOverride`. In its outcome-only schema, the optional `metrics` array accepts up to eight objects, each with `title`, `value`, and `tertiaryText` strings. Each metric `value` must contain a number; units, percentages, and currency symbols are allowed, but text-only values are not. Keep large currency values compact with sensible rounding (for example, ~$33.67M rather than $33,671,561).

`sectionHeaderWidget` is also reserved for Agentic Autonomous Outcome reports and is intentionally excluded from this list. Never use it in an Agentic App chat response, an agent `displayPrompt`, a panel `initDisplayPromptOverride`, `displayWidgetList`, or `initDisplayWidgetListOverride`. In its outcome-only schema, use `properties.title` as the single section title and omit the outer widget `title` field.

## Agent widget override list (`displayWidgetList`)

In the App Builder agent editor, “override widgets used” is represented by:

- `agents[agentKey].displayWidgetList: string[] | undefined`
- `pageConfig.agentContainers[].initDisplayWidgetListOverride: string[] | undefined` for panel-specific initial display overrides

When `displayWidgetList` is **undefined**, the agent uses the default widget allowance.
When `displayWidgetList` is a **list**, it restricts which widgets the agent should use in `<oraInfoDisplay>`.
When `initDisplayWidgetListOverride` is set on a container, it restricts that container’s initial display output and takes precedence over the shared agent widget list for that container.

Valid `displayWidgetList` values (widget ids) and their corresponding `patternId`:

- `ORA_LAYOUT_CARD` → `cardWidget`
- `ORA_LAYOUT_ARTIFACT_PREVIEW` → `artifactPreviewWidget`
- `ORA_LAYOUT_MULTICARD` → `multiCardWidget`
- `ORA_LAYOUT_CHANGE_LIST` → `changeListWidget`
- `ORA_LAYOUT_CHART` → `chartWidget`
- `ORA_LAYOUT_MESSAGES_LIST` → `messageListWidget`
- `ORA_LAYOUT_MULTIRECORD` → `multiRecordWidget`
- `ORA_LAYOUT_RECORD` → `recordWidget`
- `ORA_LAYOUT_SANKEY` → `sankeyWidget`
- `ORA_LAYOUT_COMPARISON` → `comparisonWidget`
- `ORA_LAYOUT_TOGGLE_BAR` → `toggleBarWidget`

Rule:
- Whenever you edit an agent’s `displayPrompt`, update `displayWidgetList` to **only** the widget ids used by that prompt (default to one widget unless the prompt clearly uses more).
- Whenever you edit a container’s `initDisplayPromptOverride`, update `initDisplayWidgetListOverride` to **only** the widget ids used by that prompt (default to one widget unless the prompt clearly uses more).
- If a top-level panel has its own display discriminator, or the same agent is reused by multiple top-level panels, use container-level `initDisplayPromptOverride` / `initDisplayWidgetListOverride` for unique panel startup graphics; do not overwrite the shared agent `displayPrompt` or `displayWidgetList` unless the intended default should change for every panel using that agent.
- Runtime multiplex payloads carry the panel discriminator on each `InitDisplay` request, while the effective panel-specific prompt/widget list is sent on the matching `agents[agentKey].panels[]` entry where `name` equals that discriminator. This lets two requests for the same agent use different widget lists in one multiplex call.

## General rules

- Do not invent new widget types.
- Produce **valid JSON** matching the selected widget's schema, with the selected widget schema nested under top-level `properties`.
- Use concise, scannable text (titles 2–8 words, summaries 1–2 sentences when possible).
- Unless explicitly asked, **do not add interactive actions** (commands/links/buttons). If actions are included, keep command strings stable and meaningful.
- Runtime UI context uses a condensed JSON snapshot of widget content and strips visual-only fields (for example badges, badge priority/variant styling, and images); keep core semantic text in stable fields (`title`, `summary`, `status`, values, commands).

## Commands (`ora.Invoke` / `ora.InvokeAsync`)

Some widget fields can be interactive (e.g. `command`, a row/item `action`, or card link `action`). When interactivity is requested, use one of these command formats:

- `ora.Invoke("actionCode", { ...payload... })` (preferred for app-defined actions)
- `ora.Invoke("actionCode")` (if no payload is needed)
- `ora.InvokeAsync({"mode":"Research"}, "task text")` (open Autonomous Outcomes and generate a plan preview)

Rules:

- Only add commands/actions when the user explicitly asks for interactivity.
- Use `ora.InvokeAsync(...)` only when the click should create an Autonomous Outcomes plan preview, not when it should invoke an app-defined action. Supported modes are `Quick`, `Research`, `Act`, and `Full Auto`; invalid or missing mode defaults to `Research`. The user still clicks Start before the outcome runs.
- If you plan to use `ora.Invoke("someCode", ...)` and you are not sure an action with `code: "someCode"` already exists in `appConfig.actions`, do not guess: offer to create the action first, then wire the command into the widget.
- Keep payloads small and JSON-serializable; avoid inventing complex schemas unless the user specified them.

---

## `cardWidget` (Card)

Shows a single alert/status card with optional subtitle, timestamp, badge, bottom status text, and up to 2 links.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["subject", "summary"],
  "properties": {
    "subject": { "type": "string", "description": "Clear, concise title (2-6 words typically)" },
    "subtitle": { "type": "string", "description": "Secondary line shown directly below the title" },
    "image": { "type": "string", "description": "URL of a 72px square thumbnail displayed to the right of the card content" },
    "summary": { "type": "string", "description": "1-2 sentences of descriptive text (under 100 characters when possible). Basic markdown is supported for emphasis and lists" },
    "status": { "type": "string", "description": "Bottom status text shown beneath the summary and above links. Basic markdown is supported for emphasis and lists" },
    "statusPriority": {
      "type": "string",
      "enum": ["alert", "warning", "medium", "success", "neutral"],
      "description": "Color priority for the status text (alert: critical, warning: caution, medium/neutral: neutral, success: positive)"
    },
    "timestamp": { "type": "string", "description": "Human-readable relative time (e.g., '5 min ago', 'Yesterday')" },
    "badgeText": { "type": "string", "description": "Short label for categorization" },
    "link": {
      "type": "object",
      "properties": {
        "text": { "type": "string", "description": "Action-oriented button text (1-3 words)" },
        "action": { "type": "string", "description": "Identifier for what the link does (snake_case format)" }
      }
    },
    "additionalLink": {
      "type": "object",
      "properties": {
        "text": { "type": "string", "description": "Secondary action text (1-3 words)" },
        "action": { "type": "string", "description": "Identifier for the secondary action (snake_case format)" }
      }
    },
    "variant": {
      "type": ["string", "null"],
      "enum": ["error", "warning", "info", "success", "neutral", null],
      "description": "Visual styling variant (error: critical issues, warning: cautions, info: updates, success: positive, neutral/null: neutral)"
    }
  }
}
```

**Examples**

```json
{
  "subject": "Pre-pricing alignment",
  "subtitle": "ZenBank - Digital Channels Renewal (P1)",
  "summary": "Align guardrails and next steps before the March 15 close.",
  "status": "Last interaction raised budget concern",
  "statusPriority": "warning",
  "timestamp": "Today 3:00 PM",
  "badgeText": "Today",
  "variant": "info"
}
```

```json
{
  "subject": "System Alert",
  "summary": "High CPU usage detected on web servers. Investigation in progress.",
  "timestamp": "15 min ago",
  "link": { "text": "Details", "action": "view_error_details" },
  "badgeText": "Alert",
  "variant": "error"
}
```

Notes:
- Only use `additionalLink` if `link` is also present.
- If `status` is present and `statusPriority` is omitted, the UI will treat it as `medium`.
- Prefer `variant: "neutral"` for explicit neutral badges; `variant: null` or omitting `variant` also renders neutral.
- In `summary` and `status`, basic markdown is supported for emphasis and lists; avoid large headings and long code blocks.
- `image` is optional. When present, it is a 72px square thumbnail on the right, aligned with the first available card text.
- When possible, emit card properties in display order for streaming: `variant`, `badgeText`, `timestamp`, `subject`, `subtitle`, `image`, `summary`, `status`, then `link` / `additionalLink`.

---

## `multiCardWidget` (Multi Card)

Shows multiple peer cards in one widget. The top-level `title` and `description` stay shared on the `oraInfoDisplay`; only the actual card metadata goes inside `properties.cards[]`.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["cards"],
  "properties": {
    "layoutMode": {
      "type": "string",
      "enum": ["default", "collapsed", "single-col"],
      "description": "Optional layout behavior. default preserves the normal responsive behavior, collapsed prefers two cards per row but stacks to one column on phone-width containers, and single-col forces one card per row."
    },
    "cards": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["subject", "summary"],
        "properties": {
          "subject": { "type": "string", "description": "Clear, concise title (2-6 words typically)" },
          "subtitle": { "type": "string", "description": "Secondary line shown directly below the title" },
          "image": { "type": "string", "description": "URL of a 72px square thumbnail displayed to the right of the card content" },
          "summary": { "type": "string", "description": "1-2 sentences of descriptive text (under 100 characters when possible). Basic markdown is supported for emphasis and lists" },
          "status": { "type": "string", "description": "Bottom status text shown beneath the summary and above links. Basic markdown is supported for emphasis and lists" },
          "statusPriority": {
            "type": "string",
            "enum": ["alert", "warning", "medium", "success", "neutral"],
            "description": "Color priority for the status text (alert: critical, warning: caution, medium/neutral: neutral, success: positive)"
          },
          "timestamp": { "type": "string", "description": "Human-readable relative time (e.g., '5 min ago', 'Yesterday')" },
          "badgeText": { "type": "string", "description": "Short label for categorization" },
          "link": {
            "type": "object",
            "properties": {
              "text": { "type": "string", "description": "Action-oriented button text (1-3 words)" },
              "action": { "type": "string", "description": "Identifier for what the link does (snake_case format)" }
            }
          },
          "additionalLink": {
            "type": "object",
            "properties": {
              "text": { "type": "string", "description": "Secondary action text (1-3 words)" },
              "action": { "type": "string", "description": "Identifier for the secondary action (snake_case format)" }
            }
          },
          "variant": {
            "type": ["string", "null"],
            "enum": ["error", "warning", "info", "success", "neutral", null],
            "description": "Visual styling variant (error: critical issues, warning: cautions, info: updates, success: positive, neutral/null: neutral)"
          }
        }
      }
    }
  }
}
```

**Examples**

```json
{
  "cards": [
    {
      "subject": "Pre-pricing alignment",
      "subtitle": "ZenBank - Digital Channels Renewal (P1)",
      "summary": "Align guardrails and next steps before the March 15 close.",
      "status": "Last interaction raised budget concern",
      "statusPriority": "warning",
      "timestamp": "Today 3:00 PM",
      "badgeText": "Today",
      "variant": "info"
    },
    {
      "subject": "Policy Reminder",
      "summary": "Expense approvals are due by end of day.",
      "timestamp": "Today",
      "badgeText": "Reminder"
    }
  ]
}
```

```json
{
  "cards": [
    {
      "subject": "System Alert",
      "subtitle": "Web cluster / US-East",
      "summary": "High CPU usage detected on web servers. Investigation in progress.",
      "status": "Mitigation in progress",
      "statusPriority": "alert",
      "timestamp": "15 min ago",
      "link": { "text": "Details", "action": "view_error_details" },
      "badgeText": "Alert",
      "variant": "error"
    },
    {
      "subject": "New Policy Update",
      "subtitle": "Corporate travel and expense",
      "summary": "Company travel policy has been updated with new guidelines.",
      "status": "Review due this week",
      "statusPriority": "medium",
      "timestamp": "Yesterday",
      "link": { "text": "View Policy", "action": "view_policy" },
      "additionalLink": { "text": "Dismiss", "action": "dismiss_notification" },
      "badgeText": "Policy",
      "variant": "warning"
    }
  ]
}
```

```json
{
  "layoutMode": "single-col",
  "cards": [
    {
      "subject": "Critical Alert",
      "summary": "Database failover triggered in the primary region.",
      "timestamp": "5 min ago",
      "badgeText": "Critical",
      "variant": "error"
    },
    {
      "subject": "Capacity Warning",
      "summary": "API cluster is running above the recommended threshold.",
      "timestamp": "12 min ago",
      "badgeText": "Warning",
      "variant": "warning"
    }
  ]
}
```

Notes:
- If a card includes `status` and omits `statusPriority`, the UI will treat it as `medium`.
- Prefer `variant: "neutral"` for explicit neutral card badges; `variant: null` or omitting `variant` also renders neutral.
- Use `multiCardWidget` when you need multiple standalone cards, not a table or a message list.
- Keep the `oraInfoDisplay` `title` and `description` shared for the full set.
- In each card `summary` and `status`, basic markdown is supported for emphasis and lists; avoid large headings and long code blocks.
- Optional `layoutMode` values are `default`, `collapsed`, and `single-col`.
- For the normal responsive behavior, prefer omitting `layoutMode` instead of setting it to `default`.
- Only use `layoutMode: "collapsed"` or `layoutMode: "single-col"` when the prompt instructions explicitly call for that layout behavior.
- Only use `additionalLink` if `link` is also present on that same card.
- For smoother streaming, emit cards in final display order and emit each card's properties in display order: `variant`, `badgeText`, `timestamp`, `subject`, `subtitle`, `summary`, `status`, then `link` / `additionalLink`.

---

## `artifactPreviewWidget` (Artifacts Preview)

Shows one or more artifact preview cards. Each card uses a dedicated `content` payload for the inline preview. `preview` and `edit` open the artifact viewer directly, while `custom` can expose a command button.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["items"],
  "properties": {
      "items": {
        "type": "array",
        "items": {
          "type": "object",
          "required": ["artifactId", "title", "mode", "content"],
          "properties": {
            "artifactId": {
              "type": "string",
              "description": "Required artifact identifier forwarded as metadata.artifactId when the artifact is saved."
            },
            "title": { "type": "string", "description": "Card title shown below the preview." },
            "subtitle": { "type": "string", "description": "Secondary line shown below the card title." },
            "mode": { "type": "string", "enum": ["preview", "edit", "custom"] },
            "content": {
              "type": "object",
              "description": "Artifact payload used for inline preview. Mirrors the artifact viewer/editArtifact shape, including optional parameters."
            },
            "actionText": { "type": "string", "description": "Optional button label. preview defaults to View, edit defaults to Edit, and custom defaults to Run." },
            "action": {
              "type": "string",
              "description": "Required only for custom mode. Full ora.Invoke(...) command string executed as-is."
            }
          }
        }
      }
  }
}
```

**Examples**

```json
{
  "items": [
    {
      "artifactId": "variant-preview-1",
      "title": "Variant 1: Default",
      "subtitle": "ERP Excellence: FDI Customer Success",
      "mode": "preview",
      "content": {
        "id": "variant-default",
        "type": "richText",
        "title": "Variant / Artifact 1",
        "value": "<p><strong>MedCore Diagnostics Team,</strong></p><p>I hope you are doing well.</p><p>We are following up on your request for quotation.</p>"
      }
    },
    {
      "artifactId": "variant-edit-2",
      "title": "Variant 1: Name",
      "subtitle": "ERP Excellence: FDI Customer Success",
      "mode": "edit",
      "content": {
        "id": "variant-name",
        "type": "text",
        "title": "Variant / Artifact 2",
        "value": "MedCore Diagnostics Team,\\n\\nI hope you are doing well.\\n\\nWe are following up on your request for quotation.",
        "commitText": "Save",
        "parameters": [
          {
            "id": "recipientName",
            "type": "text",
            "defaultValue": "MedCore Diagnostics Team",
            "displayName": "Recipient Name"
          }
        ]
      }
    }
  ]
}
```

```json
{
  "items": [
    {
      "artifactId": "renewal-brief-card",
      "title": "Renewal Brief",
      "subtitle": "Executive package",
      "mode": "custom",
      "actionText": "Open",
      "content": {
        "id": "renewal-brief",
        "type": "pdf",
        "title": "Renewal Brief",
        "url": "/artifacts/renewal-brief.pdf",
        "mediaType": "binary"
      },
      "action": "ora.Invoke(\"OPEN_ARTIFACT_PREVIEW\", {\"id\":\"renewal-brief\"})"
    }
  ]
}
```

```json
{
  "items": [
    {
      "artifactId": "supplier-portal-card",
      "title": "Supplier Portal",
      "subtitle": "Embedded read-only page",
      "mode": "preview",
      "content": {
        "id": "supplier-portal",
        "type": "url",
        "title": "Supplier Portal",
        "url": "https://example.com/supplier-portal"
      }
    }
  ]
}
```

Notes:
- Each item must include `artifactId`, `mode`, and `content`.
- `action` is only used for `custom` items.
- For `preview` and `edit`, do not rely on `action`; the runtime opens the artifact viewer directly from `content`.
- The `content` object must mirror the artifact-viewer/editArtifact payload shape:
  - `id` (optional)
  - `type`: `"text"`, `"richText"`, `"structuredRichText"`, `"pdf"`, or `"url"`
  - `title` (optional)
  - `value` (for text / richText)
  - `sections` (for `structuredRichText`): array of `{ name, locked, text }`
  - `url` (for pdf or url)
  - `mediaType` (optional, for pdf)
  - `useApplicationSecurity` (optional, for secured pdf URLs)
  - `highlightText` (optional)
  - `commitText` (optional)
- `metadata` (optional)
- `parameters` (optional): array of `{ id, type: "text", defaultValue, displayName? }`
- For `structuredRichText`, provide `sections` and do not rely on `value`; the runtime currently concatenates each section's `text` into one rich text editor value.
- `preview` opens the artifact viewer in read-only mode.
- `edit` opens the artifact viewer in editable mode.
- `pdf` and `url` artifacts are always read-only, even when launched from an `edit` card.
- `custom` runs `action` as-is.
- When `parameters` are present, the viewer shows `Content` and `Metadata` tabs. The `Metadata` tab renders one text input per parameter.
- `displayName` is optional and controls the field label shown in the viewer. If omitted, the viewer uses `id`.
- Only `type: "text"` is currently supported for parameters. Do not emit other parameter types.
- Do not invent parameters. Only include `parameters` when they are explicitly specified in the user request or prompt instructions.
- On text / richText save, the runtime sends:

```xml
<oraFormSubmit id="{content.id-or-artifact}">
{"newValue":"...","parameters":[{"id":"recipientName","value":"..."}],"metadata":{"artifactId":"..."}}
</oraFormSubmit>
```

- `type` and `displayName` are UI/input metadata and are not returned in form submit.
- `metadata` round-trips unchanged; `artifactPreviewWidget` adds `artifactId` under `metadata.artifactId`.
- After a successful save from a widget-launched editor, the matching preview card updates in place.
- For PDF artifacts, provide a valid `url`.
- For URL artifacts, provide a valid `url`; the runtime iframes it in read-only mode.
- Use `artifactPreviewWidget` when the primary goal is to preview reviewable artifacts, not generic alerts or tables.

---

## `changeListWidget` (Change List)

Compares “current vs previous” values across one or more metrics, optionally with anomaly/insight messages.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["displayType", "items"],
  "properties": {
    "subtitle": { "type": "string", "description": "Additional context or description" },
    "displayType": {
      "type": "string",
      "enum": ["percentage", "raw", "currency"],
      "description": "Display format: 'percentage' for rates/percentages, 'raw' for absolute numbers"
    },
    "items": {
      "type": "array",
      "description": "Array of metric objects to compare",
      "items": {
        "type": "object",
        "required": ["title", "currentValue", "previousValue"],
        "properties": {
          "title": { "type": "string", "description": "Descriptive name for the metric" },
          "currentValue": { "type": "number", "description": "The most recent/current measurement" },
          "previousValue": { "type": "number", "description": "The comparison/baseline measurement" }
        }
      }
    },
    "messages": {
      "type": "array",
      "description": "Array of alert/warning strings for anomalies or important notes",
      "items": { "type": "string" }
    }
  }
}
```

**Example**

```json
{
  "subtitle": "Campaign performance comparison",
  "displayType": "percentage",
  "items": [
    { "title": "Email Open Rate", "currentValue": 28.2, "previousValue": 24.5 },
    { "title": "Click-through Rate", "currentValue": 4.6, "previousValue": 3.8 },
    { "title": "Conversion Rate", "currentValue": 1.9, "previousValue": 2.1 }
  ],
  "messages": ["Conversion rate drop may indicate landing page issues"]
}
```

Notes:
- Values must be numbers (no `%` or `$` symbols); use `displayType` to control formatting.
- Only include `messages` when they add non-obvious, actionable insight.
- For better streaming UX, emit `displayType` first, then each `items[]` row as a complete object, then `messages`.

---

## `chartWidget` (Chart)

Renders a line/bar/pie chart with labels + datasets, plus optional insights.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["type", "data"],
  "properties": {
    "type": { "type": "string", "enum": ["line", "bar", "pie"] },
    "data": {
      "type": "object",
      "required": ["labels", "datasets"],
      "properties": {
        "labels": { "type": "array", "items": { "type": "string" } },
        "datasets": {
          "type": "array",
          "items": {
            "type": "object",
            "required": ["label", "data"],
            "properties": {
              "label": { "type": "string", "description": "Name for the data series (appears in legend)" },
              "data": { "type": "array", "items": { "type": "number" } }
            }
          }
        }
      }
    },
    "referenceObjects": {
      "type": "array",
      "description": "Optional reference lines or areas for line/bar charts. Use for thresholds, targets, forecast bands, or comparison ranges.",
      "items": {
        "oneOf": [
          {
            "type": "object",
            "required": ["type", "value"],
            "properties": {
              "type": { "type": "string", "enum": ["line"] },
              "label": { "type": "string", "description": "Optional legend label" },
              "value": {
                "description": "Constant y-axis value or one value per label",
                "anyOf": [
                  { "type": "number" },
                  { "type": "array", "items": { "type": "number" } }
                ]
              }
            }
          },
          {
            "type": "object",
            "required": ["type", "yMin", "yMax"],
            "properties": {
              "type": { "type": "string", "enum": ["area"] },
              "label": { "type": "string", "description": "Optional legend label" },
              "yMin": {
                "description": "Constant lower y-axis value or one lower value per label",
                "anyOf": [
                  { "type": "number" },
                  { "type": "array", "items": { "type": "number" } }
                ]
              },
              "yMax": {
                "description": "Constant upper y-axis value or one upper value per label",
                "anyOf": [
                  { "type": "number" },
                  { "type": "array", "items": { "type": "number" } }
                ]
              }
            }
          }
        ]
      }
    },
    "insights": { "type": "array", "items": { "type": "string" } }
  }
}
```

**Examples**

Reference line for a threshold/target:

```json
{
  "type": "bar",
  "data": {
    "labels": ["Q1", "Q2", "Q3", "Q4"],
    "datasets": [{ "label": "Hiring", "data": [420, 560, 610, 690] }]
  },
  "referenceObjects": [
    { "type": "line", "label": "Threshold", "value": 500 }
  ],
  "insights": ["Hiring exceeded the threshold after Q1", "Q4 had the strongest hiring volume"]
}
```

Reference area for an expected range/forecast band:

```json
{
  "type": "line",
  "data": {
    "labels": ["January", "February", "March", "April", "May"],
    "datasets": [{ "label": "Sales Revenue", "data": [10000, 25000, 15000, 40000, 30000] }]
  },
  "referenceObjects": [
    {
      "type": "area",
      "label": "Expected range",
      "yMin": [8000, 15000, 18000, 22000, 25000],
      "yMax": [18000, 28000, 32000, 42000, 38000]
    }
  ],
  "insights": ["Revenue peaked in April", "Steady growth trend overall"]
}
```

Notes:
- `labels.length` must match each dataset’s `data.length`.
- `referenceObjects` is supported for `line` and `bar` charts. It is ignored for `pie`.
- Reference line shape: `{ "type": "line", "label"?: string, "value": number | number[] }`.
- Reference area shape: `{ "type": "area", "label"?: string, "yMin": number | number[], "yMax": number | number[] }`.
- Use a number for a constant y-axis reference; use `number[]` for a reference that varies by label. Reference arrays must match `labels.length`.
- Reference object `label` appears in the legend when provided.
- Do not put reference lines, thresholds, targets, benchmarks, bands, or ranges in `data.datasets`.
- Do not use Chart.js-style dataset fields such as `type`, `borderDash`, `borderColor`, or `fill`; they are not part of this widget contract.
- Use a `line` reference object for a target, threshold, SLA, minimum, maximum, benchmark, quota, or goal.
- Use an `area` reference object for an acceptable range, expected range, confidence interval, tolerance band, budget band, or forecast band.
- Use at most 1–3 `insights`.
- For better streaming UX, emit chart config fields in this order: `type`, `data.labels`, each `data.datasets[]` entry, then `referenceObjects`, then `insights`.

---

## `messageListWidget` (Message List)

Displays a list of message rows (or a single message). Items can include badge, priority, timestamp, status, optional image, and optional actions.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["items"],
  "properties": {
    "subtitle": { "type": "string" },
    "items": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["title"],
        "properties": {
          "title": { "type": "string" },
          "subtitle": { "type": "string" },
          "summary": { "type": "string" },
          "statusPriority": { "type": "string", "enum": ["alert", "warning", "medium", "success", "neutral"], "description": "Optional status-only color override. When omitted, status uses priority." },
          "badgeText": { "type": "string" },
          "priority": { "type": "string", "enum": ["alert", "warning", "medium", "success", "neutral"], "default": "medium" },
          "timestamp": { "type": "string" },
          "action": { "type": "string", "description": "Command string passed to handler when item is clicked" },
          "additionalAction": {
            "type": "object",
            "required": ["text", "command"],
            "properties": {
              "text": { "type": "string" },
              "command": { "type": "string" },
              "contextualText": {
                "type": "string",
                "description": "Optional short label that provides item-specific context for the action"
              }
            }
          },
          "status": { "type": "string" },
          "image": { "type": "string", "description": "URL (48px wide thumbnail)" }
        }
      }
    }
  }
}
```

**Example**

```json
{
  "subtitle": "Real-time metrics",
  "items": [
    {
      "title": "Memory Usage Spike Detected",
      "subtitle": "82% confidence",
      "summary": "Memory consumption increased by 40% in the last 5 minutes",
      "status": "Investigating root cause",
      "statusPriority": "warning",
      "badgeText": "Medium",
      "priority": "medium",
      "timestamp": "3 min ago"
    }
  ]
}
```

Notes:
- Use `priority: "alert"` sparingly for truly critical items.
- Use `priority: "medium"` for informational blue badges, `priority: "neutral"` for neutral gray badges, and `priority: "success"` for positive green badges.
- Use `statusPriority` only when the status text should differ from the badge priority.
- Only include `action` / `additionalAction` when explicitly asked to add interactivity.
- For best streaming behavior, emit each `items[]` object as a complete row before starting the next row. Do not interleave partial fields across multiple rows.

---

## `multiRecordWidget` (Multi Record)

Renders a table with columns and rows. Cells can be strings or badge objects. Rows can optionally include an action button and/or drilldown command. It can also optionally support multi-row selection with checkbox submit.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["cols", "rows"],
  "properties": {
    "id": { "type": "string", "description": "Optional submit identifier used when selectMode is multiSelect" },
    "subtitle": { "type": "string", "description": "Optional description for accessibility" },
    "selectMode": {
      "type": "string",
      "enum": ["none", "multiSelect"],
      "description": "Optional row selection behavior. multiSelect shows row checkboxes and a submit button."
    },
    "multiSelectActionText": {
      "type": "string",
      "description": "Optional label for the multi-select submit button."
    },
    "multiSelectMetadata": {
      "description": "Optional JSON value returned unchanged as metadata in the multi-select submit payload."
    },
    "cols": {
      "type": "array",
      "items": {
        "oneOf": [
          { "type": "string" },
          {
            "type": "object",
            "required": ["label"],
            "properties": {
              "label": { "type": "string" },
              "showOnExpand": { "type": "boolean" },
              "valueType": {
                "type": "string",
                "enum": ["text", "number", "currency"],
                "description": "Optional column value type. Use number or currency to right-align and format values."
              },
              "pattern": {
                "type": "string",
                "description": "Optional numeric display pattern, such as 0,0 or 0,0.00. Applies to number and currency columns."
              },
              "currencyCode": {
                "type": "string",
                "description": "Optional ISO currency code for currency columns. Defaults to USD."
              }
            }
          }
        ]
      }
    },
    "rows": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["cells"],
        "properties": {
          "cells": {
            "type": "array",
            "items": {
              "oneOf": [
                { "type": "string" },
                { "type": "number" },
                {
                  "type": "object",
                  "required": ["type", "text", "priority"],
                  "properties": {
                    "type": { "type": "string", "enum": ["badge"] },
                    "text": { "type": "string" },
                    "priority": { "type": "string", "enum": ["alert", "warning", "medium", "success", "neutral"] }
                  }
                }
              ]
            }
          },
          "action": {
            "type": "object",
            "required": ["text", "command"],
            "properties": { "text": { "type": "string" }, "command": { "type": "string" } }
          },
          "drillDownAction": { "type": "string" }
        }
      }
    }
  }
}
```

**Example (basic)**

```json
{
  "subtitle": "Monthly sales",
  "cols": [
    "Region",
    { "label": "Deal Count", "valueType": "number" },
    { "label": "Pipeline Value", "valueType": "currency", "currencyCode": "USD" }
  ],
  "rows": [
    { "cells": ["North America", 1250, 3400000] },
    { "cells": ["Europe", 875.5, 1250000.75] },
    { "cells": ["Asia Pacific", 1024, 980000.5] },
    { "cells": ["Latin America", 320.25, 450000] }
  ]
}
```

**Example (multi-select)**

```json
{
  "id": "selected_orders",
  "subtitle": "Orders awaiting batch approval",
  "selectMode": "multiSelect",
  "multiSelectActionText": "Approve Selected",
  "multiSelectMetadata": { "action": "approve_orders", "source": "batch_review_queue" },
  "cols": ["Order ID", "Customer", "Status"],
  "rows": [
    { "cells": ["ORD-5001", "Acme Corp", { "type": "badge", "text": "PENDING", "priority": "warning" }] },
    { "cells": ["ORD-5002", "Global Inc", { "type": "badge", "text": "PENDING", "priority": "warning" }] }
  ]
}
```

Notes:
- Badge cell example: `{ "type": "badge", "text": "PENDING", "priority": "warning" }`.
- Badge priorities are `alert` (red), `warning` (orange), `medium` (informational blue), `success` (green), and `neutral` (gray).
- Use column objects with `valueType: "number"` or `valueType: "currency"` only when values should be right-aligned and formatted. Without this metadata, existing text-like rendering is preserved.
- Default number/currency formatting uses US grouping. Whole numbers show no decimals; decimal values show two decimal places. Example: `3400000` → `3,400,000`; `980000.5` → `980,000.50`; currency defaults to USD unless `currencyCode` is provided.
- `pattern` can be used for explicit fraction display, for example `0,0` or `0,0.00`.
- Only include row `action` / `drillDownAction` when explicitly requested.
- If `selectMode` is `multiSelect`, the UI renders a checkbox per row plus a submit button whose label is `multiSelectActionText` or `Submit`.
- Multi-select submit returns `oraFormSubmit` with JSON body `{ "value": [{ "id": "selectedRows", "value": [ ...selected row objects... ] }], "metadata": multiSelectMetadata }`.
- When streaming this widget, emit `cols` first, then append complete row objects to `rows` one at a time. Do not stream partial row objects if you can avoid it.

---

## `recordWidget` (Record)

Renders a form-like record viewer/editor with typed fields; supports read-only mode.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["id", "fields"],
  "properties": {
    "id": { "type": "string", "description": "Unique identifier for this form instance" },
    "readOnly": { "type": "boolean", "default": false },
    "submitText": { "type": "string", "description": "Optional label for the submit button shown when readOnly is false. Defaults to Submit." },
    "fields": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["id", "type", "value"],
        "properties": {
          "id": { "type": "string" },
          "type": { "type": "string", "enum": ["text", "textarea", "number", "date", "select", "system"] },
          "label": { "type": "string", "description": "Required for all types except system" },
          "required": { "type": "boolean", "description": "When true on an editable visible field, the user must enter a value before submit." },
          "maxLength": { "type": "integer", "minimum": 1, "description": "Optional maximum character count for text, textarea, and number fields." },
          "value": {
            "oneOf": [{ "type": "string" }, { "type": "number" }, { "type": "object" }, { "type": "array" }]
          },
          "options": {
            "type": "array",
            "items": {
              "type": "object",
              "required": ["value", "label"],
              "properties": { "value": { "type": "string" }, "label": { "type": "string" } }
            }
          }
        }
      }
    }
  }
}
```

**Example**

```json
{
  "id": "employee_form",
  "readOnly": false,
  "submitText": "Save Employee",
  "fields": [
    { "id": "full_name", "type": "text", "label": "Full Name", "value": "John Doe" },
    { "id": "employee_id", "type": "number", "label": "Employee ID", "value": 12345 },
    { "id": "hire_date", "type": "date", "label": "Hire Date", "value": "2023-06-15" }
  ]
}
```

Notes:
- For `type: "select"` in editable mode (`readOnly: false`), include `options`.
- Set `required: true` only on visible editable fields that must be completed before submit. Supported required field types are `text`, `textarea`, `number`, `date`, and `select`.
- Set `maxLength` only for `text`, `textarea`, and `number` fields when a character limit is required. For `number`, this limits typed character count, not numeric value.
- For `type: "system"`, omit `label` and the field is hidden.
- For editable forms, `submitText` customizes the submit button label; omit it to use `Submit`.
- Editable forms submit their normal `oraFormSubmit` message to the backing workflow. The backing workflow owns any requested post-submit behavior, including invoking an app action after confirmed business success.
- Do not add or request a widget-level post-submit hook. For a requested success-only panel refresh, use a workflow success response containing `oraImmediateInsight` to invoke an app action whose `refreshAgents.panelTargets` identifies the affected panel. Validation and failure responses must omit the immediate action.

---

## `comparisonWidget` (Comparison)

Compares multiple named options. The widget has individual option tabs plus a Compare tab that shows all options side by side.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["sections", "items"],
  "properties": {
    "showRecommended": { "type": "boolean" },
    "descriptionLabel": { "type": "string" },
    "actionTemplate": {
      "type": "object",
      "required": ["text", "command"],
      "properties": {
        "text": { "type": "string" },
        "command": { "type": "string" },
        "contextualText": { "type": "string" }
      }
    },
    "sections": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["keys"],
        "properties": {
          "id": { "type": "string" },
          "title": { "type": "string" },
          "keyHeader": { "type": "string" },
          "valueHeader": { "type": "string" },
          "keys": {
            "type": "array",
            "items": {
              "type": "object",
              "required": ["id", "label"],
              "properties": { "id": { "type": "string" }, "label": { "type": "string" } }
            }
          }
        }
      }
    },
    "items": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["id", "name", "title", "values"],
        "properties": {
          "id": { "type": "string" },
          "name": { "type": "string" },
          "title": { "type": "string" },
          "subtitle": { "type": "string" },
          "description": { "type": "string" },
          "statusText": {
            "type": "object",
            "required": ["text"],
            "properties": {
              "text": { "type": "string" },
              "status": { "type": "string", "enum": ["alert", "warning", "medium", "success", "neutral"] }
            }
          },
          "values": {
            "type": "array",
            "items": {
              "type": "object",
              "required": ["keyId", "value"],
              "properties": {
                "sectionId": { "type": "string" },
                "keyId": { "type": "string" },
                "value": {}
              }
            }
          }
        }
      }
    }
  }
}
```

**Example**

```json
{
  "showRecommended": true,
  "descriptionLabel": "Description",
  "actionTemplate": {
    "text": "Proceed with {name}",
    "command": "ora.Invoke(\"selectRenewalOption\", { \"optionId\": \"{id}\" })"
  },
  "sections": [
    {
      "id": "subscription",
      "keyHeader": "Subscription",
      "valueHeader": "Notes",
      "keys": [
        { "id": "sensor", "label": "Supremo Smart Sensor - Model X200" },
        { "id": "gateway", "label": "Edge Gateway Units" }
      ]
    },
    {
      "id": "addons",
      "title": "Add-ons",
      "keys": [
        { "id": "compute_pack", "label": "On-Demand Compute Pack" }
      ]
    }
  ],
  "items": [
    {
      "id": "option_1",
      "name": "Option 1",
      "title": "Renewal with usage-based add-on",
      "subtitle": "$22,750 (after discount)",
      "description": "Renewal proposal tailored to current usage.",
      "statusText": { "text": "Savings of $10,000 or more per year.", "status": "success" },
      "values": [
        { "keyId": "sensor", "value": { "focused": "Same as your current plan", "comparison": { "status": "yes" } } },
        { "keyId": "gateway", "value": { "status": "yes" } },
        { "sectionId": "addons", "keyId": "compute_pack", "value": { "focused": "Rate plan changed to prevent overages", "comparison": { "status": "yes" } } }
      ]
    }
  ]
}
```

Notes:
- Put the most common section first. Values without `sectionId` target the first section.
- Include `sectionId` only for values in later sections.
- Comparison values can be text, number, boolean, null, `{ "status": "yes" }`, `{ "status": "no" }`, or `{ "focused": ..., "comparison": ... }`.
- Do not include `icon` or `ariaLabel`; the UI derives the visual and accessible label from `status`.
- Only include `actionTemplate` when actions are explicitly requested. The placeholders `{id}`, `{name}`, and `{title}` resolve from each item.

---

## `toggleBarWidget` (Toggle Bar)

Shows a segmented toggle for switching between two or more related views. Each option owns the nested widget displayed when that option is selected.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["options"],
  "properties": {
    "id": {
      "type": "string",
      "description": "Optional unique identifier for this toggle bar instance. Use snake_case."
    },
    "subtitle": {
      "type": "string",
      "description": "Optional context for the toggle bar, used for accessibility."
    },
    "selectedOptionId": {
      "type": "string",
      "description": "Optional id of the option selected by default. Must match one options[].id value. Defaults to the first option."
    },
    "options": {
      "type": "array",
      "minItems": 2,
      "description": "Available toggle options. Each option owns the widget rendered when selected.",
      "items": {
        "type": "object",
        "required": ["id", "label", "content"],
        "properties": {
          "id": { "type": "string", "description": "Stable option identifier. Use snake_case or kebab-case." },
          "label": { "type": "string", "description": "Short visible option label." },
          "content": {
            "type": "object",
            "required": ["widget"],
            "description": "Content displayed when this option is selected.",
            "properties": {
              "title": { "type": "string", "description": "Optional title for the selected option content area." },
              "description": { "type": "string", "description": "Optional short description for the selected option content area." },
              "tertiaryText": { "type": "string", "description": "Optional tertiary supporting text for the selected option content area." },
              "statusMessage": {
                "type": "object",
                "required": ["text"],
                "description": "Optional item-level status or informational message for the selected option content area.",
                "properties": {
                  "text": { "type": "string", "description": "Short status or informational message." },
                  "status": {
                    "type": "string",
                    "enum": ["alert", "warning", "info", "success", "neutral"],
                    "description": "Visual status tone. Defaults to info."
                  }
                }
              },
              "widget": {
                "type": "object",
                "required": ["patternId", "properties"],
                "description": "Widget displayed in the widget area when this option is selected.",
                "properties": {
                  "patternId": {
                    "type": "string",
                    "enum": [
                      "cardWidget",
                      "messageListWidget",
                      "changeListWidget",
                      "chartWidget",
                      "recordWidget",
                      "multiCardWidget",
                      "artifactPreviewWidget",
                      "multiRecordWidget",
                      "sankeyWidget"
                    ],
                    "description": "Widget type to render for this selected option. Do not use toggleBarWidget or comparisonWidget inside toggleBarWidget."
                  },
                  "properties": { "type": "object", "description": "Properties payload matching the nested widget patternId schema." }
                }
              },
              "actionButton": {
                "type": "object",
                "required": ["text", "action"],
                "description": "Optional primary action button associated with the selected option content.",
                "properties": {
                  "text": { "type": "string", "description": "Short button label." },
                  "action": { "type": "string", "description": "Action command to fire when the action button is selected." },
                  "contextualText": { "type": "string", "description": "Optional action description passed to the executor." }
                }
              },
              "suggestedActions": {
                "type": "array",
                "description": "Optional tab-level suggested actions associated with the selected option content.",
                "items": {
                  "type": "object",
                  "required": ["text", "action"],
                  "properties": {
                    "text": { "type": "string", "description": "Short button label." },
                    "action": { "type": "string", "description": "Action command to fire when the suggested action is selected." },
                    "contextualText": { "type": "string", "description": "Optional action description passed to the executor." }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
```

**Example**

```json
{
  "id": "pipeline_view_toggle",
  "subtitle": "Pipeline view selector",
  "selectedOptionId": "summary",
  "options": [
    {
      "id": "summary",
      "label": "Summary",
      "content": {
        "title": "Pipeline Summary",
        "description": "Top pipeline risk and next step.",
        "tertiaryText": "Updated from renewal data.",
        "statusMessage": {
          "text": "Owner action recommended",
          "status": "warning"
        },
        "widget": {
          "patternId": "cardWidget",
          "properties": {
            "subject": "Pipeline Risk",
            "summary": "Three late-stage renewals need owner follow-up.",
            "status": "Owner action recommended",
            "statusPriority": "warning",
            "variant": "warning"
          }
        },
        "actionButton": {
          "text": "Submit forecast",
          "action": "ora.Invoke(\"submitPipelineForecast\")",
          "contextualText": "Submit forecast from pipeline summary"
        },
        "suggestedActions": [
          {
            "text": "Open pipeline",
            "action": "ora.Invoke(\"openPipeline\")",
            "contextualText": "Open pipeline from summary view"
          }
        ]
      }
    },
    {
      "id": "accounts",
      "label": "Accounts",
      "content": {
        "title": "At-Risk Accounts",
        "description": "Accounts needing review.",
        "widget": {
          "patternId": "messageListWidget",
          "properties": {
            "items": [
              {
                "title": "ZenBank",
                "summary": "Security review is blocking signature.",
                "status": "Needs legal follow-up",
                "statusPriority": "warning"
              }
            ]
          }
        },
        "actionButton": {
          "text": "Review account plan",
          "action": "ora.Invoke(\"reviewAccountPlan\")"
        },
        "suggestedActions": [
          {
            "text": "Assign owner",
            "action": "ora.Invoke(\"assignAccountOwner\")",
            "contextualText": "Assign an owner for the selected at-risk accounts"
          },
          {
            "text": "Draft follow-up",
            "action": "ora.Invoke(\"draftAccountFollowUp\")"
          }
        ]
      }
    }
  ]
}
```

Notes:
- Use `toggleBarWidget` when the user needs alternate views of the same subject, such as Summary vs Accounts vs Trend.
- Do not use it when all content should be visible at once; emit separate widgets instead.
- Do not include an outer section headline inside the toggle bar. Use the section/widget title outside this widget for that.
- Use `options[].content.title`, `description`, `tertiaryText`, and `statusMessage` for the selected option content intro.
- Each `options[].content.widget` must include only a valid nested widget `patternId` and matching `properties`. Do not include `title` or `description` inside `content.widget`; use `options[].content.title` and `options[].content.description` instead.
- Use `options[].content.actionButton` for the selected content's single primary action.
- Use `options[].content.suggestedActions` only for additional tab-level suggested actions.
- Do not nest `toggleBarWidget` or `comparisonWidget` inside `toggleBarWidget`.
- Use short option labels.
- Use `subtitle` as an accessibility label for the toggle group.

---

## `sankeyWidget` (Sankey)

Visualizes flow from nodes to nodes with weighted edges.

**Schema**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["nodes", "edges"],
  "properties": {
    "nodes": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["id", "name"],
        "properties": { "id": { "type": "number" }, "name": { "type": "string" } }
      }
    },
    "edges": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["source", "target", "value"],
        "properties": {
          "source": { "type": "number" },
          "target": { "type": "number" },
          "value": { "type": "number" }
        }
      }
    }
  }
}
```

**Example**

```json
{
  "nodes": [
    { "id": 0, "name": "Web Visitor" },
    { "id": 1, "name": "Web Chat" },
    { "id": 2, "name": "AI Chat bot" }
  ],
  "edges": [
    { "source": 0, "target": 1, "value": 1000 },
    { "source": 1, "target": 2, "value": 1000 }
  ]
}
```

Notes:
- Node ids must be unique numbers.
- Edge `source`/`target` must reference existing node ids.
