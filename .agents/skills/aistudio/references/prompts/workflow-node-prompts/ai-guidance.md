### AI Guidance

- Backend `type`: `AI_GUIDANCE`
- **Metadata:** flat node metadata only. Missing `resolutionMode` means legacy Business Object behavior.
- **Business Object:** `resolutionMode: "BO"`, `boCode`, copied BO contract metadata, and `recordKey`.
- **Agentic Application:** `resolutionMode: "AI_ARTIFACT"`, `storageObjectType: "applications"`, and the canonical application `code` in `recordKey`.
- **Ask Oracle Plugin:** `resolutionMode: "AI_ARTIFACT"`, `storageObjectType: "askOraclePlugins"`, and the canonical plugin `code` in `recordKey`.
- **Output:** READ and WRITE use fixed/read-only generic guidance response `outputSpecification` values. READ has `items` plus `hasMore`; WRITE has `items` without `hasMore`.

#### Authoring rules

- Use `AI_GUIDANCE` for AI Guidance Store reads and writes. Do not wrap AI Guidance Store access in a generic `BO_FUNCTION` node.
- For domain-record guidance, select a Business Object that is enabled for AI Guidance Store.
- For application guidance or agentic app guidance, use `AI_ARTIFACT` with `storageObjectType: "applications"`. For Ask Oracle Plugin guidance, use `AI_ARTIFACT` with `storageObjectType: "askOraclePlugins"`.
- Artifact nodes never include `boCode`, `finderFunctionName`, `finderParameterName`, or `guidanceKeyAttribute`. Never invent an artifact code from its display name; use an explicitly supplied or uniquely resolved canonical code, and ask the user when the identity is missing or ambiguous.
- **Business Object mode only:** pass the selected `search-business-objects` result as `businessObjectHint` and set `metadataPatch.boCode`. The tool copies `finderFunctionName`, `finderParameterName`, `storageObjectType`, and `guidanceKeyAttribute` from the BO's `objectProperties.aiGuidance`; do not hand-author those copied BO fields.
- **AI artifact mode:** author `resolutionMode`, `storageObjectType`, and canonical-code `recordKey`; do not pass `businessObjectHint` or include BO contract metadata.
- Do not put `family` or `product` in persisted node metadata.
- READ requires `recordKey`.
- READ supports optional `filter`; runtime applies it as the BOSS collection filter after the selected record is resolved.
- READ supports optional `guidanceReferencesFilter`; runtime applies it only to the returned `guidanceReferences` accessor rows, for example `primaryRef = 'N'`. Use `filter` for guidance-row filtering and `guidanceReferencesFilter` for returned-reference filtering.
- `targetPersona` is optional for READ and WRITE. Use `targetPersona: "ALL"` when no persona-specific filtering is needed; otherwise pass a fixed persona such as `MANAGER` or an expression such as `{{$context.$variables.targetPersona}}`.
- READ and WRITE output schemas are fixed by the product/editor; do not author custom AI Guidance output schemas.
- WRITE requires `recordKey`, `guidanceType`, `guidanceSubtype`, `category`, and `payload`.
- WRITE `guidanceType`, `guidanceSubtype`, and `category` may use the recommended curated values below, a valid custom static code (`^[A-Z][A-Z0-9_]*$`; lengths 64, 128, and 64 respectively), or an expression. `status` and `urgency` retain their existing behavior.
- WRITE payload may be inline JSON or an expression such as `{{ $context.$nodes.BUILD_PAYLOAD.$output }}`.
- WRITE supports optional `additionalReferences` shaped as `[{ "boCode": "ORA_CX_OPTY_GUIDANCE_BO", "storageObjectType": "CX_OPPORTUNITIES", "recordKey": "{{$context.$variables.optyNumber}}", "primaryRef": "N" }]`. Use BO AI Guidance metadata to populate each additional reference `storageObjectType`.
- Do not ask users to hand-build `$bulk`, `$lookupBy`, `resolverBoCode`, `primaryObjectType`, `primaryObjectKey`, `primaryObjectAltKey`, or `guidanceReferences`.
- Do not use legacy `objectType` or `objectAltKeys` mode for this node.

#### Recommended values

