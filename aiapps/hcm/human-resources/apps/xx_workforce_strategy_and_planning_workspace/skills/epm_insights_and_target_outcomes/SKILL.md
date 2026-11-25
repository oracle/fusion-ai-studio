---
name: epm-insights-and-target-outcomes
description: outcome-driven epm workforce and budget decision analysis for target outcomes across employees, role strategy, location market, budget scenarios, skills, requisitions, offers, and planning enrichment. use for epm inputs in any style, including narratives, statements, questions, commands, calculations, definitions, extractions, rewrites, and follow-ups. default every invocation to the full chat and artifact decision package; use a lightweight response only when the user explicitly requests summary-only output.
---

<!-- Copyright © 2026, Oracle and/or its affiliates. ** Licensed under the Universal Permissive License (UPL), Version 1.0  as shown at oss.oracle.com/licenses/upl -->

# EPM Insights And Target Outcomes

## Purpose

Use this skill to turn EPM workforce, budget, role, location, skill, requisition, offer, and enrichment data into an outcome-driven decision package. The answer must show what outcome is achievable, why the available data supports it, what actions are recommended, which explicit and data-supported protection constraints apply, what risks remain, which courses of action are available, and what communication should happen next.

Do not produce a simple data summary or stop at aggregate targets. Follow explicit user instructions and constraints, then applicable documented defaults; where neither resolves a necessary detail, proceed with a reasonable, context-supported assumption. Do not invent authoritative policies or numeric limits. Ask for clarification only when an essential ambiguity cannot be resolved reliably. Complete the proposed allocation using disclosed, context-supported assumptions and distinguish the proposal from implementation approvals. Do not stop at ranking merely because allocation rules were not supplied; follow `references/business-logic.md` for score-and-salary allocation and reconciliation.

Match fetched data to references semantically using recognized aliases, naming variations, equivalent terminology, and available context; do not force uncertain matches. Synthesize relevant research with matched references, distinguishing sourced facts from inferences. Follow `references/business-logic.md` for matching, precedence, and source provenance, and `references/capability-policy-contract.md` for scoring inputs. The explicit missing-score-input rules remain mandatory: `0.5` when no employee has a valid value for a required field, `0` for missing individual values when at least one employee has valid data, and no change to valid normalized values. These rules override generic fallback assumptions unless the user explicitly changes them.

For time-sensitive tasks without a user-specified date or reporting period, use the current date from the execution context and obtain the latest available relevant information. Distinguish the reference date from publication dates and underlying effective periods. End every completed outcome with **Assumptions**, recording material equivalences, fallback defaults, inferred interpretations, date assumptions, and consequential uncertainty; state **None.** when none were needed.

## Request Mode

Classify request mode before selecting sources or constructing the response.

- Default to `FULL_PACKAGE` for every invocation, regardless of input style, apparent intent, length, structure, wording, or analytical content. This includes statements, narratives, questions, commands, bullets, fragments, definitions, extractions, rewrites, single calculations, follow-ups, and planning scenarios.
- Use `LIGHTWEIGHT` only when the user explicitly requests summary-only output. If summary wording appears with a request for full analysis, recommendations, tables, drill-downs, charts, evidence, artifacts, or the complete package, use `FULL_PACKAGE`.
- Do not infer a lightweight request from simplicity, concise wording, prose format, missing headings, absence of an action verb, lack of planning keywords, or apparently non-analytical content.
- If the request is ambiguous, use `FULL_PACKAGE`.
- Input style and keywords may determine the scenario dimension and relevant sources, but they must never determine whether the complete package is generated.

For `FULL_PACKAGE`, always produce all 12 core chat sections, the conditional `Protected Capability And Retention Guardrails` section only when its protection gate is satisfied, applicable drill-down and evidence tables, and eligible charts. Always attempt the 14-core-sheet `Outcome_Detail_Workbook.xlsx` with a conditional `Guardrails` sheet, `Outcome_Response.docx`, a PDF when the document capability supports PDF, and the seven-slide `Leadership_Target_Outcome_Deck.pptx`. Generate the follow-up email when stakeholder action is present. Missing or limited governed data must create visible decision-information-gap tables and workbook status rows; it must never downgrade the request to `LIGHTWEIGHT`.

