## Business Objects

## Business Object : Document Records Expiring Lookup

| Code | `ORA_HCM_GLOBALHUMA_XX_DOCUMENTRECORDSEXPIRINGLOOKUP` |
|---------------|---------------|
| Description | Retrieves document records with DateTo between the supplied current date and date after 30 days. Input: Current date and date after 30 days. Output: Document display name, document type, document name, and end date. |

## Functions


### Function : getDocumentRecordsExpiringWithinDateRange

Description: Retrieves expiring document records for one authorized person number within the supplied date range. The team workflow calls this separately for each session-derived direct report.

| Parameter Name | Description |
|---------------|---------------|
| `pPersonNumber` | Exact authorized subject person number; the operation no longer excludes the viewer to query other workers. |
| `pCurrentDate` | Stores the current date |
| `pDateAfter30Days` | Date after 30 days in YYYY-MM-DD format used as the end of the document DateTo range. |

### Function : getDocumentRecordsForPersonWithinDateRange

Description: Retrieves document records for the logged-in user's person number within the specified date range and returns the matching document record details from documentRecords.

| Parameter Name | Description |
|---------------|---------------|
| `pPersonNumber` | Person number of the logged-in user. |
| `pStartDate` | Start date in YYYY-MM-DD format for the document DateTo range. |
| `pEndDate` | End date in YYYY-MM-DD format for the document DateTo range. |

---------------

## Business Object : Worker Employment

| **Name** | Worker Employment |
|---------------|---------------|
| **Code** | `ORA_HCM_GLOBALHUMA_XX_EMPLOYMENTGHR` |
| **Description** | Provides worker assignment, employment history, manager hierarchy, seniority, salary, performance, representative, and reporting information. Retrieves talent profiles and notes, and updates existing About Me summary, expertise, and interest records. |

## Functions


### Function : GetAssignmentHistoryUpdates

Description: Returns assignment history update records for the supplied assignment identifier as of the supplied effective date.

| Parameter Name | Description |
|---------------|---------------|
| `assignmentId` | Assignment identifier used to retrieve assignment history update records. |
| `effectiveDate` | Effective date used to retrieve assignment history updates, formatted as YYYY-MM-DD. |

### Function : GetWorkerConnections

Description: Returns worker connection records for the supplied person and assignment, including line-manager hierarchy relationships.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to locate the worker record in HCM. |
| `assignmentId` | Assignment identifier used with the person identifier for assignment-scoped lookups. |

### Function : GetWorkerManagers

Description: Returns manager details for the supplied person and assignment.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to locate the worker record in HCM. |
| `assignmentId` | Assignment identifier used with the person identifier for assignment-scoped lookups. |

### Function : GetWorkerPrimaryAssignmentInfo

Description: Returns the primary assignment identifier for the supplied person.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve the worker primary assignment. |

### Function : GetAssignmentInformationByPerson

Description: Returns assignment information for the supplied person identifier.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve worker assignment records. |

### Function : GetPersonSeniorityInformation

Description: Returns seniority information for the supplied person identifier.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve worker seniority records. |

### Function : GetTeamSeniorityInformationByManager

Description: Returns seniority information for workers in the supplied manager hierarchy.

| Parameter Name | Description |
|---------------|---------------|
| `managerPersonId` | Manager person identifier used to retrieve team seniority records. |

### Function : GetSalaryHistoryByPersonId

Description: Returns current and historical salary records for the supplied person identifier, including salary amount, annualized salary, compa-ratio, quartile, and salary range values.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Worker person identifier used to retrieve salary history. |

### Function : GetPerformanceRatingsByPersonId

Description: Returns talent profile performance rating records for the supplied person identifier, including expanded performance rating details.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Worker person identifier used to retrieve talent and performance ratings. |

### Function : GetAssignmentUpdatesBetweenDates

Description: Returns assignment history rows for the supplied assignment identifier and effective-date range.

| Parameter Name | Description |
|---------------|---------------|
| `AssignmentId` | Worker assignment identifier whose history should be returned. |
| `RangeStartDate` | Start date of the history extraction range in YYYY-MM-DD format. |
| `RangeEndDate` | End date of the history extraction range in YYYY-MM-DD format. |

The fields projection is fixed to the attributes in the exported assignment-history response. Callers cannot supply `pFields`.

### Function : GetWorkerRepresentatives

