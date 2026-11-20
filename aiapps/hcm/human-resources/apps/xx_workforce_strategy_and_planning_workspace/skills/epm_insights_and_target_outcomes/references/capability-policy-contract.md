## Capability Contract

Invoke only these capabilities using the configured `{{}}` syntax:

- {{getEmployeeData}}: employee records.

Use {{getEmployeeData}} to retrieve all required employee records in batches of 900. You should always paginate for every user query until all the required data is fetched continue until finished is true.

Derive inputMessage from the user’s request using only these supported employee filters:

- Job Name
- Job Family
- Department Name
- Business Unit Name
- Location Name
- Country

If the request has no employee filter, use:
Fetch all employees.

If the request specifies supported filters, express those filters clearly in the inputMessage. Resolve recognized aliases and naming variations using available context without changing the user's intended scope or replacing a field with a different concept. Do not add unrequested filters or force uncertain matches. Where an essential ambiguity remains, follow the clarification rule in `business-logic.md`.

For the first call, pass sessionId: null, queryId: null, columnMap: {}, the batch size of 900, and the derived inputMessage. For every subsequent call, pass the same exact inputMessage and batch size together with the latest returned sessionId, queryId, and columnMap. Append each returned employee record to an in-memory list and continue until finished is true. Only then use the complete retrieved population for scoring, analysis, recommendations, or outputs. Always follow this pagination rules.

## Mandatory Pagination Policy

This API supports pagination.

Execution requirements:

- ALWAYS retrieve data using pagination.
- NEVER assume a single response is complete.
- Continue requesting pages until the API explicitly indicates completion.
- Merge all pages into one logical dataset.
- Perform filtering, ranking, aggregation, summarization, and reasoning only after the complete dataset has been assembled.
- If pagination cannot be completed because of connector limits, timeouts, or execution constraints, explicitly inform the user that the response is based on a partial dataset.

- {{getLocationMarketData}}: location and labor-market context.
- {{getRoleStratergyData}}: role criticality, market, raise caps, and reduction sensitivity.
- {{getRecquisitionsData}}: requisition and hiring-pipeline records.
- {{getOffersData}}: offer and future-workforce-commitment records.
- {{runWorkforcePolicyAnalysis}}: approved raise and reduction priority scores.

For `FULL_PACKAGE`, retrieve employees, requisitions, offers, role strategy, and location context unless the scenario or user explicitly limits the relevant source domain. For `LIGHTWEIGHT`, retrieve only the sources needed for the explicitly limited answer. Normalize source data using stable employee, requisition, and offer IDs. Limited or unavailable sources must not downgrade a `FULL_PACKAGE` request or block allocation from the usable information. Include both employee and hiring commitments unless explicitly restricted; disclose unquantified exposure separately. Preserve role-strategy and location-market policy JSON as governed source data. Match it semantically to relevant fetched data and research under `business-logic.md`, recording inferred links separately; it must not override employee policy scores or create automatic protection. Treat requisition and offer inputs as hardcoded source records and preserve their deterministic exposure, linked-record deduplication, and stable-ID handling.

## Operating Workflow

1. Set `FULL_PACKAGE` or `LIGHTWEIGHT` using the deterministic Request Mode rules in `SKILL.md`.
2. Classify the request intent and target dimension: region, function, department, management layer, compensation cohort, role family, location, skill/criticality, hiring stage, scenario, or general budget.
3. Fetch all pages and normalize the relevant capability outputs. Resolve semantic matches, reference dates, and applicable defaults under `business-logic.md`, then prepare scoring inputs under the rules below before splitting scoring batches or selecting records. Build categories dynamically from the data received; do not force a fixed category list from the prompt or from this skill.
4. Set budget labels in user-facing language:
   - Use **current employee cost reduction** for savings from active employee actions.
   - Use **planned hiring spend reduction** for future spend reduced through requisition freeze/cancel/review or offer pause/reprice/review.
   - Use **total planned cost reduction** for the combined plan impact.