For `LIGHTWEIGHT`, answer the explicitly requested summary and end with `Assumptions`, listing material assumptions or `None.`. Do not generate the full package or its artifacts unless the user also explicitly requests them.

## Capability Contract

Invoke only these capabilities using the configured `{{}}` syntax:

- {{getEmployeeData}}
- {{getLocationMarketData}}
- {{getRoleStratergyData}}
- {{getRecquisitionsData}}
- {{getOffersData}}
- {{runWorkforcePolicyAnalysis}}

Before invoking any capability, retrieving data, normalizing records, applying policy calculations, or selecting records, you MUST read and follow `references/capability-policy-contract.md`. That reference is the sole authoritative capability, pagination, normalization, policy-payload, scoring, and selection contract. Do not duplicate or override it in this file.

## Final Response Boundary

For `FULL_PACKAGE`, the final assistant chat message must be the complete decision package built from retrieved source data and returned policy results.

The complete decision package is the final answer. It is not a draft, intermediate artifact source, document-only source, or content to summarize.

After workbook, document, PDF, chart, email, or deck artifacts are generated, return to the original complete decision package and use it as the chat response. Do not replace the chat response with an artifact completion note.

Invalid final chat responses include:

- a short title plus summary paragraph,
- a statement beginning with "Prepared..." or "Generated artifacts include...",
- an artifact list without the full mandatory sections,
- a response that says the detailed answer is in the document,
- a response that contains only Research Analysis,
- a response that omits Business Signal Analysis, Available Course of Action, Review And Decision Loop, or Data Coverage, Assumptions, And Workbook Detail.

If any external artifact skill returns a completion summary, treat that summary as tool status only. Do not use it as the final chat response. The final chat response must still be the complete decision package.

Do not emit JSON as the final response. The user-facing final response must remain the complete decision package.

## Mandatory Response Structure

For `FULL_PACKAGE`, include all 12 core sections below using the resolved display titles. Render `Protected Capability And Retention Guardrails` between the resolved top-evidence section and Risks only when the user explicitly requests a protection constraint and returned data can identify the applicable records. If requested protection cannot be resolved from returned data, report the issue under `Decision Information Gaps And Inference Notes` and do not infer protected records.

1. `Research Analysis`
2. Target-summary slot using `targetSummaryTitle`
3. `Business Signal Analysis`
4. Outcome-impact slot using `outcomeImpactTitle`
5. Recommended-actions slot using `recommendedActionsTitle`
6. Exposure slot using `exposureTitle`
7. Top-evidence slot using `topEvidenceTitle`
8. `Risks, Trade-Offs, And Mitigations`
9. `Available Course of Action`
10. `Review And Decision Loop`
11. `Data Coverage, Assumptions, And Workbook Detail`
12. `Assumptions`

Before rendering chat content or creating charts or artifacts, resolve and freeze `targetSummaryTitle`, `outcomeImpactTitle`, `recommendedActionsTitle`, `exposureTitle`, and `topEvidenceTitle`. Reuse those exact values in chat, chart titles, Reader's Cues, Word/PDF, workbook labels when applicable, and PowerPoint headings when the same section is represented.

Choose the title family using this precedence: first, use the analytical dimension explicitly present in the request; second, corroborate exact values and evidence using governed returned data; third, use a dimension present only in governed data when the request provides none; fourth, use the neutral fallback only when neither source establishes a stronger dimension. The request may establish the dimension, but governed data remains authoritative for exact records, names, evidence, metrics, and calculations. Never use an ID, code, field name, path, capability name, placeholder, truncated value, list, or multiple values as a scope label. Put awkward, unsupported, or misleading scope detail in the Reader's Cue or decision-information-gap section and use the applicable focus-based title.

When a readable business scope is used, render `[Business Scope] Target Summary`, `Outcome Impact For [Business Scope]`, `Recommended Actions For [Business Scope]`, and `Top Action Evidence For [Business Scope]`.

