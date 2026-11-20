# Outcome Response Contract

## Mandatory section order

Use this exact order for the 12 core sections of every `FULL_PACKAGE` request, substituting the frozen resolved titles where marked. Insert `Protected Capability And Retention Guardrails` between the resolved top-evidence section and Risks only when the user explicitly requests a protection constraint and returned governed data identifies the applicable records.

1. Research Analysis
2. Target-summary slot using `targetSummaryTitle`
3. Business Signal Analysis
4. Outcome-impact slot using `outcomeImpactTitle`
5. Recommended-actions slot using `recommendedActionsTitle`
6. Exposure slot using `exposureTitle`
7. Top-evidence slot using `topEvidenceTitle`
8. Risks, Trade-Offs, And Mitigations
9. Available Course of Action
10. Review And Decision Loop
11. Data Coverage, Assumptions, And Workbook Detail
12. Assumptions

Data coverage belongs immediately before the final `Assumptions` section. Keep it brief in chat and point to the workbook for detailed coverage, assumptions, returned policy calculations, and evidence. Do not create a standalone outcome markdown file; the complete decision package is the final chat response. For every `FULL_PACKAGE` request, use Create Documents or a similar external skill to generate a formatted document and a PDF when supported from the complete final chat response.


## Assumption disclosure

End every completed outcome, including summaries and follow-ups, with `Assumptions`. List material semantic equivalences, fallback defaults and their documented sources, inferred interpretations, date assumptions, and assumed analytical inputs; explain uncertainty that could materially affect the result. Keep sourced facts, documented rules, and inferences distinguishable. If no material assumptions or fallback choices were needed, state `None.`. For material choices, state the method or assumption, rationale, scope, and inputs needed to revise it. Include a concise, non-blocking invitation for changes after delivering the proposed allocation. A data-coverage note or artifact alone does not satisfy this requirement.

Apply the exact scoring defaults in `capability-policy-contract.md` before policy calls; do not invent alternative imputations or replace returned scores. Preserve source missingness separately from preprocessed scoring inputs. Proceed using reasonable business assumptions when they resolve missing use-case details, and ask only when an essential ambiguity cannot be resolved reliably. Use the allocation method in `business-logic.md` when rules are absent, retaining original scores and separate derived amounts. Missing implementation approvals, absent source periods, and unmatched nonessential reference context are review notes or caveats, not prerequisites to completing the proposal. Preserve this disclosure unchanged in the response document/PDF and carry material assumptions into other artifacts.

## Research Analysis presentation rule

Research Analysis must remain an insight synthesis, not a restatement of the user's prompt. Preserve its substantive content, recommendation, evidence, caveats, and decision posture. It should summarize the whole response for a C-level reader: recommended course, expected outcome, impact mix, largest visible segments, strongest business signals, guardrails or cautions, and where the supporting evidence is located. Do not use generic process language.

Render the content as two to four short paragraphs, Present the analysis as short, readable paragraphs. Emphasize the recommendation or an important caution when useful. Let Fusion choose the natural layout and appearance, without custom cards, colors, fonts, spacing, borders, or markup. Aim for roughly 150 to 250 visible words as an editorial guide only. Do not omit material content to meet the range and do not add filler.

Wrap at least one existing recommendation, expected outcome, or decisive-evidence. Wrap at least one existing assumption, caution, guardrail, unresolved gap, or review-condition. Select both of them dynamically from the generated content; do not use fixed wording, invent content, or rewrite the analysis solely to satisfy formatting. Keep emphasis sparse and meaningful; do not add decorative emphasis, icons, colored text, nested headings, lists, tables, or unsupported claims inside the card.

Chat and the response document/PDF must preserve the same visible text, paragraph order, and meaning, using each destination's native formatting.

## Data-aware titles

Before rendering, resolve and freeze `targetSummaryTitle`, `outcomeImpactTitle`, `recommendedActionsTitle`, `exposureTitle`, and `topEvidenceTitle`; reuse them unchanged across chat and artifacts. Choose the title family from an analytical dimension explicitly present in the request, corroborate exact values with governed data, then use a governed-data dimension when the request provides none, and use the neutral fallback only when no stronger dimension exists. The request may establish the dimension, but governed data remains authoritative for exact records, names, evidence, metrics, and calculations. Never use an ID, code, field, path, capability name, placeholder, truncated value, list, or multiple values as a scope label. Put awkward, unsupported, or misleading scope detail in the Reader's Cue or decision-information-gap section.

