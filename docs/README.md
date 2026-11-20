# AI Studio download guidance

This documentation is shared across AI Studio releases.

1. Identify the release major that matches your AI Studio environment.
2. Open the [release catalog](../files/aistudio/catalog/external.json) and find that major's `latest` build. Recommendations are per major; the repository-wide Latest badge is not used.
3. Open the matching `aistudio-FULL_VERSION` entry in [GitHub Releases](https://github.com/oracle/fusion-ai-studio/releases) and download `aistudio-skill.zip` and `aistudio-skill.zip.sha256` from its assets.
4. Keep both files in the same directory and verify the checksum before using the ZIP. On macOS, run `shasum -a 256 -c aistudio-skill.zip.sha256`; on Linux with GNU coreutils, run `sha256sum -c aistudio-skill.zip.sha256`. The result must say `aistudio-skill.zip: OK`.

For workspace setup, follow the [AI Studio repository instructions](https://github.com/oracle/fusion-ai-studio). Downloading a ZIP alone does not install or update a workspace.
