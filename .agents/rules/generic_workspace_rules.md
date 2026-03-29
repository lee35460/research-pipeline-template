---
trigger: always_on
---

# Generic Workspace Rules

## 1. Scope
- This rule set is project-agnostic and reusable across research/development topics.
- Topic-specific rules MUST be defined separately in `.agents/rules/<topic>_workspace_rules.md`.

## 2. Pipeline Order (MANDATORY)
1. Knowledge Capture
2. NotebookLM Storage
3. Structuring
4. Implementation Spec
5. Code Implementation
6. Final Validation

## 3. Artifact Types (MANDATORY)
- source_fact
- design_draft
- design_approved
- implementation_spec
- validation_report

## 4. State Policy (STRICT)
- draft MUST NOT be used as implementation basis
- only approved can be used for implementation

## 5. Pre-code / Completion Gates (MANDATORY)
- implementation_spec missing -> DO NOT generate code
- validation_report missing -> DO NOT mark complete
- use gate check script when available

## 6. Separation Policy (MANDATORY)
Always separate:
- original facts
- AI interpretation
- design decisions
- unresolved points (TBD)

## 7. NotebookLM Usage Boundary
NotebookLM MCP can be used for:
- research reconstruction
- source grounding
- design structuring
- failure analysis

NotebookLM MCP must NOT be used for:
- direct code generation
- direct code modification

## 8. Code Generation Boundary
Implementation agents/models must follow approved design + implementation_spec only.
No architecture redefinition during implementation.

## 9. Topic Rule Injection
For each project, add one topic-specific rule file:
- path: `.agents/rules/<topic>_workspace_rules.md`
- purpose: domain taxonomy, terminology, model routing details, forbidden assumptions

If generic and topic-specific rules conflict:
- topic-specific rule takes precedence for that topic only.
