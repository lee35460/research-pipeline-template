---
description: "Generic Step 5: Create validation_report and enforce completion gate."
---

Before completion decision, run:
- `scripts/pipeline_gate_check.sh pre-complete .agents/workflows/generic/approval_registry.md`

If gate fails, keep status incomplete and list required fixes.

Generate `validation_report` with:
- source grounding
- architecture consistency
- math-to-code consistency
- paper-to-code consistency
- hidden assumptions
- unresolved TBD

Output:
1. Validation Target
2. Checked Items
3. Consistency Findings
4. Mismatches
5. Risk Level
6. Required Fixes
7. Final Verdict
