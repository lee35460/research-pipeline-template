---
description: "Generic Step 4: Implement code strictly from implementation_spec."
---

Before coding, run:
- `scripts/pipeline_gate_check.sh pre-implement .agents/workflows/generic/approval_registry.md <topic_slug>`

If gate fails, stop and list missing approval items.

Generate code strictly based on `implementation_spec`.
Rules:
- do not modify architecture
- do not invent new logic
- preserve equation/variable consistency
