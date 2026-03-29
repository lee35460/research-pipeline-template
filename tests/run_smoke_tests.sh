#!/usr/bin/env bash
# tests/run_smoke_tests.sh — Smoke tests for pipeline scripts
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PASS=0
FAIL=0

ok()   { echo "  [PASS] $1"; PASS=$((PASS+1)); }
fail() { echo "  [FAIL] $1"; FAIL=$((FAIL+1)); }

echo "--- Smoke Tests ---"
TOPIC="smoke_topic"

# ── Gate script: usage error (no args) ──────────────────────────────────────
echo ""
echo "[TEST] gate_check: no args → exit 2"
set +e
"$ROOT_DIR/scripts/pipeline_gate_check.sh" > /dev/null 2>&1
EXIT=$?
set -e
if [[ $EXIT -eq 2 ]]; then ok "no-arg exit 2"; else fail "no-arg exit 2 (got $EXIT)"; fi

# ── Gate script: invalid mode ────────────────────────────────────────────────
echo ""
echo "[TEST] gate_check: invalid mode → exit 2"
set +e
"$ROOT_DIR/scripts/pipeline_gate_check.sh" bad_mode > /dev/null 2>&1
EXIT=$?
set -e
if [[ $EXIT -eq 2 ]]; then ok "invalid-mode exit 2"; else fail "invalid-mode exit 2 (got $EXIT)"; fi

# ── Gate script: pre-implement on empty file → exit 1 ───────────────────────
echo ""
echo "[TEST] gate_check: pre-implement on empty registry → exit 1"
TMPFILE="$(mktemp)"
echo "| Topic | Date | Artifact | Type | Status |" > "$TMPFILE"
echo "|---|---|---|---|---|" >> "$TMPFILE"
set +e
"$ROOT_DIR/scripts/pipeline_gate_check.sh" pre-implement "$TOPIC" "$TMPFILE" > /dev/null 2>&1
EXIT=$?
set -e
rm -f "$TMPFILE"
if [[ $EXIT -eq 1 ]]; then ok "pre-implement empty → exit 1"; else fail "pre-implement empty → exit 1 (got $EXIT)"; fi

# ── Gate script: pre-implement on approved row → exit 0 ─────────────────────
echo ""
echo "[TEST] gate_check: pre-implement with approved row → exit 0"
TMPFILE="$(mktemp)"
cat >> "$TMPFILE" <<'ROW'
| Topic | Date | Artifact | Type | Status |
|---|---|---|---|---|
| smoke_topic | 2026-03-29 | spec_v1 | implementation_spec | approved |
ROW
set +e
"$ROOT_DIR/scripts/pipeline_gate_check.sh" pre-implement "$TOPIC" "$TMPFILE" > /dev/null 2>&1
EXIT=$?
set -e
rm -f "$TMPFILE"
if [[ $EXIT -eq 0 ]]; then ok "pre-implement approved → exit 0"; else fail "pre-implement approved → exit 0 (got $EXIT)"; fi

# ── Gate script: pre-implement rejects invalid status enums → exit 1 ────────
echo ""
echo "[TEST] gate_check: pre-implement rejects invalid Status enums → exit 1"

TMPFILE="$(mktemp)"
cat >> "$TMPFILE" <<'ROW'
| Topic | Date | Artifact | Type | Status |
|---|---|---|---|---|
| smoke_topic | 2026-03-29 | spec_v1 | implementation_spec | pending |
ROW
set +e
"$ROOT_DIR/scripts/pipeline_gate_check.sh" pre-implement "$TOPIC" "$TMPFILE" > /dev/null 2>&1
EXIT=$?
set -e
rm -f "$TMPFILE"
if [[ $EXIT -eq 1 ]]; then ok "pre-implement invalid status pending → exit 1"; else fail "pre-implement invalid status pending → exit 1 (got $EXIT)"; fi

TMPFILE="$(mktemp)"
cat >> "$TMPFILE" <<'ROW'
| Topic | Date | Artifact | Type | Status |
|---|---|---|---|---|
| smoke_topic | 2026-03-29 | spec_v1 | implementation_spec | Approved |
ROW
set +e
"$ROOT_DIR/scripts/pipeline_gate_check.sh" pre-implement "$TOPIC" "$TMPFILE" > /dev/null 2>&1
EXIT=$?
set -e
rm -f "$TMPFILE"
if [[ $EXIT -eq 1 ]]; then ok "pre-implement invalid status Approved → exit 1"; else fail "pre-implement invalid status Approved → exit 1 (got $EXIT)"; fi

# ── Gate script: topic isolation on pre-implement → exit 1 ─────────────────
echo ""
echo "[TEST] gate_check: pre-implement ignores other topic rows → exit 1"
TMPFILE="$(mktemp)"
cat >> "$TMPFILE" <<'ROW'
| Topic | Date | Artifact | Type | Status |
|---|---|---|---|---|
| another_topic | 2026-03-29 | spec_v1 | implementation_spec | approved |
ROW
set +e
"$ROOT_DIR/scripts/pipeline_gate_check.sh" pre-implement "$TOPIC" "$TMPFILE" > /dev/null 2>&1
EXIT=$?
set -e
rm -f "$TMPFILE"
if [[ $EXIT -eq 1 ]]; then ok "pre-implement topic isolation → exit 1"; else fail "pre-implement topic isolation → exit 1 (got $EXIT)"; fi

