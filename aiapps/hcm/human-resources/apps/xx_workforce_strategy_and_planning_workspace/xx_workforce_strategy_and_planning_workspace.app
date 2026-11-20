{
  "_comment": "Copyright © 2026, Oracle and/or its affiliates. ** Licensed under the Universal Permissive License (UPL), Version 1.0  as shown at oss.oracle.com/licenses/upl",
  "name": "Workforce Strategy and Planning Workspace",
  "internalName": "Workforce Strategy and Planning Workspace",
  "code": "XX_WORKFORCE_STRATEGY_AND_PLANNING_WORKSPACE",
  "internalDescription": "Helps users review and analyze EPM Signals alongside HCM data to understand workforce trends, identify gaps, and assess their impact on business goals. It develops actionable proposals and workforce strategies, helping users evaluate options, prioritize actions, and align workforce plans with desired business outcomes.",
  "status": "DRAFT",
  "version": 1,
  "specification": {
    "applicationMetadata": {
      "title": "Workforce Strategy and Planning",
      "enableFileUpload": false,
      "initiallyHideAgentPanelIfEmpty": false,
      "pagePattern": "swimlanesPattern",
      "pageConfig": {
        "agentContainers": [
          {
            "id": "container-1795156071481",
            "title": "Signals",
            "agents": [
              "agent-1795156071481"
            ]
          }
        ],
        "layout": "1",
        "firstLane": [
          "container-1795156071481"
        ],
        "secondLane": []
      },
      "agents": {
        "agent-1795156071481": {
          "agent": "XX_EPM_FORECAST_SIGNAL_INSIGHTS",
          "name": "EPM Forecast Signal Insights",
          "description": "This workflow retrieves signals for a specified application within an EPM instance, provides detailed signal information, and supports an Explain action to help users understand each signal and initiate actions toward the desired outcome.",
          "includeInSummary": false,
          "includeInActions": true,
          "includeInCommunications": false
        }
      },
      "communications": [],
      "enableAutonomousActivities": true,
      "additionalAutonomousAgents": [
        {
          "workflowCode": "XX_EPM_FORECAST_SIGNALS_HELPER_WORKFLOW",
          "title": "EPM Forecast Signals Helper Workflow",
          "description": "Retrieves employee, job requisition, and job offer information through three independent EPM Insights capabilities."
        }
      ],
      "skills": [
        {
          "code": "epm_insights_and_target_outcomes",
          "name": "epm-insights-and-target-outcomes",
          "description": "outcome-driven epm workforce and budget decision analysis for target outcomes across employees, role strategy, location market, budget scenarios, skills, requisitions, offers, and planning enrichment. use for epm inputs in any style, including narratives, statements, questions, commands, calculations, definitions, extractions, rewrites, and follow-ups. default every invocation to the full chat and artifact decision package; use a lightweight response only when the user explicitly requests summary-only output.",
          "storage": "internal"
        }
      ],
      "exampleTasks": [
        {
          "title": "Analytics Compensation Growth",
          "text": "Compensation investment in the Analytics job family is planned to increase by 5.5%, within a targeted growth range of 4.5% to 6.2%. The planning scope includes Data Scientist and Data Analyst roles. Allocation considers current salary and performance ratings across locations.",
          "taskMode": "RESEARCH",
          "category": "Research"
        },
        {
          "title": "Support and Design Cost Optimization",
          "text": "Compensation cost across the Support and Design job families is planned to decrease by 8.6%, within a targeted decrease range of 8.0% to 9.0%. The objective is to improve support efficiency. The majority of planned savings are concentrated in the Support job family, including Support Specialist roles, while the Design job family, including UX Designer roles, experiences the smallest reduction, preserving capability that supports usability, adoption, and service quality.",
          "taskMode": "RESEARCH",
          "category": "Research"
        },
        {
          "title": "Customer and Sales Compensation Growth",
          "text": "Compensation across the Customer and Sales job families is planned to increase by 5.7%, within a targeted growth range of 4.2% to 6.8%. Customer Success Manager and Sales Account Executive roles are included in the planning scope. The increase is allocated using current salary, performance rating, department, and location data.",
          "taskMode": "RESEARCH",
          "category": "Research"
        },
        {
          "title": "Planned Hiring Reduction",
          "text": "Total planned hiring is projected to decrease by 51 positions (10.9%), primarily driven by reduced hiring for Finance Analyst, Operations Specialist, and Support Specialist roles across the Finance, Operations, and Support job families. The planning objective is to meet future workforce demand through AI enablement, employee reskilling, and workforce redeployment.",
          "taskMode": "RESEARCH",
          "category": "Research"
        },
        {
          "title": "Department Compensation Reduction",
          "text": "Compensation is planned to decrease by 10%. The majority of planned savings are concentrated in the Cloud Operations department, while the Enterprise AI department experiences the smallest reduction, reflecting continued investment in strategic engineering capabilities.",
          "taskMode": "RESEARCH",
          "category": "Research"
        },
        {
          "title": "Merit Budget Reallocation",
          "text": "Total planned merit compensation is targeted to decrease by $0.06B (10.71%), with available merit funding strategically reallocated toward the Engineering and Analytics job families while moderating investments across the Sales, Operations, and Support job families. The planned allocation prioritizes critical talent retention within the approved compensation budget.",
          "taskMode": "RESEARCH",
          "category": "Research"
        }
      ],
      "enableEmailAttachments": false,
      "goals": "Helps users review and analyze EPM Signals alongside HCM data to understand workforce trends, identify gaps, and assess their impact on business goals. It develops actionable proposals and workforce strategies, helping users evaluate options, prioritize actions, and align workforce plans with desired business outcomes.",
      "appContextView": {
        "agentCode": "XX_EPM_FORECAST_SIGNAL_INSIGHTS",
        "searchPlaceholder": "Select an application instance"
      },
      "actions": [
        {
          "id": "e5180114-a77a-43c7-a480-900e89663f7d",
          "code": "signalDetails",
          "displayName": "Signal Details",
          "description": "",
          "events": {
            "onInvoke": [
              {
                "id": "2a2e5833-aeb6-4afc-9ddd-24607836ba4c",
                "type": "preserveAction",
                "params": {}
              },
              {
                "id": "5a25a4ab-3d94-44e4-b542-e1274a79d1a9",
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
      "initiallyHideActions": "all",
      "titleAgentCode": "XX_EPM_FORECAST_SIGNAL_INSIGHTS",
      "subtitleAgentCode": "XX_EPM_FORECAST_SIGNAL_INSIGHTS",
      "defaultOutcomeModel": "OPENAI_5_6_SOL"
    }
  },
  "id": "300100662848947"
}