When a readable business scope is used, render `[Business Scope] Target Summary`, `Outcome Impact For [Business Scope]`, `Recommended Actions For [Business Scope]`, and `Top Action Evidence For [Business Scope]`.

Use the v10 focus families: regional; management cost and management layer; higher-compensation and compensation cohort; hiring plan and hiring stage; and skill/role criticality. Use management layer, skill, role criticality, scarcity, level, or similar dimensions only when returned governed JSON contains those attributes and the request makes them relevant. For department or function questions, use the returned business-area name when exactly one readable name is confirmed. When one unconfirmed department is named in the request or multiple departments are named or returned, use `Department Target Summary`, `Outcome Impact By Department`, `Recommended Actions By Department`, `Department Exposure` when department is displayed, and `Top Department Action Evidence`; otherwise use `Target Summary`, `Outcome Impact`, `Recommended Actions`, and `Top Action Evidence`. Put an unconfirmed requested name in the Reader's Cue or decision-information-gap section. Never add `Function` to a visible heading. For general budget requests, use the strongest supported focus family, then the neutral fallback.

Build the exposure heading only from dimensions actually displayed: `Role And Location Exposure` when both are displayed; `[Dimension] Exposure` for one; `[Primary Dimension] And [Secondary Dimension] Exposure` for two; and `Workforce Exposure` for more than two or no clean dimensions. Include `Level` only when level data is returned and displayed. Put additional dimensions in the Reader's Cue. Final headings must not contain `Dynamic`, unresolved square-bracket placeholders, internal heading-map keys, or `By Segment` when a more specific resolved dimension exists.

## Required table pattern

Keep separate tables for separate concerns.

1. Target or population summary table: size, target, planned outcome, and readiness.
2. Business Signal Analysis table: signal, evidence, implication, response, reasoning.
3. Outcome Impact table: segment, baseline, target, proposed allocation, resulting budget, current employee cost reduction, planned hiring spend reduction, action count, residual gap, and separate planning-completion and implementation-review notes.
4. Recommended Actions table: segment, action type, proposed amount and rate, resulting amount, what changes, why, how/when, expected impact, implementation review note.
5. Exposure table: role, level, location, department, country, or capability concentration.
6. Top Evidence table: decision-critical employee, requisition, offer, role, location, or compensation rows.
7. If current employee cost reduction is part of the analysis, a separate Current Employee Review Evidence table.
8. If planned hiring spend reduction is part of the analysis, a separate Requisition And Offer Evidence table.
9. If the protection gate is satisfied, a Guardrails table: protected capability, reason, allowed alternative, review note.
10. Risk table: risk, where it appears, why it matters, mitigation, review needed.
11. Available Course of Action table: course, meaning, expected outcome, trade-off, evidence, best-fit condition.

Do not merge these into one mega-table. For allocation requests, include record-level baseline, proposed change, and resulting amount in the relevant employee and hiring evidence. Reconcile totals across these rows, summaries, and the target. Keep unquantified commitments visible without treating missing amounts as zero. Do not substitute rankings or approval requests for a proposed allocation.

## Table presentation

Present row-and-column information as clear tables with meaningful column headings. Use Fusion's native table and heading rendering. Do not supply CSS, styling markup, fixed dimensions, or custom table templates.

## Canonical display-row binding

Define every table column as a visible label, canonical key, and accepted source aliases before rendering; never use the visible label as the row lookup key. Recognize equivalent source aliases using semantic matching and context while preserving canonical output keys; leave ambiguous bindings unresolved. Build display rows only after normalization, policy joins, selection, and ranking. For employee evidence, bind `EmployeeName` from `EmployeeName` or `Display Name`; `Role` from `Role` or `Job Name`; `Department` from `Department` or `Department Name`; `Location` from `Location`, `LocationName`, or `Location Name`; numeric `CurrentSalary` from `CurrentSalary`, `Current Salary`, or `salary`; and `PlanningPriority` from an already populated `PlanningPriority`, `Planning Priority`, or `interp`. Do not derive a planning-priority label locally from `score`.

