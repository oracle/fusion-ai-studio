# Talent Management Workflows

<!-- BEGIN GENERATED WORKFLOWS -->
<br/>

#### Workflow : Team Unscheduled Check-Ins

| Workflow Name | Team Unscheduled Check-Ins |
|---------------|---------------|
| **Code** | XX_TEAM_UNSCHEDULED_CHECK_INS |
| **Description** | Identifies team members for a logged-in user with last checkin date more that 30 days ago and displays recent check-in status of employees , performance, and potential to help prioritize unscheduled check-ins. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | Retrieves team check-in data using the Team Unscheduled Check-In Business Object whose PersonId and AssignmentId parameters are obtained from LoggedIn Employee Context Business Object. The retrieved data is then displayed in a Multi Record widget with an executive summary. Each row shows the employee's name, business title, date of last check-in, team performance rating, and talent potential rating; performance and potential are displayed as badges to help the manager prioritize follow-up. The workflow prioritizes employees with check-ins older than 30 days, then those with no check-ins, using lower performance ratings as a tie-breaker. |

#### Workflow : Team Highest and Lowest Achieved Skills

| Workflow Name | Team Highest and Lowest Achieved Skills |
|---------------|---------------|
| **Code** | XX_TEAM_HIGHEST_AND_LOWEST_ACHIEVED_SKILLS |
| **Description** | Identifies the highest and lowest achieved Core and Role skills across a manager’s direct reports and answers questions about the results. In workflow mode, set `workflowMode` to `true` and provide the manager’s `personId` to return the same skill details and employee counts as JSON. Otherwise, in Agentic app mode, it uses the logged-in manager, displaying a table of skills, categories, and skilled, learning, and assigned employee counts, plus separate Core and Role bar charts comparing skilled and learning counts. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` (string) - Manager person identifier; required in REST workflow mode. Agentic App mode uses the logged-in manager.<br>`workflowMode` (boolean) - Set to true to return structured JSON; otherwise use the Agentic App path. |
| **Output Parameters** | workflowMode=true returns lowestAchieved and highestAchieved, each containing coreSkills and roleSkills arrays. Records include skillName, skillId, achievedCount, developingCount, totalCount, achievedPerson, and developingPerson. Each category is limited to two records by the transformation code. In Agentic App mode, InitDisplay shows a skill table and separate Core and Role bar charts; Query answers using the retrieved data. The app display excludes non-achieved records from the highest group and non-developing records from the lowest group. |

#### Workflow : Team Skill Details

| Workflow Name | Team Skill Details |
|---------------|---------------|
| **Code** | XX_TEAM_SKILL_DETAILS |
| **Description** | Retrieves a skills summary for employees who report directly to a manager and supports questions about their skills. In workflow mode, set `workflowMode` to `true` and provide the manager’s `personId`; the workflow returns their direct reports’ skills summary as JSON. In Agentic app mode, it uses the logged-in user as the manager, with no `personId` required, and displays employee names, total, achieved, role, core, and top skills in tables with access to employee skill details. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` (string) - Manager person identifier; required in REST workflow mode. Agentic App mode uses the logged-in manager.<br>`workflowMode` (boolean) - Set to true to return structured JSON; otherwise use the Agentic App path. |
| **Output Parameters** | workflowMode=true returns the direct reports’ prepared skill details as JSON. In Agentic App mode, displays employee names, total skills, achieved skills, Core and Role skills, and top skills in tables, with employee-skill drill-down actions. Query answers using the scoped team skill data. Additional-content handling displays records beyond the initial table. |

#### Workflow : Team Skill Overview

