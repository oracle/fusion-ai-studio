# Oracle Fusion AI Agent Studio Sample Apps and Workflows

This repository provides samples demonstrating how to use Oracle AI Agent Studio to build apps, workflows, etc.

## Oracle Fusion AI Agent Studio
**Oracle Fusion AI Agent Studio** (often referred to as AI Agent Studio) is Oracle’s primary platform for **building, configuring, and deploying agentic applications** and their underlying specialized agent teams. It serves as the "intelligence layer" of the agentic app framework, providing the tools needed to design how agents reason, analyze data, and generate responses. 

```text
AI Agent Studio is a specialized design-time environment that lets you create, configure, test, and deploy AI agents for your organization.
```

The primary purpose of the Studio is to allow users to create, configure, validate, and deploy agents. It offers a combination of pre-built agent template libraries for common scenarios (such as opportunity-to-quote processing) and extensibility tools to customize agents for specific industry needs.


### Fusion AI Agentic Apps
Oracle’s Agentic Apps, built within the AI Agent Studio, represent a completely new category of enterprise application – one that does not just store your data or present your data, but understands it, prioritizes it, and proactively tells you what to do about it.


The Builder UI is your primary workspace for creating and configuring agentic applications. It is where you choose your app’s pattern, arrange agents on the page, configure prompts, set up communications, and ultimately preview and publish your app. Everything starts here.

In Fusion AI Agent Studio, AI Agents are built using a few key parts that work together to complete business tasks automatically. Teams/Workflows are the step-by-step plans, Agents are the AI workers that perform tasks, Tools connect the agents to fusion (and external) systems and data, Instructions/Prompts control how the agent behaves and responds, Topics define the subject of conversation, and Testing ensures everything works correctly. Together, these components help organizations create smart, automated AI advisors that can talk to users, gather information, make decisions, and take actions efficiently.

#### Key functions and Components
- **Building Agent Teams**: You can create specialized teams using two primary architectures:
  - **Workflow Teams (Recommended):** These use a structured graph of nodes (LLM, Code, Switch) for deterministic processing and predictable latency
- **The App Experience Tab:** This is a critical interface within the Studio where you grant an agent the right to participate in agentic apps. Here, you enable specific output features: 
  - **Enable Actions**: Allows agents to produce actionable insights.
  - **Enable Communications**: Allows agents to suggest outbound messages like emails or Slack notifications
  - **Select Widgets**: Determines which of the seven visual components (e.g., Charts, Sankey diagrams, Tables) the agent is allowed to render

### Fusion AI Workflows aka Agent Teams
In Oracle Fusion AI Agent Studio, Agent Teams are the foundational intelligence units that power agentic applications, while Workflows are the recommended architectural pattern used to build them. It is a specialized group of AI agents built to handle specific domains (such as HR, Finance, or Procurement). 

Agent Teams serve as the "brain" of the application, responsible for reasoning over data, generating insights, and producing the four pillars of the user experience: Information Displays, Actionable Insights, Communications, and Ask Oracle responses.
There are two primary architectures for these teams:
- **Workflow Teams :** These teams use a structured graph of nodes (LLM, Code, Switch, and Agent nodes) to process requests deterministically. They provide the most control over routing and ensure predictable latency, which is critical for meeting the framework's strict 60-second response limit

#### Workflows
A Workflow refers to the specific configuration of nodes that define how an Agent Team responds to the application framework.
Key characteristics of a Workflow include:
- **Message Hint Routing:** The workflow's first node is typically a Switch node that reads the $context.$app.$OraMessageHint variable. This allows the agent to branch its logic based on whether the app is requesting a summary, an initial display, an answer to a query, or an action execution.
- **Node-Based Logic:** Builders chain nodes together to perform complex tasks. For example, a Code node might be used to assemble a prompt, which is then passed to an LLM node for reasoning
- **Explicit Context Passing:** A critical rule of workflows is that user input and chat history are not passed automatically to internal nodes; builders must explicitly wire variables like $context.$system.$inputMessage and $context.$system.$chatHistory into the prompt for downstream LLM or Agent nodes to function correctly
- **Licensing Capabilities:** Within the workflow, builders use the App Experience Tab on LLM or Agent nodes to "license" what that team can produce, such as enabling specific widget types, actions, or communications.


#### Agentic App Builder
The Agentic App Builder (or Builder UI) is the primary workspace within the Oracle Fusion AI framework for creating, configuring, and publishing agentic applications. It is designed as a "no code" visual interface that allows domain experts and solution architects to build intelligent applications without needing a developer for every change. While AI Agent Studio defines what an agent team is capable of doing globally, the Agentic App Builder decides what that team should contribute within a specific application.
**Core Configuration Areas**:
The Builder UI organizes application design into several key functional areas:

- **App Settings:** Builders define the app shell, including its title, subtitle, security roles for access control, and page layout (e.g., asymmetric or multi-column arrangements).

- **Static Agents:** This area handles the top-level "Ask Oracle" and "Summary" slots. Builders can assign dedicated agents to these slots to control the application's unified voice, or rely on the orchestrator to dynamically aggregate insights from all panel agents.

