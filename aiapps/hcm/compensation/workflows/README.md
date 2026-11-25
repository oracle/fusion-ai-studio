# Compensation Workflows

<!-- BEGIN GENERATED WORKFLOWS -->
<br/>

#### Workflow : Direct Reports Below Compa Ratio

| Workflow Name | Direct Reports Below Compa Ratio |
|---------------|---------------|
| **Code** | XX_DIRECT_REPORTS_BELOW_COMPA_RATIO |
| **Description** | Displays the list of direct reports with compensation compa ratios below 100 |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | This workflow retrieves the logged-in person's personId and assignmentId using `LoggedIn Employee Context` business object and then retrieves the compensation details of directs using `My Team Compensation Details Lookup` business object and displays the list of employees with compa ration less than 100 using Message List widget. <br> Fields displayed : Person Image, Person Name, Business title, Salary Range, Current Salary and the Compa ratio. Sorted by Compa ration in ascending order |

#### Workflow : Team Overdue Salary Reviews

| Workflow Name | Team Overdue Salary Reviews |
|---------------|---------------|
| **Code** | XX_TEAM_OVERDUE_SALARY_REVIEWS |
| **Description** | Displays the direct reports, whose next salary review date has passed, helping compensation teams prioritize overdue review follow-up and maintain timely pay governance. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | This workflow retrieves the logged-in person's personId and assignmentId using `LoggedIn Employee Context` business object and then retrieves the list of compensation details of the team using `My Team Compensation Details Lookup` business object and filters the records whose compensation review date is already passed and displays the result using Messages List widget. <br> Fields displayed : Person Image, Person Name, Business Title, Current Salary and Badge showing days since review is due. |

#### Workflow : Team Compensation Details By Employee Currency

| Workflow Name | Team Compensation Details By Employee Currency |
|---------------|---------------|
| **Code** | XX_TEAM_COMPENSATION_DETAILS_BY_EMPLOYEE_CURRENCY |
| **Description** | Shows direct-report salary, individual compensation and stock details in each employee’s currency. Managers can compare available annual salary, bonus, stock and total compensation across their team in a single employee table. Follow-up questions use the same selected manager and retrieved records. Workflow mode returns the corresponding grouped compensation data for other workflows. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Displays all direct reports in one table using each employee’s compensation currency, with employee-name navigation to Employee Compensation Details. Fields: Employee Name, Business Title, Annual Salary, Bonus, Stocks and Total Compensation. <br> <br> `Query` - Answers questions using the retrieved team records. <br> <br> Workflow mode returns grouped team compensation data. |


#### Workflow : Team Compensation Details In Preferred Currency

| Workflow Name | Team Compensation Details In Preferred Currency |
|---------------|---------------|
| **Code** | XX_TEAM_COMPENSATION_DETAILS_IN_PREFERRED_CURRENCY |
| **Description** | Shows direct-report compensation in the viewer’s preferred currency using the available currency settings and exchange rates. Managers can compare annual salary, bonus, stock and total compensation across employees in one table. Follow-up questions use the selected manager and retrieved compensation evidence. Workflow mode provides grouped team compensation details for use by other workflows. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Converts computed compensation amounts to the viewer’s preferred currency and returns an employee table. Fields: Employee Name, Business Title, Annual Salary, Bonus, Stocks and Total Compensation. Each employee name opens Employee Compensation Details with that employee’s person and assignment IDs. <br> <br> `Query` - Answers questions using the same retrieved records. <br> <br> Workflow mode returns grouped team compensation data. |


#### Workflow : Team Compensation Distribution By Grade

| Workflow Name | Team Compensation Distribution By Grade |
|---------------|---------------|
| **Code** | XX_TEAM_COMPENSATION_DISTRIBUTION_BY_GRADE |
| **Description** | Displays how direct-report compensation is distributed across grades, using available employee salary, individual compensation and stock information. Managers can review the grade comparison and ask follow-up questions about the displayed team data. Employee amounts retain their applicable currencies and existing calculation rules. Workflow mode returns the corresponding grouped compensation data for other workflows. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Retrieves matching assignment grades and displays compensation distribution by grade and currency. When no usable grades are available, displays an informational card. <br> <br> `Query` - Answers questions about the retrieved team records. <br> <br> Workflow mode returns grouped team compensation data. |


#### Workflow : Team Compensation Spend Distribution

| Workflow Name | Team Compensation Spend Distribution |
|---------------|---------------|
| **Code** | XX_TEAM_COMPENSATION_SPEND_DISTRIBUTION |
| **Description** | Displays how compensation spending is distributed across the selected manager’s direct reports. The view combines available salary, individual compensation and stock information, using the existing preferred-currency conversion rules where applicable. Managers can inspect the distribution and ask questions grounded in the same team records. Workflow mode returns the underlying grouped team compensation details. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Displays the team compensation spending distribution using available salary, individual compensation and stock data and the configured preferred-currency conversion. <br> <br> `Query` - Answers questions using the same team records. <br> <br> Workflow mode returns grouped team compensation data. |


#### Workflow : Team Compensation Summary

| Workflow Name | Team Compensation Summary |
|---------------|---------------|
| **Code** | XX_TEAM_COMPENSATION_SUMMARY |
| **Description** | Summarizes compensation for the selected manager’s direct reports using available salary, individual compensation and stock records. Managers can review the team overview and ask follow-up questions about the retrieved compensation data. The summary preserves the existing currency grouping and calculation rules. Workflow mode supplies the corresponding team compensation data for use in other workflows. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Returns a summary card with employee counts, annual compensation totals, component percentages and average annual salaries by currency. <br> <br> `Summary` - Returns the same calculated summary as plain text. <br> <br> `Query` - Answers questions using retrieved team records. <br> <br> Workflow mode returns grouped team compensation data. |