Description: Returns work-contact representatives for a worker assignment, including representative responsibility, person, assignment, contact, and effective-date details.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier of the worker whose assignment representatives are retrieved. |
| `assignmentId` | Assignment identifier used to retrieve representatives for the worker assignment. |

### Function : GetTalentPersonProfiles

Description: Returns eligible talent profile sections for a person, including profile summary, career ambassador details, expertise, interests, favorite links, tags, and skills.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier of the worker whose talentProfiles are to be retrieved. |

### Function : GetPersonNotes

Description: Returns person notes for a worker, including note text and note visibility details when available.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve person notes for the requested worker. |

### Function : CreateFavoriteLink

Description: Creates a favorite link using the talent person profile canonical REST resource key and a JSON-serialized request containing only Description and URL.

| Parameter Name | Description |
| --- | --- |
| `profileId` | Canonical REST resource key; not the numeric ProfileId. |
| `payload` | JSON-serialized object containing only Description and URL. |

### Function : UpdateFavoriteLink

Description: Updates Description and URL on an existing favorite link.

| Parameter Name | Description |
| --- | --- |
| `profileId` | Canonical REST resource key; not the numeric ProfileId. |
| `bookmarkId` | Integer BookmarkId from the selected profile's freshly retrieved favoriteLinks collection. |
| `payload` | JSON-serialized object containing only Description and URL. |

### Function : GetManagerDirectReports

Description: Returns direct reports for the supplied manager assignment, including worker identifiers and report-count metadata.

| Parameter Name | Description |
|---------------|---------------|
| `managerPersonId` | Manager person identifier whose direct reports should be returned. |
| `managerAssignmentId` | Manager assignment identifier used to retrieve direct reports. |

### Function : GetWorkerDirectReportsCount

Description: Returns direct reports count metadata for the supplied worker assignment using totalResults.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier whose direct reports count should be returned. |
| `assignmentId` | Assignment identifier used to retrieve direct reports count. |

### Function : GetWorkerAllReportsCount

Description: Returns total reports count metadata for the supplied worker assignment using totalResults.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier whose total reports count should be returned. |
| `assignmentId` | Assignment identifier used to retrieve total reports count. |

### Function : GetTalentProfileByPersonId

Description: Resolves a person's talent profile and canonical REST item link for About Me updates.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier whose profile resource link is requested. |

### Function : UpdateTalentProfileSummary

Description: Updates only Summary through a fixed one-field body. Callers supply the summary string after independently verifying the session and parent/child ownership.

| Parameter Name | Description |
|---------------|---------------|
| `profileId` | REST resource key obtained from the profile self or canonical link. |
| `summary` | The summary rich-text string. Preserve approved text encoding; verify quoted-value escaping with the platform before deployment. |

### Function : UpdateAboutMeExpertise

Description: Updates only Expertise through a fixed one-field body. Callers supply the expertise string after independently verifying the session and parent/child ownership.

| Parameter Name | Description |
|---------------|---------------|
| `profileId` | REST resource key obtained from the profile self or canonical link. |
| `expertiseId` | Existing areasOfExpertise record identifier. |
| `expertise` | The expertise rich-text string. Preserve approved text encoding; verify quoted-value escaping with the platform before deployment. |

### Function : UpdateTalentProfileExpertise

Description: Updates only Expertise through a fixed one-field body. Callers supply the expertise string after independently verifying the session and parent/child ownership.

| Parameter Name | Description |
|---------------|---------------|
| `profileId` | REST resource key obtained from the profile self or canonical link. |
| `expertiseId` | Existing areasOfExpertise record identifier. |
| `expertise` | The expertise rich-text string. Preserve approved text encoding; verify quoted-value escaping with the platform before deployment. |

### Function : UpdateTalentProfileInterest

Description: Updates only Interest through a fixed one-field body. Callers supply the interest string after independently verifying the session and parent/child ownership.

| Parameter Name | Description |
|---------------|---------------|
| `profileId` | REST resource key obtained from the profile self or canonical link. |
| `interestId` | Existing areasOfInterest record identifier. |
| `interest` | The interest rich-text string. Preserve approved text encoding; verify quoted-value escaping with the platform before deployment. |

---------------

## Business Object : Person Direct Reports V2