- Region questions: `Regional Target Summary`, `Outcome Impact By Region`, `Recommended Actions By Region`, `Top Regional Action Evidence`.
- Management-cost questions: `Management Cost Summary`, `Outcome Impact By Management Layer`, `Recommended Actions By Management Layer`, `Top Management Efficiency Evidence`.
- Higher-compensation questions: `Higher-Compensation Population Summary`, `Outcome Impact By Compensation Cohort`, `Recommended Actions By Compensation Cohort`, `Top Compensation Efficiency Evidence`.
- Requisition or offer questions: `Hiring Plan Spend Summary`, `Outcome Impact By Hiring Stage`, `Recommended Actions By Hiring Stage`, `Top Requisition And Offer Evidence`.
- Skill or role criticality questions: `Skill And Role Criticality Summary`, `Outcome Impact By Skill Or Role`, `Recommended Actions By Skill Or Role`, `Top Skill-Criticality Evidence`.
- Department or function questions: use `[Business Area] Target Summary`, `Outcome Impact For [Business Area]`, `Recommended Actions For [Business Area]`, and `Top Action Evidence For [Business Area]` when exactly one readable business-area name is confirmed by governed data. When one unconfirmed department is named in the request or multiple departments are named or returned, use `Department Target Summary`, `Outcome Impact By Department`, `Recommended Actions By Department`, `Department Exposure` when department is displayed, and `Top Department Action Evidence`. Put an unconfirmed requested name in the Reader's Cue or decision-information-gap section. In every other case use `Target Summary`, `Outcome Impact`, `Recommended Actions`, and `Top Action Evidence`. Never add `Function` to a visible heading.
- General budget questions: use the focus-based family for the strongest decision dimension supported by the request and data; otherwise use the neutral fallback.

Choose the exposure heading only from dimensions actually displayed. Use `Role And Location Exposure` when role and location are both displayed; `[Dimension] Exposure` when one dimension is displayed; `[Primary Dimension] And [Secondary Dimension] Exposure` when two are displayed; and `Workforce Exposure` when more than two or no clean dimensions are displayed. Include `Level` only when level data is returned and displayed. Put additional dimensions in the Reader's Cue. Final visible headings must not contain `Dynamic`, unresolved square-bracket placeholders, internal heading-map keys, or `By Segment` when a more specific resolved dimension exists.

## Section Rules

### Research Analysis

This is the most important section for C-level readers. Preserve its substantive content: synthesize the generated insights without rephrasing the user input, changing the recommendation, removing evidence, or adding unsupported conclusions. By reading only this section, the user should understand the recommended course, expected outcome, largest visible segments, strongest evidence-backed signals, key guardrails, and the next review posture. Do not mention the raw prompt except when a specific target or constraint materially explains the recommendation.

Present the same content as two to four short, readable paragraphs. Emphasize the key recommendation and any important caution when helpful. Let Fusion choose its native presentation and emphasis. Do not specify colors, fonts, spacing, borders, cards, or rendering markup.

Aim for roughly 150 to 250 visible words as an editorial guide, not a hard limit. Do not remove material evidence, caveats, guardrails, or decisions to meet the range, and do not add filler to reach it. Wrap at least one existing recommendation, expected outcome, or decisive-evidence. Wrap at least one existing assumption, caution, guardrail, unresolved gap, or review-condition. Select both of them dynamically from the generated content; do not use fixed wording, invent content, or rewrite the analysis solely to satisfy formatting. Keep emphasis sparse and meaningful; do not add decorative emphasis, icons, colored text, nested headings, lists, tables, or unsupported claims inside the card.

The response document/PDF must preserve the same visible text, paragraph order, and meaning as chat, using its native document formatting. Before returning, verify that the heading is `Research Analysis`, the content remains substantively unchanged, the card contains readable paragraphs, and chat and the response document/PDF match.

### Target-summary section rules

Show the target population or planning segment in a clear table. Include target, planned outcome, current employee cost reduction, planned hiring spend reduction, number of actions, and readiness in plain language.

### Business Signal Analysis

Explain the business signals behind the recommendation. Use columns such as `Business signal`, `Observed or inferred evidence`, `Decision implication`, `Recommended response`, and `Reasoning used`. Do not use the phrase root cause.

### Outcome-impact section rules

This is the summary table that may include action counts. Do not use “Action Count” in the heading. Include the segment-level baseline, proposed allocation, resulting budget, target reconciliation, and any residual gap here; retain record-level detail in the appropriate evidence tables and workbook.

### Recommended-actions section rules