5. Use {{runWorkforcePolicyAnalysis}} for deterministic scoring and preserve returned scores. Then execute the proposed-allocation guidance in `business-logic.md`: apply provided allocation rules, or derive amounts using scores, salary, and reliable applicable knowledge when rules are absent. Calculate record-level amounts, resulting budgets, and totals before assembling the response; do not stop at scoring or ranking. Allocation arithmetic is permitted and must not recalculate or replace a policy score.
6. For `FULL_PACKAGE`, reconcile proposed record-level amounts to the target and segment totals, then construct the complete decision package from the scored population, proposed allocation, warnings, source coverage, and request context, end it with `Assumptions` listing all material assumptions or `None.`, then freeze it as immutable `FINAL_RESPONSE`. Do not depend on a local package-builder script or create an outcome markdown file.
7. Before returning, verify that `FINAL_RESPONSE` includes every mandatory section, applicable evidence table, drill-down, and eligible chart. Mention only artifacts that were actually generated and validated. Artifact failures follow the independent retry and silent-omission policy in `references/artifact-generation.md`.
8. For `FULL_PACKAGE`, always generate the 14-core-sheet workbook with the conditional `Guardrails` sheet only when its protection gate is satisfied, the response document and supported PDF, and the seven-slide deck, regardless of action-row count, artifact mode, user wording, or audience.

Artifact creation must happen after immutable `FINAL_RESPONSE` is available. Artifact completion messages are not the final answer. Attach or link required artifacts only after the full chat response. Attach or link chart, email draft, and deck only when they are actually generated.

## Policy Rules

Cache complete records and completed scores in `workforce_policy_cache.json`; reuse matching complete sources and score types for follow-ups, invalidate on source, policy, normalization, missing-data-rule, employee-population, or per-field valid-data-coverage, matched-reference, allocation-rule, allocation-assumption, analysis-period, or source-freshness change, and never cache final employment decisions. Cache matching provenance, the analysis reference date, source effective periods and freshness, population scope, and per-field default decisions with the normalized inputs; never reuse defaults or scores for a subset or changed population without recomputing valid-data coverage.

Call {{runWorkforcePolicyAnalysis}} in batches of 25. Use only this request shape; do not send one-row probes, original employee rows, source-label keys, or any other payload shape:

```text
action: <getRaiseFormulaBatch or getReductionFormulaBatch>
payload: { records: [ { employeeId, normalized formula fields } ] }
```

The scorer accepts only canonical formula field names inside `payload.records`. Build a new scorer payload from the employee source row before every scoring call. Never pass employee source fields such as `Performance Rating`, `Career Potential`, `Risk of Loss`, `Impact of Loss`, `Person Number`, `Current Salary`, or the full employee record into `payload.records`.

Normalize the {{getEmployeeData}} payload into canonical planning fields before selection and rendering: `Person Number` to `EmployeeID`, `Display Name` to `EmployeeName`, `Job Name` to `Role`, `Job Family` to `RoleFamily`, and `Department Name` to `Department`. Preserve `Person ID`, `Assignment Number`, `Manager Person Identifier`, `Business Unit Name`, `Legal Employer Name`, `Manager Name`, `Location Name`, `Country`, `Enterprise Hire Date`, `FTE`, and `Work At Home` as returned identifiers or planning context. Preserve `Compa-Ratio`, `Enterprise Seniority Date`, and `Grade Name` only when populated. Use `Current Salary` as current compensation only when it is populated and numeric. If it is unavailable or invalid, preserve that absence and disclose the affected count. Where an applicable documented default or defensible assumption supports a planning estimate, keep that estimate separate and labeled; do not present assumed compensation or cost impact as a verified employee fact. Use contextually supported reference matches for analysis, preserving source fields and labeling derived or assumed values separately; do not copy attributes across entities merely because their labels are similar.