| Code | `ORA_HCM_GLOBALHUMA_XX_PERSONDIRECTREPORTSV2` |
|---------------|---------------|
| Description | This business object gives direct report information for a manager. It can be used to retrieve direct report records based on the input manager person id, manager assignment id, limit, and offset. |

## Functions


### Function : get_directReports

Description: This function gives direct report records for a manager based on the input manager person id, manager assignment id, limit, and offset.

| Parameter Name | Description |
|---------------|---------------|
| `managerPersonId` | Manager person identifier used to retrieve direct report records. |
| `managerAssignmentId` | Manager assignment identifier used to retrieve direct report records. |
| `limit` | Maximum number of direct report records to return. |
| `offset` | Zero-based offset used for paginated direct report results. |

---------------

## Business Object : Person Direct Reports

| **Name** | Person Direct Reports |
|---------------|---------------|
| **Code** | `ORA_HCM_GLOBALHUMA_XX_PERSONDIRECTREPORTS` |
| **Description** | Retrieves a manager's direct reports using person and assignment identifiers, with paging for larger teams. Returns worker identity, job, department, location, and work contact details, and provides direct-report and total-report counts for a worker assignment. |

## Functions


### Function : get_directReports

Description: Retrieves a manager's direct reports using the manager person ID and assignment ID. Supports limit and offset paging and returns worker identity, assignment, and reporting-count details ordered by display name.

| Parameter Name | Description |
|---------------|---------------|
| `managerPersonId` | Manager person identifier used to retrieve direct report records. |
| `managerAssignmentId` | Manager assignment identifier used to retrieve direct report records. |
| `limit` | Maximum number of direct report records to return. |
| `offset` | Zero-based offset used for paginated direct report results. |

### Function : get_directReportDetails

Description: Returns direct-report display details, including job, department, location, work email, and work phone, for a manager assignment.

| Parameter Name | Description |
|---------------|---------------|
| `managerAssignmentId` | Manager primary assignment identifier used by the Manager filter. |
| `limit` | Maximum number of direct rows to return. Default: 25. |
| `offset` | Zero-based result offset. Default: 0. |

### Function : get_directReportCounts

Description: Returns the direct-report collection count for one worker assignment.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Worker person identifier used in the direct-reports resource path. |
| `assignmentId` | Worker assignment identifier used in the direct-reports resource path. |

### Function : get_allReportCounts

Description: Returns the total all-reports count for one worker assignment.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Worker person identifier used in the all-reports resource path. |
| `assignmentId` | Worker assignment identifier used in the all-reports resource path. |

---------------

## Business Object : Worker Search

| **Name** | Worker Search |
|---------------|---------------|
| **Code** | `ORA_HCM_GLOBALHUMA_XX_PERSONSEARCHESGHR` |
| **Description** | Searches for workers and returns worker lists, reporting relationships, and grouped counts. Supports name, department, job, grade, business unit, position, location, and manager filters, as well as custom search criteria. |

## Functions


### Function : GetWorkerCount

Description: Returns worker aggregation counts for a supplied workerAggregationsV2 request payload.

| Parameter Name | Description |
|---------------|---------------|
| `payload` | JSON request payload for workerAggregationsV2, including security filters, facets, filters, and optional facet value query. |

### Function : GetWorkersCountByDepartmentName

Description: Returns the number of workers whose department name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `departmentName` | Department name used to filter worker records or count matching workers. |

### Function : GetWorkersByJobId

Description: Lists workers whose job identifier matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `jobId` | Job identifier used to filter worker records or retrieve job details. |

### Function : GetWorkersCountByBusinessUnitName

Description: Returns the number of workers whose business unit name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `businessUnitName` | Business unit name used to filter worker records or count matching workers. |

### Function : GetWorkersByName

Description: Lists workers whose display name matches the supplied full or partial worker name.

| Parameter Name | Description |
|---------------|---------------|
| `workerName` | Full or partial worker display name used for workerSearchesV2 name matching. |

### Function : GetWorkersCountByGradeCode

Description: Returns the number of workers whose grade code matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `gradeCode` | Grade code used to filter worker records or count matching workers. |

### Function : GetWorkersCountByGradeName

Description: Returns the number of workers whose grade name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `gradeName` | Grade name used to filter worker records or count matching workers. |

### Function : GetWorkersByGradeName

Description: Lists workers whose grade name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `gradeName` | Grade name used to filter worker records or count matching workers. |