Place this immediately after the section using `outcomeImpactTitle`. Show proposed allocation amounts and rates, what changes, why, how, when, expected impact, and a plain-language implementation review note. Do not include owner/validator columns. Avoid technical wording such as validation gate; use review needed, caution, approval check, or planning assumption.

### Exposure section rules

Use the data-aware exposure heading defined above. Show where the plan concentrates by the dimensions actually available, such as role, location, department, country, skill, management layer, or level. Do not name a dimension in the heading unless it is returned and displayed. This section should make overexposure and operating-capability concerns visible.

### Top-evidence section rules

Show the most decision-relevant employee, requisition, offer, role, location, or compensation rows in chat. Include enough evidence for the user to understand the recommendation without opening a workbook. Do not claim that a workbook or other artifact is attached inside `FINAL_RESPONSE`; mention or attach it only after successful generation and validation.

### Protected Capability And Retention Guardrails

Render this conditional section only when the user explicitly requests a protection constraint and returned governed data contains the field or stable record identifier needed to identify the affected records. Show only the requested, data-supported protection, its evidence, allowed alternative, and review note. Do not create, infer, or apply a protected population from planning signals alone. If the request cannot be resolved against returned data, omit this section and report a decision information gap.

### Risks, Trade-Offs, And Mitigations

Use exact risk data when available. If exact risk details are not available, infer practical organizational risks from the decision type and state that they are inferred planning risks. Prefer plain wording: risk, where it appears, why it matters, mitigation, and review needed.

### Available Course of Action

Always include this table. Use columns: `Course of action`, `What it means`, `Expected outcome`, `Trade-off`, `Evidence supporting it`, and `Best-fit condition`. Do not include a `Decision needed` column.

### Review And Decision Loop

Separate analytical completion from implementation approval. Deliver the completed proposed allocation, then state what must be reviewed, approved, or supplied before implementing business changes and what inputs would revise the proposal. Do not pause the planning result to request routine approval or confirmation of disclosed assumptions. If communication with teams is appropriate, generate `Decision_Follow_Up_Email.txt`; the template must include request context, key signals, evidence counts, suggested review teams, workbook reference, and specific next actions.

### Data Coverage, Assumptions, And Workbook Detail

Place this immediately before `Assumptions`. Keep it brief in chat. State what data was available, which scoring inputs were defaulted, what remains unverified, and that the workbook contains detailed data coverage, assumptions, calculations, and evidence.

### Assumptions

This is the final section of every completed outcome in both request modes and every follow-up. List material semantic equivalences, fallback defaults and their documented basis, inferred interpretations, date assumptions, and assumed scoring inputs with their affected scope. Explain uncertainty that could materially affect the recommendation. Record the allocation method and reliable knowledge or source used, baseline proxy, scope choices, freshness caveats, and unresolved contextual matches. For each material assumption, identify the input needed for changes; offer a concise, non-blocking invitation to revise the proposal without withholding the completed analysis. Identify scenario estimates and business conventions as assumptions, separate from verified facts. When no assumptions were necessary, write `None.`. Preserve this exact heading and disclosure in the response document/PDF and carry the material assumptions into other artifacts.

## Table And Visual Rules

Use one business-facing heading for each content unit. For every table, use this exact order: section heading; chart when required; Reader's Cue; table; Insight; bounded-view note when the table is an evidence table. Do not add separate chart and table headings.

Use clear section headings and readable tables. Let Fusion apply its natural layout, styling, and section separation. Do not provide CSS, inline styles, markup templates, or fixed presentation measurements.

Before rendering any table, define each column as a visible label, canonical key, and accepted source aliases; never use the visible label directly as the row lookup key. Use semantic matching and context to recognize equivalent source aliases while preserving canonical output keys; leave ambiguous bindings unresolved. Build canonical display rows only after normalization, policy joins, selection, and ranking. For employee evidence, bind `EmployeeName` from `EmployeeName` or `Display Name`; `Role` from `Role` or `Job Name`; `Department` from `Department` or `Department Name`; `Location` from `Location`, `LocationName`, or `Location Name`; numeric `CurrentSalary` from `CurrentSalary`, `Current Salary`, or `salary`; and `PlanningPriority` from an already populated `PlanningPriority`, `Planning Priority`, or `interp`. Never derive `PlanningPriority` or `interp` locally from `score`. Preserve valid zero and false values. Treat only null, undefined, blank strings, and invalid numeric values as unavailable. Never leave a table cell empty; render `Not available` for a genuinely unavailable value and retain any applicable business-data information gap.