| Workflow Name | Team Skill Overview |
|---------------|---------------|
| **Code** | XX_TEAM_SKILL_OVERVIEW |
| **Description** | Provides a manager’s team overview for a selected skill, including matching direct reports’ skill details and a generated skill description. Provide the skill name and an optional skill-type filter. In workflow mode, set `workflowMode` to `true` and provide the manager’s `personId` to return the same details as JSON. Otherwise, it uses the logged-in manager and displays a titled table with employee display names, assignment names, achieved levels, required levels, and endorsement counts, alongside the skill description for the provided skillId from the supplied input or app context. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` (string) - Manager person identifier; required in REST workflow mode. Agentic App mode uses the logged-in manager.<br>`skillName` (string) - Skill name to search; may also come from OraAppContext.<br>`workflowMode` (boolean) - Set to true to return structured JSON; otherwise use the Agentic App path. |
| **Output Parameters** | workflowMode=true returns skillName, skillType, description, and rows; each row contains displayName, assignmentName, achievedLevel, requiredLevel, and endorsementsCount. The configured skill type is ALL. InitDisplay presents a titled multi-record table and generated skill description. Query answers using those records. Missing display values are shown as Not available. |

#### Workflow : Team Skills Summary

| Workflow Name | Team Skills Summary |
|---------------|---------------|
| **Code** | XX_TEAM_SKILLS_SUMMARY |
| **Description** | Summarizes skills across a manager’s direct reports, highlighting overall skill distribution, strongest achieved skills, and skills needing improvement. In workflow mode, set `workflowMode` to `true` and provide the manager’s `personId` to return their direct reports’ team skills summary as JSON. In Agentic app mode, it uses the logged-in manager with no `personId` required, displays a summary card with a title and paragraph, and answers questions using the retrieved team skill data. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `workflowMode` (boolean) - Set to true to return structured JSON; otherwise use the Agentic App path.<br>`personId` (string) - Manager person identifier; required in REST workflow mode. Agentic App mode uses the logged-in manager. |
| **Output Parameters** | workflowMode=true returns directReportsSkills, highestAchievedSkills, and lowestAchievedSkills. In Agentic App mode, InitDisplay shows a summary card describing the manager’s team skills, strengths, and areas needing improvement. Query answers using the retrieved team skill data. |

#### Workflow : Worker Current and Future Role Skills Gap

| Workflow Name | Worker Current and Future Role Skills Gap |
|---------------|---------------|
| **Code** | XX_WORKER_CURRENT_AND_FUTURE_ROLE_SKILLS_GAP |
| **Description** | Analyzes an employee’s current and future role skill gaps to identify skills that need improvement, using available assignment, public skills, and advancement-readiness data. Set workflowMode to true and provide the employee’s personId to return the analyzed skill gaps as JSON. Otherwise, it displays separate current and future role skill gap tables when gaps exist, shows status messages when no gaps or future role are found and answers questions using the analyzed data. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `workflowMode` (boolean) - Set to true to return structured JSON; otherwise use the Agentic App path.<br>`personId` (string) - Selected worker person identifier; supplied input takes precedence over app context. |
| **Output Parameters** | workflowMode=true returns the prepared current- and future-role skills-gap analysis as JSON. InitDisplay shows current-role gaps followed by advancement-readiness gaps when available, or status/guidance messages when no gaps or required role data are available. Query answers using the analyzed data. Uses the selected worker’s assignment, current job profile, public skills, talent ratings, and advancement-readiness records. |

#### Workflow : Worker Skills Details

| Workflow Name | Worker Skills Details |
|---------------|---------------|
| **Code** | XX_WORKER_SKILLS_DETAILS |
| **Description** | Retrieves an employee’s unique public skills, including skill type, target and achieved levels, rating descriptions, development status, and endorsement count. In workflow mode, set `workflowMode` to `true` and provide the employee’s numeric `personId` to return the skill details as JSON. In Agentic app mode, provide `personId` and optional `SkillId` through `OraAppContext`; the workflow displays the matching skill or one row per unique skill in a table and answers questions using the retrieved records. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `workflowMode` (boolean) - Set to true to return structured JSON; otherwise use the Agentic App path.<br>`personId` (string) - Selected worker person identifier; supplied input takes precedence over app context.<br>`skillId` (string) - Optional exact skill identifier used to filter the selected worker’s public skills. |
| **Output Parameters** | workflowMode=true returns the prepared unique skill records as JSON. Optional skillId filters the selected worker’s records. Records contain skillName, skillType, targetLevel, targetRatingDescription, achievedLevel, managerRatingDescription, developmentStatus, and endorsementCount. InitDisplay shows a multi-record table; Query answers using the retrieved records. Achieved ratings use manager ratings and displayed levels are formatted as stars. |

#### Workflow : Worker Skills Summary

| Workflow Name | Worker Skills Summary |
|---------------|---------------|
| **Code** | XX_WORKER_SKILLS_SUMMARY |
| **Description** | Summarizes a selected employee’s public skills, including total, Core, and Role skill counts, development status, rating alignment, and notable strengths or gaps. In workflow mode, set `workflowMode` to `true` and provide the employee’s numeric `personId` to return the summary as JSON. In Agentic app mode, the employee’s numeric `personId` is taken from the supplied input or app context, with supplied input taking precedence; the app displays a single summary card and answers questions regarding employee skills. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `workflowMode` (boolean) - Set to true to return structured JSON; otherwise use the Agentic App path.<br>`personId` (string) - Selected worker person identifier; supplied input takes precedence over app context. |
| **Output Parameters** | workflowMode=true returns the prepared worker skills summary as JSON, including employeeName, skills, and totals for total, Core, Role, developed, developing, and not-assessed skills. InitDisplay shows one summary card describing counts, strengths, and improvement areas. Query answers using the selected worker’s skill records. |

<!-- END GENERATED WORKFLOWS -->
