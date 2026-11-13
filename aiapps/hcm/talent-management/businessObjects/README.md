# Business Objects
<br>



## Business Object : Team Unscheduled Check-In


| **Name** | Team Unscheduled Check-In |
|---------------|---------------|
| **Code** | ORA_HCM_TALENT_XX_TEAMUNSCHEDULEDCHECKIN |
| **Description** | Fetches direct reports for a logged-in manager or user, including each employee's last check-in date, performance, potential, and assignment details. |

### Functions

#### Function : getCheckIns
Description : Returns team member check-in details for the given person ID and assignment ID, limited to direct line-manager reports and including display name, assignment name, last check-in date, performance, and potential.

| **Parameter Name** | **Description**|
|---------------|---------------|
| PersonId | Person ID of the logged-in user whose team check-in data should be fetched. |
| AssignmentId | Assignment ID of the logged-in user whose team check-in data should be fetched. |

## Business Object : Person Skill Details Search

| **Name** | Person Skill Details Search |
|---------------|---------------|
| **Code** | ORA_HCM_PROFILEMAN_XX_PERSON_SKILL_DETAILS_SEARCH |
| **Description** | Searches for skill details that people are developing or have achieved. |

### Functions

#### Function : personSkillDetailsSearches

Description : Gets skill details that match the specified criteria for people who are developing or have achieved those skills.

| **Parameter Name** | **Description** |
|---------------|---------------|
| skillType | Ways to categorize skills. Valid values are Core, Role, Other, All. |
| managerId | Unique identifier of the manager. |
| reportsType | Identifies the level of subordinates in the manager hierarchy. Valid values are directs, all. |
| skillName | Names of the skills used to filter the person-skill details search results. Pass a JSON array of skill names. |
| limit | Maximum number of items to get. |
| offset | The number of items to skip before starting to return results. |
| sortAttributeName | Name of the attribute used to sort the results. |
| sortDirection | Sort order for the results. Valid values are ASC, DESC. |

#### Function : personSkillDetailsSearchesByJob

Description : Gets skill details that match the specified criteria for people who are developing or have achieved those skills.

| **Parameter Name** | **Description** |
|---------------|---------------|
| skillType | Ways to categorize skills. Valid values are Core, Role, Other, All. |
| managerId | Unique identifier of the manager. |
| reportsType | Identifies the level of subordinates in the manager hierarchy. Valid values are directs, all. |
| skillName | Names of the skills used to filter the person-skill details search results. Pass a JSON array of skill names. |
| jobCode | Job code used to filter the person-skill details search results. |
| limit | Maximum number of items to get. |
| offset | The number of items to skip before starting to return results. |
| sortAttributeName | Name of the attribute used to sort the results. |
| sortDirection | Sort order for the results. Valid values are ASC, DESC. |

## Business Object : Team Skill Search

| **Name** | Team Skill Search |
|---------------|---------------|
| **Code** | ORA_HCM_PROFILEMAN_XX_TEAM_SKILL_SEARCH |
| **Description** | Searches for skills that team members are developing or have achieved. |

### Functions

#### Function : teamSkillSearches

Description : Gets counts for skills that team members are developing or have achieved.

| **Parameter Name** | **Description** |
|---------------|---------------|
| skillType | Ways to categorize skills. Valid values are Core, Role, Other, All. |
| managerId | Unique identifier of the manager. |
| reportsType | Identifies the level of subordinates in the manager hierarchy. Valid values are directs, all. |
| skillName | Name of the skill used to filter the team-skill search results. |
| limit | Maximum number of items to get. |
| offset | The number of items to skip before starting to return results. |
| sortAttributeName | Name of the attribute used to sort the results. |
| sortDirection | Sort order for the results. Valid values are ASC, DESC. |

## Business Object : Person Talent Profile V2

| **Name** | Person Talent Profile V2 |
|---------------|---------------|
| **Code** | ORA_HCM_TALENTREVI_XX_PERSONTALENTPROFILEV2 |
| **Description** | Consolidates talent profile lookup, profile section lookup, accomplishment, honor, and certification retrieval for a person. |

### Functions

#### Function : find_personTalentProfileId