### Function : GetWorkersByGradeCode

Description: Lists workers whose grade code matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `gradeCode` | Grade code used to filter worker records or count matching workers. |

### Function : GetWorkersByGradeId

Description: Lists workers whose grade identifier matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `gradeId` | Grade identifier used to filter worker records. |

### Function : GetWorkersByBusinessUnitName

Description: Lists workers whose business unit name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `businessUnitName` | Business unit name used to filter worker records or count matching workers. |

### Function : GetWorkersByDepartmentName

Description: Lists workers whose department name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `departmentName` | Department name used to filter worker records or count matching workers. |

### Function : GetWorkersCountByJobCode

Description: Returns the number of workers whose job code matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `jobCode` | Job code used to filter worker records or count matching workers. |

### Function : GetWorkersCountByJobName

Description: Returns the number of workers whose job name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `jobName` | Job name used to filter worker records or count matching workers. |

### Function : GetWorkersByJobName

Description: Lists workers whose job name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `jobName` | Job name used to filter worker records or count matching workers. |

### Function : GetWorkersByJobCode

Description: Lists workers whose job code matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `jobCode` | Job code used to filter worker records or count matching workers. |

### Function : GetWorkersByBusinessUnitId

Description: Lists workers whose business unit identifier matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `businessUnitId` | Business unit identifier used to filter worker records. |

### Function : GetWorkersCountByPositionName

Description: Returns the number of workers whose position name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `positionName` | Position name used to filter worker records or count matching workers. |

### Function : GetWorkersCountByPositionCode

Description: Returns the number of workers whose position code matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `positionCode` | Position code used to filter worker records or count matching workers. |

### Function : GetWorkersCountByLocationName

Description: Returns the number of workers whose location name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `locationName` | Location name used to filter worker records or count matching workers. |

### Function : GetWorkersByPositionCode

Description: Lists workers whose position code matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `positionCode` | Position code used to filter worker records or count matching workers. |

### Function : GetWorkersByPositionName

Description: Lists workers whose position name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `positionName` | Position name used to filter worker records or count matching workers. |

### Function : GetWorkersByPositionId

Description: Lists workers whose position identifier matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `positionId` | Position identifier used to filter worker records. |

### Function : GetWorkersCountByLocationCode

Description: Returns the number of workers whose location code matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `locationCode` | Location code used to filter worker records or count matching workers. |

### Function : GetWorkersByLocationId

Description: Lists workers whose location identifier matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `locationId` | Location identifier used to filter worker records. |

### Function : GetWorkersByLocationName

Description: Lists workers whose location name matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `locationName` | Location name used to filter worker records or count matching workers. |

### Function : GetWorkersByLocationCode

Description: Lists workers whose location code matches the supplied value.

| Parameter Name | Description |
|---------------|---------------|
| `locationCode` | Location code used to filter worker records or count matching workers. |

### Function : GetWorkers

Description: Returns workers for a supplied workerSearchesV2 request payload.

| Parameter Name | Description |
|---------------|---------------|
| `payload` | JSON request payload for workerSearchesV2, including security filters, display fields, filters, offset, and limit. |

### Function : GetWorkersByManager

Description: Gets the list of workers who are directs for a line manager

| Parameter Name | Description |
|---------------|---------------|
| `context` | security context for filtering the workers by directs of a manager |

### Function : GetWorkersByManagerAssignmentId

Description: Gets workers reporting directly or indirectly to a manager identified by manager assignment ID.

| Parameter Name | Description |
|---------------|---------------|
| `managerAssignmentId` | Positive integer manager assignment ID used by the WorkerSearchesV2 Manager filter. Workflow requests reject values that cannot be represented exactly. |
| `directType` | Reporting scope relative to the selected manager assignment. Use DIRECTS for immediate reports or ALL for the complete reporting hierarchy. |
| `offset` | Zero-based result offset used for pagination. Pass a non-negative integer. |
| `limit` | Maximum number of workers to return in the page. Pass a positive integer supported by WorkerSearchesV2. |
| `sortby` | WorkerSearchesV2 sort attribute. Use DisplayName for alphabetical sorting or Relevance for relevance sorting. |
| `direction` | Sort direction. Use asc or desc with DisplayName; use desc with Relevance. |

### Function : GetPrimaryAssignmentDirectReportCount

