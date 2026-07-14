# Inventory Workflows

<!-- BEGIN GENERATED WORKFLOWS -->
<br/>

#### Workflow : Inventory Organization Context Switcher

| Workflow Name | Inventory Organization Context Switcher |
|---------------|---------------|
| **Code** | XX_INVENTORY_ORGANIZATION_CONTEXT_SWITCHER |
| **Description** | Inventory Context Switching is a workflow that allows users to switch the selected organization and view or perform inventory-related actions within that organization's context. This ensures the displayed inventory data and transactions are relevant to the chosen organization. |
| **Exposed to Agentic Apps** | Yes |
| **Input Parameters** | No input parameters required |
| **Output Parameters** | This workflow supports InitContextSuggestions, Query, and QueryContextSuggestions. <br> <br> `InitContextSuggestions` - Retrieves the user's default inventory organization using `Fetch Default Organization` business object. When a default organization is available, it retrieves the organization details using `Inventory Organizations List` business object and returns the organization name and an app context containing its organization ID. When no default organization is available, it retrieves an accessible fallback organization; if none is available, it sets the app context to All Organizations with organization ID `-1`. It also displays up to five accessible inventory organizations as selectable suggestions using Messages List widget. Selecting a suggestion sets the inventory organization app context. <br> Fields displayed : Organization Name. <br> <br> `Query` - Extracts an organization name or organization code from the user's request, searches accessible organizations using `Inventory Organizations List` business object, and evaluates the matching records. When exactly one organization matches, it immediately sets the app context to that organization's ID and returns a confirmation message. When multiple organizations match, it displays the matching organizations as a selectable table using Multi Record widget. When no organization matches, it returns a message asking the user to provide a different or more specific value. <br> Fields displayed : Organization Name. <br> <br> `QueryContextSuggestions` - Searches accessible inventory organizations using the entered text and displays the matching organizations as selectable suggestions using Messages List widget. Each suggestion displays only the organization name and sets the app context to the selected organization's ID. The workflow does not expose organization IDs, organization codes, or other technical details in the displayed output. <br> Fields displayed : Organization Name. |
<!-- END GENERATED WORKFLOWS -->
