<!-- Copyright © 2026, Oracle and/or its affiliates. ** Licensed under the Universal Permissive License (UPL), Version 1.0  as shown at oss.oracle.com/licenses/upl -->

# Business Logic

## Generalized data model

Use whatever governed data is returned from employees, role-strategy policy JSON, location-market policy JSON, budget scenarios, skill taxonomy and criticality, requisitions, and offers. Treat requisition and offer inputs as hardcoded source records. Do not invent an enrichment source or attribute that is not returned.

Do not force the exact data categories listed in the user prompt. Build categories dynamically from the received data. If the data includes region, group regionally. If it includes department/function, group by function. If it includes management layer, group by layer. If it includes compa-ratio and level, build compensation cohorts. If it includes requisitions/offers, build hiring-stage and planned-hiring-spend views.

## Budget and cost terminology

Use plain language:

- current employee cost reduction: cost reduction from current employee actions.
- planned hiring spend reduction: planned future spend reduced through requisition freeze/cancel/review or offer pause/reprice/review.
- total planned cost reduction: combined current employee cost reduction plus planned hiring spend reduction.

For budget planning, include current employees and hiring commitments unless the user explicitly restricts scope. Keep employee cost changes, planned hiring spend changes, and combined impact separate. Match the target denominator to the stated scope and disclose the baseline used; do not silently substitute a different population. Deduplicate linked commitments before financial aggregation.

## Semantic Matching And Contextual Synthesis

Match fetched data to reference information by meaning, accounting for recognized aliases, naming variations, and equivalent terminology. Use available organizational, entity, unit, and temporal context to resolve ambiguity. Preserve source labels and stable identifiers, record material equivalences and their supporting context, and leave uncertain matches unresolved rather than forcing them. Treat unmatched reference context as a caveat unless an explicit requested constraint depends on that match; do not block otherwise supported allocations. Semantic similarity alone does not establish record identity.

Align relevant research findings with matched reference data to form a coherent analysis. Check that scope, units, and effective periods are comparable; explain conflicts or limitations. Distinguish sourced facts, documented rules, and analytical inferences, and retain source attribution.

## Assumption-Based Execution

Follow explicit user instructions and constraints first. The required-score-input rules in `capability-policy-contract.md` are explicit user instructions. Do not replace these rules with generic defaults or assumptions unless explicitly instructed. Where a rule, threshold, percentage, or required input is unspecified, use the applicable documented default and identify its source and scope. If none exists, make a reasonable, context-supported assumption when needed to proceed, labeling it as an assumption rather than an established rule. Do not invent authoritative policies or numeric limits. An assumption must not override an explicit constraint or be presented as satisfying an unverified mandatory requirement.

Prioritize completing the requested proposed allocation and analysis rather than stopping at aggregate targets or rankings. Ask for clarification only when an essential ambiguity cannot be resolved reliably through available evidence and disclosed planning assumptions. Complete supported parts while isolating any genuinely unresolved dependency; do not treat ordinary implementation review as an analytical blocker. Preserve original source data; keep derived or assumed analytical inputs and their provenance separate from verified facts. For score-input preparation, apply the specific rules in `capability-policy-contract.md`; use the general fallback hierarchy only for matters not already covered by explicit instructions.

## Proposed Allocation

Follow provided allocation rules and explicit constraints first, then applicable documented rules. When no allocation rules are present, select a transparent, reproducible planning method using reliable applicable domain knowledge, available reference evidence, returned policy scores, and salary or comparable monetary exposure. Explain the method and its evidential basis as a planning assumption; do not present it as client policy, invent authoritative limits, or stop at ranking merely because a method was not supplied.

Use scores and salary together to determine employee allocation amounts when rules are absent. Preserve returned scores exactly and distinguish them from derived allocation weights, amounts, and rates. A score establishes planning priority; it is not itself a compensation-change percentage or an instruction to remove an employee. Keep score-based evidence ordering intact while separately calculating amounts. Apply provided allocation rules when present even if their amount distribution differs from the fallback method.