Place one short Reader's Cue before each table explaining what to inspect, why it matters, and which decision it informs. Ground it in governed source or policy evidence and identify any disclosed assumptions affecting the result. Do not present assumed inputs or estimates as verified facts. When chart data is unavailable or all zero, explain the reason in the cue.

Place one Insight after each table, grounded in the displayed evidence and explicitly labeled assumptions. Do not repeat the cue or present assumptions as verified facts.

Include a clear comparison chart when a table has at least two comparable categories and a meaningful non-zero numeric measure. Let Fusion choose an appropriate chart and native presentation. Include meaningful labels, exact values, units, an accessible description, and a source note.

Build every chart from the full relevant analysis population, not from chat-limited table rows. Display the leading five aggregate groups and combine every remaining group into an exact `Other` value. The chart and its table must use the same scope, filters, measure, units, category definitions, and ordering, and their totals must reconcile exactly. Place the chart immediately before its Reader's Cue and matching table. Do not create an empty or all-zero chart. Do not chart employee, requisition, or offer records directly; aggregate them first into a non-person-level category such as department, role, location, action, status, or planning area.

Use the completed chat chart's data as the authoritative source for artifact charts. Freeze its chart ID, title, source population, filters, categories, ordering, units, exact values, description, and reconciliation with the response. External Charting may create Office-compatible assets from that specification without changing the data or meaning; each destination may apply its native styling.

Charts supplement the required evidence, risk, guardrail, action, and course-of-action tables. Keep the tables and explain unavailable or all-zero chart inputs in the Reader's Cue.

## Business-Facing Terminology And Casing

Keep capability names, policy action names, source field names, internal instructions, and Excel audit terminology unchanged. After constructing the complete response but before freezing `FINAL_RESPONSE`, normalize all visible chat and Word text using these longest-phrase-first substitutions: `pipeline future-spend avoidance` to `planned hiring spend reduction`; `pipeline exposure` to `planned future hiring spend`; `pipeline-first` to `planned hiring commitments first`; `pipeline avoidance` to `planned hiring spend reduction`; `protect-pipeline` to `review user-protected hiring commitments`; `employee-first` to `current workforce actions first`; `policy-scored` to `assessed for planning priority`; `policy score` to `planning priority score`; `policy interpretation` to `planning priority`; `eligible record` to `record included in planning review`; `coverage gap` to `decision information gap`; `validation gate` to `approval check`; and finally standalone `pipeline` to `planned hiring commitments`. Treat space and hyphen variants, including `pipeline first` and `policy scored`, as the same terms. Use natural singular or plural grammar without changing meaning.

Apply the substitutions case-insensitively to every visible heading, chart title, caption, Reader's Cue, table header and cell, Insight, bounded-view note, and prose paragraph. Scan visible text after normalization. If any prohibited internal term or variant remains, revise the visible text and scan again before artifact handoff. Do not alter capability calls, policy instructions, source fields, hidden metadata, or Excel audit fields.

Use Title Case for section headings, chart titles, and table headers. Use sentence case for prose. Preserve standard acronyms such as EPM, FTE, ID, PDF and HR in uppercase. Keep the heading `Protected Capability And Retention Guardrails`. Use `Decision Information Gaps And Inference Notes`, never `Evidence Gaps And Inference Notes`, in visible output.

## Evidence And Inference Rules

Do not leave mandatory core sections empty. Use returned governed data first. Proceed with reasonable planning assumptions under the Purpose rules and explicitly label them. Analytical inputs prepared under the documented-default and assumption precedence are not verified employee attributes. Preserve original source values and missingness; do not fabricate employee facts, protected records, criticality, scarcity, productivity, compensation position, role status, location status, or offer status. Preserve returned role-strategy and location-market facts while semantically aligning relevant research and reference information; label derived interpretations and do not turn them into automatic employee protection or override an employee policy score. Define higher-compensation populations from populated numeric `Current Salary` values unless another returned governed source supplies the requested compensation measure.

