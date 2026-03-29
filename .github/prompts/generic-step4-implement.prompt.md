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

---
**[Post-Step Action: NotebookLM Sync]**
문서 또는 코드 생성이 완료되면, 반드시 `mcp_notebooklm_source_add` 툴을 호출하여 이 단계의 핵심 결과물을 NotebookLM에 동기화하세요.
