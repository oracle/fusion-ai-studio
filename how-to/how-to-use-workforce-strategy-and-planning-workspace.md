# How to use Workforce Strategy and Planning Workspace Agentic Application

## 1. What the application does

Workforce Strategy and Planning brings EPM forecast signals together with HCM workforce information to help you understand workforce trends, investigate gaps, and develop proposals aligned with business outcomes.

You can begin with an EPM signal or a Research task. The configured analysis considers relevant employee information, role strategy, location-market context, requisitions, and offers. It is designed to produce recommendations, supporting evidence, proposed allocations where relevant, risks, alternatives, and next steps.

Treat proposed allocations as planning recommendations requiring implementation review. A completed analysis does not establish that employee records, EPM budgets, requisitions, offers, or signal statuses have changed. The current local application does not define a save-to-plan, approval-submission, or signal-status-update action.

## 2. Before you begin

Ensure you have access to the agentic application, a configured EPM instance, and the data required for your analysis. Contact your administrator for the application launch link and access instructions.

### Step 1: Configure the EPM instance
1. Sign in to your Fusion environment.
2. Open AI Studio at https://<hostname>/hcmUI/redwoodAI.
3. Navigate to Credentials → Data Source Applications.
4. Click Add Data Source and provide the following EPM instance details:
   - EPM instance base URL
   - IDCS URL
   - Client ID
   - Scope
   - Public key
   - Private key
5. Ensure the data source Code starts with EPM. The application lists only data sources whose codes begin with this prefix.

### Step 2: Verify access to OTBI subject areas
Ensure users accessing the agentic application have access to the following OTBI subject areas:
1. Compensation - Workforce Assignment Salary Real Time
2. Workforce Profiles - Person Profile Real Time
3. Recruiting - Recruiting Real Time

## 3. Quick start: Review a signal

1. Run the Open **Workforce Strategy and Planning Workspace** in VS Code and Run the App.
2. Use **Select an application instance** to choose the intended EPM connection.
3. Review the **Signals** panel, supplied by **EPM Forecast Signal Insights**.
4. Select a signal to open its details.
5. Read its insight, evidence, and planning context.
6. Select **Explain** at the end of the details to launch Research using the signal's insight text.
7. Review the decision package and any generated supporting files.
8. Refine the proposal with a follow-up that states the changed target, scope, or constraint.

## 4. Understand the Signals panel

Each returned signal can display:

| Display element | Meaning |
| --- | --- |
| Title | Signal type, with the account or entity when provided. |
| Planning context | Returned dimensions such as entity, account, scenario, version, year, period, and currency. |
| Insight | The signal's explanatory text, when supplied. |
| Priority | The returned priority, presented as a badge when available. |
| Status | The signal's returned status, when available. |

Select a signal to retrieve its details. Displayed fields depend on the source response; every signal may not contain the same information.

If **No signals available.** appears, check the selected instance and whether signals are available for that application.

After reviewing the details, select **Explain**. The action starts asynchronous **Research** using the insight text; it does not itself apply a workforce or budget change. Include any additional scope, baseline, or constraints in your Research request or follow-up rather than assuming every detail field becomes part of the Research input.

## 6. Start with an example Research task

The application includes these six example tasks, all configured for **Research** mode. Use their titles to identify the available examples; their figures are planning examples, not verified results for your organization.

| Example task | Configured scenario |
| --- | --- |
| Analytics Compensation Growth | Plan 5.5% compensation growth, within 4.5%–6.2%, for Analytics roles including Data Scientist and Data Analyst. |
| Support and Design Cost Optimization | Plan an 8.6% compensation cost reduction, within 8.0%–9.0%, concentrated in Support while preserving Design capability. |
| Customer and Sales Compensation Growth | Plan 5.7% compensation growth, within 4.2%–6.8%, for Customer and Sales roles. |
| Planned Hiring Reduction | Assess 51 fewer planned positions, or 10.9%, with AI enablement, reskilling, and redeployment as planning objectives. |
| Department Compensation Reduction | Assess a 10% compensation reduction, with most savings in Cloud Operations and the smallest reduction in Enterprise AI. |
| Merit Budget Reallocation | Reduce planned merit compensation by $0.06B, or 10.71%, and reallocate funding toward Engineering and Analytics. |

