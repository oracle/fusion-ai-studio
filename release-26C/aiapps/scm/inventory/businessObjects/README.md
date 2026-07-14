# Business Objects
<br>


## Fetch Default Organization

| **Name** | Fetch Default Organization |
|---------------|---------------|
| **Code** | ORA_SCM_INVENTORYM_XX_FETCHESDEFAULTO |
| **Description** | Fetches the default organization of the user |


### Function : get_default_organization
Description : Fetches the default organization of the user

| **Parameter Name** | **Description**|
|---------------|---------------|

## Inventory Organizations List

| **Name** | Inventory Organizations List |
|---------------|---------------|
| **Code** | ORA_SCM_INVENTORYM_XX_INVENTORYORGANIZATIONSLIST |
| **Description** | Retrieves the list of inventory organizations accessible to the user, including the OrganizationName , which can be used to display and switch the active inventory organization context. |


### Function : searchOrganizationsByName
Description : Searches accessible inventory organizations by OrganizationName or OrganizationCode using a server-side case-insensitive query predicate.

| **Parameter Name** | **Description**|
|---------------|---------------|
| SearchQuery | Organization Name |

### Function : getOrganizationsNameAndId
Description : Retrieves the list of inventory organizations accessible to the user, including the OrganizationName, which can be used to display and switch the active inventory organization context.

| **Parameter Name** | **Description**|
|---------------|---------------|

### Function : getDefaultOrganizationName
Description : For getting the default organization name

| **Parameter Name** | **Description**|
|---------------|---------------|
| ProfileOptionValue | Profile  option value |