Never infer or use protected-class attributes. If fairness or adverse-impact data is not explicitly provided through an approved path, require HR/legal review rather than inventing it.

## Artifacts

After freezing the complete response, full evidence, and chart specifications, hand off artifacts in this exact order:

1. Invoke the external Charting skill when charts exist. It consumes only chart specifications for charts already present in immutable `FINAL_RESPONSE` and returns Office-safe assets keyed by chart ID without recalculating or changing the meaning.
2. Invoke the external Create Spreadsheets skill for the required `Outcome_Detail_Workbook.xlsx` generation attempt. Pass a structured sheet-by-sheet payload for the 14 mandatory core sheets and the conditional `Guardrails` sheet defined in `references/artifact-generation.md`, using full evidence populations rather than bounded chat rows. Preserve every existing stable ID column and preserve or add its corresponding returned name column.
3. Invoke the external Create Documents skill for the required `Outcome_Response.docx` generation attempt and a PDF when the document capability supports PDF. Pass immutable `FINAL_RESPONSE` unchanged plus artifact-safe chart assets keyed by chart ID. Word must preserve all visible text, headings, section boundaries, evidence rows, charts, Reader's Cues, Insights, bounded-view notes, and meaningful emphasis as native formatting without literal HTML. Do not summarize, rewrite, reorder, independently select evidence, or regenerate headings.
4. Invoke the external Create Powerpoints skill for the required `Leadership_Target_Outcome_Deck.pptx` generation attempt. For every `FULL_PACKAGE` request, preserve the seven-slide executive flow defined in `references/artifact-generation.md`.

Artifact completion messages remain internal status. The final chat response remains the complete frozen decision package. Do not generate an `outcome.md`, `outcome_response.md`, or other standalone markdown response file. Generate `Decision_Follow_Up_Email.txt` when team communication is appropriate.

Before completion, maintain an internal artifact ledger and independently attempt every required artifact once. Confirm each returned artifact exists and is non-empty; confirm `.xlsx`, `.docx`, and `.pptx` are valid OOXML packages; and reopen each through the relevant external skill or an available inspection capability. Verify the exact ordered workbook sheet set, full evidence, IDs, and names. Verify Word against `FINAL_RESPONSE` for section order, headings, visible paragraph text, meaningful emphasis, table headers, evidence rows and ordering, chart placement, Reader's Cues, Insights and bounded-view notes, and confirm that it contains no literal HTML. Verify PowerPoint opens and has the seven required slides; verify the PDF opens when required. After the first pass, retry only missing or invalid artifacts once without regenerating successful artifacts. Continue later artifact attempts even when an earlier attempt fails. After the retry, silently omit any artifact that remains unavailable or invalid; do not attach it, claim it, show failure details, add an artifact information gap, or ask the user to retry.

## Planning Completion And Orchestration

For allocation requests, orchestrate retrieval, normalization, scoring, allocation, reconciliation, response construction, and artifact handoff in that order. Do not treat a successful ranking or aggregate budget envelope as completed allocation. Determine analytical completion separately from implementation readiness: routine approvals, missing implementation dates, freshness caveats, and unmatched nonessential context do not by themselves require user action before presenting the proposal. If the host supports a needs-action status, reserve it for an essential unresolved user decision or input that genuinely prevents reliable completion; do not invent status fields or change source records to implement this guidance. Complete supported work and identify the exact dependency when clarification is essential.

## Follow-Up Questions

For follow-ups, do not only restate the final result. Reuse the prior outcome package and answer with the changed assumption, affected business signals, affected evidence rows, impact delta, risk delta, and updated course of action when relevant. Reassess matches, default applicability, reference dates, and source freshness when context or the employee population changes, and end every completed follow-up with `Assumptions` listing all material assumptions still applied or `None.`.

## References

- See `references/outcome-response-contract.md` for the mandatory response contract and section details.
- See `references/business-logic.md` for budget, data, inference, and guardrail rules.
- See `references/artifact-generation.md` for workbook, chart, email, and deck behavior.
- MUST read and follow `references/capability-policy-contract.md` before every capability invocation, data retrieval, policy calculation, or record-selection operation. It is the sole authoritative capability contract.

## Evidence Tables That Must Not Be Skipped

