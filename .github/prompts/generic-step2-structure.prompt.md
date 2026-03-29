---
description: "Generic Step 2: Structure approved NotebookLM sources into architecture/math/paper and mark TBD."
---

중요: NotebookLM에 과거 실패한 `validation_report`가 존재한다면 먼저 쿼리하고, 해당 실패 원인을 회피하도록 구성할 것.

Using approved NotebookLM sources, structure:
- architecture
- mathematical formulation
- paper structure

Separate:
- grounded facts
- assumptions
- unresolved parts (`TBD`)

템플릿 작성 기준은 글로벌 공유 템플릿 `.agents/workflows/generic/artifact_templates.md` 를 참고할 것.

Output:
1. Goal
2. Grounded Sources
3. Structured Result
4. Unresolved Points
5. Recommended Next Artifact

Do not generate code.

---
**[Post-Step Action: NotebookLM Sync]**
이 단계의 문서/코드 작성이 완료되면, 반드시 파일들이 글로벌 `research/` 가 아닌 격리된 `research/<topic_slug>/` (또는 `development/<topic_slug>/`) 하위의 올바른 폴더에 저장되었는지 확인하세요.
이후, `mcp_notebooklm_source_add` 툴을 호출하여 생성된 핵심 결과물을 NotebookLM에 동기화하세요.
