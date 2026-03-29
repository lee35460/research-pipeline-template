#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEFAULT_REGISTRY="$ROOT_DIR/.agents/workflows/approval_registry.md"
REGISTRY_INPUT="${2:-}"

if [[ -n "$REGISTRY_INPUT" ]]; then
  if [[ "$REGISTRY_INPUT" = /* ]]; then
    REGISTRY="$REGISTRY_INPUT"
  else
    REGISTRY="$ROOT_DIR/$REGISTRY_INPUT"
  fi
else
  REGISTRY="$DEFAULT_REGISTRY"
fi

if [[ -z "$MODE" ]]; then
  echo "Usage: scripts/pipeline_gate_check.sh <pre-implement|pre-complete> [registry_path]"
  exit 2
fi

if [[ "$MODE" != "pre-implement" && "$MODE" != "pre-complete" ]]; then
  echo "Unknown mode: $MODE"
  echo "Usage: scripts/pipeline_gate_check.sh <pre-implement|pre-complete> [registry_path]"
  exit 2
fi

if [[ ! -f "$REGISTRY" ]]; then
  echo "[GATE-FAIL] approval registry missing: $REGISTRY"
  exit 1
fi

has_approved_spec() {
  local pattern="\\|\\s*[^|]+\\s*\\|\\s*[^|]+\\s*\\|\\s*implementation_spec\\s*\\|\\s*approved\\s*\\|"
  if command -v rg >/dev/null 2>&1; then
    rg -n "$pattern" "$REGISTRY" >/dev/null
  else
    grep -nE "$pattern" "$REGISTRY" >/dev/null
  fi
}

has_pass_validation() {
    local pattern="\\|\\s*[^|]+\\s*\\|\\s*[^|]+\\s*\\|\\s*[^|]+\\s*\\|\\s*pass\\s*\\|"
    if command -v rg >/dev/null 2>&1; then
      rg -n "$pattern" "$REGISTRY" >/dev/null
    else
      grep -nE "$pattern" "$REGISTRY" >/dev/null
    fi
}

case "$MODE" in
  pre-implement)
    if has_approved_spec; then
      echo "[GATE-PASS] approved implementation_spec found"
      exit 0
    fi
    echo "[GATE-FAIL] approved implementation_spec not found in approval registry"
    echo "           Update $REGISTRY before coding."
    exit 1
    ;;
  pre-complete)
    if has_pass_validation; then
      echo "[GATE-PASS] validation pass record found"
      exit 0
    fi
    echo "[GATE-FAIL] validation pass record not found in approval registry"
    echo "           Add validation_report result in $REGISTRY before marking completion."
    exit 1
    ;;
  *)
    echo "Unknown mode: $MODE"
    echo "Usage: scripts/pipeline_gate_check.sh <pre-implement|pre-complete> [registry_path]"
    exit 2
    ;;
esac