# ── Gate script: pre-complete on pass row → exit 0 ──────────────────────────
echo ""
echo "[TEST] gate_check: pre-complete with pass row → exit 0"
TMPFILE="$(mktemp)"
cat >> "$TMPFILE" <<'ROW'
| Topic | Date | Artifact | Risk Level | Final Verdict |
|---|---|---|---|---|
| smoke_topic | 2026-03-29 | validation_v1 | low | pass |
ROW
set +e
"$ROOT_DIR/scripts/pipeline_gate_check.sh" pre-complete "$TOPIC" "$TMPFILE" > /dev/null 2>&1
EXIT=$?
set -e
rm -f "$TMPFILE"
if [[ $EXIT -eq 0 ]]; then ok "pre-complete pass → exit 0"; else fail "pre-complete pass → exit 0 (got $EXIT)"; fi

# ── Gate script: pre-complete rejects invalid final verdict enum → exit 1 ───
echo ""
echo "[TEST] gate_check: pre-complete rejects invalid Final Verdict enum → exit 1"
TMPFILE="$(mktemp)"
cat >> "$TMPFILE" <<'ROW'
| Topic | Date | Artifact | Risk Level | Final Verdict |
|---|---|---|---|---|
| smoke_topic | 2026-03-29 | validation_v1 | low | passed |
ROW
set +e
"$ROOT_DIR/scripts/pipeline_gate_check.sh" pre-complete "$TOPIC" "$TMPFILE" > /dev/null 2>&1
EXIT=$?
set -e
rm -f "$TMPFILE"
if [[ $EXIT -eq 1 ]]; then ok "pre-complete invalid verdict passed → exit 1"; else fail "pre-complete invalid verdict passed → exit 1 (got $EXIT)"; fi

# ── Gate script: topic isolation on pre-complete → exit 1 ──────────────────
echo ""
echo "[TEST] gate_check: pre-complete ignores other topic rows → exit 1"
TMPFILE="$(mktemp)"
cat >> "$TMPFILE" <<'ROW'
| Topic | Date | Artifact | Risk Level | Final Verdict |
|---|---|---|---|---|
| another_topic | 2026-03-29 | validation_v1 | low | pass |
ROW
set +e
"$ROOT_DIR/scripts/pipeline_gate_check.sh" pre-complete "$TOPIC" "$TMPFILE" > /dev/null 2>&1
EXIT=$?
set -e
rm -f "$TMPFILE"
if [[ $EXIT -eq 1 ]]; then ok "pre-complete topic isolation → exit 1"; else fail "pre-complete topic isolation → exit 1 (got $EXIT)"; fi

# ── Bootstrap: no slug → exit 2 ─────────────────────────────────────────────
echo ""
echo "[TEST] bootstrap_domain: no slug → exit 2"
set +e
"$ROOT_DIR/scripts/bootstrap_domain.sh" > /dev/null 2>&1
EXIT=$?
set -e
if [[ $EXIT -eq 2 ]]; then ok "no-slug exit 2"; else fail "no-slug exit 2 (got $EXIT)"; fi

# ── Bootstrap: invalid slug → exit 2 ────────────────────────────────────────
echo ""
echo "[TEST] bootstrap_domain: invalid slug (UPPER) → exit 2"
set +e
"$ROOT_DIR/scripts/bootstrap_domain.sh" BadSlug > /dev/null 2>&1
EXIT=$?
set -e
if [[ $EXIT -eq 2 ]]; then ok "invalid-slug exit 2"; else fail "invalid-slug exit 2 (got $EXIT)"; fi

# ── Bootstrap: valid slug creates expected files ─────────────────────────────
echo ""
echo "[TEST] bootstrap_domain: valid slug → creates rule + map files"
TMPROOT="$(mktemp -d)"
mkdir -p "$TMPROOT/.agents/rules"
mkdir -p "$TMPROOT/.agents/workflows/generic"
set +e
BOOTSTRAP_ROOT_DIR="$TMPROOT" "$ROOT_DIR/scripts/bootstrap_domain.sh" smoke_test_topic < /dev/null > /dev/null 2>&1
EXIT=$?
set -e
RULE_FILE="$TMPROOT/.agents/rules/smoke_test_topic_workspace_rules.md"
MAP_FILE="$TMPROOT/.agents/workflows/generic/smoke_test_topic_folder_rule_map.md"
if [[ $EXIT -eq 0 && -f "$RULE_FILE" && -f "$MAP_FILE" ]]; then
  ok "bootstrap creates rule + map files"
else
  fail "bootstrap creates rule + map files (exit=$EXIT, rule=$(test -f "$RULE_FILE" && echo exists || echo missing), map=$(test -f "$MAP_FILE" && echo exists || echo missing))"
fi
rm -rf "$TMPROOT"

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo "--- Results: $PASS passed, $FAIL failed ---"
if [[ $FAIL -gt 0 ]]; then
  exit 1
fi
exit 0
