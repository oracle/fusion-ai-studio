# Journeys Workflows

<!-- BEGIN GENERATED WORKFLOWS -->
<br/>

#### Workflow : Overdue Onboarding Team Journeys

| Workflow Name | Overdue Onboarding Team Journeys |
|---------------|---------------|
| **Code** | XX_OVERDUE_ONBOARDING_TEAM_JOURNEYS |
| **Description** | Fetches Enterprise Onboarding and Onboarding team journeys, renders the top journey records as a message list with person image, person name, journey name, person number, and an alert badge for overdue task count for review by manager. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | Retrieves overdue Enterprise Onboarding and Onboarding team journeys from ``Journey Searches and Aggregation`` Business Object and displays them in a Messages List widget. Fields displayed: person image, person name, journey name, person number, and overdue task count. |

#### Workflow : Overdue Onboarding Team Journeys Tasks

| Workflow Name | Overdue Onboarding Team Journeys Tasks |
|---------------|---------------|
| **Code** | XX_OVERDUE_ONBOARDING_TEAM_JOURNEYS_TASKS |
| **Description** | Fetches overdue Enterprise Onboarding and Onboarding team journey tasks, filters them to the top five tasks, enriches each task with due-date timing details, and renders them as a message list with task name, journey name, owner details, and overdue status for review by manager. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | Retrieves overdue Enterprise Onboarding and Onboarding team journey tasks from `Journey Searches and Aggregation` Business Object, displays them in a Messages List widget. Fields displayed: task name, journey name, owner details, and due-date or overdue status. |

#### Workflow : Overdue Team Journey Tasks

| Workflow Name | Overdue Team Journey Tasks |
|---------------|---------------|
| **Code** | XX_OVERDUE_TEAM_JOURNEY_TASKS |
| **Description** | Fetches overdue team journey tasks, filters them to the top five tasks, enriches each task with due-date timing details, and renders them as a message list with task name, journey name, owner details, and overdue status for review by manager. If overdue tasks are not present then presents the open tasks which are due ordered by end date. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | Retrieves the top overdue team journey tasks from `Journey Searches and Aggregation` Business Object, or open tasks ordered by end date when no overdue tasks are present, and displays them in a Messages List widget. Fields displayed: task name, journey name, owner details, and due-date or overdue status. |

#### Workflow : Overdue Team Journeys

| Workflow Name | Overdue Team Journeys |
|---------------|---------------|
| **Code** | XX_OVERDUE_TEAM_JOURNEYS |
| **Description** | Fetches overdue team journeys, renders the top journey records as a message list with person image, person name, journey name, person number, and an alert badge for overdue task count, and provides navigation to the Team Journeys page for viewing more journeys for review by manager. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | Retrieves overdue team journeys from `Journey Searches and Aggregation` Business Object and displays them in a Messages List widget. Fields displayed: person image, person name, journey name, person number, and overdue task count. Provides a Show Team Journeys action to open the Team Journeys page. |

#### Workflow : Team Journey Aggregation Chart

| Workflow Name | Team Journey Aggregation Chart |
|---------------|---------------|
| **Code** | XX_TEAM_JOURNEY_AGGREGATION_CHART |
| **Description** | Displays team journey category distribution as a pie chart using aggregation data from the Worker Journey business object, with absolute category counts shown below the chart for easy comparison for review by manager. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | Retrieves team journey category aggregations from `Journey Searches and Aggregation` Business Object and displays categories with positive counts as a pie chart and a multi-record table showing the category and its count. |
<!-- END GENERATED WORKFLOWS -->
