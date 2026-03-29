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
문서 또는 코드 생성이 완료되면, 반드시 `mcp_notebooklm_source_add` 툴을 호출하여 이 단계의 핵심 결과물을 NotebookLM에 동기화하세요.