- `guidanceType`: `INSIGHT`, `SUMMARY`, `RECOMMENDATION`, `ALERT`
- `INSIGHT` subtypes: `HEALTH_ASSESSMENT`, `RISK_ASSESSMENT`, `ANOMALY_ASSESSMENT`, `GROWTH_ASSESSMENT`
- `SUMMARY` subtypes: `STATE_SUMMARY`, `ISSUE_SUMMARY`
- `RECOMMENDATION` subtypes: `NEXT_STEP_RECOMMENDATION`, `ESCALATION_RECOMMENDATION`
- `ALERT` subtypes: `ATTENTION_REQUIRED`
- `category`: `COMMERCIAL`, `USAGE`, `SERVICE`, `ENGAGEMENT`, `PROCESS`, `FINANCIAL`
- `status`: `ACTIVE`
- `urgency`: `LOW`, `MEDIUM`, `HIGH`, `CRITICAL`

#### Examples

- READ: `do-create-node({ type: "AI_GUIDANCE", name: "Read Account Guidance", metadataPatch: { operation: "READ", boCode: "ORA_CX_ACCOUNT_GUIDANCE_BO", recordKey: "{{$context.$variables.accountNumber}}", targetPersona: "ALL", filter: "guidanceType = 'SUMMARY'", guidanceReferencesFilter: "primaryRef = 'N'" }, businessObjectHint: <selected BO> })`
- WRITE: `do-create-node({ type: "AI_GUIDANCE", name: "Write Account Guidance", metadataPatch: { operation: "WRITE", boCode: "ORA_CX_ACCOUNT_GUIDANCE_BO", recordKey: "{{$context.$variables.accountNumber}}", targetPersona: "{{$context.$variables.targetPersona}}", guidanceType: "INSIGHT", guidanceSubtype: "HEALTH_ASSESSMENT", category: "COMMERCIAL", status: "ACTIVE", urgency: "LOW", generatedBy: "{{'agent:' + $context.$workflow.$code}}", agentJobKey: "{{$context.$workflow.$traceId}}", payload: "{{ $context.$nodes.BUILD_GUIDANCE_PAYLOAD.$output }}", additionalReferences: [{ "boCode": "ORA_CX_OPTY_GUIDANCE_BO", "storageObjectType": "CX_OPPORTUNITIES", "recordKey": "{{$context.$variables.optyNumber}}", "primaryRef": "N" }] }, businessObjectHint: <selected BO> })`
- Application READ: `do-create-node({ type: "AI_GUIDANCE", name: "Read Application Guidance", metadataPatch: { operation: "READ", resolutionMode: "AI_ARTIFACT", storageObjectType: "applications", recordKey: "BENEFITS_APP" } })`
- Application WRITE: `do-create-node({ type: "AI_GUIDANCE", name: "Write Application Guidance", metadataPatch: { operation: "WRITE", resolutionMode: "AI_ARTIFACT", storageObjectType: "applications", recordKey: "BENEFITS_APP", guidanceType: "INSIGHT", guidanceSubtype: "HEALTH_ASSESSMENT", category: "COMMERCIAL", status: "ACTIVE", urgency: "LOW", generatedBy: "{{'agent:' + $context.$workflow.$code}}", agentJobKey: "{{$context.$workflow.$traceId}}", payload: "{}" } })`
- Ask Oracle Plugin READ: `do-create-node({ type: "AI_GUIDANCE", name: "Read Plugin Guidance", metadataPatch: { operation: "READ", resolutionMode: "AI_ARTIFACT", storageObjectType: "askOraclePlugins", recordKey: "BENEFITS_PLUGIN" } })`
- Ask Oracle Plugin WRITE: `do-create-node({ type: "AI_GUIDANCE", name: "Write Plugin Guidance", metadataPatch: { operation: "WRITE", resolutionMode: "AI_ARTIFACT", storageObjectType: "askOraclePlugins", recordKey: "BENEFITS_PLUGIN", guidanceType: "SUMMARY", guidanceSubtype: "STATE_SUMMARY", category: "USAGE", status: "ACTIVE", urgency: "LOW", generatedBy: "{{'agent:' + $context.$workflow.$code}}", agentJobKey: "{{$context.$workflow.$traceId}}", payload: "{}" } })`
