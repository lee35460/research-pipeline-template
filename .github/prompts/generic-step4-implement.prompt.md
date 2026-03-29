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

참조 템플릿이 필요한 경우 글로벌 공유 템플릿 `.agents/workflows/generic/artifact_templates.md` 를 기준으로 문서 구조를 맞출 것.

---
**[Post-Step Action: NotebookLM Sync]**
이 단계의 문서/코드 작성이 완료되면, 반드시 파일들이 글로벌 `research/` 가 아닌 격리된 `research/<topic_slug>/` (또는 `development/<topic_slug>/`) 하위의 올바른 폴더에 저장되었는지 확인하세요.
이후, `mcp_notebooklm_source_add` 툴을 호출하여 생성된 핵심 결과물을 NotebookLM에 동기화하세요.