#### Workflow : Worker Bonus History

| Workflow Name | Worker Bonus History |
|---------------|---------------|
| **Code** | XX_WORKER_BONUS_HISTORY |
| **Description** | Displays a selected worker’s available current and prior individual compensation records in the existing bonus-history view. Users can review plan and component details, effective dates, amounts and currencies when returned by HCM. Follow-up questions are answered from the same worker’s records. Workflow mode returns the compensation-history data for use in other workflows. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Displays the selected worker’s available current and prior individual compensation history. <br> <br> `Query` - Answers questions using those records. <br> <br> Workflow mode returns the retrieved individual compensation data. |


#### Workflow : Worker Bonus History Chart

| Workflow Name | Worker Bonus History Chart |
|---------------|---------------|
| **Code** | XX_WORKER_BONUS_HISTORY_CHART |
| **Description** | Displays the selected worker’s available bonus and individual compensation history as a chart. Users can review compensation patterns over time and ask follow-up questions about the underlying current and prior records, amounts, currencies, plans and effective dates. The view follows the existing chart and calculation rules. Workflow mode returns the corresponding compensation-history data. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Displays the selected worker’s available individual compensation history as a chart. <br> <br> `Query` - Answers questions using the retrieved records. <br> <br> Workflow mode returns the underlying individual compensation data. |


#### Workflow : Worker Compensation History Bundle

| Workflow Name | Worker Compensation History Bundle |
|---------------|---------------|
| **Code** | XX_WORKER_COMPENSATION_HISTORY_BUNDLE |
| **Description** | Combines the selected worker’s salary, bonus and stock history into the existing yearly compensation view. Users can review the available annual salary, bonus, vested stock value and total compensation together, with the existing date, currency and calculation rules. Workflow mode returns the combined historical data for callers that need the underlying compensation evidence. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Retrieves and combines the selected worker’s salary, individual compensation and stock history for a consolidated view. <br> <br> `Query` - Answers questions using the combined compensation history. |


#### Workflow : Worker Compensation Query

| Workflow Name | Worker Compensation Query |
|---------------|---------------|
| **Code** | XX_WORKER_COMPENSATION_QUERY |
| **Description** | Answers questions about the selected worker’s available salary, bonus and stock compensation history. It retrieves the relevant worker records and uses those records to explain dates, amounts, compensation changes and available totals. Responses follow the existing query presentation and calculation rules and remain grounded in the compensation evidence retrieved for the selected worker. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `Query` - Answers compensation questions for the selected worker using salary, individual compensation and stock history. Provides the Ask Oracle workflow for Employee Compensation Details. |


#### Workflow : Worker Salary History

| Workflow Name | Worker Salary History |
|---------------|---------------|
| **Code** | XX_WORKER_SALARY_HISTORY |
| **Description** | Displays the selected worker’s salary history using the available HCM salary records. Users can review effective dates, business titles, salary amounts, currencies and salary adjustments in the existing history view. Follow-up questions use the same worker’s retrieved history and viewer date preferences where available. Workflow mode returns the salary-history data for other workflows. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Displays the selected worker’s available salary history. <br> <br> `Query` - Answers questions using the retrieved salary records. <br> <br> Workflow mode returns salary history data. |


#### Workflow : Worker Salary History Increment Chart

| Workflow Name | Worker Salary History Increment Chart |
|---------------|---------------|
| **Code** | XX_WORKER_SALARY_HISTORY_INCREMENT_CHART |
| **Description** | Displays the selected worker’s salary increment history as the existing line chart. Users can compare available salary increase percentages across effective dates and roles, then ask follow-up questions grounded in the underlying salary records. The view preserves the existing chart labels, calculation rules and employee selection behavior. Workflow mode returns the corresponding salary-history data. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Displays the selected worker’s salary progression and increments as a chart. <br> <br> `Query` - Answers questions using salary history records. <br> <br> Workflow mode returns salary history data. |


#### Workflow : Worker Stock History

| Workflow Name | Worker Stock History |
|---------------|---------------|
| **Code** | XX_WORKER_STOCK_HISTORY |
| **Description** | Displays the selected worker’s available stock-grant and vesting history. Users can review grant dates, quantities, vested and unvested shares, grant prices and available stock values in the existing history view. Follow-up questions use the same retrieved worker records and applicable date preferences. Workflow mode returns the stock-history data for use in other workflows. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Displays the selected worker’s available stock grant and vesting history. <br> <br> `Query` - Answers questions using the retrieved stock records. <br> <br> Workflow mode returns stock history data. |


#### Workflow : Worker Stock History Chart

| Workflow Name | Worker Stock History Chart |
|---------------|---------------|
| **Code** | XX_WORKER_STOCK_HISTORY_CHART |
| **Description** | Displays the selected worker’s available stock history as the existing chart. Users can review grant dates, share quantities and stock values over time, then ask follow-up questions about the underlying grants and vesting records. The workflow retains the current chart presentation and valuation rules. Workflow mode returns the corresponding stock-history data for other workflows. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional person identifier, supplied as a positive integer string. When omitted, resolves the selected app-context person or the logged-in worker. <br> `workflowMode` - Set to `true` to return underlying compensation data for another workflow. <br> Uses app context: `personId` in `$OraAppContext` and `userId` in `$OraUserContext`. |
| **Output Parameters** | `InitDisplay` - Displays the selected worker’s available stock history as a chart. <br> <br> `Query` - Answers questions using the retrieved stock records. <br> <br> Workflow mode returns stock history data. |
<!-- END GENERATED WORKFLOWS -->
