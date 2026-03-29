---
description: "Generic Step 1: Capture discussion into design_draft with fact/interpretation/decision/open_question split."
---

Summarize current discussion into a NotebookLM-ready document.

Requirements:
- Separate: `fact`, `interpretation`, `design_decision`, `open_question`
- Status: `draft`
- Type: `design_draft`

Output:
1. Document Title
2. Status
3. Type
4. Full Content

Do not generate code.

---
**[Post-Step Action: NotebookLM Sync]**
이 단계의 문서/코드 작성이 완료되면, 반드시 파일들이 글로벌 `research/` 가 아닌 격리된 `research/<topic_slug>/` (또는 `development/<topic_slug>/`) 하위의 올바른 폴더에 저장되었는지 확인하세요.
이후, `mcp_notebooklm_source_add` 툴을 호출하여 생성된 핵심 결과물을 NotebookLM에 동기화하세요.