Description: Returns the primary-assignment direct-report count for a manager through workerAggregationsV2.

| Parameter Name | Description |
|---------------|---------------|
| `managerAssignmentId` | Primary assignment ID of the manager whose reports are counted. |

### Function : GetPrimaryAssignmentAllReportCount

Description: Returns the primary-assignment total/all-report count for a manager through workerAggregationsV2.

| Parameter Name | Description |
|---------------|---------------|
| `managerAssignmentId` | Primary assignment ID of the manager whose reports are counted. |

### Function : GetWorkersByManagerPersonId

Description: Lists direct reports for one validated manager person. The complete workerSearchesV2 operation payload is defined in this BO function; workflows pass only managerPersonId.

| Parameter Name | Description |
|---------------|---------------|
| `managerPersonId` | Manager person identifier inserted into the BO-defined Manager filter; callers don't supply an operation payload. |

---------------

### Function : GetLookupFacetValues

Description: Returns accessible Location, Department, Position or Job lookup values with a fixed PrimaryAssignmentOnly filter, PersonSearch AdvancedSearch security and native authentication.

| Parameter Name | Description |
|---------------|---------------|
| `facetField` | One of LocationName, DepartmentName, PositionName or JobName. |
| `searchText` | Optional plain search text for the lookup query. Callers must validate text length and reject JSON delimiters and control characters before substitution. |

### Function : GetLookupManagers

Description: Returns up to 25 accessible primary-assignment managers ordered by display name. Uses AssignmentManagerFlag Yes, PersonSearch AdvancedSearch access controls and native authentication.

### Function : GetLookupManagersWithQuery

Description: Returns up to 25 accessible primary-assignment managers ordered by display name and matching nonempty search text. Uses AssignmentManagerFlag Yes, PersonSearch AdvancedSearch access controls and native authentication.

### Function : GetLookupPeople

Description: Returns up to 25 accessible primary-assignment people ordered by display name. Uses PersonSearch AdvancedSearch access controls and native authentication, with no manager-only or WorkerType filter.

### Function : GetLookupPeopleWithQuery

Description: Returns up to 25 accessible primary-assignment people ordered by display name and matching nonempty search text. Uses PersonSearch AdvancedSearch access controls and native authentication, with no manager-only or WorkerType filter.

## Business Object : Representatives Search V2

| Code | `ORA_HCM_GLOBALHUMA_XX_REPRESENTATIVESSEARCHV2` |
|---------------|---------------|
| Description | This business object gives representative information for a worker. It can be used to retrieve representatives based on the input person id, assignment id, responsibility type, limit, and offset. |

## Functions


### Function : get_representatives

Description: This function gives representative records for a worker based on the input person id, assignment id, limit, and offset.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve representatives for the worker. |
| `assignmentId` | Assignment identifier used to retrieve representatives for the worker assignment. |
| `limit` | Maximum number of representative records to return. |
| `offset` | Zero-based offset used for paginated representative results. |

### Function : get_representatives_by_responsibility_type

Description: This function gives representative records for a worker based on the input person id, assignment id, responsibility type, limit, and offset.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve representatives for the worker. |
| `assignmentId` | Assignment identifier used to retrieve representatives for the worker assignment. |
| `responsibilityType` | Responsibility type used to filter representative records. |
| `limit` | Maximum number of representative records to return. |
| `offset` | Zero-based offset used for paginated representative results. |

---------------

## Business Object : Representatives Search

| Code | `ORA_HCM_GLOBALHUMA_XX_REPRESENTATIVESSEARCH` |
|---------------|---------------|
| Description | This business object gives representative information for a worker. It can be used to retrieve representatives based on the input person id, assignment id, responsibility type, limit, and offset. |

## Functions


### Function : get_representatives

Description: This function gives representative records for a worker based on the input person id, assignment id, limit, and offset.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve representatives for the worker. |
| `assignmentId` | Assignment identifier used to retrieve representatives for the worker assignment. |
| `limit` | Maximum number of representative records to return. |
| `offset` | Zero-based offset used for paginated representative results. |

### Function : get_representatives_by_responsibility_type

Description: This function gives representative records for a worker based on the input person id, assignment id, responsibility type, limit, and offset.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve representatives for the worker. |
| `assignmentId` | Assignment identifier used to retrieve representatives for the worker assignment. |
| `responsibilityType` | Responsibility type used to filter representative records. |
| `limit` | Maximum number of representative records to return. |
| `offset` | Zero-based offset used for paginated representative results. |

