---
description: "Generic Step 3: Convert approved design into implementation_spec before coding."
---

중요: NotebookLM에 과거 실패한 `validation_report`가 존재한다면 먼저 쿼리하고, 해당 실패 원인을 회피하도록 구성할 것.

Convert approved design into `implementation_spec`.

Must include:
- modules / files
- function signatures
- tensor shapes / data flow
- equation-to-code mapping
- constraints
- validation criteria

Output:
1. Goal
2. Approved Design Basis
3. Modules / Files
4. Function Signatures
5. Equation-to-Code Mapping
6. Constraints
7. Validation Criteria
8. Registry Append Command: 표 오염 방지를 위해 마크다운 행 자체가 아니라, 터미널에서 실행할 Bash append 명령어 1줄을 코드 블록으로 출력해 주세요. 반드시 `echo "| Topic | Date | Artifact | Type | Status | Approved By | Based on Approved Design | Notes |" >> research/<topic_slug>/approval_registry.md` 형식으로 출력하세요. 단, Status 컬럼 값은 반드시 소문자 `approved` 또는 `draft` 중 하나만 정확히 사용해야 합니다(다른 단어, 대문자, 과거형 절대 금지).

Do not generate code yet.

---
**[Post-Step Action: NotebookLM Sync]**
문서 또는 코드 생성이 완료되면, 반드시 `mcp_notebooklm_source_add` 툴을 호출하여 이 단계의 핵심 결과물을 NotebookLM에 동기화하세요.