Choose a relevant example in the Research experience, then adjust its target and scope to match your planning question. The exact placement of these examples depends on the host interface.

## 7. Write your own Research request

Use a clear business objective. The configured analysis accepts questions, statements, narratives, and follow-ups; a special prompt format is not required.

Include the following when relevant:

- **Objective and target:** growth, reduction, reallocation, or another desired outcome; include the amount or percentage and its baseline.
- **Population:** job name, job family, department, business unit, location, or country. These are the supported employee retrieval filters.
- **Period and units:** reporting period, currency, and whether amounts are annual or period-specific.
- **Scope of costs:** employees, hiring commitments, or both. The analysis instructions include both unless you restrict the scope.
- **Constraints:** explicit inclusions, exclusions, allocation rules, and any requested protections that can be identified from returned data.
- **Output preference:** the full decision package, or explicitly summary-only output.

### Compensation growth

> For the Analytics job family, propose a 5.5% compensation increase for Data Scientist and Data Analyst roles. Use current salary as the planning baseline, explain the allocation method, and show proposed amounts, resulting totals, and assumptions. Use the period and currency supported by the available data and identify any gaps.

### Cost optimization

> Propose an 8.6% compensation cost reduction across Support and Design. Concentrate the proposed savings in Support and keep the Design reduction as small as feasible. Separate current employee cost reduction from planned hiring spend reduction, and show how the proposal reconciles to the target.

### Hiring strategy

> Assess a reduction of 51 planned positions across Finance, Operations, and Support. Evaluate hiring changes, reskilling, and redeployment options. Identify which recommendations are supported by returned data and which need additional evidence.

A request can ask for an outcome that available data cannot fully quantify. Review the disclosed gaps rather than treating an estimate or an unquantified amount as a verified result.

## 8. Understand the decision package

Research is configured to produce a full decision package by default, including for short questions and follow-ups. It includes these 12 core sections; some headings adapt to the business dimension being analyzed.

| Section | How to use it |
| --- | --- |
| Research Analysis | Read the recommendation, expected outcome, strongest evidence, and main cautions. |
| Target Summary | Check the target, population, and baseline. The heading may name a department, region, or other focus. |
| Business Signal Analysis | Understand the drivers behind the recommendation. |
| Outcome Impact | Review proposed changes and their effect on the outcome. |
| Recommended Actions | Review the proposed actions and allocations. |
| Exposure | Identify where financial or workforce impact is concentrated. |
| Top Evidence | Challenge the recommendation using the most relevant supporting records. |
| Risks, Trade-Offs, And Mitigations | Evaluate limitations and consequences. |
| Available Course of Action | Compare alternative paths. |
| Review And Decision Loop | Identify review responsibilities and next decisions. |
| Data Coverage, Assumptions, And Workbook Detail | Check source coverage, missing information, and supporting detail. |
| Assumptions | Review defaults, interpretations, reference dates, and what to change for a revised proposal. |

A **Protected Capability And Retention Guardrails** section is conditional: it is included when you explicitly request a protection and the returned data identifies the applicable records. If the data cannot identify them, expect an information gap rather than an assumed protected population.

## 8. Policy templates and configured policy details

A **policy template** defines the extraction or calculation instructions, functions, inputs, and return types. A **policy** links to that template and contains its configured function implementations. There are two policy templates used for this agentic application
- Strategic Workforce Planning Policy Template
- Raise and Reduction Priority Score Calculation Policy Template

### 1. Strategic Workforce Planning Policy Template

This template `XX_STRATEGIC_WORKFORCE_PLANNING_POLICY_TEMPLATE` identifies two kinds of information in a supplied workforce policy document:

