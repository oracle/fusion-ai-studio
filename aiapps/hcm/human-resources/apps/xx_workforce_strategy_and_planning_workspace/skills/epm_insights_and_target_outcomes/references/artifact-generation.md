<!-- Copyright © 2026, Oracle and/or its affiliates. ** Licensed under the Universal Permissive License (UPL), Version 1.0  as shown at oss.oracle.com/licenses/upl -->

# Artifact Generation

## Workbook

For every `FULL_PACKAGE` request, make a required attempt through the external Create Spreadsheets skill to generate `Outcome_Detail_Workbook.xlsx` from retrieved source data and returned policy results. The workbook is the detailed companion to the chat response. Do not make the generation attempt conditional on artifact mode, action-row count, input style, wording, or an explicit artifact request.

Pass Create Spreadsheets a structured sheet-by-sheet payload, not a prose request, generic source dump, or extraction from bounded chat tables. Require these sheets in this exact order:

1. `ResearchSummary`
2. `TargetSummary`
3. `BusinessSignals`
4. `OutcomeImpact`
5. `RecommendedActions`
6. `Exposure`
7. `TopEvidence`
8. `EmployeeEvidence`
9. `ReqOfferEvidence`
10. `Risks`
11. `CoursesOfAction`
12. `DataCoverage`
13. `WorkbookScope`
14. `AllActionRows`

These 14 core sheets are mandatory. Insert `Guardrails` immediately after `ReqOfferEvidence` only when the user explicitly requested a protection constraint and returned governed data identifies the applicable records. If a core sheet has no applicable records, create it with one explanatory status row rather than omitting it. Use frozen analysis values, including the resolved analytical scoring inputs and explicitly disclosed planning assumptions; preserve their provenance separately from returned source facts. Do not add formulas, scripts, new calculations, fresh imputation, or independent reranking during artifact generation.

The chat response must still include key evidence, including separate current employee evidence and requisition/offer evidence when those action types appear. The workbook contains all records included in planning review and the full supporting breakdown. Populate the structured payload from full-detail populations, never chat-limited rows. Include full action rows with baseline, original returned score where applicable, separate allocation weight, proposed change amount and rate, resulting amount, rule or assumption used, implementation review note, and target reconciliation. Keep actual source values separate from proposed values. Include full employee/requisition/offer evidence, full exposure rows, returned policy results and calculations, assumptions, source coverage, and workbook-scope row counts. Include critical-role, scarce-skill, management-layer, level, or similar specialized evidence only when those attributes are present in returned governed JSON and relevant to the request. Do not generate proxy or inferred records to satisfy an artifact template. Preserve every existing stable ID column unchanged and preserve or add the corresponding returned name column. Do not generate a separate outcome markdown file; immutable `FINAL_RESPONSE` is the final chat response.

Include the complete `Assumptions` disclosure in `ResearchSummary` and the detailed matching, source-freshness, assumption, and score-input audit in `DataCoverage`, retaining the existing sheet order. For every defaulted score input, include employee ID and returned name, original source value or missingness, normalized value, applied default, reason, population scope, and per-field valid/defaulted counts. Retain all employees in the scoring audit, including valid source values unchanged. When no assumptions were applied, record `None.`. Include material semantic equivalences, fallback defaults and their sources, inferred interpretations, date assumptions, and consequential uncertainty. Preserve reference dates separately from source publication dates and effective periods. Preserve the explicit scoring defaults. Preserve the frozen allocation method, baseline choices, freshness caveats, unresolved-context notes, and the specific inputs needed for revisions. Artifact generation must not choose new defaults, compute a new allocation, or reinterpret verified facts.

## Mandatory response document/PDF copy

For every `FULL_PACKAGE` request, make a required attempt through the external Create Documents skill to generate `Outcome_Response.docx` and a PDF when the document capability supports PDF from immutable `FINAL_RESPONSE`. Pass `FINAL_RESPONSE` unchanged plus Office-safe chart assets keyed by the chart IDs already present in it. Do not summarize, rewrite, shorten, reorder, independently select evidence, regenerate headings, or otherwise restructure the response. The document/PDF must end with the same `Assumptions` section, listing all material assumptions or `None.`. It must preserve the same sections and the same section, chart, cue, table, insight, and evidence-note order, including identical visible paragraph text, meaningful emphasis, bounded evidence rows, columns, values, and ordering. The workbook remains the detailed evidence artifact.

Preserve the Research Analysis text and paragraph order using native document formatting. Let the document capability choose its natural headings, layout, emphasis, and section separation. Do not translate chat CSS or impose colors, borders, fonts, padding, or spacing.

## Charts and external Charting

Include a clear comparison chart when a table has at least two comparable categories and a meaningful non-zero numeric measure. Let Fusion choose its native chart presentation. Include meaningful labels, exact values, units, an accessible description, and a source note. Place each chart near its matching Reader's Cue and table.

Useful chart comparisons:

- target coverage by segment
- current employee cost reduction vs planned hiring spend reduction
- role, returned level, location, or function exposure
- compensation cohort exposure
- course-of-action comparison

Charts are decision aids only. They do not replace Business Signal Analysis or evidence tables. Charts are additive: do not alter, remove, shorten, or reorder tables. Generate chart aggregates from the full available analysis data, not bounded chat rows. Display the leading five aggregate groups plus exact `Other`, and require chart scope, filters, measure, units, category definitions, ordering, and totals to match the corresponding table. Add section-level charts for department, location, and role-family concentration when meaningful. Add critical-role, scarce-skill, management-layer, level, or similar charts only when returned governed JSON supplies the dimension and the request makes it relevant. Do not chart individual employee, requisition, or offer records without aggregation. If chart inputs are unavailable or all zero, omit the chart and explain the decision information gap in the Reader's Cue.