Use null-aware binding rather than truthiness: preserve valid zero and false values, and treat only null, undefined, blank strings, and invalid numeric values as unavailable. Never leave a table cell empty; show `Not available` for a genuinely unavailable value and retain the applicable business-data information gap. Treat a populated accepted alias with an empty displayed cell as a rendering failure. Chat, Word, and workbook must use the same bound value.

## Reader's Cue and Insight rule

Use one business-facing heading per content unit. For every table, render this exact sequence: section heading; chart when required; Reader's Cue; table; Insight; bounded-view note when it is an evidence table. Do not render separate chart and table headings.

Place one short Reader's Cue immediately before each table explaining what to inspect, why it matters, and which decision the table informs. 
Keep the cue to one or two sentences and ground it in governed source or policy evidence, identifying disclosed assumptions affecting that evidence. Do not present assumed inputs or scenario estimates as verified facts or introduce a new calculation or recommendation. If valid chart inputs are unavailable or all zero, explain why in the Reader's Cue.

Place one factual Insight immediately after each table. Ground it in the displayed evidence and explicitly labeled assumptions without repeating the cue or presenting assumptions as verified facts.

## Evidence visibility rule

The chat response must include enough evidence for the user to understand and challenge the recommendation. The workbook may contain full detail, but the workbook must not be the only place where the reasoning appears.

If the recommendation includes planned hiring spend reduction, show the actual requisition and offer evidence rows in chat. If the recommendation includes current employee cost reduction, show the actual current employee review candidate rows in chat. Do not rely on aggregate action counts or Business Signal Analysis alone.

Keep the evidence section self-contained. Do not claim that a workbook or other artifact is attached inside `FINAL_RESPONSE`; mention or attach it only after successful generation and validation.

## Plain language labels

Use these final-answer labels:

- current employee cost reduction
- planned hiring spend reduction
- total planned cost reduction
- review needed
- caution
- approval check
- planning assumption

Do not use jargon such as pipeline avoidance, validation gate, or employee comp review in final user-facing output.

After constructing the complete response but before freezing it as immutable `FINAL_RESPONSE`, apply this longest-phrase-first map case-insensitively to all visible chat and Word text while retaining internal source, capability, field, policy, hidden-metadata, and Excel audit terms: `pipeline future-spend avoidance` becomes `planned hiring spend reduction`; `pipeline exposure` becomes `planned future hiring spend`; `pipeline-first` becomes `planned hiring commitments first`; `pipeline avoidance` becomes `planned hiring spend reduction`; `protect-pipeline` becomes `review user-protected hiring commitments`; `employee-first` becomes `current workforce actions first`; `policy-scored` becomes `assessed for planning priority`; `policy score` becomes `planning priority score`; `policy interpretation` becomes `planning priority`; `eligible record` becomes `record included in planning review`; `coverage gap` becomes `decision information gap`; `validation gate` becomes `approval check`; and standalone `pipeline` becomes `planned hiring commitments`. Treat space and hyphen variants, including `pipeline first` and `policy scored`, as the same terms. Inflect singular and plural naturally without changing meaning.

Scan every visible heading, chart title, caption, Reader's Cue, table header and cell, Insight, bounded-view note, and prose paragraph after normalization. If a prohibited internal term or variant remains, revise the visible text and scan again before artifact handoff.

Use Title Case for headings, chart titles, and table headers, sentence case for prose, and uppercase for EPM, FTE, ID, PDF and HR. Keep `Protected Capability And Retention Guardrails`. Use `Decision Information Gaps And Inference Notes`, never `Evidence Gaps And Inference Notes`, in visible output.

## Name-first evidence

Chat and Word must use business names as primary labels: Employee Name; requisition name or title; offer name or returned candidate/business name; role name or role family; skill name; and business-facing location name. When the name is missing and a stable ID exists, show `ID: [stable ID] (name unavailable)`. For duplicate names, append the stable ID only to duplicated names. When both name and ID are missing, show `Name unavailable` and record a decision information gap. Never invent names.

Excel keeps every record included in planning review and both stable IDs and returned names. Existing ID columns remain unchanged; preserve or add corresponding name columns. Do not apply name-first suppression to the workbook.


## Section and chart presentation

Use clear section headings and place each chart near its related Reader's Cue and table. Let Fusion handle spacing, section separation, and visual presentation naturally. Preserve the same content order in the response document/PDF.  Place each chart immediately before its matching Reader's Cue and table. Do not place charts only at the end.