Use `getRaiseFormulaBatch` for raise, compensation-pool, market-correction, retention-investment, and protection-prioritization scenarios. Use `getReductionFormulaBatch` for reduction and over-market scenarios. Submit every eligible employee in its 25-record batch with `employeeId` and the required canonical inputs for the selected action after applying the missing-score-input rules below. Do not send raw employee rows, display-label field names, unsupported values, or locally reweighted scores. Prepare required scoring inputs using the explicit missing-score-input rules below, with provenance outside the payload. Missing or null source scoring inputs must not exclude an employee or prevent scoring; do not substitute generic assumptions for these prescribed defaults. Join only the capability's returned scores by `employeeId` and disclose rows still unscored because of capability errors.

Recognize equivalent source terminology using semantic matching and context before mapping to the canonical fields below. Record material equivalences; do not force uncertain mappings or change the capability's required machine-facing keys.

Build canonical scorer fields as follows:

- `Person Number` or `EmployeeID` -> `employeeId`.
- `Performance Rating` -> `Performance`: `Outstanding` to `1.0`; `Exceeds expectations` to `0.8`; `Meets expectations` to `0.6`; `Inconsistently meets expectations` to `0.4`; `Unsatisfactory` to `0.2`.
- `Career Potential` -> `Potential`: `Low` to `0.2`; `Medium` to `0.6`; `High` to `1.0`.
- `Risk of Loss` -> `Retention`: `Low` to `0.2`; `Medium` to `0.6`; `High` to `1.0`.
- `Impact of Loss` -> `Impact`: `Low` to `0.1`; `Medium` to `0.45`; `High` to `0.75`; `Mission Critical` to `1.0`. `Mission Critical` is only a normalized `Impact` input; it does not imply role criticality or automatic protection.
- `CompaRatio` or `Compa-Ratio` -> canonical `CompaRatio` (usually percentage, can be more than 100. normalize by dividing with 100). When populated and numeric, derive `UnderMarket = max(0, 1 - CompaRatio)` for raise scoring and `OverMarket = max(0, CompaRatio - 1)` for reduction scoring. When blank, unavailable, or invalid, preserve the missing `CompaRatio` in source data and leave the derived scoring inputs unavailable until applying the missing-score-input rules below. Apply the prescribed missing-score-input default to the required derived input (`UnderMarket` or `OverMarket`) directly; do not default `CompaRatio` and then derive a different value.

For `getRaiseFormulaBatch`, records may include only these keys: `employeeId`, `Performance`, `Potential`, `Retention`, `UnderMarket`, and `Impact`. For `getReductionFormulaBatch`, records may include only these keys: `employeeId`, `Performance`, `OverMarket`, and `Impact`. Apply missing-score-input preprocessing to every required field before sending records; omit fields belonging only to the other action. Keep default provenance outside the payload so these key allowlists remain unchanged.

### Missing Score Inputs

Apply these rules to every field required by a scoring calculation. For raise scoring, the required fields are `Performance`, `Potential`, `Retention`, `UnderMarket`, and `Impact`. For reduction scoring, they are `Performance`, `OverMarket`, and `Impact`. Productivity (including `ProductivityIndex`), Criticality (including `StrategicCriticality`), and SkillScarcity (including `Scarcity`) remain excluded from scoring and must not be defaulted or reintroduced.