---------------

## Business Object : Talent Person Profiles

| Code | `ORA_HCM_GLOBALHUMA_XX_TALENTPERSONPROFILES` |
|---------------|---------------|
| Description | This business object gives talent profile information for a person. It can be used to retrieve about me, expertise, interests, tags, and skills based on the input person id. |

## Functions


### Function : getall_talentPersonProfiles

Description: This function gives talent profile information for a person based on the input person id.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve records for the person. |

---------------

## Business Object : HCM GHR Worker Contact Details

| Code | `ORA_HCM_GLOBALHUMA_XX_WORKERDETAILSGHR` |
|---------------|---------------|
| Description | Provides Global Human Resources public worker and contact information by person identifier or person number, including worker profile, email, phone, address, and other communication account details. |

## Functions


### Function : GetWorkerEmailsByPersonId

Description: Returns worker email details for the supplied person identifier.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve worker contact detail records. |

### Function : GetWorkerPhonesByPersonId

Description: Returns worker phone details for the supplied person identifier.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve worker contact detail records. |

### Function : GetWorkerEmailsByPersonNumber

Description: Returns worker email details for the supplied person number.

| Parameter Name | Description |
|---------------|---------------|
| `personNumber` | Person number used to retrieve worker contact detail records. |

### Function : GetWorkerPhonesByPersonNumber

Description: Returns worker phone details for the supplied person number.

| Parameter Name | Description |
|---------------|---------------|
| `personNumber` | Person number used to retrieve worker contact detail records. |

### Function : GetWorkerAddressesByPersonId

Description: Returns worker address details for the supplied person identifier.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve worker contact detail records. |

### Function : GetWorkerAddressesByPersonNumber

Description: Returns worker address details for the supplied person number.

| Parameter Name | Description |
|---------------|---------------|
| `personNumber` | Person number used to retrieve worker contact detail records. |

### Function : GetWorkerDetailsByPersonId

Description: Returns worker details for the supplied person identifier.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve worker details. |

### Function : GetWorkerDetailsByPersonNumber

Description: Returns worker details for the supplied person number.

| Parameter Name | Description |
|---------------|---------------|
| `personNumber` | Person number used to retrieve worker details. |

### Function : GetWorkerOtherCommunicationAccountsByPersonId

Description: Returns a worker's other communication account details for the supplied person identifier.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve the worker's other communication account details. |

---------------

#### Business Object : **Person Headers Data Object Access**

| Code | `ORA_HCM_GLOBALHUMA_XX_PERSON_HEADERS_DATA_OBJECT_ACCESS` |
|---------------|---------------|
| Description | Retrieves the data-object access permissions for a person as of an effective date. |

## Functions

---------------

#### Function : **getObjectsDataAccess**

Description: Retrieves the data-object access permissions for the specified person and effective date.

| Parameter Name | Description |
|---------------|---------------|
| `objectName` | Comma-separated data object names for which to retrieve access permissions. |
| `personId` | Identifier of the person whose data-object access is requested. |
| `effectiveDate` | Effective date used to evaluate data-object access. |

---------------

## Business Object : Person Notes V2

| Code | `ORA_HCM_GLOBALHUMA_XX_PERSONNOTESV2` |
|---------------|---------------|
| Description | This business object gives person note information for a worker. It can be used to retrieve note text, visibility, author, worker, and context details based on the input person id. |

## Functions


### Function : get_person_notes

Description: This function gives person note records for a worker based on the input person id. It returns note text, visibility, author, worker, and context details when available.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person identifier used to retrieve note records for the worker. |

---------------

## Business Object : Person Notes Visibility Options

| **Name** | Person Notes Visibility Options |
|---------------|---------------|
| **Code** | `ORA_HCM_GLOBALHUMA_XX_PERSONNOTESVISIBILITYOPTIONS` |
| **Description** | Retrieves the visibility choices available when creating a person note in the current setup context. Returns visibility codes, display labels, and the default visibility setting for feedback forms. |

## Functions

### Function : get_person_notes_visibility_options

Description: Returns the available person note visibility options for the current setup context.

---------------

## Business Object : Person Feedback Notes

