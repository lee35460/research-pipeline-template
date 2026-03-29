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

템플릿 작성 기준은 글로벌 공유 템플릿 `.agents/workflows/generic/artifact_templates.md` 를 참고할 것.

Output:
1. Goal
2. Approved Design Basis
3. Modules / Files
4. Function Signatures
5. Equation-to-Code Mapping
6. Constraints
7. Validation Criteria
8. Registry Append Command: 표 오염 방지를 위해 마크다운 행 자체가 아니라, 터미널에서 실행할 Bash append 명령어 1줄을 코드 블록으로 출력해 주세요. 반드시 `echo "| Topic | Date | Artifact | Type | Status | Approved By | Based on Approved Design | Notes |" >> research/<topic_slug>/approval_registry.md` 형식으로 출력하세요. 단, Status 컬럼 값은 반드시 소문자 `approved` 또는 `draft` 중 하나만 정확히 사용해야 합니다(다른 단어, 대문자, 과거형 절대 금지). 또한 Artifact 컬럼 이름은 절대 임의로 지어내지 말고, 반드시 `<topic_slug>_spec_v<버전숫자>` 형식의 엄격한 네이밍 규칙을 따르세요.

Do not generate code yet.

---
**[Post-Step Action: NotebookLM Sync]**
이 단계의 문서/코드 작성이 완료되면, 반드시 파일들이 글로벌 `research/` 가 아닌 격리된 `research/<topic_slug>/` (또는 `development/<topic_slug>/`) 하위의 올바른 폴더에 저장되었는지 확인하세요.
이후, `mcp_notebooklm_source_add` 툴을 호출하여 생성된 핵심 결과물을 NotebookLM에 동기화하세요.
