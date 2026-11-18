{
  "id": "300100646759685",
  "name": "Sales Command Center",
  "internalName": "Sales Command Center",
  "code": "ORA_SALES_COMMAND_CENTER",
  "internalDescription": "Provides sales representatives with a unified, AI-driven workspace to manage territory priorities, meetings, customer accounts, and programs. The application presents prioritized opportunities that need action, premeeting briefs and follow-ups, customer account insights, and territory-linked marketing programs. Intelligent agents support these workflows and can be extended to support additional sales workflows.",
  "status": "DRAFT",
  "version": 1,
  "specification": {
    "applicationMetadata": {
      "title": "Sales Command Center",
      "pagePattern": "swimlanesPattern",
      "pageConfig": {
        "agentContainers": [
          {
            "id": "container-1774718649978",
            "title": "Priority Opportunities Requiring Immediate Action",
            "agents": [
              "agent-1774718649978"
            ]
          },
          {
            "id": "container-1774823721450",
            "title": "Pre-Meeting Briefs and Follow Up",
            "agents": [
              "agent-1774823721450"
            ]
          },
          {
            "id": "container-1774841850734",
            "title": "Strategic Accounts",
            "agents": [
              "agent-1774841850735"
            ]
          }
        ],
        "layout": "2",
        "firstLane": [
          "container-1774718649978",
          "container-1774841850734"
        ],
        "secondLane": [
          "container-1774823721450"
        ]
      },
      "agents": {
        "agent-1774718649978": {
          "agent": "ORA_OPPORTUNITY_HEALTH_AND_PRIORITIZATION",
          "name": "Opportunity Health & Prioritization Agent",
          "description": "Retrieves the opportunities you or your team owns, ranks them by expected impact, and recommends next actions and communication ideas.",
          "includeInSummary": true,
          "includeInActions": true,
          "includeInCommunications": true
        },
        "agent-1774823721450": {
          "agent": "ORA_MEETING_OVERVIEW",
          "name": "Meeting Overview",
          "description": "Compiles a concise meeting brief with the latest context, key updates, and suggested topics to cover next.",
          "includeInSummary": true,
          "includeInActions": false,
          "includeInCommunications": false
        },
        "agent-1774841850735": {
          "agent": "ORA_SALES_REPRESENTATIVE_ACCOUNT_ADVISOR",
          "name": "Sales Representative Account Advisor",
          "description": "This workflow enables sales representatives to view and manage accounts associated with them by presenting a consolidated list along with key insights and summaries. It captures and organizes account-level signals, including indicators related to risk, expansion potential, and overall status, providing a structured view of each account and its associated details within the system.",
          "includeInSummary": false,
          "includeInActions": false,
          "includeInCommunications": false
        }
      },
      "communications": [],
      "subTitle": "",
      "subtitleAgentCode": "ORA_OPPORTUNITY_HEALTH_AND_PRIORITIZATION",
      "actions": [
        {
          "id": "3c7d5fd0-41a8-4f40-a3ad-0fa2049d7024",
          "code": "launchOpportunity",
          "displayName": "Launch Opportunity",
          "description": "Drill down into the Opportunity Details",
          "events": {
            "onInvoke": [
              {
                "id": "691f926c-b042-4660-b70e-48ece2eaf5f7",
                "type": "navigateToAgenticApp",
                "params": {
                  "passPayloadAsContext": true,
                  "appCode": "ORA_SALES_OPPORTUNITY_DETAILS"
                }
              }
            ]
          }
        },
        {
          "id": "af2c0ec7-40cd-4d33-8261-82a674d5019f",
          "code": "launchAccount",
          "displayName": "Launch Account",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "bbc3c6bb-2690-42e5-8140-cf199918e7fc",
                "type": "navigateToAgenticApp",
                "params": {
                  "appCode": "ORA_SALES_ACCOUNT_DETAILS",
                  "passPayloadAsContext": true
                }
              }
            ]
          }
        },
        {
          "id": "645213a1-6418-4085-822a-81939e70545d",
          "code": "launchProgram",
          "displayName": "Launch Program",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "5c5982d6-38cf-4deb-8ae8-ea9423f22b99",
                "type": "navigateToAgenticApp",
                "params": {
                  "passPayloadAsContext": true,
                  "appCode": "ORA_SALES_PROGRAM_ADVISOR"
                }
              }
            ]
          }
        },
        {
          "id": "d1bb94d5-3dfa-4932-b8fe-fbc169e37c4d",
          "code": "invokeSuggestedTask",
          "displayName": "Invoke Suggested Task",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "a861e8a5-4c7e-4df3-a809-489606a69ef8",
                "type": "agentCommand",
                "params": {
                  "sendPayloadAsContext": true,
                  "doNotAutoRefresh": true
                }
              }
            ]
          }
        }
      ],
      "enableFileUpload": true
    }
  }
}