1. Assemble the complete employee population retrieved for the use case, normalize supported source values, and validate scoring inputs before assessing missingness. Determine valid-data coverage across all employees in this population, before ranking, action selection, exclusions, or splitting into 25-record scoring batches. Do not determine defaults separately by page, batch, department, selected action rows, or score type. An empty population produces no employee rows or invented scores.
2. For each required canonical field independently, if **no employee has a valid value**, assign **`0.5`** (neutral mean) to that field for **all employees** in the population. This applies when the field is absent or null across the population.
3. If **at least one employee has a valid value**, preserve every valid normalized value and assign **`0`** only to employees with missing or null values for that field. A valid zero counts as valid data; never use truthiness to test coverage.
4. Treat absent fields, null, undefined, blank strings, and values rejected by the existing normalization/range validation as unavailable for these rules. Record invalid source values as data-quality issues; do not clamp or silently replace a valid value. Preserve the established categorical-to-numeric normalization; do not remap valid normalized values. Apply defaults after normalization and derive compensation gaps only from a valid returned compa-ratio.
5. Apply the resulting values consistently across all employees and every scoring calculation. Shared fields such as `Performance` and `Impact` must use the same preprocessed value in raise and reduction scoring. Keep the same formulas, weights, inversions, and thresholds; do not recalculate scores locally. A default of `0` is the literal input, even where a formula inverts that input.
6. Preserve original source records and missingness unchanged. Maintain a separate per-employee, per-field audit of the original value or absence, normalized scoring input, whether it was defaulted, the applied `0.5` or `0` rule, population scope, and valid/defaulted employee counts. Pass only the action-specific canonical fields to the scoring capability; do not add audit keys to `payload.records`.
7. Disclose defaulted fields, applied values, reasons, and affected counts under `Assumptions` at the end of every completed outcome. Include the detailed audit in the workbook. Never present a default as a measured employee characteristic or verified source value. Do not introduce alternative defaults, population averages, medians, role/location enrichment, or other imputation methods unless explicitly instructed.

These are score-input preprocessing rules. They do not authorize defaulting employee identifiers, salaries, FTE, protected attributes, source statuses, source records, or final scores. Use reasonable, labeled planning assumptions for unspecified use-case parameters under `business-logic.md`, while keeping verified facts separate. If retrieval is incomplete, do not assert that a field is missing across all employees; any analysis based on the available population must be explicitly provisional and disclose that scope and limitation.

The raise and reduction policy returns `{ employeeId, score }` results. Join returned scores by `employeeId`, preserve returned scores and errors, and keep scores internal unless explicitly requested. Keep capability errors as unscored rows, disclose their count, and never recreate a missing policy score locally.

### Deterministic Scoring And Selection

Apply only the user’s explicit scope and actionable inclusions, exclusions, and protection constraints before scoring. Apply a protection constraint only when the user explicitly requests it and returned data contains the field or stable record identifier needed to identify the applicable records. If the request cannot be resolved against returned data, do not infer protected records; report a decision information gap. Score every remaining eligible employee in the selected scope using the population-preprocessed canonical inputs; never skip an employee because a required source scoring field was missing or null. Apply the prescribed defaults before scoring; preserve and disclose capability errors rather than manufacturing scores.

Do not change policy scores, invent protections or exclusions, or override score-based employee evidence ordering from planning signals. Separate allocation amounts may reflect provided allocation rules or the disclosed score-and-salary method; this does not alter returned scores or automatically protect a population. Only the action-specific canonical scoring inputs listed above may be passed to {{runWorkforcePolicyAnalysis}} using valid normalized source values or the explicit missing-score-input defaults specified above; excluded factors remain outside scoring even when populated. For employee evidence ordering, preserve the returned score as the primary ranking criterion and use `EmployeeID` as the deterministic tie-breaker. Do not recalculate, reweight, or replace returned scores. This restriction does not prohibit calculating separate allocation weights or amounts: follow provided allocation rules first, otherwise combine scores and salary using the method documented under `Proposed Allocation` in `business-logic.md`. Include current employees and hiring commitments unless explicitly restricted. Do not impose an automatic hiring-first sequence when no allocation rule establishes one; explain the selected distribution using the available evidence. Keep employee reduction, pipeline avoidance, and total plan impact separate. Requisition exposure is `ApprovedBudget * FTERequested`; offer exposure is `ProposedTotalComp * FTE`; active offers replace linked requisitions. Rank requisition and offer source records by user constraints, controllability, priority, growth/backfill, date, exposure, then stable ID; do not apply automatic criticality or scarcity protection or prioritization. Treat genuine ties as tied review sets.
