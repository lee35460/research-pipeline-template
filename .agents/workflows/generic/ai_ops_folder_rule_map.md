# ai_ops Folder-Rule Mapping

## Applied Rules
- Base: .agents/rules/generic_workspace_rules.md
- Topic: .agents/rules/ai_ops_workspace_rules.md

## Folder Mapping

| Folder | Purpose | Primary Artifacts | Governing Rules |
|---|---|---|---|
| research/raw | Source collection | source_fact | generic + ai_ops |
| research/history | Trace and evolution | source_fact / validation_report | generic + ai_ops |
| research/candidates | Candidate designs | design_draft | generic + ai_ops |
| research/selected | Selected design/spec | design_approved / implementation_spec | generic + ai_ops |
| research/math | Formalization | design_approved | generic + ai_ops |
| research/ablations | Validation evidence | validation_report | generic + ai_ops |
| development/src | Product code | implementation outputs | generic + ai_ops |
| development/tests | Validation code | test artifacts | generic + ai_ops |
| development/configs | Runtime settings | config artifacts | generic + ai_ops |
| development/docs | Dev docs | implementation notes | generic + ai_ops |

## Pipeline Gate Usage
- pre-implement: scripts/pipeline_gate_check.sh pre-implement .agents/workflows/generic/approval_registry.md
- pre-complete: scripts/pipeline_gate_check.sh pre-complete .agents/workflows/generic/approval_registry.md