Freeze chart IDs and data specifications with the completed response. Include the source population, filters, categories, ordering, units, exact values, description, and reconciliation.When charts exist, invoke the external Charting skill after `FINAL_HTML` is frozen. External Charting is render-only and artifact-only. External Charting may create Office-compatible assets for Word, Excel, and PowerPoint from those specifications without changing the data or meaning. Let each destination use its native presentation. Reject assets with mismatched data. If an eligible chat chart is absent, do not freeze the response or begin artifact handoff.

## Email

Generate `Decision_Follow_Up_Email.txt` when next actions involve teams or stakeholders. The email should be copy-ready and context-driven.

Include:

- subject
- suggested teams
- original request context
- recommended action
- key business signals
- count of current employee review rows and requisition/offer review rows
- evidence summary
- implementation review requested separately from the completed proposed allocation
- timing or next action expectation
- references only to attachments, workbook, response document/PDF, and chart assets that were successfully generated and validated
- a final `Assumptions` section with all material assumptions relevant to the email, or `None.`

## Presentation deck

For every `FULL_PACKAGE` request, make a required attempt through the external Create Powerpoints skill and its supported presentation-generation path to generate `Leadership_Target_Outcome_Deck.pptx`. Never manually assemble a minimal OOXML ZIP package. Pass only frozen business-facing content and resolved plain-text headings; never pass internal heading-map keys as visible slide text. The deck summarizes the same frozen outcome package and does not replace chat. Do not make the generation attempt conditional on audience, input style, wording, or an explicit presentation request.

Use a concise slide flow:

1. Decision summary
2. Target / population summary
3. Business signals
4. Recommended actions
5. `Exposure And Guardrails` when the protection gate is satisfied; otherwise `Exposure`
6. Risks and available courses of action
7. Review and next steps, ending with an `Assumptions` block listing all material assumptions or `None.`

Do not generate the deck for `LIGHTWEIGHT` requests unless the user explicitly requests a presentation artifact.

## Handoff order and validation

After freezing immutable `FINAL_RESPONSE`, full evidence, and chart specifications, maintain an internal artifact ledger with artifact name, attempt count, returned artifact identity, structural validation, reopen/render validation, and final availability. Do not expose this ledger in chat. On the first pass, invoke external Charting when charts exist, then attempt Create Spreadsheets with the structured 14-core-sheet payload plus the conditional `Guardrails` sheet only when triggered, Create Documents with unchanged `FINAL_RESPONSE`, and Create Powerpoints. Attempt every later artifact even when an earlier artifact is missing or invalid. On the second pass, retry only missing or invalid artifacts once and preserve successful first-pass artifacts. Return `FINAL_RESPONSE` unchanged as chat.

Before reporting completion:

- Confirm every returned artifact exists and is non-empty.
- Confirm each returned `.xlsx`, `.docx`, and `.pptx` is a valid OOXML ZIP package with `[Content_Types].xml` and its expected workbook, document, or presentation parts.
- Reopen each returned artifact through its relevant external skill or an available inspection capability.
- Verify the exact 14-core-sheet Excel order, the conditional `Guardrails` sheet immediately after `ReqOfferEvidence` only when triggered, one status row for any non-applicable core sheet, all records included in planning review, stable IDs, returned names, policy results, assumptions, source coverage, workbook-scope counts, and full action rows.
- Verify Word contains every mandatory section and ends with `Assumptions` listing all material assumptions or `None.`, contains no literal HTML, and matches `FINAL_RESPONSE` section order, headings, visible paragraph text, meaningful emphasis, table headers, evidence rows and ordering, chart placement, Reader's Cues, Insights and bounded-view notes.
- Verify record-level allocations reconcile to segment totals, targets, and resulting budgets, original scores remain unchanged, unquantified exposure is distinguished from zero, and implementation approval is separate from planning completion.
- Verify the workbook preserves assumption provenance and score-default audit, and the final deck slide includes `Assumptions` with all material assumptions or `None.`.
- Verify PowerPoint contains `ppt/presentation.xml`, exactly seven slide parts, at least one slide master, at least one slide layout, a theme part, and a relationship file for every slide. Verify presentation relationships include a slide-master relationship; every slide relationship file links to an existing slide layout; and slide shapes contain usable placement geometry or valid inherited placeholders.
- Reopen and render the PowerPoint through the presentation inspection capability. Verify all seven rendered slides appear in the required order. Treat any import or render failure, including `Arg_NullReferenceException`, as artifact failure; ZIP integrity alone is insufficient.
- Verify the PDF opens when required.

If generation or validation fails, retry that artifact once through the same external skill and rerun every applicable structural and render check. After the retry, silently omit an artifact that remains missing or invalid: do not attach it, claim it, mention its failure, add an artifact information gap, or ask the user to retry. Mention and attach only successfully returned and validated artifacts. Artifact failure must not downgrade or replace the full chat package and must not prevent attempts for other artifacts.


## Numerical comparison tables

Charts do not replace tables. Add a chart before a table when the table has at least two comparable categories and a meaningful non-zero numeric measure. Do not remove evidence tables, action tables, risk tables, a triggered guardrail table, or Available Course of Action.