## Mandatory evidence expansion

Every surfaced key metric must have evidence in chat. Build each evidence table from the complete governed eligible population after scope, eligibility, any actionable user-requested protection, join, and policy-result rules are applied. Rank that population deterministically before limiting rows: use the applicable returned policy score and stable ID for employee evidence; the capability-policy contract's ordered source-record criteria and stable ID for requisition or offer evidence; returned criticality, scarcity, supporting-record count, replacement difficulty, and financial exposure only when governed JSON supplies them and the request makes them relevant; and decision-impact amount, supporting-record count, then display label for aggregate evidence.

Chat and the response document/PDF must show the first five ranked records included in planning review plus all records genuinely tied with rank five on the decision-relevant ranking values. Use identical ordered rows, columns, and values in both. Do not rerank the document independently. Do not place records with unavailable or unresolved planning priority above records with an available planning priority unless the table reports decision information gaps.

After the Insight for each evidence table, add exactly one bounded-view note: `Showing the five most relevant records included in planning review. The workbook contains all records included in planning review.`; `Showing the top-five relevance band, including [N] records tied at rank five. The workbook contains all records included in planning review.`; or `Showing all [N] records included in planning review.` when fewer than five exist.

If action count, returned critical roles, returned scarce skills, current employee cost reduction, planned hiring spend reduction, or an actionable user-requested protection is mentioned, add the appropriate drill-down evidence table. Do not rely only on workbook detail for those surfaced claims. Do not create proxy or inferred records to satisfy a drill-down. If multiple entire drill-down sections have no data, group them into one Decision Information Gaps And Inference Notes section.

## Final response boundary

For every `FULL_PACKAGE` request, the final answer must be immutable `FINAL_RESPONSE`: the complete, terminology-normalized decision package built from retrieved source data and returned policy results. Do not replace it with a short research result, artifact note, or one-table summary. Artifact generation is not completion; the mandatory chat response is required. Workbook, Create Documents response document and supported PDF, and seven-slide deck generation attempts are required. Before freezing `FINAL_RESPONSE`, verify every mandatory core section, the conditional guardrail section only when triggered, meaningful emphasis where useful, and every required chart. Attempt every artifact independently, retry only missing or invalid artifacts once, then silently omit anything still unavailable without a visible artifact failure message or retry prompt.

## Numerical comparisons

Include a clear chart when a table has at least two comparable categories and a meaningful non-zero numeric measure. Let Fusion choose the chart presentation. Include meaningful labels, exact values, units, an accessible description, and a source note.

Build chart aggregates from the full relevant population, not chat-limited rows. Display the leading five aggregate groups and combine all remaining groups into an exact `Other`. Chart and table scope, filters, measures, units, category definitions, ordering, and totals must reconcile. Aggregate individual employee, requisition, or offer records before charting. Omit empty or all-zero charts and explain the data gap in the Reader's Cue.

Use the completed chat chart's data as the authoritative source for artifact charts. Freeze its chart ID, title, source population, filters, categories, ordering, units, exact values, description, and reconciliation with the response. External Charting may create Office-compatible assets from that specification without changing the data or meaning; each destination may apply its native styling.
Charts supplement the required evidence, risk, guardrail, action, and course-of-action tables. Keep the tables and explain unavailable or all-zero chart inputs in the Reader's Cue.

## Pre-send parity check

Before freezing `FINAL_RESPONSE`, verify all 12 core sections, the conditional guardrail section when triggered, and every required table, drill-down, and eligible chart. Check resolved headings, canonical column bindings, populated values, preservation of zero and false, name fallbacks, duplicate-name handling, business terminology, and evidence rankings. Verify that `Assumptions` is the final section, lists all material assumptions or `None.`, and discloses every applied score-input default and affected count. Every table needs a Reader's Cue and an Insight, and evidence tables need their bounded-view notes. Charts must reconcile with the full relevant population and corresponding tables. Let Fusion handle presentation using its native rendering.

After artifact generation, check the document/PDF against the completed response for visible text, section order, evidence rows, cues, insights, notes, and chart data. Check the workbook's required sheets, full evidence, IDs, and names, and the deck's content and ability to open. Correct content failures before returning the response; follow the existing retry policy for artifact failures.
