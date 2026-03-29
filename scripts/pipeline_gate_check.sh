#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-}"
TOPIC="${2:-}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEFAULT_REGISTRY="$ROOT_DIR/.agents/workflows/generic/approval_registry.md"
REGISTRY_INPUT="${3:-}"

if [[ -z "$MODE" ]]; then
  echo "Usage: scripts/pipeline_gate_check.sh <pre-implement|pre-complete> <topic_slug> [registry_path]"
  exit 2
fi

if [[ "$MODE" != "pre-implement" && "$MODE" != "pre-complete" ]]; then
  echo "Unknown mode: $MODE"
  echo "Usage: scripts/pipeline_gate_check.sh <pre-implement|pre-complete> <topic_slug> [registry_path]"
  exit 2
fi

if [[ -z "$TOPIC" ]]; then
  echo "[GATE-FAIL] topic_slug is required for topic-isolated gate checks"
  echo "Usage: scripts/pipeline_gate_check.sh <pre-implement|pre-complete> <topic_slug> [registry_path]"
  exit 2
fi

TOPIC_REGISTRY="$ROOT_DIR/research/$TOPIC/approval_registry.md"

if [[ -n "$REGISTRY_INPUT" ]]; then
  if [[ "$REGISTRY_INPUT" = /* ]]; then
    REGISTRY="$REGISTRY_INPUT"
  else
    REGISTRY="$ROOT_DIR/$REGISTRY_INPUT"
  fi
else
  # Prefer topic-local registry first.
  if [[ -f "$TOPIC_REGISTRY" ]]; then
    REGISTRY="$TOPIC_REGISTRY"
  else
    REGISTRY="$DEFAULT_REGISTRY"
  fi
fi

if [[ ! -f "$REGISTRY" ]]; then
  echo "[GATE-FAIL] approval registry missing: $REGISTRY"
  exit 1
fi

has_matching_row() {
  local mode="$1"
  local topic="$2"
  local registry="$3"

  awk -v mode="$mode" -v topic="$topic" '
    function trim(s) {
      sub(/^[[:space:]]+/, "", s)
      sub(/[[:space:]]+$/, "", s)
      return s
    }

    function norm(s) {
      s = tolower(trim(s))
      gsub(/[^a-z0-9]/, "", s)
      return s
    }

    function is_separator(n, arr,   i, v) {
      for (i = 1; i <= n; i++) {
        v = trim(arr[i])
        if (v == "") {
          continue
        }
        if (v !~ /^:?-{3,}:?$/) {
          return 0
        }
      }
      return 1
    }

    BEGIN {
      found = 0
      in_table = 0
      topic_col = type_col = status_col = verdict_col = 0
      topic_lc = tolower(topic)
    }

    /^[[:space:]]*\|/ {
      line = $0
      sub(/^[[:space:]]*\|/, "", line)
      sub(/\|[[:space:]]*$/, "", line)
      n = split(line, cols, "|")

      for (i = 1; i <= n; i++) {
        cols[i] = trim(cols[i])
      }

      if (is_separator(n, cols)) {
        next
      }

      if (norm(cols[1]) == "topic") {
        in_table = 1
        topic_col = type_col = status_col = verdict_col = 0
        for (i = 1; i <= n; i++) {
          key = norm(cols[i])
          if (key == "topic") {
            topic_col = i
          } else if (key == "type" || key == "artifacttype") {
            type_col = i
          } else if (key == "status") {
            status_col = i
          } else if (key == "finalverdict") {
            verdict_col = i
          }
        }
        next
      }

      if (!in_table || topic_col == 0) {
        next
      }

      row_topic = tolower(trim(cols[topic_col]))
      if (row_topic == "" || row_topic != topic_lc) {
        next
      }

      if (mode == "pre-implement") {
        if (type_col == 0 || status_col == 0) {
          next
        }
        row_type = tolower(trim(cols[type_col]))
        row_status = tolower(trim(cols[status_col]))
        if (row_type == "implementation_spec" && row_status == "approved") {
          found = 1
          exit 0
        }
      } else if (mode == "pre-complete") {
        row_verdict = ""
        if (verdict_col > 0) {
          row_verdict = tolower(trim(cols[verdict_col]))
        } else if (status_col > 0) {
          row_verdict = tolower(trim(cols[status_col]))
        }

        if (row_verdict == "pass") {
          if (type_col > 0) {
            row_type = tolower(trim(cols[type_col]))
            if (row_type != "" && row_type != "validation_report" && row_type != "validation") {
              next
            }
          }
          found = 1
          exit 0
        }
      }
    }

    END {
      if (found == 1) {
        exit 0
      }
      exit 1
    }
  ' "$registry"
}

case "$MODE" in
  pre-implement)
    if has_matching_row "$MODE" "$TOPIC" "$REGISTRY"; then
      echo "[GATE-PASS] topic=$TOPIC approved implementation_spec found"
      exit 0
    fi
    echo "[GATE-FAIL] topic=$TOPIC approved implementation_spec not found in approval registry"
    echo "           Update $REGISTRY before coding."
    exit 1
    ;;
  pre-complete)
    if has_matching_row "$MODE" "$TOPIC" "$REGISTRY"; then
      echo "[GATE-PASS] topic=$TOPIC validation pass record found"
      exit 0
    fi
    echo "[GATE-FAIL] topic=$TOPIC validation pass record not found in approval registry"
    echo "           Add validation_report result in $REGISTRY before marking completion."
    exit 1
    ;;
  *)
    echo "Unknown mode: $MODE"
    echo "Usage: scripts/pipeline_gate_check.sh <pre-implement|pre-complete> <topic_slug> [registry_path]"
    exit 2
    ;;
esac
