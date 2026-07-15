# How to uptake incremental updates to existing Fusion AI Apps workspaces?

This guide explains how to upgrade existing Fusion App workspaces with new skill versions and sample apps when new versions are published in the GitHub repository.

## Contents

1. [Download or clone the latest repo](#download-or-clone-the-latest-repo)  
2. [Steps to update Fusion AI Studio VS Code Extension](#steps-to-update-fusion-ai-studio-vs-code-extension)
3. [Steps to update Fusion AI Studio Skill](#steps-to-update-fusion-ai-studio-skill)
4. [Steps to update Fusion AI Apps Skills](#steps-to-update-fusion-ai-apps-skills)
4. [Steps to update sample apps and workflows](#steps-to-update-sample-apps-and-workflows)

A Fusion App workspace typically contains the following folders:

```text
fusion-ai-workspace/
└── aiapps/
└── .agents/
    └── skills/
        └── <list-of-ai-apps-domain-skills>
        └── aistudio/
└── src/
```

| Folder  | Artifacts   | Impact  | 
|---------|-------------|----------|
|`aiapps`|  Sample apps, workflows, and other artifacts|Folder to be replaced with the latest version from the repo|
|`.agents/skills/aistudio/`|  Hosts the Fusion AI Studio skill|Folder to be replaced with the latest version from the repo|
|`.agents/skills/<list-of-ai-apps-domain-skills>`|  Multiple directories of domain-specific skills|Folders to be replaced with all corresponding folders from the repo|
|`src`|  Local artifacts created during the app/workflow building process |No change|

## Download or clone the latest repo

The latest repository can either be downloaded as a ZIP file and extracted, or cloned from GitHub.

#### Download as ZIP 
To download the repository as a ZIP file:

1. Open the GitHub link in your browser and click **Code**.
2. Click **Download ZIP**.
3. Extract the downloaded ZIP file to a folder named `fusion-ai-repo` in an easy-to-find location.
4. On Windows, select **Extract All...**.
5. On macOS, select **Open With > Archive Utility** or double-click the ZIP file.
6. Confirm that it now contains a folder named something like `fusion-ai-studio-main`.
7. Open the extracted folder.

#### Clone Github Repository 
If you prefer to clone the repository instead of downloading it as a ZIP file, follow the steps below.

To clone the repository, you need to have Git installed on your system. Refer to this [guide](https://github.com/git-guides/install-git) for installation instructions. Once Git is installed, you can clone the repository using the following steps:

1. Open the GitHub link in your browser and click **Code**.
2. Copy the link similar to `https://github.com/oracle/fusion-ai-studio.git` (mentioned above under *Clone using the web URL*).
3. Create a folder named `fusion-ai-repo` in an easy-to-find location.
4. Open a terminal and enter the following command inside the `fusion-ai-repo` folder.
   
   ```bash
   git clone https://github.com/oracle/fusion-ai-studio.git
   ```

5. The repository will be cloned into your current `fusion-ai-repo` folder.
6. Confirm that it now contains a folder named `fusion-ai-studio`.

## Steps to update Fusion AI Studio VS Code Extension

### Extract the Fusion AI Studio Extension ZIP

The Fusion AI Studio Extension is available as a ZIP file, `aistudio-extension.zip`, under the `<release>/aistudio/bin` folder in either the cloned or downloaded repository folder:

The same file is also available at the following GitHub location:

```text
https://github.com/oracle/fusion-ai-studio/blob/main/<release>/aistudio/bin/aistudio-extension.zip
```

Open the downloaded or cloned repository folder. 

The extension ZIP file, `aistudio-extension.zip`, will be available in
- `fusion-ai-repo/fusion-ai-studio/<release>/aistudio/bin/` in the cloned repository 
- `fusion-ai-repo/fusion-ai-studio-main/<release>/aistudio/bin/` in the downloaded GitHub repository


The ZIP file `aistudio-extension.zip` must be extracted to get the `.vsix` file inside it.

1. Open the folder that contains `aistudio-extension.zip`.
2. Extract the ZIP file to the same folder.
3. On Windows, select **Extract All...**.
4. On macOS, select **Open With > Archive Utility** or double-click the ZIP file.
5. Open the extracted folder.
6. Confirm that it contains a file named something like:

```text
aistudio-extension.vsix
```

If you do not see the `.vsix` file, open any folder created by the extraction process and check inside it.

**Result before continuing:** You have found the extracted `.vsix` file.

### Install updated Fusion AI Studio VS Code Extension

The extension adds Fusion AI Studio commands and views to VS Code.

1. Open Visual Studio Code.
2. Select the Extensions icon on the left Activity Bar (it looks like stacked squares).
3. In the Extensions panel, find the `...` menu near the top of the panel.
4. Click the `...` menu.
5. Select **Install from VSIX...**.
6. In the file picker, go to the folder where you extracted the ZIP file.
7. Select the `aistudio-extension.vsix` file.
8. Confirm the installation if VS Code asks for confirmation.
9. If VS Code asks you to reload or restart the window, select the reload option.
10. Click the Extensions icon, and you should now see the extension installed: `Fusion AI Studio`.

## Steps to update Fusion AI Studio Skill

The Fusion AI Studio Skill must be copied from the `fusion-ai-repo` folder to the workspace folder `fusion-ai-workspace`.

The Fusion AI Studio Skill is available as a ZIP file
- `aistudio-skill.zip`, under `fusion-ai-repo/fusion-ai-studio/<release>/aistudio/bin` if you created the `fusion-ai-repo` folder by cloning the repository
- `aistudio-skill.zip`, under `fusion-ai-repo/fusion-ai-studio-main/<release>/aistudio/bin` if you created the `fusion-ai-repo` folder by extracting the downloaded ZIP file.

Extract the ZIP file to access the `aistudio` folder and its contents.

1. Open the folder that contains `aistudio-skill.zip`.
2. Right-click the ZIP file and extract it to the same folder location.
3. On Windows, select **Extract All...**.
4. On macOS, select **Open With > Archive Utility** or double-click the ZIP file.
6. Open the extracted folder.
7. Confirm that it contains a file named `SKILL.md` and three folders.
9. Open the `.agents/skills` folder for each workspace and replace the existing `.agents/skills/aistudio` folder with the extracted `fusion-ai-repo/fusion-ai-studio-main/<release>/aistudio/bin/aistudio` folder from the `fusion-ai-repo` folder.

## Steps to update Fusion AI Apps Skills

The Fusion AI App Skill must be copied from the `fusion-ai-repo` folder to the workspace folder `fusion-ai-workspace`.

The Fusion AI App Skill is available as a ZIP file
- `aistudio-apps-skills.zip`, under `fusion-ai-repo/fusion-ai-studio/<release>/aistudio/ai-studio-apps-skills` if you created the `fusion-ai-repo` folder by cloning the repository.
- `aistudio-apps-skills.zip`, under `fusion-ai-repo/fusion-ai-studio-main/<release>/aistudio/ai-studio-apps-skills` if you created the `fusion-ai-repo` folder by extracting the downloaded ZIP file.

Extract the ZIP file to access the `aistudio-apps-skills` folder and its contents.

1. Extract the ZIP file to the same folder.
2. On Windows, select **Extract All...**.
3. On macOS, select **Open With > Archive Utility** or double-click the ZIP file.
4. Open the extracted folder.
5. Confirm that it contains one or more app folders, such as `aistudio-apps-succession-management`.
6. Replace ALL the domain skill folders in existing workspaces with the domain skill folders in the repo `fusion-ai-repo/fusion-ai-studio-main/<release>/aistudio/ai-studio-apps-skills/ai-studio-apps-skills` folder.

## Steps to update sample apps and workflows

The `aiapps` folder for all existing workspaces needs to be replaced with the `aiapps` folder in the repo `fusion-ai-repo/fusion-ai-studio/release-26C/aiapps`


## Disclaimer

ORACLE AND ITS AFFILIATES DO NOT PROVIDE ANY WARRANTY WHATSOEVER, EXPRESS OR IMPLIED, FOR ANY SOFTWARE, MATERIAL OR CONTENT OF ANY KIND CONTAINED OR PRODUCED WITHIN THIS REPOSITORY, AND IN PARTICULAR SPECIFICALLY DISCLAIM ANY AND ALL IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE.  FURTHERMORE, ORACLE AND ITS AFFILIATES DO NOT REPRESENT THAT ANY CUSTOMARY SECURITY REVIEW HAS BEEN PERFORMED WITH RESPECT TO ANY SOFTWARE, MATERIAL OR CONTENT CONTAINED OR PRODUCED WITHIN THIS REPOSITORY.  IN ADDITION, AND WITHOUT LIMITING THE FOREGOING, THIRD PARTIES MAY HAVE POSTED SOFTWARE, MATERIAL OR CONTENT TO THIS REPOSITORY WITHOUT ANY REVIEW. USE AT YOUR OWN RISK. 

