# Business Objects
<br>



## Business Object : Journey Searches and Aggregation


| **Name** | Journey Searches and Aggregation |
|---------------|---------------|
| **Code** | ORA_HCM_JOURNEYS_XX_JOURNEYSEARCHESANDAGGREGATION |
| **Description** | Journey Searches and Aggregation enables efficient retrieval and aggregation of worker journey and team task information within the HCM Journeys product. It supports searching and summarizing journey-related records through multiple POST operations, facilitating insights into worker journeys and associated team tasks. |

### Functions

#### Function : get_workerTeamJourneyTasks
Description : Retrieves detailed information about worker team journey tasks based on specified status, categories, and task name filters. This function supports searching and aggregating journey-related team tasks within the HCM Journeys product to provide insights into task progress and assignment. It performs a POST operation on the workerJourneyTaskSearches resource to deliver relevant task data.

| **Parameter Name** | **Description**|
|---------------|---------------|
| Status | Status of the tasks to be searched. |
| Categories | Categories of the tasks to be searched. |
| pTaskName | Name of the tasks to be searched. |

#### Function : getWorkerTeamJourney
Description : Retrieves detailed information about Worker Team Journey Tasks by searching for team journeys based on specified journey status and categories. This function supports filtering and aggregation of journey-related tasks for direct reports within the HCM Journeys product.

| **Parameter Name** | **Description**|
|---------------|---------------|
| Status | Status of the journey to search for. |
| Categories | Categories of the journey to search for. |

#### Function : getWorkerJourneyAggregations
Description : Retrieves aggregated data on worker journeys by searching and summarizing journey records within a team or organization. This function supports filtering and grouping journey information to provide insights into worker activities and associated tasks. It represents a POST operation on the workerJourneyAggregations resource in the Journey Searches and Aggregation business object.

| **Parameter Name** | **Description**|
|---------------|---------------|