When Business Signal Analysis or Available Course of Action mentions current employee cost reduction, the response must include a `Current Employee Review Evidence` table in chat. When it mentions planned hiring spend reduction, the response must include a `Requisition And Offer Evidence` table in chat. These tables are required even when a general Top Evidence table is already present.

Employee rows must be framed as planning review candidates only, not final termination decisions. Requisition and offer rows must show which hiring records support planned hiring spend reduction. The workbook should contain the complete detail, but chat must show enough row-level evidence to understand and challenge the recommendation.

Chat and Word evidence are name-first. Display `Employee Name`; requisition name or title; offer name or the returned candidate/business name; role name or role family; skill name; and a business-facing location name. Do not display a stable ID as the primary label when a returned business name exists. If a name is missing but a stable ID exists, display `ID: [stable ID] (name unavailable)`. If duplicate names occur in the same evidence population, append the stable ID only to those duplicated names. If both name and ID are missing, display `Name unavailable` and add a decision information gap. Never invent a name.

Excel retains all records included in planning review and both stable IDs and returned names. Keep existing ID columns unchanged and preserve or add the corresponding name columns. Name-first chat and Word rendering must not delete, rename, or suppress workbook ID fields.

## Response Completeness And Evidence Gate

For `FULL_PACKAGE`, the response must not omit mandatory core sections. If exact rows are unavailable for a surfaced claim, render a missing-evidence table that explains what was unavailable and what would strengthen the recommendation; do not invent proxy records.

Every key metric or key data point surfaced in the response must have supporting evidence in chat and full detail in the workbook. This includes action counts, current employee cost reduction, planned hiring spend reduction, role/location concentration, compensation-cohort signals, and any specialized attribute actually returned and surfaced. Protection metrics may appear only when the user requested the protection and returned data identifies the affected records.
If the response states a number such as planning actions, current employee review rows, requisition or offer rows, data-supported critical-role rows, data-supported scarce-skill rows, user-requested protected records, or regional/function target coverage, a supporting drill-down table must appear in chat. Do not place the detail only in the workbook. If exact drill-down rows are unavailable, render a missing-evidence table explaining what data was unavailable and what would strengthen the recommendation; do not infer the rows.

If multiple whole drill-down sections have no data, group those gaps into a single `Decision Information Gaps And Inference Notes` section instead of repeating multiple no-data tables. Never prefer inferred record evidence over a disclosed data gap.

Build each evidence table from the complete governed eligible population after scope, eligibility, any actionable user-requested protection, join, and policy-result rules are applied. Rank before limiting rows. Rank employee reduction evidence by reduction score descending and then `EmployeeID` ascending. Rank raise, retention, and investment evidence by raise score descending and then `EmployeeID` ascending. Rank requisition and offer evidence by controllable status, lower priority, growth before backfill, earlier start or expiration date, lower exposure, and then stable requisition or offer ID. When returned governed JSON supplies critical-role or scarce-skill attributes and the request makes them relevant, rank those evidence rows by their returned values, supporting-record count, applicable financial exposure or replacement difficulty, and then stable ID or name. Rank location, department, role-family, compensation-cohort, and other aggregate evidence by decision-impact amount, supporting-record count, and then display label.

Chat and the response document/PDF must show the first five ranked records included in planning review plus every record genuinely tied with rank five on the decision-relevant ranking values. They must use the same ordered rows, columns, and values. If more than five rows are shown because of a rank-five tie, say so explicitly. Do not rank records with unavailable or unresolved planning priority above records with an available planning priority unless the table specifically reports decision information gaps.

After each evidence table, append one bounded-view note after the Insight. Use `Showing the five most relevant records included in planning review. The workbook contains all records included in planning review.` when at least five records exist without a cutoff tie; `Showing the top-five relevance band, including [N] records tied at rank five. The workbook contains all records included in planning review.` when rank five is tied; or `Showing all [N] records included in planning review.` when fewer than five exist.

When returned governed JSON supplies critical roles and the request makes them relevant, include a `Critical Role Evidence` table showing only returned roles or role families and their returned support. When returned governed JSON supplies scarce skills and the request makes them relevant, include a `Scarce Skill Evidence` table showing only returned skills and their returned support. Do not create skill proxies or infer these records to satisfy an evidence template.

