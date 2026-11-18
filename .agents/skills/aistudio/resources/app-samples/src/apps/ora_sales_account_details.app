{
  "id": "300100647763608",
  "name": "Sales Account Details",
  "internalName": "Sales Account Details",
  "code": "ORA_SALES_ACCOUNT_DETAILS",
  "internalDescription": "Provides a consolidated view of account data, including the account summary, retention status, risk indicators, and growth opportunities. The application organizes these details to present a structured view of each account and its related information.",
  "status": "DRAFT",
  "version": 1,
  "specification": {
    "applicationMetadata": {
      "title": "",
      "pagePattern": "swimlanesPattern",
      "pageConfig": {
        "agentContainers": [
          {
            "id": "container-1775861381406",
            "title": "Current Account Strategy",
            "agents": [
              "agent-1775861381406"
            ],
            "panelId": "RETENTION",
            "initDisplayPromptOverride": "",
            "additionalPanels": []
          },
          {
            "id": "container-1775958652838",
            "title": "Account Signals",
            "agents": [
              "agent-1775861381406"
            ],
            "panelId": "EXECUTION",
            "initDisplayPromptOverride": "Display extraMessage content after the list",
            "additionalPanels": []
          }
        ],
        "layout": "1",
        "firstLane": [
          "container-1775861381406",
          "container-1775958652838"
        ],
        "secondLane": []
      },
      "agents": {
        "agent-1775861381406": {
          "agent": "ORA_SALES_REPRESENTATIVE_ACCOUNT_DETAILS",
          "name": "Sales Representative Account Details",
          "description": "This workflow provides sales representatives with a consolidated view of the accounts they manage by presenting key information such as account summary, retention status, risk indicators, and growth or white space opportunities. It aggregates and organizes these signals to offer a structured representation of each account and its associated details within the system.",
          "includeInSummary": true,
          "includeInActions": true,
          "includeInCommunications": true,
          "panels": [],
          "summaryPrompt": "",
          "actionsPrompt": ""
        }
      },
      "communications": [],
      "actions": [
        {
          "id": "a4b6039b-134e-436e-9461-bf4886057ab0",
          "code": "launchOpportunity",
          "displayName": "Launch Opportunity",
          "description": "Launch Opportunity Detail",
          "events": {
            "onInvoke": [
              {
                "id": "f2332ff0-e691-4baa-bf59-c9e738814115",
                "type": "navigateToAgenticApp",
                "params": {
                  "appCode": "SALES_OPPORTUNITY_DETAILS",
                  "passPayloadAsContext": true
                }
              }
            ]
          }
        }
      ],
      "initiallyHideActions": "all",
      "queryAgent": "ORA_SALES_REPRESENTATIVE_ACCOUNT_DETAILS",
      "autoTranslate": true,
      "enableFileUpload": true
    }
  }
}