- **Role strategy:** roles, role families, strategic importance, compensation guidelines, retention considerations, and other explicitly documented role attributes.
- **Location market:** locations, countries, regions, currencies, labor costs, hiring difficulty, talent availability, attrition, and other explicitly documented market attributes.

Its general instructions use semantic meaning rather than fixed document layouts. They require source-supported values, preservation of relevant client-specific fields, exclusion of legends and illustrative examples, and no invented missing information. Records may be combined only when they unambiguously refer to the same role or location and planning context. You can review the policy template for detailed functions and their purpose.

A policy need to be created for this policy template and has to be linked in the workflow - `XX_EPM_FORECAST_SIGNALS_POLICY_HELPER_WORKFLOW` under capabilities - getRoleStratergyData, getLocationMarketData. The current policy implementations return fixed arrays and can be seen in the policy - `XX_STRATEGIC_WORKFORCE_PLANNING_POLICY`

A sample policy document should contain below data: 

Role strategy records

| Role | Role family | Strategic criticality | Default maximum raise (%) | Reduction sensitivity |
| --- | --- | --- | --- | --- |
| AI Research Scientist | Engineering | 5 | 15 | High |
| Principal Software Engineer | Engineering | 5 | 12 | High |
| Cyber Security Architect | Security | 5 | 15 | High |
| Product Manager | Product | 4 | 10 | Medium |
| Data Scientist | Analytics | 4 | 10 | Medium |
| HR Business Partner | Human Resources | 3 | 8 | Medium |
| Financial Analyst | Finance | 3 | 7 | Medium |
| Customer Support Specialist | Operations | 2 | 5 | Low |
| Administrative Assistant | Administration | 1 | 4 | Low |

The field names above reflect the configured policy records. A role's criticality or reduction sensitivity does not automatically protect employees, change their planning priority scores, or establish a compensation adjustment. The Research instructions require explicit, data-supported protections and disclosure of applicable planning rules. Confirm how the default maximum raise guideline applies to your proposal. A definition of the criticality scale is not included in these local records.

Location-market records

| Location | Country | Geography | Currency | Labor cost index | Hiring difficulty | Talent availability | Attrition risk |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Bangalore | India | APAC | INR | 65 | 4 | High | Medium |
| Hyderabad | India | APAC | INR | 60 | 3 | High | Medium |
| Singapore | Singapore | APAC | SGD | 125 | 4 | Medium | Medium |
| London | United Kingdom | EMEA | GBP | 145 | 4 | Medium | High |
| Dublin | Ireland | EMEA | EUR | 130 | 3 | Medium | Medium |
| New York | USA | Americas | USD | 180 | 5 | Medium | High |
| Austin | USA | Americas | USD | 140 | 3 | High | Medium |
| Mexico City | Mexico | Americas | MXN | 70 | 2 | High | Low |

Do not interpret these numbers as currency conversion rates or verified current market measurements. Match them to employee locations using supported context, preserve the original labels, and disclose uncertain matches.

**Above Data is for illustrative purpose only**

### 2. Raise and Reduction Priority Score Calculation Policy Template

This template `XX_RAISE_AND_REDUCTION_PRIORITY_SCORE_CALCULATION_POLICY_TEMPLATE` defines policy-driven scoring: identify the models, variables, weights, normalization rules, and interpretation thresholds; validate the supplied inputs; calculate each model independently; round the result to four decimal places; and return the score, priority classification, and missing-input list.

A policy need to be created for this policy template and has to be linked in the workflow - XX_EPM_FORECAST_SIGNALS_HELPER_WORKFLOW under capability - runWorkforcePolicyAnalysis. The current policy implements `scoreCalculation(Performance, Potential, Retention, UnderMarket, OverMarket, Impact)` and can be seen in the policy - `XX_RAISE_AND_REDUCTION_PRIORITY_SCORE_CALCULATION_POLICY`.