## Contract Verification Cases

Before release or after any contract change, verify the rules without adding package scripts. Exercise regional, management, compensation, hiring, skill/role, named department, multi-department, and unclassified requests; one and multiple exposure dimensions; no level data; complete, missing, and duplicate business names; fewer than five evidence rows; exactly five rows; more than five rows without a cutoff tie; and a genuine rank-five tie. Confirm focus-based, business-name, exposure, and neutral fallback headings; meaningful emphasis where useful; case and hyphen terminology variants; name-first display and all fallbacks; identical chat/Word rows; all 14 core workbook sheets plus the conditional `Guardrails` sheet when triggered; exact top-five-plus-ties behavior; native Fusion rendering; consistent chart data; and external Charting data parity.

Verify request mode with structured objectives, a declarative project-budget paragraph, a question, a command, bullets, fragmented notes, an executive narrative, a definition, an extraction, a rewrite, a single calculation, a follow-up, a request with no action verb, and an ambiguous input; all must select `FULL_PACKAGE`. Confirm only explicit summary-only requests select `LIGHTWEIGHT`, and full-package requirements override summary wording. Confirm insufficient governed data retains all 12 core sections and uses gap tables and workbook status rows. For every `FULL_PACKAGE` case, verify all 12 core chat sections, the conditional guardrail section only when triggered, applicable drill-downs, eligible charts, the exact 14-core-sheet workbook order with the conditional `Guardrails` sheet only when triggered, Word and supported-PDF parity, and the seven-slide deck.

Verify score preprocessing for all-missing and all-null fields (`0.5`), mixed valid/missing fields (`0` for missing only), valid zero values, unchanged valid normalized inputs, shared inputs across scoring calculations, and populations spanning multiple batches. Confirm a valid value in a later batch prevents a population-wide `0.5` default for that field. Reject alternative imputation unless explicitly instructed.

Verify semantic matching for recognized aliases, naming variations, contextual disambiguation, unresolved matches, and research/reference conflicts. Check explicit-instruction precedence, documented defaults, disclosed assumptions where no default exists, preservation of valid inputs, shared-input consistency, unchanged source data, and excluded scoring factors. Verify user-specified periods, current-date fallback, source publication/effective-period distinctions, and freshness limitations. Confirm every completed outcome ends with `Assumptions` covering material equivalences, defaults, interpretations, date choices, and consequential uncertainty, with chat/artifact parity. Verify provided-rule and absent-rule allocations, scores unchanged while amounts use scores and salary, salary-baseline fallback, all-zero or tied scores, target reconciliation and rounding, genuine infeasibility, incomplete hiring financials, unmatched context, and freshness caveats. Confirm supported allocations complete without routine approval blockers, implementation requirements remain separate, and revision guidance identifies change inputs without pausing the result.

As a static contract check, fail validation if any legacy broad-or-structured response-routing gate, artifact-mode gate, or dependency on an absent package-builder script reappears. Domain phrases such as `broad cuts` are not response-routing gates and may remain.

## Pre-Send Content And Parity Check

Before freezing `FINAL_RESPONSE`, verify all 12 core sections, the conditional guardrail section when triggered, and every required table, drill-down, and eligible chart. Check resolved headings, canonical column bindings, populated values, preservation of zero and false, name fallbacks, duplicate-name handling, business terminology, and evidence rankings. Verify that the final section is `Assumptions`, lists every material assumption or `None.`, and includes defaulted scoring fields, applied rules, and affected counts. Every table needs a Reader's Cue and an Insight, and evidence tables need their bounded-view notes. Charts must reconcile with the full relevant population and corresponding tables. Let Fusion handle presentation using its native rendering.

After artifact generation, check the document/PDF against the completed response for visible text, section order, evidence rows, cues, insights, notes, and chart data. Check the workbook's required sheets, full evidence, IDs, and names, and the deck's content and ability to open. Correct content failures before returning the response; follow the existing retry policy for artifact failures.

Do not silently omit, fabricate, substitute, or downgrade business content when a content or data check fails. Render a visible decision-information-gap table using the same Reader's Cue, table, and Insight structure, and state what could not be verified and what would resolve it. This visible-gap rule applies to business content and data only. Artifact-generation failures follow the silent-omission policy above after one retry.
