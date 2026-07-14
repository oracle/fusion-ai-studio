# How do I use Fusion AI Studio with VS Code and Codex?

This guide explains how to use Fusion AI Studio with VS Code to create and update AI-powered Agentic apps and workflows. It is intended for business users, implementation teams, and project teams who need a clear and structured way to build Agentic Apps and workflows outside the Fusion Applications user interface, while working with business objects, agents, and related artifacts.

Fusion AI Studio provides the tools for building the AI Studio Agentic apps and workflows, while VS Code acts as the workspace where files are created, opened, reviewed, and updated. The Fusion AI Studio VS Code extension adds guided commands and visual editing options so users can complete common tasks from one place. This includes setting up a workspace, connecting to the correct environment, creating new artifacts, opening existing artifacts, and making changes in a structured way.

Codex can also be used as an optional assistant when a task involves several related changes or when users want help creating, reviewing, or updating artifacts. Instead of manually changing each file one by one, users can describe the intended business outcome and ask Codex to help apply the change across the relevant local files. This can be useful when creating an app that depends on workflows, business objects, agents, or other supporting artifacts.

This guide focuses on the practical steps needed to get started. It explains how to install the required tools, open a workspace, configure access, create or fetch artifacts, and understand the main approaches available for building AI Studio apps and workflows. The goal is to help users follow the process confidently, understand what is happening at each stage, and know when to use the VS Code extension directly or when to use Codex for assistance.

## What You Will Be Able To Do

By following this guide, you should be able to:

1. Install VS Code and the Fusion AI Studio VS Code extension.
2. Download or clone the samples GitHub repository.
3. Create and open a local Fusion AI Studio workspace.
4. Connect the workspace to the correct Fusion AI Studio environment.
5. Create or fetch apps, workflows, business objects, agents, tools and other artifacts.
6. Use Codex for assistance in creating and editing agentic apps and supporting files.
7. Review and test agentic apps and workflows before sharing or publishing them.

## Contents

