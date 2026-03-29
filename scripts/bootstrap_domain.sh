#!/usr/bin/env bash
set -euo pipefail

TOPIC="${1:-}"
ROOT_DIR="${BOOTSTRAP_ROOT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

if [[ -z "$TOPIC" ]]; then
  echo "Usage: scripts/bootstrap_domain.sh <topic_slug>"
  echo "Example: scripts/bootstrap_domain.sh vision_anomaly"
  exit 2
fi

if [[ ! "$TOPIC" =~ ^[a-z0-9_\-]+$ ]]; then
  echo "[ERROR] topic_slug must match: [a-z0-9_-]+"
  exit 2
fi

RESEARCH_DIR="$ROOT_DIR/research"
DEV_DIR="$ROOT_DIR/development"
RULES_DIR="$ROOT_DIR/.agents/rules"
WORKFLOW_DIR="$ROOT_DIR/.agents/workflows/generic"
TOPIC_RULE_FILE="$RULES_DIR/${TOPIC}_workspace_rules.md"
MAP_FILE="$WORKFLOW_DIR/${TOPIC}_folder_rule_map.md"
NLM_REGISTRY="$WORKFLOW_DIR/notebooklm_notebook_registry.md"
TOPIC_DIR="$RESEARCH_DIR/$TOPIC"
TOPIC_APPROVAL_REGISTRY="$TOPIC_DIR/approval_registry.md"

mkdir -p \
  "$TOPIC_DIR" \
  "$RESEARCH_DIR/raw" \
  "$RESEARCH_DIR/history" \
  "$RESEARCH_DIR/candidates" \
  "$RESEARCH_DIR/notes" \
  "$RESEARCH_DIR/selected" \
  "$RESEARCH_DIR/math" \
  "$RESEARCH_DIR/ablations" \
  "$DEV_DIR/src" \
  "$DEV_DIR/tests" \
  "$DEV_DIR/scripts" \
  "$DEV_DIR/configs" \
  "$DEV_DIR/docs"

cat > "$TOPIC_RULE_FILE" <<EOF
---
trigger: always_on
---

# ${TOPIC} Workspace Rules

## 1. Scope
- This file defines topic-specific rules for: ${TOPIC}
- Base rules are inherited from: .agents/rules/generic_workspace_rules.md

## 2. Topic Taxonomy
- Define core concepts, boundaries, and non-goals for ${TOPIC}
- Keep terminology consistent across research, design, and code

## 3. Model Routing (Topic-specific)
- NotebookLM MCP: source grounding, literature synthesis, design structuring
- Sequential Thinking MCP: ambiguity resolution, candidate comparison
- Implementation model(s): coding/debug/refactor from approved spec

## 4. Mandatory Constraints
- Add domain-specific constraints here
- Add forbidden assumptions here

## 5. Validation Focus
- Add domain-specific validation criteria
- Add required experiment protocol checks
EOF

cat > "$MAP_FILE" <<EOF
# ${TOPIC} Folder-Rule Mapping

## Applied Rules
- Base: .agents/rules/generic_workspace_rules.md
- Topic: .agents/rules/${TOPIC}_workspace_rules.md

## Folder Mapping

| Folder | Purpose | Primary Artifacts | Governing Rules |
|---|---|---|---|
| research/raw | Source collection | source_fact | generic + ${TOPIC} |
| research/history | Trace and evolution | source_fact / validation_report | generic + ${TOPIC} |
| research/candidates | Candidate designs | design_draft | generic + ${TOPIC} |
| research/selected | Selected design/spec | design_approved / implementation_spec | generic + ${TOPIC} |
| research/math | Formalization | design_approved | generic + ${TOPIC} |
| research/ablations | Validation evidence | validation_report | generic + ${TOPIC} |
| development/src | Product code | implementation outputs | generic + ${TOPIC} |
| development/tests | Validation code | test artifacts | generic + ${TOPIC} |
| development/configs | Runtime settings | config artifacts | generic + ${TOPIC} |
| development/docs | Dev docs | implementation notes | generic + ${TOPIC} |

## Pipeline Gate Usage
- pre-implement: scripts/pipeline_gate_check.sh pre-implement ${TOPIC}
- pre-complete: scripts/pipeline_gate_check.sh pre-complete ${TOPIC}
EOF