- **Domain Agents:** In the central page pattern, builders arrange specialized agent teams into "slots." Clicking an agent card opens the Agent Editor, where local prompts are written to define exactly how that agent contributes its summary, actionable insights, and initial graphics for this specific app.


- **Integrated Editors:** From the Builder toolbar, you can access the Actions Editor to build reusable multi-step workflows and the Template Editor to design document formats (PowerPoint, PDF, Email, or Text) for outbound communications.


- **Communications List:** On the right panel, builders create communication buttons and link them to templates, designating which agents are allowed to suggest specific outreach

[![Watch the demo](https://img.youtube.com/vi/TDJJLHdBvnY/mqdefault.jpg)](https://www.youtube.com/watch?v=TDJJLHdBvnY)

## Installation 

### How do I install and use Fusion AI Studio with Visual Studio Code (VS Code) and Codex?

Fusion AI Studio provides the tools for building the AI Studio Agentic apps and workflows, while VS Code acts as the workspace where files are created, opened, reviewed, and updated. The Fusion AI Studio VS Code extension adds guided commands and visual editing options so users can complete common tasks from one place. This includes setting up a workspace, connecting to the correct environment, creating new artifacts, opening existing artifacts, and making changes in a structured way.

Codex can also be used as an optional assistant when a task involves several related changes or when users want help creating, reviewing, or updating artifacts. Instead of manually changing each file one by one, users can describe the intended business outcome and ask Codex to help apply the change across the relevant local files. This can be useful when creating an app that depends on workflows, business objects, agents, or other supporting artifacts.

You may need to refer to `install-and-use-fusion-ai-studio-CLI_vscode-codex.md` in the  `<release>/how-to` folder for more detail. The guide focuses on the practical steps needed to get started. It explains how to install the required tools, open a workspace, configure access, create or fetch artifacts, and understand the main approaches available for building AI Studio apps and workflows. 

### How to Uptake Incremental Updates for Fusion AI Studio Skills and Samples in Existing Fusion AI Apps Workspaces?

Instructions for upgrading existing Fusion Agentic Apps workspaces with the latest skill versions and sample apps and workflows are available in the `how-to-uptake-incremental-updates` guide, located in the `<release>/how-to` folder.


## Fusion AI Studio Artifacts
| Artifact | Plain-language meaning | Typical use |
| --- | --- | --- |
| App | A user-facing workspace with panels, actions, and agents. | Give HR, finance, supply chain, or project users one place to complete AI-assisted work. |
| Workflow | A step-by-step deterministic flow that can call AI, services, code, or approvals. | Fetch data, analyze it, make recommendations, and return results. |
| Business Object | A reusable data connection to Fusion or another service. | Retrieve workers, jobs, plans, invoices, suppliers, or other business records. |
| Agent | A reusable AI worker with a role, tools, and instructions. | Answer domain-specific questions or perform tasks. |
| Tool | A reusable capability for an agent or workflow. | Call a business object, open a deeplink, call REST, or use a connector. |
| Topic | Instructions that guide an agent on a specific subject. | Tell an agent how to answer benefits, succession, payroll, or policy questions. |
| Deeplink | A link definition that opens a target page or record. | Open an employee profile, succession plan, transaction, or work area. |
| Connector Instance | A configured connection to an external connector. | Connect to approved external systems. |


## Documentation

You can find the online documentation for Oracle Fusion AI Agent Studio at [official documentation](https://docs.oracle.com/en/cloud/saas/fusion-ai/) and information about the project at [Oracle Fusion AI](https://www.oracle.com/in/applications/fusion-ai/).

## Contributing

This project do not accept accept external pull requests. Please [review our contribution guide](./CONTRIBUTING.md)

## Security

Please consult the [security guide](./SECURITY.md) for our responsible security vulnerability disclosure process

## License

Copyright © 2026, Oracle and/or its affiliates.  Licensed under the Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl/

## Disclaimer

ORACLE AND ITS AFFILIATES DO NOT PROVIDE ANY WARRANTY WHATSOEVER, EXPRESS OR IMPLIED, FOR ANY SOFTWARE, MATERIAL OR CONTENT OF ANY KIND CONTAINED OR PRODUCED WITHIN THIS REPOSITORY, AND IN PARTICULAR SPECIFICALLY DISCLAIM ANY AND ALL IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE.  FURTHERMORE, ORACLE AND ITS AFFILIATES DO NOT REPRESENT THAT ANY CUSTOMARY SECURITY REVIEW HAS BEEN PERFORMED WITH RESPECT TO ANY SOFTWARE, MATERIAL OR CONTENT CONTAINED OR PRODUCED WITHIN THIS REPOSITORY.  IN ADDITION, AND WITHOUT LIMITING THE FOREGOING, THIRD PARTIES MAY HAVE POSTED SOFTWARE, MATERIAL OR CONTENT TO THIS REPOSITORY WITHOUT ANY REVIEW. USE AT YOUR OWN RISK. 
