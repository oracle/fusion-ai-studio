# Agentic App Samples

Use these samples only as examples of well-built Agentic Apps and app-backed workflow structure. Review them for inspiration before designing or materially editing an app-backed workflow, especially for data-source retrieval, shared fetches before app-stage routing, `OraMessageHint` switches, panel-specific display behavior, query handling, action wiring, and communication paths.

Do not use these samples directly, copy them exactly, or treat them as templates to clone. Do not transplant sample ids, Business Object choices, field names, action codes, prompts, workflow wiring, or communication behavior into a new app. Build from the user's requested functionality, confirmed data sources, and available APIs/tools; use the samples only to understand what a well-built workflow can look like.

## Sales Sample Set

Source files live under `/src/`.

### Sales Command Center

- App file: `/src/apps/ora_sales_command_center.app`
- App code: `ORA_SALES_COMMAND_CENTER`
- Purpose: Unified sales-representative workspace for territory priorities, meetings, strategic accounts, and drill-down navigation.
- Layout: Swimlanes with panels for priority opportunities, pre-meeting briefs/follow-up, and strategic accounts.
- Capabilities:
  - Shows priority opportunities that need immediate action.
  - Summarizes upcoming meetings and follow-up context.
  - Shows strategic account insights for the representative's territory.
  - Generates priority actions and communication suggestions from the opportunity workflow.
  - Navigates to opportunity details with `launchOpportunity`.
  - Navigates to account details with `launchAccount`.
  - Navigates to a program advisor with `launchProgram`.
  - Sends suggested-task payloads back to the active agent with `invokeSuggestedTask`.
- Supporting workflows:
  - `/src/workflows/ora_opportunity_health_and_prioritization.wf`: Fetches owned open opportunities from the CX object search BO, gathers opportunity details, AI outcome summaries, recommendations, and engagement insights, then produces app-stage summary, startup display, query response, send-communication, subtitle, invoke-action, and initial action outputs.
  - `/src/workflows/ora_meeting_overview.wf`: Fetches upcoming appointments from the CX object search BO, summarizes meeting activity, renders meeting cards, answers meeting queries, generates communication suggestions, and invokes the opportunity assistant workflow for talking points.
  - `/src/workflows/ora_sales_representative_account_advisor.wf`: Fetches sales-team accounts and AI outcome insights, prioritizes accounts, renders account widgets, and delegates query handling to a customer portfolio chat workflow.

### Sales Opportunity Details

- App file: `/src/apps/ora_sales_opportunity_details.app`
- App code: `ORA_SALES_OPPORTUNITY_DETAILS`
- Purpose: Detail workspace for one opportunity, including account insights, engagement progress, recommendations, contacts, meeting context, and follow-up actions.
- Layout: Swimlanes with Account Insights and Engagement Progress panels backed by the same opportunity detail agent.
- Capabilities:
  - Reads the selected opportunity id from app context for navigation payloads, then retrieves real opportunity data through BO nodes.
  - Displays account insight and engagement progress panels.
  - Produces app subtitle, summary, startup display, initial actions, communication suggestions, fill-parameter output, query responses, invoke-action handling, and send-communication behavior.
  - Supports suggested-task review with `invokeSuggestedTask`.
  - Supports objective progress, engagement history, opportunity contacts, recent deal insights, meeting briefs, recommended contacts, and contact-add commands through agent actions.
  - Opens editable or viewable artifacts for LinkedIn, engagement details, and recent deal insight flows.
  - Navigates to account details with `launchAccount`.
- Supporting workflows:
  - `/src/workflows/ora_opportunity_detail_agent.wf`: Parses the opportunity navigation context, fetches the opportunity, account insights, opportunity recommendations, engagement insights, appointments, contact data, opportunity feeds, LinkedIn foreign ids, and Outlook connector behavior. It also invokes the opportunity assistant workflow for summaries, queries, and suggested tasks, updates opportunity deal data, and routes app stages through `InitSubtitle`, `InitCommunications`, `FillParameters`, `InitDisplay`, `Summary`, `Query`, `InvokeAction`, and `SendCommunication`.

### Sales Account Details

- App file: `/src/apps/ora_sales_account_details.app`
- App code: `ORA_SALES_ACCOUNT_DETAILS`
- Purpose: Detail workspace for one account, including current strategy, account signals, retention/risk context, growth opportunities, product insight, related opportunities, and action recommendations.
- Layout: Single swimlane with Current Account Strategy and Account Signals panels backed by the same account details workflow.
- Capabilities:
  - Reads account and optional activity identifiers from app context for navigation payloads, then retrieves real account and activity data through BO nodes.
  - Shows account insight, retention risk, account summary, commercial news/profile, product summary, execution, and recommendation views.
  - Supports initial display, summary, initial actions, and query paths.
  - Invokes product-insight and account-advisor workflows for product and free-form account guidance.
  - Fetches related opportunities and recommendations for the current account.
  - Navigates to opportunity details with `launchOpportunity`.
- Supporting workflows:
  - `/src/workflows/ora_sales_representative_account_details.wf`: Parses account navigation context, fetches account insights, company news, account summaries, appointment details, activity summaries, related opportunities, and recommendations. It calls account product insight and account advisor workflows, renders retention/account/product/execution widgets, and routes `InitDisplay`, `Summary`, `InitActions`, and `Query` app stages.

## Workflow Catalog

- `/src/workflows/ora_opportunity_health_and_prioritization.wf` - Opportunity prioritization workflow. Uses CX object search to get owned open opportunities, AI outcome store data for summaries/recommendations, engagement insights, email connector behavior, and opportunity assistant workflows. Produces prioritized opportunity display, summary, query, action, subtitle, and communication outputs.
- `/src/workflows/ora_meeting_overview.wf` - Meeting overview workflow. Uses CX object search to fetch upcoming appointments, formats meeting data, invokes the opportunity assistant workflow for talking points, and produces summary, startup display, query, invoke-action, and communication outputs.
- `/src/workflows/ora_sales_representative_account_advisor.wf` - Account advisor list workflow. Uses CX object search for account lists, AI outcome store for account insights/summaries, and a customer portfolio chat workflow for query handling. Produces account list widgets, summaries, and query responses.
- `/src/workflows/ora_opportunity_detail_agent.wf` - Opportunity detail workflow. Uses opportunity, account, engagement, contact, sales feed, LinkedIn, object update, Outlook email, and opportunity assistant integrations to power opportunity detail panels and actions.
- `/src/workflows/ora_sales_representative_account_details.wf` - Account detail workflow. Uses account outcome store data, CX object search for activity/opportunity records, product insight workflows, and account advisor workflows to power account strategy, signals, recommendations, and query behavior.