Description : Finds the talent profile identifier for a person identifier.

| **Parameter Name** | **Description** |
|---------------|---------------|
| pPersonId | Person identifier used to find the talent profile. |

#### Function : getProfileTypeSectionId

Description : Retrieves the section identifier for the specified person and profile section context.

| **Parameter Name** | **Description** |
|---------------|---------------|
| sectionContext | Profile section context used to locate the section, for example PERSON_COMPETENCY. |
| personId | Surrogate identifier of the person whose profile section is requested. |

#### Function : getAccomplishmentItems

Description : Retrieves accomplishment items for a talent person profile and section.

| **Parameter Name** | **Description** |
|---------------|---------------|
| profileId | Talent person profile identifier. |
| sectionId | Profile section identifier. |

#### Function : getHonorItems

Description : Retrieves honor and award items for a talent person profile and section.

| **Parameter Name** | **Description** |
|---------------|---------------|
| profileId | Talent person profile identifier. |
| sectionId | Profile section identifier. |

#### Function : getCertificationItems

Description : Retrieves certification items for a talent person profile and section.

| **Parameter Name** | **Description** |
|---------------|---------------|
| profileId | Talent person profile identifier. |
| sectionId | Profile section identifier. |

## Business Object : Team Skills Details

| **Name** | Team Skills Details |
|---------------|---------------|
| **Code** | `ORA_HCM_TALENT_XX_TEAM_SKILLS_DETAILS` |
| **Description** | Retrieves team skill counts, worker public skills, skill descriptions, and skill aggregations using supplied person, manager, and skill identifiers. |

### Functions

#### Function : Skills_In_Team

Description : Retrieves skill names and IDs with achieved, developing, and total counts for the specified manager and skill type, ordered by achieved count in the requested direction and limited to the specified number of skills.

| **Parameter Name** | **Description** |
|---------------|---------------|
| `limit` | Maximum number of skill-summary records to return. |
| `AchievedCountDirection` | Sort direction for AchievedCount: ASC for the lowest counts or DESC for the highest counts. |
| `SkillType` | Skill category to include: Core or Role. |
| `ManagerId` | HCM person ID of the manager whose reporting population's skill counts should be returned. |

#### Function : Person_Skills_In_Team

Description : Retrieves up to 10 direct reports for the specified manager and skill type, with each worker's name, person ID, assignment name, and achieved, developing, and total skill counts, ordered by achieved count in the requested direction.

| **Parameter Name** | **Description** |
|---------------|---------------|
| `AchievedCountDirection` | Sort direction for AchievedCount: ASC for the lowest counts or DESC for the highest counts. |
| `SkillType` | Skill category to include: Core or Role. |
| `ManagerId` | HCM person ID of the manager whose reporting population's skill counts should be returned. |

#### Function : Get_Talent_Person_Public_Skills

Description : Retrieves public talent skill records for the worker with the specified person ID, including skill, proficiency, grouping, assignment, endorsement, and achievement details.

| **Parameter Name** | **Description** |
|---------------|---------------|
| `personId` | HCM person ID of the worker whose public talent skill records should be returned. |

#### Function : Get_Team_Skills_Aggregations

Description : Retrieves achieved, developing, and total counts for each skill in the reporting population of the manager with the specified person ID.

| **Parameter Name** | **Description** |
|---------------|---------------|
| `ManagerPersonId` | HCM person ID of the manager whose reporting-population skill counts should be returned. |

#### Function : Get_Direct_Person_Skill_Details

Description : Retrieves skill details for the specified skill type and name among the direct reports of the manager with the specified person ID, including worker names, assignment names, achieved and required skill levels, and endorsement counts.

| **Parameter Name** | **Description** |
|---------------|---------------|
| `SkillType` | Skill category used to filter direct-report skill results. |
| `ManagerPersonId` | HCM person ID of the manager whose direct reports should be searched. |
| `SkillName` | Skill name used to filter direct-report skill results. |

#### Function : Get_Skill_Description

Description : Retrieves a skill description for the specified skill name and returns it in the response.

| **Parameter Name** | **Description** |
|---------------|---------------|
| `SkillName` | Name of the skill for which a description should be generated. |
