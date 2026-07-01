{
  "_comment": "Copyright © 2022,2023, Oracle and/or its affiliates. ** Licensed under the Universal Permissive License (UPL), Version 1.0  as shown at oss.oracle.com/licenses/upl",
  "id": "300100655308439",
  "name": "Person Succession Readiness Workspace",
  "code": "XX_PERSON_SUCCESSION_READINESS_WORKSPACE",
  "version": 1,
  "status": "DRAFT",
  "internalName": "Person Succession Readiness Workspace",
  "internalDescription": "Succession Overview Agentic Application that lists Succession Information, Compensation History, Risk and Impact of Loss in Detail",
  "specification": {
    "applicationMetadata": {
      "title": "Succession Planning",
      "pagePattern": "swimlanesPattern",
      "pageConfig": {
        "agentContainers": [
          {
            "id": "container-1776076009568",
            "title": "Compensation History",
            "agents": [
              "agent-1776076009568"
            ]
          },
          {
            "id": "container-1776083617218",
            "title": "Impact Of Loss",
            "agents": [
              "agent-1776083617218"
            ]
          },
          {
            "id": "container-1776084341971",
            "title": "Risk Of Loss",
            "agents": [
              "agent-1776084341971"
            ]
          },
          {
            "id": "container-1776150884309",
            "title": "Succession Information",
            "agents": [
              "agent-1776150884309"
            ]
          }
        ],
        "layout": "2",
        "firstLane": [
          "container-1776150884309"
        ],
        "secondLane": [
          "container-1776084341971",
          "container-1776083617218",
          "container-1776076009568"
        ]
      },
      "agents": {
        "agent-1776076009568": {
          "agent": "XX_COMPENSATION_ANALYSIS",
          "name": "Compensation Analysis",
          "description": "",
          "includeInSummary": false,
          "includeInActions": false,
          "includeInCommunications": false
        },
        "agent-1776083617218": {
          "agent": "XX_IMPACT_OF_LOSS_ANALYSIS",
          "name": "Impact of Loss Analysis",
          "description": "",
          "includeInSummary": false,
          "includeInActions": false,
          "includeInCommunications": false
        },
        "agent-1776084341971": {
          "agent": "XX_RISK_OF_LOSS_ANALYSIS",
          "name": "Risk of Loss Analysis",
          "description": "",
          "includeInSummary": false,
          "includeInActions": false,
          "includeInCommunications": false
        },
        "agent-1776150884309": {
          "agent": "XX_SUCCESSION_ANALYSIS",
          "name": "Succession Analysis",
          "description": "",
          "includeInSummary": false,
          "includeInActions": false,
          "includeInCommunications": false
        }
      },
      "communications": [],
      "actions": [],
      "subtitleAgentCode": "XX_SUCCESSION_ANALYSIS",
      "enableFileUpload": false
    }
  },
  "seededFlag": false,
  "customizationPolicy": null,
  "$id": "300100655308439",
  "customizedSpecifications": {
    "items": [],
    "hasMore": false
  }
}
