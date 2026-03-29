#!/usr/bin/env bash
# setup.sh — One-shot initialization for Research Pipeline Template
# Run this once after cloning: bash scripts/setup.sh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "=== Research Pipeline Template — Setup ==="
echo ""

# 1. Make scripts executable
echo "[1/4] Setting script permissions..."
chmod +x scripts/pipeline_gate_check.sh
chmod +x scripts/bootstrap_domain.sh
echo "  Done."

# 2. Verify dependencies
echo "[2/4] Checking dependencies..."
MISSING=0
if ! command -v bash >/dev/null 2>&1; then
  echo "  [WARN] bash not found"
  MISSING=1
fi
if command -v rg >/dev/null 2>&1; then
  echo "  [OK] ripgrep (rg) found — gate searches will use rg"
else
  echo "  [OK] ripgrep not found — gate searches will fall back to grep"
fi
if [[ $MISSING -eq 1 ]]; then
  echo "  [ERROR] Required dependency missing. Resolve before continuing."
  exit 1
fi
echo "  Done."

# 3. Run smoke tests
echo "[3/4] Running smoke tests..."
if [[ -x tests/run_smoke_tests.sh ]]; then
  bash tests/run_smoke_tests.sh
else
  echo "  [SKIP] tests/run_smoke_tests.sh not found or not executable"
fi

# 4. Bootstrap topic (optional)
echo "[4/4] Domain bootstrap (optional)"
echo ""
read -r -p "  Enter a topic slug to bootstrap now (or press Enter to skip): " TOPIC_SLUG
if [[ -n "$TOPIC_SLUG" ]]; then
  bash scripts/bootstrap_domain.sh "$TOPIC_SLUG"
else
  echo "  Skipped. Run later: scripts/bootstrap_domain.sh <topic_slug>"
fi

echo ""
echo "=== Setup complete ==="
echo ""
echo "Next steps:"
echo "  1. Open .agents/workflows/generic/README.md"
echo "  2. Apply .agents/workflows/generic/copilot_system_prompt.md"
echo "  3. Use /generic-step0-nlm-setup to configure NotebookLM notebook"
echo "  4. Follow generic-step1..5 slash prompts in order"
echo "  5. Check gate status before each implementation step"
