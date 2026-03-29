---
description: "Generic Step 4: Implement code strictly from implementation_spec."
---

Before coding, run:
- `scripts/pipeline_gate_check.sh pre-implement <topic_slug> research/<topic_slug>/approval_registry.md`

If gate fails, stop and list missing approval items.

Generate code strictly based on `implementation_spec`.
Rules:
- do not modify architecture
- do not invent new logic
- preserve equation/variable consistency