Use a proportionate, score-informed monetary allocation where supported by the context. Explain how score direction and salary exposure determine weights, normalize allocations to the requested monetary target, and apply only supplied or documented constraints. If scores cannot differentiate the population, use a disclosed salary-proportionate fallback rather than inventing discriminatory priorities or score values. Do not add arbitrary multipliers, caps, protected groups, or fixed regional/role assumptions. Handle known bounds, ties, zero weights, and rounding deterministically; redistribute rounding residuals within constraints. If the target is infeasible under actual constraints, show the feasible allocation and exact remaining gap rather than claiming success.

Use available salary as a disclosed planning baseline when a more specific compensation budget is unavailable, and complete the proposed allocation. Preserve the original salary; proposed budgets or compensation amounts are analytical outputs, not updates to employee records. Use compatible periods, units, and currencies. Include hiring commitments in scope and quantify their exposure and proposed changes from available data, separating measured amounts from defensible estimates. Missing hiring financials must remain visibly unquantified where no reliable estimate exists; do not treat them as zero or let them block the quantifiable employee allocation. Disclose whether the target applies to the known baseline or a broader, partially unquantified scope.

Before completing, reconcile record-level allocations to segment and total results. Show the baseline, target change, proposed amounts and rates, resulting budget, action counts, and any residual gap. Distinguish a completed planning proposal from realized savings and from implementation readiness. Pending business approval, local review, or permission to change source records belongs under implementation requirements and does not prevent completing a proposed allocation.

## Current Information

Honor the user's specified date or reporting period. Otherwise, when the task requires time-sensitive information, use the current date from the execution context as the reference point and obtain the latest available relevant information through available sources. Do not request an effective date merely because none was supplied. Distinguish the analysis reference date from each source's publication date, retrieval date, and effective or reporting period; a recent publication may describe older data. Proceed with available information and disclose unavailable current information, stale sources, and material period mismatches as freshness caveats rather than claiming verification. Missing source effective periods alone do not block a planning proposal; isolate only a dependency that genuinely prevents reliable calculation.

## Assumptions

End every completed outcome, including summaries and follow-ups, with `Assumptions`. Record material semantic equivalences, fallback defaults and their documented basis, inferred interpretations, date assumptions, and assumed analytical inputs. Explain uncertainty that could materially affect the result. Distinguish documented defaults from discretionary assumptions and reuse the same provenance across chat and artifacts. For each material choice, include its rationale, affected scope, and what information the user can provide to revise it. End the section with a concise, non-blocking invitation identifying the relevant rules, baseline, scope, period, or constraints needed for changes. Do not require the user to confirm reasonable assumptions before delivering the allocation. If no material assumptions or fallback choices were needed, state `None.`.

## Guardrails

Never present employee actions as final termination decisions. Present proposed employee actions as planning review candidates or cost actions requiring implementation review. Complete their analytical allocation before listing approvals; do not interpret review requirements as a prohibition on proposing amounts.

Do not create default protected populations. Apply and report a protection only when the user explicitly requests it and returned governed data contains the field or stable record identifier needed to identify the applicable records. If either condition is missing, do not infer or enforce protection; report a decision information gap when the user requested an unavailable protection.

Never infer or use protected-class attributes. If adverse-impact or fairness data is not explicitly provided through an approved path, require HR/legal review rather than inventing the analysis.

## Required outcome behavior

For `FULL_PACKAGE` target-outcome requests:

- Do not return only a recommendation paragraph.
- Do not return only a target summary table or ranked records when allocation is requested; deliver the proposed amounts and reconciliation.
- Separate completed planning work from outstanding implementation approvals and provide non-blocking revision guidance under Assumptions.
- Do not show action count without a separate recommendation drill-down table.
- Do not claim planned hiring spend reduction without requisition or offer evidence, unless clearly marked as a scenario assumption.
- Do not claim current employee cost reduction without employee evidence, unless clearly marked as a scenario assumption.
- Do not claim exact legal or consultation risk unless supporting location/legal data exists.
- Always include Available Course of Action.
- Always include brief data coverage followed by the final `Assumptions` section, listing all material assumptions or `None.`.