1. [Prerequisites and Setup](#prerequisites-and-setup)  
2. [Install Fusion AI Studio VS Code Extension](#install-fusion-ai-studio-vs-code-extension)
3. [Building AI Studio Apps and Workflows](#building-ai-studio-apps-and-workflows)
4. [Creating an Agentic App using codex](#creating-an-agentic-app-using-codex)


## Prerequisites and Setup

This section walks through the first-time setup step-by-step.

### What You Need Before You Start

1. The Fusion AI Studio VS Code extension ZIP file.
2. Fusion AI Studio skill ZIP file.
3. The Fusion AI Studio server URL for your environment.
4. A user account with permission to access Fusion AI Studio.
5. A location on your computer where you can create a workspace folder.
6. Codex access if you plan to use AI-assisted development.

### Install Visual Studio Code

Visual Studio Code, often called VS Code, is the desktop application that can be used as a workspace for Fusion AI Studio apps and workflow development.

1. Open a web browser and go to the official Visual Studio Code download page: `https://code.visualstudio.com/`.
2. Select the download option for your operating system.
3. Open the downloaded installer file.
4. Follow the installer prompts.
5. Open Visual Studio Code when installation finishes.

For a broader introduction to the editor, use the official Visual Studio Code getting started documentation: `https://code.visualstudio.com/docs/getstarted/overview`.

### Download or Clone the GitHub Repository

Oracle provides files necessary for development of Agentic Apps and Workflows as well as delivers the tools needed to create, edit, and run the files through the public GitHub repository:

```text
https://github.com/oracle/fusion-ai-studio
```

To make use of this, we need to either download it as ZIP and extract it or clone the repository.

#### Download as ZIP 
To download the repository as a ZIP file:

1. Open the GitHub link in your browser and click on Code
2. Click on download ZIP
3. Extract the downloaded ZIP file to a folder `fusion-ai-repo` in an easy-to-find location.
4. On Windows, select **Extract All...**.
5. On macOS, select **Open With > Archive Utility** or double-click the ZIP file.
6. Confirm that it now contains a folder named similar to: `fusion-ai-studio-main`
7. Open the extracted folder.

#### Clone Github Repository 
If you wish to clone the repository instead of downloading it as zip, follow the steps below.

In order to clone the repository, you need to have git installed in your system. Refer to this [guide](https://github.com/git-guides/install-git) for installation instructions. Once git is installed, the repository can be cloned using the following steps

1. Open the GitHub link in your browser and click on Code
2. Copy the link similar to https://github.com/oracle/fusion-ai-studio.git (mentioned above '*Clone using the web URL*')
3. Create a folder `fusion-ai-repo` in an an easy-to-find location.
4. Open terminal and enter the following command inside `fusion-ai-repo` folder.
   
   ```bash
   git clone https://github.com/oracle/fusion-ai-studio.git
   ```

5. The repository will be cloned in your current folder `fusion-ai-repo`
6. Confirm that it now contains a folder named: `fusion-ai-studio`

### Create a workspace folder

Create a dedicated workspace folder named `fusion-ai-workspace`. This folder will serve as the root directory for your project and related resources, helping you keep your development environment organized.

   (e.g. `/Users/<replace-with-your-user-name>/fusion-ai-workspace`)

### Extract the Fusion AI Studio Extension ZIP

The Fusion AI Studio Extension is available as a ZIP file `aistudio-extension.zip` under `<release>/aistudio/bin` folder in the cloned folder or the downloded folder:

The same is avalailable in the following GitHub location as well
```text
https://github.com/oracle/fusion-ai-studio/blob/main/<release>/aistudio/bin/aistudio-extension.zip
```

Open the downloaded or cloned repository folder. The extension ZIP `aistudio-extension.zip` will be available in `fusion-ai-repo\fusion-ai-studio\<release>\aistudio\bin\` in the cloned folder and in `fusion-ai-repo\fusion-ai-studio-main\<release>\aistudio\bin\` for the downloaded GitHub repository.

The ZIP file `aistudio-extension.zip`, must be extracted to get the `.vsix` file inside it.

1. Open the folder that contains `aistudio-extension.zip`.
2. Extract the ZIP file to the same folder.
3. On Windows, select **Extract All...**.
4. On macOS, select **Open With > Archive Utility** or double-click the ZIP file.
5. Open the extracted folder.
6. Confirm that it contains a file named similar to:

```text
aistudio-extension.vsix
```

If you do not see the `.vsix` file, open any folder created by the extraction process and check inside it.

**Result before continuing:** You have found the extracted `.vsix` file.

## Install Fusion AI Studio VS Code Extension

The extension adds Fusion AI Studio commands and views to VS Code.

1. Open Visual Studio Code.
2. Select the Extensions icon on the left Activity Bar (it looks like stacked squares).
3. In the Extensions panel, find the `...` menu near the top of the panel.
4. Click on `...` menu.
5. Select **Install from VSIX...**.
6. In the file picker, go to the folder where you extracted the ZIP file.
7. Select the `aistudio-extension.vsix` file.
8. Confirm the installation if VS Code asks for confirmation.
9. If VS Code asks you to reload or restart the window, select the reload option.
10. Click Extensions icon and you should now see the extension installed - `Fusion AI Studio`. 

### Confirm the Extension Is Installed

Use this check to confirm that VS Code can see the Fusion AI Studio extension.

1. Press `Cmd+Shift+P` on macOS or `Ctrl+Shift+P` on Windows or Linux.
2. The Command Palette opens at the top of the VS Code window.
3. Type `Fusion AI Studio`.
4. Confirm that commands such as `Fusion AI Studio: Configure Authentication` appear.
5. Press `Esc` if you only wanted to check the commands and do not want to run one yet.

If no Fusion AI Studio commands appear, reload VS Code and repeat the check. If they still do not appear, reinstall the extension from the extracted `aistudio-extension.vsix` file.

**Result before continuing:** Fusion AI Studio commands appear in the Command Palette.


### Extract the Fusion AI Studio Skill ZIP

The Fusion AI Studio Skill need to be copied from the `fusion-ai-repo` folder to the workspace folder `fusion-ai-workspace`.

The Fusion AI Studio Skill is available as a ZIP file `aistudio-skill.zip` under `fusion-ai-repo/fusion-ai-studio/<release>/aistudio/bin` folder in case you have created `fusion-ai-repo` folder by cloning the repository.

The Fusion AI Studio Skill is available as a ZIP file `aistudio-skill.zip` under `fusion-ai-repo/fusion-ai-studio-main/<release>/aistudio/bin` folder in case you have created `fusion-ai-repo` folder by extracting the downloaded zip file.

The ZIP file must be extracted to get the `aistudio` folder with files inside it.

1. Open the folder that contains `aistudio-skill.zip`.
2. Right-click the ZIP file and extract to the same folder location.
3. On Windows, select **Extract All...**.
4. On macOS, select **Open With > Archive Utility** or double-click the ZIP file.
6. Open the extracted folder.
7. Confirm that it contains a file named `SKILL.md` and three folders
8. Create a new folder named `.agents` inside the workspace folder `fusion-ai-workspace`
9. Open the `.agents` folder and create a new folder named `skills`
10. Open the skills folder and copy the extracted `aistudio` folder in the prior step inside the skills folder

**Result before continuing:** You have created the required folders inside the workspace folder and copied the skill related files to it. The folder structure should look similar to:

```text
fusion-ai-workspace/
└── .agents/
    └── skills/
        └── aistudio/
            ├── scripts/
            ├── references/
            ├── resources/
            └── SKILL.md
```


### Extract Fusion AI App Skills ZIP

The Fusion AI App Skill need to be copied from the `fusion-ai-repo` folder to the workspace folder `fusion-ai-workspace`.

The Fusion AI App Skill is available as a ZIP file `aistudio-apps-skills.zip` under `fusion-ai-repo/fusion-ai-studio/<release>/aistudio/ai-studio-apps-skills` folder in case you have created `fusion-ai-repo` folder by cloning the repository.

The Fusion AI Studio Skill is available as a ZIP file `aistudio-apps-skills.zip` under `fusion-ai-repo/fusion-ai-studio-main/<release>/aistudio/ai-studio-apps-skills` folder in case you have created `fusion-ai-repo` folder by extracting the downloaded zip file.

The ZIP file must be extracted to get the `aistudio-apps-skills` folder with folders inside it.

1. Extract the zip file to the same folder.
2. On Windows, select **Extract All...**.
3. On macOS, select **Open With > Archive Utility** or double-click the ZIP file.
4. Open the extracted folder.
5. Confirm that it contains one or more app folders like `aistudio-apps-succession-management`
6. Copy ALL the extracted folders to the `skills` folder in the workspace folder `fusion-ai-workspace\.agents\`.

**Result before continuing:** You have copied the skill related files. The folder structure should look similar to:

```text
fusion-ai-workspace/
└── .agents/
    └── skills/
        └── aistudio-apps-succession-management/
        └── aistudio/
```

### Copy sample apps and workflows to the workspace

Sample apps and workflows in folder `aiapps` need to be copied from the `fusion-ai-repo\<release>\` folder to the workspace folder `fusion-ai-workspace`.

Copy the folder `fusion-ai-repo\<release>\aiapps` to workspace folder `fusion-ai-workspace`. 

**Result before continuing:** You have copied the sample related files. The folder structure should look similar to:

```text
fusion-ai-workspace/
└── aiapps/
└── .agents/
    └── skills/
        └── aistudio-apps-succession-management/
        └── aistudio/
```


### Open the Workspace Folder in VS Code

Opening the correct folder matters because the extension initializes and manages files inside the currently open folder.

1. Open VS Code.
2. Select **File > Open Folder...**.
3. Browse to the workspace folder you created `fusion-ai-workspace`.
4. Select the folder.
5. Select **Open**.
6. VS Code may ask whether you trust the authors of the files in the folder, confirm it.
7. Confirm that the folder name appears in the Explorer area on the left.

### Configure Authentication

Authentication connects VS Code to your Fusion AI Studio environment.

1. Press `Cmd+Shift+P` on macOS or `Ctrl+Shift+P` on Windows or Linux.

2. Type `Fusion AI Studio: Configure Authentication`.

3. Select `Fusion AI Studio: Configure Authentication`.

4. Select Basic Authentication. 

5. Enter the server URL or environment details provided by your administrator _(note that the url should end with .com and should not have extra resource path)_.

6. Add the Username 

7. Provide password 

The workspace will be connected to the environment.

If authentication fails, confirm the server URL, and account access with your administrator.

**Result before continuing:** VS Code shows that authentication completed successfully. A new `env.properties` file will get created in the workspace folder with the entered details.

### Confirm You Are Ready to Start

Before creating or editing artifacts, confirm the setup is complete.

1. VS Code opens without installation prompts.
2. The workspace folder is visible in the Explorer.
3. Fusion AI Studio commands appear in the Command Palette.
4. Authentication has completed successfully.
5. You know where project files will be created.

## VS Code Extension for Fusion AI Studio

The VS Code extension lets you create, open, inspect, and fetch artifacts without memorizing commands.

### Available Fusion AI Studio Commands

| Command                                           | Use it for                                               | Description                                                                                | Example Use                                                                              |
| ------------------------------------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------- |
| `Fusion AI Studio: Configure Authentication`      | Connect VS Code to your Fusion AI Studio environment.    | This sets the target environment used by later extension actions.                          | —                                                                                        |
| `Fusion AI Studio: Fetch from Server`             | Download an existing server artifact into the workspace. | By providing the resource type and name, you can fetch them from the connected environment | —                                                                                        |
| `Fusion AI Studio: Create New App`                | Create a user-facing app.                                | A user-facing workspace with panels, actions, and agents.                                  | Give HR, finance, supply chain, or project users one place to complete AI-assisted work. |
| `Fusion AI Studio: Create New Workflow`           | Create a workflow process.                               | A step-by-step deterministic flow that can call AI, services, code, or approvals.          | Fetch data, analyze it, make recommendations, and return results.                        |
| `Fusion AI Studio: Create New Business Object`    | Create a reusable data object.                           | A reusable data connection to Fusion or another service.                                   | Retrieve workers, jobs, plans, invoices, suppliers, or other business records.           |
| `Fusion AI Studio: Create New Agent`              | Create a reusable AI agent.                              | A reusable AI worker with a role, tools, and instructions.                                 | Answer domain-specific questions or perform tasks.                                       |
| `Fusion AI Studio: Create New Tool`               | Create a tool for an agent or workflow.                  | A reusable capability for an agent or workflow.                                            | Call a business object, open a deeplink, call REST, or use a connector.                  |
| `Fusion AI Studio: Create New Connector Instance` | Create an external connector instance.                   | A configured connection to an external connector.                                          | Connect to approved external systems.                                                    |
| `Fusion AI Studio: Create New Deeplink`           | Create a link to a target page or record.                | A link definition that opens a target page or record.                                      | Open an employee profile, succession plan, transaction, or work area.                    |
| `Fusion AI Studio: Create New Topic`              | Create topic instructions for an agent.                  | Instructions that guide an agent on a specific subject.                                    | Tell an agent how to answer benefits, succession, payroll, or policy questions.          |
| `Fusion AI Studio: Logout`                        | Sign out from the environment.                           | After sign-out, reauthentication would need to be done again                               | —                                                                                        |

## Building AI Studio Apps and Workflows

Fusion AI Studio provides more than one way to create and update AI-powered Agentic apps and workflows. You can work directly in the Fusion AI Studio VS Code extension when you want a guided, visual way to create and edit artifacts, or you can use Codex when you want AI assistance to make coordinated changes across multiple files. This section explains both approaches so users can choose the method that best fits the task, their comfort level, and the amount of control they need.




### Building AI Studio Apps and Workflows using Codex with Fusion AI Studio

Codex can help you create and change artifacts. You describe the business outcome, and Codex can use the AI Studio project files and CLI commands to build new applications and make structured changes to existing applications.

#### Install and Sign In to Codex

1. Install Codex (App, CLI, etc.) by following the official OpenAI guide on: `https://developers.openai.com/codex/quickstart?setup=app`

2. Open a terminal. In VS Code, you can click `Terminal` menu and select `New Terminal`.

3. Confirm that Codex is installed by opening the app or running `codex --version` on the terminal:

4. Sign in to Codex. (For CLI use command `codex login`)

5. Follow the browser or terminal sign-in prompts.

6. If your organization uses API-key based access instead, follow the secure instructions provided by your administrator.

7. In the terminal, run `codex` or open the codex app.

## Creating an Agentic App using codex

An Agentic App is the main experience that business users interact with. It brings together the user-facing parts of an AI Studio experience in one place. It helps users interact with AI-powered business capabilities through a guided interface. In Fusion AI Studio, an Agentic App acts as the main workspace where the different supporting artifacts come together to create a complete business experience.

##### What an Agentic App contains

An app can contain sections, panels, configured agents, actions, and communications.

##### Using Codex to build a new Agentic App

You can now use codex to build a new agentic app that would reuse the business objects and workflows. To begin, open Codex (ensure that it is opened in the same project directory) and provide the appropriate prompts.

Sample prompt for buidling a succession plannning app for a line manager

````
Design and build a Succession Planning Agentic App for people managers
responsible for succession planning for their direct reports.

The app should enable managers to proactively identify succession risks,
assess succession readiness, and highlight key performers who do not 
have identified successors. It should also recommend actionable
next steps, such as identifying potential successors,evaluating 
readiness levels, and creating or updating succession plans.
````

Codex will then guide you through each step required to build the app.


## Disclaimer

ORACLE AND ITS AFFILIATES DO NOT PROVIDE ANY WARRANTY WHATSOEVER, EXPRESS OR IMPLIED, FOR ANY SOFTWARE, MATERIAL OR CONTENT OF ANY KIND CONTAINED OR PRODUCED WITHIN THIS REPOSITORY, AND IN PARTICULAR SPECIFICALLY DISCLAIM ANY AND ALL IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE.  FURTHERMORE, ORACLE AND ITS AFFILIATES DO NOT REPRESENT THAT ANY CUSTOMARY SECURITY REVIEW HAS BEEN PERFORMED WITH RESPECT TO ANY SOFTWARE, MATERIAL OR CONTENT CONTAINED OR PRODUCED WITHIN THIS REPOSITORY.  IN ADDITION, AND WITHOUT LIMITING THE FOREGOING, THIRD PARTIES MAY HAVE POSTED SOFTWARE, MATERIAL OR CONTENT TO THIS REPOSITORY WITHOUT ANY REVIEW. USE AT YOUR OWN RISK. 

