# Business Objects

Compensation business objects, their functions, and input parameters.

## My Team Compensation Details Lookup

| **Name** | My Team Compensation Details Lookup |
|---------------|---------------|
| **Code** | ORA_HCM_COMP_XX_MYTEAMCOMPENSATIONDETAILSLOOKUP |
| **Description** | Retrieves compensation details for a selected employee's direct reports using the employee selected through the myTeamDetails findByObject action. It uses the person's ID and assignment ID to return compensation information such as salary basis, current salary, annual salary, currency, range position, compa ratio, quartile, quintile, and salary review dates |


### Function : findMyTeamCompensationDetails
Description : Retrieves compensation details for direct reports using the `myTeamDetails` `findByObject` action, based on the person's ID and assignment ID. It returns compensation details for those direct reports.

| **Parameter Name** | **Description**|
|---------------|---------------|
| pPersonId | Person ID used to retrieve direct report compensation details |
| pAssignmentId | Assignment ID used to retrieve direct report compensation details |


## Worker Stock Details

| **Name** | Worker Stock Details |
|---------------|---------------|
| **Code** | ORA_HCM_COMP_XX_WORKERSTOCKDETAILS |
| **Description** | Retrieves a worker’s stock grant history, including stock grants, vesting information, and stock prices. |

### Function : GetPersonStockHistory
Description : Returns global stock-grant history for the supplied worker person Id and assignment Id.

| **Parameter Name** | **Description**|
|---------------|---------------|
| assignmentId | Worker assignment Id used in the stock-history finder. |
| personId | Worker person Id used in the stock-history finder. |

## Worker Individual Compensation Details

| **Name** | Worker Individual Compensation Details |
|---------------|---------------|
| **Code** | ORA_HCM_COMP_XX_WORKERINDIVIDUALCOMPENSATIONDETAILS |
| **Description** | Retrieves a worker’s current and prior individual compensation details. |

### Function : GetCurrentIndividualCompensation
Description : Returns the employee's current individual compensation records, including future records, as of the supplied system effective date.

| **Parameter Name** | **Description**|
|---------------|---------------|
| assignmentId | Employee assignment Id used to retrieve individual compensation details |
| personId | Employee person Id used to retrieve individual compensation details |
| sysEffectiveDate | System effective date in YYYY-MM-DD format. |

### Function : GetPriorIndividualCompensation
Description : Returns the employee's prior individual compensation records as of the supplied system effective date.

| **Parameter Name** | **Description**|
|---------------|---------------|
| assignmentId | Employee assignment Id used to retrieve individual compensation details |
| personId | Employee person Id used to retrieve individual compensation details |
| sysEffectiveDate | System effective date in YYYY-MM-DD format. |

## Compensation Currency Details

| **Name** | Compensation Currency Details |
|---------------|---------------|
| **Code** | ORA_HCM_COMP_XX_COMPENSATIONCURRENCYDETAILS |
| **Description** | Provides currency display options and exchange rates to support viewing compensation amounts in worker local, corporate, or preferred currency. |

### Function : getExchangeRates
Description : Retrieves exchange rates between source and target currencies to support viewing compensation amounts in the selected currency.

| **Parameter Name** | **Description**|
|---------------|---------------|
| fromCurrency | Source currency code associated with the returned rate. |
| toCurrency | Target currency code associated with the returned rate. |
| conversionDate | Conversion date associated with the returned rate. |

### Function : getPreferredCompensationCurrency
Description : Retrieves currency display options for viewing compensation, including worker local, corporate, and preferred currency.

No input parameters required.