| **Name** | Person Feedback Notes |
|---------------|---------------|
| **Code** | `ORA_HCM_GLOBALHUMA_XX_PERSONFEEDBACKNOTES` |
| **Description** | Retrieves feedback notes and recommendations for a selected worker using the person ID. Returns note text, creation and update dates, visibility, hidden status, and worker and author details from the Human Resources feedback service. |

## Functions

### Function : get_person_notes

Description: Retrieves up to 25 person notes for the given worker person ID where contextType is ORA_NO_CONTEXT or null. Returns note text, creation and update timestamps, hidden flag, visibility, worker ID, author ID and author display name.

| Parameter Name | Description |
|---------------|---------------|
| `personId` | Person ID of the worker whose notes are retrieved. |


## Business Object : Person Talent Profile

| Code | `ORA_HCM_TALENTREVI_XX_PERSONTALENTPROFILE` |
| --- | --- |
| Description | Consolidates talent profile lookup, profile section lookup, accomplishment, honor, and certification retrieval for a person. |

### Function : find_personTalentProfileId

Finds the talent profile identifier for a person identifier.

| Parameter | Type | Description |
| --- | --- | --- |
| `pPersonId` | string | Person identifier used to find the talent profile. |

### Function : getProfileTypeSectionId

Retrieves the section identifier for the specified person and profile section context.

| Parameter | Type | Description |
| --- | --- | --- |
| `sectionContext` | string | Profile section context used to locate the section, for example PERSON_COMPETENCY. |
| `personId` | string | Surrogate identifier of the person whose profile section is requested. |

### Function : getAccomplishmentItems

Retrieves accomplishment items for a talent person profile and section.

| Parameter | Type | Description |
| --- | --- | --- |
| `profileId` | string | Talent person profile identifier. |
| `sectionId` | string | Profile section identifier. |

### Function : getHonorItems

Retrieves honor and award items for a talent person profile and section.

| Parameter | Type | Description |
| --- | --- | --- |
| `profileId` | string | Talent person profile identifier. |
| `sectionId` | string | Profile section identifier. |

### Function : getCertificationItems

Retrieves certification items for a talent person profile and section.

| Parameter | Type | Description |
| --- | --- | --- |
| `profileId` | string | Talent person profile identifier. |
| `sectionId` | string | Profile section identifier. |

## Business Object : Person Notes

| Code | `ORA_HCM_PROFILEMAN_XX_PERSONNOTES` |
| --- | --- |
| Description | The Person Notes Business Object enables management of person notes.  It supports creating, updating, and deleting records that capture additional information or comments related to a person in the HCM system. |

### Function : hide_unhide_person_note

Hide or unhide a person note

| Parameter | Type | Description |
| --- | --- | --- |
| `NoteId` | integer | System-generated primary key of the note. |
| `HiddenFlag` | boolean | Indicates whether the note is hidden or shown. The default value is Show. |

### Function : update_person_note

Update a person note

| Parameter | Type | Description |
| --- | --- | --- |
| `NoteId` | integer | System-generated primary key of the note. |
| `NoteText` | string | Text of the note. |
| `NoteVisibilityCode` | string | Visibility of the note. Valid options are: ALL, MANAGERS, MANAGERS_AND_SUBJECT, PRIVATE, SUBJECT, MANAGERS_SUBJECT_PEERS. Administrators can remove any of the options via configuration for the specified context type. |

### Function : create_person_note

Creates a new person note by submitting data to the personNotesV2 resource using a POST operation. This function allows adding notes associated with a person in the system.

| Parameter | Type | Description |
| --- | --- | --- |
| `AuthorId` | integer | Person identifier of the author of the note. |
| `WorkerId` | integer | Person identifier of the worker who's the subject of the note. |
| `NoteVisibilityCode` | string | Visibility of the note. Valid options are: ALL, MANAGERS, MANAGERS_AND_SUBJECT, PRIVATE, SUBJECT, MANAGERS_SUBJECT_PEERS. Administrators can remove any of the options via configuration for the specified context type. |
| `ContextType` | string | Context type of the note. Supply value is ORA_NO_CONTEXT. |
| `ContextId` | integer | Context identifier of the note. |
| `ContextType2` | string | Additional context type of the note. |
| `ContextId2` | integer | Additional context identifier of the note. |
| `NoteText` | string | Text of the note. |
