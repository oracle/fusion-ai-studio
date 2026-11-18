{
  "id": "300100647763609",
  "name": "Sales Opportunity Details",
  "internalName": "Sales Opportunity Details",
  "code": "ORA_SALES_OPPORTUNITY_DETAILS",
  "internalDescription": "Provides a consolidated view of opportunity data, including priority drivers, close date pressure, engagement velocity, and related service requests. The application organizes these details with core opportunity information to present a structured view of the opportunity and its related activities.",
  "status": "DRAFT",
  "version": 1,
  "specification": {
    "applicationMetadata": {
      "title": "Opportunity",
      "pagePattern": "swimlanesPattern",
      "pageConfig": {
        "agentContainers": [
          {
            "id": "container-1774728319514",
            "title": "Account Insights",
            "agents": [
              "agent-1774728319514"
            ],
            "panelId": "ACCOUNT_INSIGHTS",
            "initDisplayPromptOverride": ""
          },
          {
            "id": "container-1774729191997",
            "title": "Engagement Progress",
            "agents": [
              "agent-1774728319514"
            ],
            "panelId": "ENGAGEMENT_PROGRESS",
            "initDisplayPromptOverride": ""
          }
        ],
        "layout": "2",
        "firstLane": [
          "container-1774728319514"
        ],
        "secondLane": [
          "container-1774729191997"
        ]
      },
      "agents": {
        "agent-1774728319514": {
          "agent": "ORA_OPPORTUNITY_DETAIL_AGENT",
          "name": "Opportunity Detail Agent",
          "description": "This agent analyzes opportunity data and generates a structured summary by capturing key signals such as priority drivers, close date pressure, engagement velocity, and associated service requests. It processes and organizes these inputs to produce a consistent representation of the opportunity and its related activities within the system.",
          "includeInSummary": true,
          "includeInActions": true,
          "includeInCommunications": true,
          "summaryPrompt": ""
        }
      },
      "communications": [],
      "subtitleAgentCode": "ORA_OPPORTUNITY_DETAIL_AGENT",
      "subTitle": "",
      "actions": [
        {
          "id": "88563e40-aeb0-4623-ae5d-dacbef2425d3",
          "code": "invokeSuggestedTask",
          "displayName": "Invoke Suggested Task",
          "description": "Review Sales Suggestion Task",
          "events": {
            "onInvoke": [
              {
                "id": "c5b47635-1f41-4e6a-b36a-eedd506be33c",
                "type": "agentCommand",
                "params": {
                  "sendPayloadAsContext": true,
                  "doNotAutoRefresh": true
                }
              }
            ]
          }
        },
        {
          "id": "0bd1471d-e48a-4e99-8185-062fe4e9e349",
          "code": "viewObjectiveProgress",
          "displayName": "View Objective Progress",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "1e2c532f-886d-41da-bea1-9c7473f51929",
                "type": "agentCommand",
                "params": {
                  "sendPayloadAsContext": true,
                  "doNotAutoRefresh": true
                }
              },
              {
                "id": "ff08ac89-3d43-4bf6-9e6e-7a863b78236e",
                "type": "preserveAction",
                "params": {}
              }
            ]
          }
        },
        {
          "id": "c12afc7b-c585-4d22-8dde-d1ae4169a72a",
          "code": "viewEngagementHistory",
          "displayName": "Engagement History",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "bf95088b-eeef-4289-bd69-c02e6bb947a8",
                "type": "agentCommand",
                "params": {
                  "sendPayloadAsContext": true,
                  "doNotAutoRefresh": true
                }
              },
              {
                "id": "33fd7434-dc13-4664-ae32-1532397c547e",
                "type": "preserveAction",
                "params": {}
              }
            ]
          }
        },
        {
          "id": "383c62ef-3fff-4bc0-b162-b86c62de9396",
          "code": "viewOpportunityContacts",
          "displayName": "Opportunity Contacts",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "5fd5d1f8-8d60-4c41-9754-95a55a9f6822",
                "type": "agentCommand",
                "params": {
                  "sendPayloadAsContext": true,
                  "doNotAutoRefresh": true
                }
              },
              {
                "id": "ea68b064-2ac3-40e3-9c0b-622680c52e1d",
                "type": "preserveAction",
                "params": {}
              }
            ]
          }
        },
        {
          "id": "b8a76298-0e27-43bd-8f0b-5c6786fb5835",
          "code": "viewRecentDealInsights",
          "displayName": "Recent Deal Insights",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "b1e75600-5021-4343-9f8f-5d062b55ac7c",
                "type": "agentCommand",
                "params": {
                  "sendPayloadAsContext": true,
                  "doNotAutoRefresh": true
                }
              },
              {
                "id": "a43e88a7-3176-4cb8-9e0a-6c7f018168bc",
                "type": "preserveAction",
                "params": {}
              }
            ]
          }
        },
        {
          "id": "4844b7c8-261a-42bb-a6c1-5ff78dab8404",
          "code": "launchLinkedIn",
          "displayName": "Launch Linked In",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "0ffb8f08-f76d-40bf-ab0a-12fce2bf367f",
                "type": "editArtifact",
                "params": {}
              }
            ]
          }
        },
        {
          "id": "ea5f5965-16a4-4676-becc-f65c966facad",
          "code": "editRecentDealInsights",
          "displayName": "Edit Recent Deal Insights",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "a98885f4-84eb-4d7c-aebe-4d677ef99297",
                "type": "agentCommand",
                "params": {
                  "sendPayloadAsContext": true,
                  "doNotAutoRefresh": true
                }
              }
            ]
          }
        },
        {
          "id": "85daac19-c544-45a7-a133-45f86763de52",
          "code": "viewEngagementDetails",
          "displayName": "View Engagement Details",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "fca8796f-eff0-43d3-b7f8-97d5da0d2dde",
                "type": "editArtifact",
                "params": {}
              }
            ]
          }
        },
        {
          "id": "0ff68cf7-212c-4b05-8d3b-840ffdecfb79",
          "code": "viewMeetingBrief",
          "displayName": "View Meeting Brief",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "e6e3f6c3-52ed-452f-8ec3-e87ed5ac9a16",
                "type": "preserveAction",
                "params": {}
              },
              {
                "id": "d5fd7f3a-2718-4ac2-a23e-5cd5323c1fa9",
                "type": "agentCommand",
                "params": {
                  "sendPayloadAsContext": true,
                  "doNotAutoRefresh": true
                }
              }
            ]
          }
        },
        {
          "id": "55fc71a7-f6a0-47d6-9e85-c9e6d9781928",
          "code": "addRecommendedContact",
          "displayName": "Add Recommended Contact",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "fd24d7b5-01fd-4988-8f46-e7a8b3dba773",
                "type": "agentCommand",
                "params": {
                  "sendPayloadAsContext": true,
                  "doNotAutoRefresh": true
                }
              }
            ]
          }
        },
        {
          "id": "3cba919d-7723-41a6-aa4e-c61519791541",
          "code": "addContact",
          "displayName": "Add Contact",
          "description": "Add duplicate checked Contact",
          "events": {
            "onInvoke": [
              {
                "id": "d7305a2d-0b8e-4a75-829d-9e0a338722d2",
                "type": "agentCommand",
                "params": {
                  "sendPayloadAsContext": true,
                  "doNotAutoRefresh": true
                }
              }
            ]
          }
        },
        {
          "id": "a91d4b87-ae32-4299-a225-baa081ceaaf5",
          "code": "launchAccount",
          "displayName": "Launch Account",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "095674bb-5fb3-4078-9fb6-9fca6b61df8a",
                "type": "navigateToAgenticApp",
                "params": {
                  "passPayloadAsContext": true,
                  "appCode": "ORA_SALES_ACCOUNT_DETAILS"
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
