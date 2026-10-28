# Human Resources Workflows

Identifier inputs such as `personId` are provided as strings and validated before conversion to typed BO arguments.

<!-- BEGIN GENERATED WORKFLOWS -->

#### Workflow : Worker Search

| Workflow Name | Worker Search |
|---------------|---------------|
| **Code** | XX_WORKER_SEARCH |
| **Description** | Worker Search is an Ask Oracle compatible workflow for worker, representative, About Me, accomplishment, and feedback lookups. It supports `Query` and `InvokeAction` modes and handles `PersonDetails`, `PersonRepresentatives`, and `PersonAbout` intents using the selected person from `OraAppContext`, with a current logged-in user fallback.<br><br>For worker search, it supports person name, phone number, work email, location, city, country, department, position, job, manager, team, organization, direct reports, all reports, time range, time zone, current user, combined filters, local-time filtering, grouped facets, paging, retry after removing the latest filter, unresolved terms, and no-result handling.<br><br>Worker results show display name, job, assignment, department, location, person image, and clickable actions. Representative search resolves the selected person's primary assignment, returns representatives, filters by responsibility, supports benefits, human resources, and payroll requests, and displays representative name, responsibility name, responsibility type, and image. `PersonAbout` retrieves talent-profile data for About Me and accomplishment summaries, and person notes for feedback summaries.<br><br>In `InvokeAction`, `selectFacet` applies selected facets and refreshes the relevant result, `selectPerson` refreshes the app with the selected person's context, and `showMore` retrieves the next page while preserving filters and context. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | This workflow supports `Query` and `InvokeAction`. <br> <br> `Query` - Interprets the Ask Oracle request and supports worker searches, representative searches, About Me summaries, feedback summaries, accomplishment summaries, team skill searches, and person skill details using the `Worker Search`, `Worker Employment`, `Representatives Search`, `Talent Person Profiles`, `Person Notes V2`, `Person Talent Profile`, `Team Skill Search`, and `Person Skill Details Search` business objects. Worker, representative, team skill, and person skill results are displayed using Message List widgets. Clicking a worker or representative invokes the `selectPerson` action with the selected person's `personId`. Query results also expose the `selectFacet` action for applying a result category or filter and the `showMore` action for retrieving additional results. Worker fields displayed: Name, Job, Assignment, Department, Location, and Person Image. Representative fields displayed: Name, Responsibility Name, Responsibility Type, and Person Image. Skill results include the worker or skill name and achieved and required skill levels when available. About Me, feedback, and accomplishment requests return concise summaries using only the available profile, note, honor, achievement, accomplishment, and certification data. Worker search supports name, work phone, work email, location, city, country, department, position, job, manager, team, organization, direct reports, all reports, time range, time zone, current user, combined filters, grouped result categories, local-time filtering, paging, unresolved terms, retries after removing the latest filter, and no-result handling. Representative search supports Benefits, Human Resources, and Payroll representative requests. Skill search supports a specified skill or all available skills within the current user's or a selected manager's organization, with separate paging for team skill and person skill results. <br> <br> Example requests include `who is Ravi`, `People in location New York and department Vision Operations`, `list all direct reports for Meg`, `who is my hr rep`, `show Satish's accomplishments`, `list people in Meg's org whose local time is between 09:00 and 12:00`, and `list employees skilled in Java in Meg's org`. <br> <br> `InvokeAction` : <br> `selectFacet` - Applies the selected person, manager, grouped result category, skill, or filter and refreshes the relevant results. <br> `selectPerson` - Receives the selected person's `personId` and refreshes the application context for that person. <br> `showMore` - Retrieves the next page of worker, representative, team skill, or person skill results while preserving the route-specific filters and application context. |

Skill-search dependencies are provided by the existing `Team Skill Search` and `Person Skill Details Search` BOs in `aiapps/hcm/talent-management/businessObjects`.

#### Workflow : Team Document Records Near Expiry

| Workflow Name | Team Document Records Near Expiry |
|---------------|---------------|
| **Code** | XX_TEAM_DOCUMENT_RECORDS_NEAR_EXPIRY |
| **Description** | Helps you monitor document records in your team that are expiring within the next 30 days by displaying the employee name, document type, document name, and expiration date. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | This workflow supports `InitDisplay`. <br> <br> `InitDisplay` - Retrieves document records for team members that are due to expire within the next 30 days using the `Document Records Expiring Lookup` business object and displays them using a Message List widget. Fields displayed: Employee Name, Document Name, Document Type, Attachments Count, Last Update Date, Expiration Date, and Employee Image when available. It also provides a brief summary of the expiring records. |

#### Workflow : Worker About Me

| Workflow Name | Worker About Me |
|---------------|---------------|
| **Code** | XX_WORKER_ABOUTME |
| **Description** | Displays a worker's About Me summary, expertise, interests, and tags, and answers questions using the available profile information. Workers can edit their own existing summary, expertise, and interest records; tags remain view-only. Also prepares About Me content for a communication. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional when the app or user context supplies a person. When provided, it takes precedence over the selected app-context person. When omitted, the workflow uses the selected person, then the logged-in worker. Provide a positive integer identifier as a string, within the supported safe-integer range. Invalid identifiers, malformed person context, or a missing resolved identifier raise an error.<br>Uses app context: `personId` - Person ID of the selected worker in `$OraAppContext`; `userId` - Person ID of the logged-in worker in `$OraUserContext`. |
| **Output Parameters** | This workflow supports `InitDisplay`, `Query`, `InvokeAction`, and `FillParameters`. <br> <br> `InitDisplay` - Retrieves About Me information using the `Worker Employment` business object and displays nonblank Summary, Expertise, Interest, and Tags using a Multi Card widget. It offers a separate Edit action only when the resolved person matches the logged-in worker; an empty profile returns an empty response. <br> <br> `Query` - Reuses stored profile context when available or retrieves it, then answers concisely using only that data. <br> <br> `InvokeAction` : <br> `editAboutMe` - Opens an editable form with Summary, Expertise, and Areas of Interest textareas, Save and Cancel controls, and view-only Tags when present. <br> `saveAboutMe` - Resolves exactly one matching talent profile and its REST item key, validates existing expertise and interest record identifiers, updates Summary, Expertise, and Interest in sequence using the `Worker Employment` business object, and reloads the profile display. Both Edit and Save require the target person to match the logged-in worker. Malformed submissions, duplicate or unexpected fields, and missing required form fields are rejected; submitted text is escaped before creating the update payloads. <br> <br> `FillParameters` - Renders available Summary, Expertise, and Interest as HTML and copies the complete HTML into communication parameter index 2 when that parameter exists. |

#### Workflow : Worker Achievements

| Workflow Name | Worker Achievements |
|---------------|---------------|
| **Code** | XX_WORKER_ACHIEVEMENTS |
| **Description** | Displays a worker's available honors, accomplishments, and certifications in separate lists. Answers questions using the selected worker's achievement information, with a fallback to the logged-in worker when no person is selected or supplied. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional. The selected app-context person takes precedence; when no person is selected, the workflow uses the supplied REST personId, then the logged-in worker. Invalid supplied identifiers or malformed selected-person context return the configured rejection response.<br>Uses app context: `personId` - Person ID of the selected worker in `$OraAppContext`; `userId` - Person ID of the logged-in worker in `$OraUserContext`. |
| **Output Parameters** | This workflow supports `InitDisplay` and `Query`. <br> <br> `InitDisplay` - Resolves the person's talent profile and the relevant Honors, Accomplishments, and Certifications sections using the `Person Talent Profile` business object. It displays each non-empty section using a separate Message List widget. Fields displayed: Honor or Award, Accomplishment, and License or Certificate. <br> <br> `Query` - Retrieves the person's Honors, Accomplishments, and Certifications and answers the user's question concisely using only the available achievement data. |


#### Workflow : Worker Card

| Workflow Name | Worker Card |
|---------------|---------------|
| **Code** | XX_WORKER_CARD |
| **Description** | Displays a worker summary with available job, grade, organization, manager, work contacts, and office address. Also prepares an email body containing the worker profile, About Me information, and recommendations for the configured communication. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional when the app or user context supplies a person. When provided, it takes precedence over the selected app-context person. When omitted, the workflow uses the selected person, then the logged-in worker. Provide a positive integer identifier as a string, within the supported safe-integer range. Invalid identifiers, malformed person context, or a missing resolved identifier raise an error.<br>Uses app context: `personId` - Person ID of the selected worker in `$OraAppContext`; `userId` - Person ID of the logged-in worker in `$OraUserContext`. |
| **Output Parameters** | This workflow supports `InitDisplay` and `FillParameters`. <br> <br> `InitDisplay` - Retrieves primary-assignment, person, phone, and other communication-account details using the `Worker Employment` and `HCM GHR Worker Contact Details` business objects. It returns formatted Markdown with the worker's name, position or job, grade, organization, manager, location, available contact rows, and multiline office address. Email uses a compose link; communication accounts use the configured provider-specific contact formatting. It does not include a widget or invocation actions. <br> <br> `FillParameters` - Additionally retrieves About Me information using `Talent Person Profiles` and recommendations using `Person Feedback Notes`. It generates an HTML email body with available worker details, About Me, Expertise, Interest, Tags, and every nonblank recommendation in the returned notes page, including author and creation date. The HTML begins with the available worker name and opening summary, without a separate Worker Profile title, and renders Contact Information, Office Address, About Me, Expertise, Interest, Tags, and Recommendations in that order while omitting unavailable sections. About Me appears once as the heading for its summary. If the worker name is unavailable, the opening summary uses The worker. It fills only the configured email BODY parameter by its exact identifier when requested, preserving the complete HTML and paragraph boundaries; other requested parameters are not filled. This route prepares the body without sending email or generating a PDF. |



#### Workflow : Direct Reports

| Workflow Name | Direct Reports |
|---------------|---------------|
| **Code** | XX_WORKER_DIRECTS |
| **Description** | Displays a worker's direct reports and reporting hierarchy, including available job, department, location, work contacts, and direct-report and total-report counts. Supports selecting a report, loading additional reports, and answering questions about the reporting information. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional when the app or user context supplies a person. When provided, it takes precedence over the selected app-context person. When omitted, the workflow uses the selected person, then the logged-in worker. Provide a positive integer identifier as a string, within the supported safe-integer range. Invalid identifiers, malformed person context, or a missing resolved identifier raise an error.<br>Uses app context: `personId` - Person ID of the selected worker in `$OraAppContext`; `userId` - Person ID of the logged-in worker in `$OraUserContext`. |
| **Output Parameters** | This workflow supports `InitDisplay`, `Query`, `InvokeAction`, and `AdditionalContent`. <br> <br> `InitDisplay` - Resolves the primary assignment using `Worker Employment`, retrieves primary-assignment employee direct and all-report counts using `Worker Search`, and retrieves worker details and manager hierarchy. It loads up to five detailed direct reports using `Person Direct Reports`, retrieves each report's counts sequentially, and merges the results by person identifier. The Message List displays Name, Job, Department, Location, Work Email, Work Phone, available report counts, and a person image. Its title shows the worker's Directs and Total counts, and its description shows the reporting hierarchy. When the worker's direct-report count is zero, it retains the hierarchy with an empty title and empty list, without row actions or images. Clicking a row with a person identifier invokes `selectDirect`. <br> <br> `Query` - Reuses available context or retrieves up to 100 direct-report collection rows at offset 0 and answers concisely using only that data. <br> <br> `InvokeAction` : <br> `selectDirect` - Receives the selected person's `personId` and refreshes the application context for that person. <br> <br> `AdditionalContent` : <br> `allDirects` - Retrieves up to 100 detailed direct reports at offset 5, enriches their counts, and renders the same available detail and contact fields in a Message List. Initial display, Query, and AdditionalContent return the configured no-primary-assignment response when the required assignment is missing. |

#### Workflow : Worker Document Record Expiry

| Workflow Name | Worker Document Record Expiry |
|---------------|---------------|
| **Code** | XX_WORKER_DOCUMENT_RECORD_EXPIRY |
| **Description** | Retrieves document records for the logged-in user that are due to expire within the next 30 days, displaying the document type, document name, expiration date, and expiry date. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | This workflow supports `InitDisplay`. <br> <br> `InitDisplay` - Retrieves document records for the current logged-in user that are due to expire within the next 30 days using the `Document Records Expiring Lookup` business object and displays them using a Message List widget. Fields displayed: Document Name, Document Type, Attachments Count, Last Update Date, and Expiration Date. It also provides a brief summary of the expiring records. |

#### Workflow : Worker Favourite Links

| Workflow Name | Worker Favourite Links |
|---------------|---------------|
| **Code** | XX_WORKER_FAVOURITE_LINKS |
| **Description** | Displays a worker's profile links and answers questions about the available links. The logged-in worker can add or update links on their own profile using the supported forms. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional. Uses the selected app-context person first, otherwise the supplied REST personId, then the logged-in worker. Malformed or ambiguous selected-person context and invalid supplied identifiers return the configured rejection response.<br>Uses app context: `personId` - Person ID of the selected worker in `$OraAppContext`; `userId` - Person ID of the logged-in worker in `$OraUserContext`. |
| **Output Parameters** | This workflow has routed branches for `InitDisplay`, `Query`, and `InvokeAction`. <br> <br> `InitDisplay` - Retrieves profile links using `Talent Person Profiles`, validates the returned profile, and renders a Multi Record table with Name and Link columns. The Link cell contains the validated URL as a clickable hyperlink. For the viewer's own profile, rows can carry edit actions and a separate Add Links action is prepared. A profile without displayable links returns an empty response. <br> <br> `Query` - Retrieves fresh profile-link data and answers from the prepared content; cache reuse is disabled. <br> <br> `InvokeAction` : <br> `editLink` - Opens an Edit Favorite Links form with Name and URL fields for the selected row, Save and Cancel controls, and an Add Another action. <br> `addLink` - Opens an Add Links form with Name and URL fields. <br> `saveLink` - Accepts one validated link, requires the submitted person to match the viewer, resolves the matching profile, and checks an existing bookmark against the freshly retrieved profile before update. It constructs a Description and URL payload and calls the configured `Worker Employment` function: `UpdateFavoriteLink` for an existing bookmark or `CreateFavoriteLink` for a new link, then reloads the display. `AdditionalContent` has no routed output branch. |

#### Workflow : Worker Feedback

| Workflow Name | Worker Feedback |
|---------------|---------------|
| **Code** | XX_WORKER_FEEDBACK |
| **Description** | Displays a worker's feedback and recommendations with available author, date, and visibility details. Supports showing additional feedback, answering questions about the retrieved notes, and adding a recommendation with a supported visibility setting. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional. Uses the selected app-context person first, otherwise the supplied REST personId, then the logged-in worker. An invalid supplied REST identifier does not fall back to the viewer.<br>Uses app context: `personId` - Person ID of the selected worker in `$OraAppContext`; `userId` - Person ID of the logged-in worker in `$OraUserContext`. |
| **Output Parameters** | This workflow supports `InitDisplay`, `Query`, `InvokeAction`, and `AdditionalContent`. <br> <br> `InitDisplay` - Retrieves up to 25 notes at offset 0 using `Person Feedback Notes`, normalizes readable nonblank note text, and displays the first five using a Message List widget. Fields displayed: Recommendation, Author, and Created On. A separate Add Recommendation action remains available when the list is empty. <br> <br> `Query` - Reuses stored feedback context only when the worker and viewer match; otherwise it retrieves notes again. It answers concisely using the available feedback and identifies first-page scope when more results exist. <br> <br> `InvokeAction` : <br> `addFeedback` - Retrieves choices using `Person Notes Visibility Options` and opens the What Others Think form with a feedback textarea and visibility select. It uses a returned default option when present, otherwise the first retained option. <br> `submitFeedback` - Parses the submitted `add_feedback_form`, creates a person note using `Person Notes` with the logged-in author, resolved worker, feedback text, selected visibility, and `ORA_NO_CONTEXT`, and returns the configured feedback-panel refresh action after success. Read and create failures have separate configured responses. <br> <br> `AdditionalContent` - Renders remaining readable recommendations after the first five from the retrieved page; it does not fetch a further notes page. |

#### Workflow : Worker Representatives

| Workflow Name | Worker Representatives |
|---------------|---------------|
| **Code** | XX_WORKER_REPS |
| **Description** | Displays a worker's assigned representatives, including responsibility, image, and available work email and phone details. Supports selecting a representative, loading the complete representative list, and answering questions about the available contacts. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional when the app or user context supplies a person. When provided, it takes precedence over the selected app-context person. When omitted, the workflow uses the selected person, then the logged-in worker. Provide a positive integer identifier as a string, within the supported safe-integer range. Invalid identifiers, malformed person context, or a missing resolved identifier raise an error. <br> `OraMessageHint` (string) - Declared request message hint; workflow routing reads the app-context message hint.<br>Uses app context: `personId` - Person ID of the selected worker in `$OraAppContext`; `userId` - Person ID of the logged-in worker in `$OraUserContext`. |
| **Output Parameters** | This workflow supports `InitDisplay`, `Query`, `InvokeAction`, and `AdditionalContent`. <br> <br> `InitDisplay` - Retrieves the primary assignment using `Worker Employment`, then up to two representatives at offset 0 using `Representatives Search`. Sequential `Worker Search` lookups enrich each representative with WorkEmail and WorkPhone. The Message List displays Representative Name, Responsibility Type as the subtitle, available work contacts, and an image when a person identifier is usable. Responsibility is not displayed as a badge. Clicking a usable row invokes `selectRepresentative`. <br> <br> `Query` - Reuses available context or retrieves up to 100 representatives at offset 0, enriches contacts, and answers using only that data. <br> <br> `InvokeAction` : <br> `selectRepresentative` - Receives the selected representative's `personId` and refreshes the application context for that person. <br> <br> `AdditionalContent` : <br> `allRepresentatives` - Retrieves up to 100 representatives at offset 2, enriches work contacts, and displays the same fields using a Message List widget. Missing primary-assignment data or an empty representative result renders an empty list without placeholder representatives. |

#### Workflow : Work Location Weather

| Workflow Name | Work Location Weather |
|---------------|---------------|
| **Code** | XX_WORKER_WRK_LOC_WEATHER |
| **Description** | Displays current weather and local-time information for a worker's work location. Uses the selected or supplied worker, with a fallback to the logged-in worker, and shows only available location, weather, and time details. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | `personId` - Optional when the app or user context supplies a person. When provided, it takes precedence over the selected app-context person. When omitted, the workflow uses the selected person, then the logged-in worker. Provide a positive integer identifier as a string, within the supported safe-integer range. Invalid identifiers, malformed person context, or a missing resolved identifier raise an error.<br>Uses app context: `personId` - Person ID of the selected worker in `$OraAppContext`; `userId` - Person ID of the logged-in worker in `$OraUserContext`. |
| **Output Parameters** | This workflow supports `InitDisplay`. <br> <br> `InitDisplay` - Retrieves the primary-assignment LocationName using `Worker Employment`, trims a readable string location, and passes it with a UTC request timestamp to the renderer. Missing assignment or location data and non-string location values are normalized to an empty location. The active rendering prompt outputs a nonblank readable location once as the first unlabeled line, then available Weather and Timezone or local-time lines with readable values and weather or day/night icons. Unavailable lines are omitted. The renderer is instructed to return zero characters when location, weather, and timezone or local time are all unavailable. |


#### Workflow : Address Details of Worker

| Workflow Name | Address Details of Worker |
|---------------|---------------|
| **Code** | XX_WORKER_ADDRESS_BY_PERSON |
| **Description** | Returns the addresses for a worker using person identifier first, or person number when person identifier is not provided. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | personId (string)<br>personNumber (string) |
| **Output Parameters** | The workflow returns an array of address objects. Each object has the fields AddressId (integer), EffectiveStartDate (date), EffectiveEndDate (date), AddressLine1 (string), AddressLine2 (string), AddressLine3 (string), AddressLine4 (string), TownOrCity (string), Region1 (string), Region2 (string), Region3 (string), Country (string), PostalCode (string), LongPostalCode (string), AddlAddressAttribute1 (string), AddlAddressAttribute2 (string), AddlAddressAttribute3 (string), AddlAddressAttribute4 (string), AddlAddressAttribute5 (string), Building (string), FloorNumber (string), CreatedBy (string), CreationDate (datetime), LastUpdatedBy (string), LastUpdateDate (datetime), PersonAddrUsageId (integer), AddressType (string), ValidationStatusCode (string), Provider (string), Longitude (number), Latitude (number), and PrimaryFlag (boolean). |

#### Workflow : Assignment History

| Workflow Name | Assignment History |
|---------------|---------------|
| **Code** | XX_WORKER_ASG_HISTORY_BY_PERSON |
| **Description** | Returns assignment history only after resolving the requested worker's current primary assignment and verifying any supplied assignment identifier against it. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | personId (string; required)<br>assignmentId (string; optional, must match the worker's current primary assignment). AssignmentId-only requests are rejected. |
| **Output Parameters** | The workflow returns an array of assignment-history objects. Each object has the fields AssignmentId (integer), EffectiveEndDate (date), EffectiveStartDate (date), EffectiveLatestChange (string), EffectiveSequence (integer), AssignmentNumber (string), AssignmentName (string), JobId (integer), GradeId (integer), PositionId (integer), LocationId (integer), DepartmentId (integer), LegalEntityId (integer), WorkerCategory (string), AssignmentCategory (string), AssignmentStatusTypeId (integer), PersonId (integer), PersonNumber (string), PersonDisplayName (string), ManagerDisplayName (string), PeriodOfServiceId (integer), WorkerNumber (string), ManagerId (integer), ManagerAssignmentId (integer), ActionId (integer), Action (string), ActionReason (string), ActionReasonId (integer), ActionOccurrenceId (integer), ActionTypeCode (string), BusinessUnit (string), Businessunitid (integer), Department (string), LegalEmployer (string), OrganizationId (integer), Location (string), Job (string), Position (string), Grade (string), GradeLadderId (integer), Gradeladder (string), GradeStepId (integer), Gradestep (string), CollectiveAgreementId (integer), CollectiveAgreement (string), BargainingUnitCode (string), ContractId (integer), IsManager (string), DateProbationEnd (date), ProbationPeriod (number), ProbationUnit (string), NormalHours (number), Frequency (string), WorkAtHome (string), TimeNormalFinish (string), TimeNormalStart (string), NoticePeriod (integer), AssignmentStatusType (string), ExpenseCheckAddress (string), InternalBuilding (string), InternalFloor (string), InternalLocation (string), InternalMailstop (string), InternalOfficeNumber (string), SystemPersonType (string), FullPartTime (string), PermanentTemporary (string), GspEligibility (string), UnionId (integer), SeniorityBasis (string), OvertimePeriod (integer), LastWorkingDate (date), TerminationDate (date), StandardHours (number), StandardFrequency (string), StandardAnnualWorkingDuration (number), AnnualWorkingDurationUnits (string), AnnualWorkingDuration (number), AnnualWorkingRatio (number), AdjustedFTE (number), Headcount (number), FTE (number), PeopleGroupId (integer), IdFlexNumber (integer), DateStart (date), BargainingUnitName (string), and LabourUnionMember (string). |

#### Workflow : Employment Information

| Workflow Name | Employment Information |
|---------------|---------------|
| **Code** | XX_WORKER_ASG_INFO_BY_PERSON |
| **Description** | Returns assignment and employment information for the supplied person identifier. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | personId (string) |
| **Output Parameters** | The workflow returns an array of assignment objects. Each object has the fields AssignmentId (integer), AssignmentNumber (string), AssignmentName (string), LegalEmployerName (string), StartDate (date), PrimaryFlag (boolean), PrimaryAssignmentFlag (boolean), WorkerType (string), WorkerNumber (string), WorkAtHomeFlag (boolean), FullPartTime (string), ManagerName (string), BusinessUnitName (string), DepartmentName (string), JobCode (string), JobName (string), PositionCode (string), PositionName (string), LocationCode (string), LocationName (string), GradeCode (string), GradeName (string), InternalBuilding (string), InternalFloor (string), InternalOfficeNumber (string), InternalMailstop (string), LocationAddressLine1 (string), LocationAddressLine2 (string), LocationAddressLine3 (string), LocationAddressLine4 (string), LocationRegion1 (string), LocationRegion2 (string), LocationRegion3 (string), LocationTownOrCity (string), LocationPostalCode (string), LocationCountry (string), LocationLongPostalCode (string), LocationTimezoneCode (string), LocationSingleLineAddress (string), LocationMultiLineAddress (string), LengthOfServiceYears (integer), LengthOfServiceMonths (integer), LengthOfServiceDays (integer), MarkedAsFavoriteFlag (boolean), DateProbationEnd (date), and ProjectedStartDate (date). |

#### Workflow : Number of Workers by Business Unit

| Workflow Name | Number of Workers by Business Unit |
|---------------|---------------|
| **Code** | XX_WORKER_CNT_BY_BU |
| **Description** | Returns the number of workers associated with the supplied business unit name. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | businessUnitName (string) |
| **Output Parameters** | The workflow returns a number representing the matching worker count. |

#### Workflow : Number of Workers by Department

| Workflow Name | Number of Workers by Department |
|---------------|---------------|
| **Code** | XX_WORKER_CNT_BY_DEPT |
| **Description** | Returns the number of workers associated with the supplied department name. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | departmentName (string) |
| **Output Parameters** | The workflow returns a number representing the matching worker count. |

#### Workflow : Number of Workers by Grade

| Workflow Name | Number of Workers by Grade |
|---------------|---------------|
| **Code** | XX_WORKER_CNT_BY_GRD |
| **Description** | A workflow agent that takes a grade as input and returns the count of employees with that grade. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | gradeName (string)<br>gradeCode (string) |
| **Output Parameters** | The workflow returns a number representing the matching worker count. |

#### Workflow : Number of Workers by Job

| Workflow Name | Number of Workers by Job |
|---------------|---------------|
| **Code** | XX_WORKER_CNT_BY_JOB |
| **Description** | Returns the number of workers associated with the supplied job code or job name. When both inputs are provided, the workflow uses job code first. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | jobCode (string)<br>jobName (string) |
| **Output Parameters** | The workflow returns a number representing the matching worker count. |

#### Workflow : Number of Workers by Location

| Workflow Name | Number of Workers by Location |
|---------------|---------------|
| **Code** | XX_WORKER_CNT_BY_LOCATION |
| **Description** | A workflow agent that takes a location as input and returns the count of employees at that location. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | locationCode (string)<br>locationName (string) |
| **Output Parameters** | The workflow returns a number representing the matching worker count. |

#### Workflow : Number of Workers by Position

| Workflow Name | Number of Workers by Position |
|---------------|---------------|
| **Code** | XX_WORKER_CNT_BY_POS |
| **Description** | A workflow agent that takes a position as input and returns the count of employees with that position. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | positionCode (string)<br>positionName (string) |
| **Output Parameters** | The workflow returns a number representing the matching worker count. |

#### Workflow : Count of Workers by Location, Job, Position, Grade and Business Unit

| Workflow Name | Count of Workers by Location, Job, Position, Grade and Business Unit |
|---------------|---------------|
| **Code** | XX_WORKER_CNT_BY_WORKSTR |
| **Description** | Agent team which gives count of Workers by Location, Job, Position, Grade and Business Unit |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | LocationName (string)<br>LocationCode (string)<br>JobName (string)<br>JobCode (string)<br>GradeName (string)<br>GradeCode (string)<br>DepartmentName (string)<br>PositionName (string)<br>PositionCode (string)<br>BusinessUnitName (string) |
| **Output Parameters** | The workflow returns a string containing the matching worker count after all supplied filters are applied. |

#### Workflow : Count of Workers by Grade

| Workflow Name | Count of Workers by Grade |
|---------------|---------------|
| **Code** | XX_WORKER_CNT_GRD_BY_MGR |
| **Description** | Returns worker counts grouped by grade for the supplied manager person identifier. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | managerId (string) |
| **Output Parameters** | The workflow returns an array of aggregation objects. Each object has the fields value (string) and count (number). |

#### Workflow : Count of Workers by Job

| Workflow Name | Count of Workers by Job |
|---------------|---------------|
| **Code** | XX_WORKER_CNT_JOB_BY_MGR |
| **Description** | Returns worker counts grouped by job for the supplied manager person identifier. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | managerId (string) |
| **Output Parameters** | The workflow returns an array of aggregation objects. Each object has the fields value (string) and count (number). |

#### Workflow : Count of Workers by Location

| Workflow Name | Count of Workers by Location |
|---------------|---------------|
| **Code** | XX_WORKER_CNT_LOC_BY_MGR |
| **Description** | Returns worker counts grouped by location for the supplied manager person identifier. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | managerId (string) |
| **Output Parameters** | The workflow returns an array of aggregation objects. Each object has the fields value (string) and count (number). |

#### Workflow : Email Details of Worker

| Workflow Name | Email Details of Worker |
|---------------|---------------|
| **Code** | XX_WORKER_EMAIL_BY_PERSON |
| **Description** | Returns the email addresses for a worker using person identifier first, or person number when person identifier is not provided. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | personId (string)<br>personNumber (string) |
| **Output Parameters** | The workflow returns an array of email objects. Each object has the fields EmailAddressId (integer), EmailType (string), EmailAddress (string), FromDate (date), ToDate (date), CreatedBy (string), CreationDate (datetime), LastUpdatedBy (string), LastUpdateDate (datetime), and PrimaryFlag (boolean). |

#### Workflow : Workers by Business Unit

| Workflow Name | Workers by Business Unit |
|---------------|---------------|
| **Code** | XX_WORKER_LIST_BY_BU |
| **Description** | Lists workers associated with the supplied business unit identifier or business unit name. When both inputs are provided, the workflow uses business unit identifier first. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | businessUnitId (string)<br>businessUnitName (string) |
| **Output Parameters** | The workflow returns an array of worker objects. Each object has the fields DisplayName (string), DepartmentName (string), JobName (string), LocationName (string), PositionName (string), PersonId (string), PersonNumber (string), and AssignmentNumber (string). |

#### Workflow : Workers by Department

| Workflow Name | Workers by Department |
|---------------|---------------|
| **Code** | XX_WORKER_LIST_BY_DEPT |
| **Description** | Lists workers associated with the supplied department name. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | departmentName (string) |
| **Output Parameters** | The workflow returns an array of worker objects. Each object has the fields DisplayName (string), DepartmentName (string), JobName (string), LocationName (string), PositionName (string), PersonId (string), PersonNumber (string), and AssignmentNumber (string). |

#### Workflow : Workers by Grade

| Workflow Name | Workers by Grade |
|---------------|---------------|
| **Code** | XX_WORKER_LIST_BY_GRD |
| **Description** | A workflow agent that takes a grade as input and lists all workers associated with that grade. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | gradeId (string)<br>gradeName (string)<br>gradeCode (string) |
| **Output Parameters** | The workflow returns an array of worker objects. Each object has the fields DisplayName (string), DepartmentName (string), JobName (string), LocationName (string), PositionName (string), PersonId (string), PersonNumber (string), and AssignmentNumber (string). |

#### Workflow : Workers by Job

| Workflow Name | Workers by Job |
|---------------|---------------|
| **Code** | XX_WORKER_LIST_BY_JOB |
| **Description** | Lists workers associated with the supplied job identifier, job code, or job name. When multiple job inputs are provided, the workflow uses job identifier first, then job code, then job name. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | jobId (string)<br>jobCode (string)<br>jobName (string) |
| **Output Parameters** | The workflow returns an array of worker objects. Each object has the fields DisplayName (string), DepartmentName (string), JobName (string), LocationName (string), PositionName (string), PersonId (string), PersonNumber (string), and AssignmentNumber (string). |

#### Workflow : Workers By Location

| Workflow Name | Workers By Location |
|---------------|---------------|
| **Code** | XX_WORKER_LIST_BY_LOCATION |
| **Description** | A workflow agent that takes a work location as input and lists all workers assigned to that location. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | locationId (string)<br>locationName (string)<br>locationCode (string) |
| **Output Parameters** | The workflow returns an array of worker objects. Each object has the fields DisplayName (string), DepartmentName (string), JobName (string), LocationName (string), PositionName (string), PersonId (string), PersonNumber (string), and AssignmentNumber (string). |

#### Workflow : Workers by Position

| Workflow Name | Workers by Position |
|---------------|---------------|
| **Code** | XX_WORKER_LIST_BY_POS |
| **Description** | A workflow agent that takes a position as input and lists all workers associated with that position. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | positionName (string)<br>positionId (string)<br>positionCode (string) |
| **Output Parameters** | The workflow returns an array of worker objects. Each object has the fields DisplayName (string), DepartmentName (string), JobName (string), LocationName (string), PositionName (string), PersonId (string), PersonNumber (string), and AssignmentNumber (string). |

#### Workflow : List of Workers by Location, Job, Position, Grade and Business Unit

| Workflow Name | List of Workers by Location, Job, Position, Grade and Business Unit |
|---------------|---------------|
| **Code** | XX_WORKER_LIST_BY_WORKSTR |
| **Description** | A workflow agent that takes Location, Job, Grade, Department, Position and Business Unit as input and returns the list of workers associated with the given input |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | departmentName (string)<br>businessUnitId (string)<br>businessUnitName (string)<br>gradeName (string)<br>gradeCode (string)<br>gradeId (string)<br>positionId (string)<br>positionName (string)<br>positionCode (string)<br>jobName (string)<br>jobCode (string)<br>jobId (string)<br>locationId (string)<br>locationName (string)<br>locationCode (string) |
| **Output Parameters** | The workflow returns an array of worker objects. Each object has the fields DisplayName (string), DepartmentName (string), JobName (string), LocationName (string), PositionName (string), PersonId (string), PersonNumber (string), and AssignmentNumber (string). |

#### Workflow : Manager Information

| Workflow Name | Manager Information |
|---------------|---------------|
| **Code** | XX_WORKER_MANAGER_BY_PERSON |
| **Description** | A workflow agent that takes person id and returns manager information. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | personId (string) |
| **Output Parameters** | The workflow returns an array of manager objects. Each object has the fields AssignmentSupervisorId (integer), ManagerPersonId (integer), ManagerPersonNumber (string), FirstName (string), LastName (string), DisplayName (string), KnownAs (string), ManagerAssignmentId (integer), ManagerAssignmentNumber (string), ManagerAssignmentName (string), ManagerType (string), ManagerTypeMeaning (string), JobCode (string), JobName (string), PositionCode (string), PositionName (string), PhotoId (integer), PhotoName (string), and WorkEmail (string). |

#### Workflow : Manager Hierarchy

| Workflow Name | Manager Hierarchy |
|---------------|---------------|
| **Code** | XX_WORKER_MNGR_HIERARCHY_BY_PERSON |
| **Description** | A workflow agent that takes person id and returns manager hierarchy till top person. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | personId (string) |
| **Output Parameters** | The workflow returns an array of manager-hierarchy objects. Each object has the fields DisplayName (string), ManagerPersonId (integer), ManagerAssignmentId (integer), RelationshipType (string), RelationshipTypeMeaning (string), and Level (integer). |

#### Workflow : Phone Details of Worker

| Workflow Name | Phone Details of Worker |
|---------------|---------------|
| **Code** | XX_WORKER_PHONE_BY_PERSON |
| **Description** | Returns the phone numbers for a worker using person identifier first, or person number when person identifier is not provided. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | personId (string)<br>personNumber (string) |
| **Output Parameters** | The workflow returns an array of phone objects. Each object has the fields PhoneId (integer), PhoneType (string), LegislationCode (string), CountryCodeNumber (string), AreaCode (string), PhoneNumber (string), Extension (string), FromDate (date), ToDate (date), Validity (string), CreatedBy (string), CreationDate (datetime), LastUpdatedBy (string), LastUpdateDate (datetime), and PrimaryFlag (boolean). |

#### Workflow : Seniority Information

| Workflow Name | Seniority Information |
|---------------|---------------|
| **Code** | XX_WORKER_SENR_INFO_BY_MGR |
| **Description** | Returns seniority information for workers in the supplied manager person identifier hierarchy. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | managerPersonId (string) |
| **Output Parameters** | The workflow returns an array of team-seniority objects. Each object has the fields SeniorityDateId (integer), PersonId (integer), AssignmentId (integer), ManagerId (integer), ManagerAssignmentId (integer), SeniorityDate (date), ExitDate (date), LevelCode (string), SeniorityField (string), SeniorityFieldKey (string), DisplayName (string), SeniorityFieldName (string), SeniorityFieldValue (string), TotalSeniorityHours (number), SeniorityLosYears (number), SeniorityLosMonths (number), SeniorityLosDays (number), ManualAdjustmentDays (number), TotalManualAdjustmentDays (number), AutoAdjustmentDays (number), TotalAutoAdjustmentDays (number), TotalAdjustmentDays (number), ManualAdjustmentHours (number), TotalManualAdjustmentHours (number), AutoAdjustmentHours (number), TotalAutoAdjustmentHours (number), TotalAdjustmentHours (number), SeniorityEffectiveDate (date), ManagerLevel (integer), and IsDirect (string). |

#### Workflow : Seniority Information of Worker

| Workflow Name | Seniority Information of Worker |
|---------------|---------------|
| **Code** | XX_WORKER_SENR_INFO_BY_PERSON |
| **Description** | Returns seniority information for the supplied person identifier. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | personId (string) |
| **Output Parameters** | The workflow returns an array of seniority objects. Each object has the fields ActionOccurrenceId (integer), AutoAdjustmentComments (string), AutoAdjustmentDays (number), AutoAdjustmentHours (number), BaseSeniorityDate (date), CalculationType (string), CreatedBy (string), CreationDate (datetime), EffectiveEndDate (date), EffectiveStartDate (date), EntryDate (date), ExitDate (date), LastUpdateDate (datetime), LastUpdatedBy (string), LevelCode (string), LevelObjectId (integer), ManualAdjustmentComments (string), ManualAdjustmentDays (number), ManualAdjustmentHours (number), PersonId (integer), SourceIdentifier (string), SeniorityDate (date), SeniorityDateCode (string), SeniorityDateId (integer), SeniorityAttributeCode (string), SeniorityAttributeIdentifier (string), SeniorityHours (number), SeniorityLengthOfServiceHours (string), TotalAdjustmentDays (number), TotalAdjustmentHours (number), TotalAutoAdjustmentDays (number), TotalAutoAdjustmentHours (number), TotalManualAdjustmentDays (number), TotalManualAdjustmentHours (number), TotalSeniorityHours (number), JobName (string), JobId (integer), LocationName (string), LocationId (integer), GradeName (string), GradeId (integer), DepartmentName (string), DepartmentId (integer), SeniorityDateCodeMeaning (string), BusinessUnitName (string), BusinessUnitId (integer), CollectiveAgreementName (string), CollectiveAgreementId (integer), LegislationCodeName (string), LegislationCode (string), EnterpriseName (string), GradeStepName (string), GradeStepId (integer), LegalEntityId (integer), PositionId (integer), PositionName (string), UnionName (string), UnionId (integer), AssignmentCategoryMeaning (string), AssignmentCategory (string), BargainingUnitMeaning (string), BargainingUnitCode (string), SeniorityAttributeIdentifierName (string), BusinessTitle (string), AssignmentNumber (string), WorkerType (string), EssRequestId (integer), ESSLastRunDate (datetime), SeniorityLengthOfServiceDays (number), SeniorityLengthOfServiceMonths (number), SeniorityLengthOfServiceTotalDays (number), SeniorityLengthOfServiceYears (number), LevelCodeMeaning (string), SeniorityAttributeCodeMeaning (string), WorkerTypeMeaning (string), AssignmentLegalEmployerName (string), RequestedEffectiveDate (date), SeniorityBasis (string), LegalEmployerName (string), SeniorityBasisMeaning (string), AssignmentStatusType (string), AssignmentStatusTypeId (integer), and AssignmentStatusTypeName (string). |

#### Workflow : Worker By Name

| Workflow Name | Worker By Name |
|---------------|---------------|
| **Code** | XX_WORKER_SRCH_BY_NAME |
| **Description** | A workflow agent that takes a worker's name or partial name as input and returns the matching worker record. |
| **Exposed to Agentic Apps** | No |
| **Input Parameters** | workerName (string) |
| **Output Parameters** | The workflow returns an array of worker objects. Each object has the fields DisplayName (string), DepartmentName (string), JobName (string), LocationName (string), PositionName (string), PersonId (string), PersonNumber (string), and AssignmentNumber (string). |
<!-- END GENERATED WORKFLOWS -->