The template's parameter labels include **Under Market** and **Over Market**. The linked policy implementation and consuming Research contract use the machine-facing names **`UnderMarket`** and **`OverMarket`**. Preserve that distinction when configuring integrations.

#### Inputs and normalization

The following mappings come from the application's Research capability contract. They prepare source values before the policy calculation; they are not additional extraction rules implemented by the policy template.

| Policy input | Source | Normalization |
| --- | --- | --- |
| `Performance` | Performance Rating | Outstanding = 1.0; Exceeds expectations = 0.8; Meets expectations = 0.6; Inconsistently meets expectations = 0.4; Unsatisfactory = 0.2. |
| `Potential` | Career Potential | Low = 0.2; Medium = 0.6; High = 1.0. |
| `Retention` | Risk of Loss | Low = 0.2; Medium = 0.6; High = 1.0. |
| `Impact` | Impact of Loss | Low = 0.1; Medium = 0.45; High = 0.75; Mission Critical = 1.0. |
| `UnderMarket` | Valid normalized compa-ratio | `max(0, 1 - CompaRatio)`. |
| `OverMarket` | Valid normalized compa-ratio | `max(0, CompaRatio - 1)`. |

A percentage-form compa-ratio is divided by 100 before deriving the compensation gap: for example, 90% becomes 0.90 and produces `UnderMarket = 0.10`. Confirm the source unit before normalization. **Mission Critical** is an impact-rating mapping, not an automatic role protection.

The current policy accepts finite numeric values, or numeric strings, in the inclusive range **0–1**. Blank strings, nulls, unsupported types, and out-of-range inputs are invalid. Even though the helper schema permits a nonnegative over-market input without an upper bound, the policy implementation rejects a value greater than 1.

#### Example scoring formulas

Raise Priority = (
    0.23 × Performance
  + 0.13 × Potential
  + 0.15 × Retention
  + 0.12 × UnderMarket
  + 0.05 × Impact
) / 0.68

Reduction Priority = (
    0.24 × (1 - Performance)
  + 0.12 × OverMarket
  + 0.16 × (1 - Impact)
) / 0.52


**Priority classifications**
The implementation rounds each score to four decimal places **before** assigning its classification.

| Rounded score | Classification |
| --- | --- |
| 0.8000–1.0000 | Very High Priority |
| 0.6000–0.7999 | High Priority |
| 0.4000–0.5999 | Medium Priority |
| 0.2000–0.3999 | Low Priority |
| 0.0000–0.1999 | Very Low Priority |

A higher raise score indicates higher relative raise priority. A higher reduction score indicates higher relative priority for planning review under the reduction model. Neither score is an adjustment percentage, an instruction to change a record, or a final employment decision. Research keeps scores internal unless explicitly requested.

Illustrative calculation

For an illustrative employee with `Performance = 0.8`, `Potential = 1.0`, `Retention = 0.6`, `UnderMarket = 0.1`, `OverMarket = 0`, and `Impact = 0.75`:

| Model | Calculation | Rounded score | Classification |
| --- | --- | --- | --- |
| Raise | `(0.184 + 0.13 + 0.09 + 0.012 + 0.0375) / 0.68` | 0.6669 | High Priority |
| Reduction | `(0.048 + 0 + 0.04) / 0.52` | 0.1692 | Very Low Priority |

**This example explains the configured formulas; it is not a result for an actual employee. The score alone does not allocate a budget. Proposed amounts use the supplied allocation rules or the separately disclosed score-and-salary planning method described earlier in this guide.**

### 9. Policy review before use

1. Confirm that the deployed policy codes and linked templates match the intended configuration.
2. Review the configured role and location records, their applicability, and their effective period.
3. Verify source-to-input normalization, valid-data coverage, defaults, and the policy's accepted range.
4. Check the requested scoring model, returned errors, target reconciliation, and proposed amounts separately.
5. Review the planning proposal through the applicable finance, HR, and business processes before implementation.

The local policy metadata contains no attached policy documents or stored test cases. 