cat > "$TOPIC_APPROVAL_REGISTRY" <<EOF
# ${TOPIC} Approval Registry

## Rules
- draft는 구현 근거로 사용 금지
- approved만 implementation_spec 근거로 사용
- validation pass 없으면 완료 선언 금지

## Design Approval Ledger

| Topic | Date | Artifact | Type | Status | Approved By | Evidence Sources | Notes |
|---|---|---|---|---|---|---|---|
| ${TOPIC} |  |  | design_draft/design_approved | draft/approved |  |  |  |

## Spec Approval Ledger

| Topic | Date | Artifact | Type | Status | Approved By | Based on Approved Design | Notes |
|---|---|---|---|---|---|---|---|
| ${TOPIC} |  |  | implementation_spec | draft/approved |  |  |  |

## Validation Ledger

| Topic | Date | Artifact | Risk Level | Final Verdict | Blocking Issues | Notes |
|---|---|---|---|---|---|---|
| ${TOPIC} |  |  | low/medium/high | pass/fail |  |  |
EOF

echo "[DONE] Domain bootstrap completed for topic: $TOPIC"
echo "- Created: research/, development/"
echo "- Created: $TOPIC_RULE_FILE"
echo "- Created: $MAP_FILE"
echo "- Created: $TOPIC_APPROVAL_REGISTRY"

# ── NotebookLM Notebook Registration ────────────────────────────────────────
echo ""
echo "=== NotebookLM Notebook Setup ==="

# Check if topic already has a notebook registered
if [[ -f "$NLM_REGISTRY" ]] && grep -q "^\| \`${TOPIC}\`" "$NLM_REGISTRY"; then
  echo "[INFO] Notebook already registered for topic: $TOPIC"
  echo "  See: $NLM_REGISTRY"
elif [[ ! -t 0 ]]; then
  # Non-interactive mode (CI, smoke test, pipe): skip prompt
  echo "[SKIP] Non-interactive environment — skipping NLM notebook prompt."
  echo "  Run scripts/bootstrap_domain.sh $TOPIC interactively, or use /generic-step0-nlm-setup."
else
  echo "This topic does not have a NotebookLM notebook registered yet."
  echo ""
  echo "Options:"
  echo "  [1] I have an existing notebook (created on notebooklm.google.com)"
  echo "  [2] I will create a new notebook via MCP (run /generic-step0-nlm-setup)"
  echo "  [3] Skip for now"
  echo ""
  read -r -p "  Choose [1/2/3] (default: 3): " NLM_CHOICE
  NLM_CHOICE="${NLM_CHOICE:-3}"

  DATE_TODAY="$(date +%Y-%m-%d)"

  case "$NLM_CHOICE" in
    1)
      read -r -p "  Paste your notebook ID (from URL): " NLM_ID
      if [[ -n "$NLM_ID" ]]; then
        NLM_URL="https://notebooklm.google.com/notebook/${NLM_ID}"
        # Append to registry
        echo "| \`${TOPIC}\` | \`${NLM_ID}\` | ${NLM_URL} | ${DATE_TODAY} | active | linked from web |" >> "$NLM_REGISTRY"
        echo "[OK] Registered existing notebook for $TOPIC"
        echo "  ID: $NLM_ID"
        echo "  Registry: $NLM_REGISTRY"
      else
        echo "[SKIP] No notebook ID provided."
      fi
      ;;
    2)
      # Append a draft placeholder row; user completes via Step 0 prompt
      echo "| \`${TOPIC}\` | \`PENDING_CREATE\` | — | ${DATE_TODAY} | draft | run /generic-step0-nlm-setup to create |" >> "$NLM_REGISTRY"
      echo "[OK] Draft entry added for $TOPIC. Run /generic-step0-nlm-setup to create the notebook."
      echo "  Registry: $NLM_REGISTRY"
      ;;
    3|*)
      echo "[SKIP] Notebook not registered. Run /generic-step0-nlm-setup later."
      ;;
  esac
fi

echo ""
echo "Next steps:"
echo "  1. Run /generic-step0-nlm-setup to finalize NotebookLM setup"
echo "  2. Source naming convention: ${TOPIC}_<stage>_<type>_<YYYYMMDD>"
echo "  3. See docs/notebooklm_integration.md for full guide"
