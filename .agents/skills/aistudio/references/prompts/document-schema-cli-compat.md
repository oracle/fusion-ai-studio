# Document Schema CLI Compatibility

Use deterministic `aistudio` commands for local Document Schema authoring whenever they support the requested change.

- Local Document Schema files live under `src/documentSchemas/*.documentSchema`, one schema per file.
- Prefer `aistudio do-create-document-schema` to create a local draft.
- Prefer `aistudio do-update-document-schema` for local name, description, and specification changes.
- Prefer `aistudio do-add-document-schema-document` to upload or attach the single source document used for generation.
- The Document Schema CLI supports one source document per schema. If the user wants to use a different document, remove the existing one first with `aistudio do-remove-document-schema-document`.
- Use `aistudio do-generate-document-schema` after a parsed source document is present. This uses the same Document Schema builder-agent prompt as the UI.
- Use `aistudio validate-document-schema --file <document-schema-file>` after material local changes.
- Use `aistudio do-save-document-schema --file <document-schema-file>` to save as DRAFT only when the user explicitly asks to save. CLI publication is disabled; publish through CI/CD deployment.
- Upload, generation, list/get, save, customize, and remote delete require `env.properties`. Local create, update, validate, remove existing metadata, and local delete do not.
- Ask for the schema name, code, source document path, optional document description, and save intent when missing.
