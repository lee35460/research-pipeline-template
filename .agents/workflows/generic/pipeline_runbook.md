# Generic NotebookLM-MCP Pipeline Runbook

## 운영 목표
- NotebookLM을 연구 기억 저장소로 사용
- 편집기 에이전트를 실행 파이프라인 관리자로 운영

## 표준 단계 (Strict)
1. Knowledge Capture
2. NotebookLM Storage
3. Structuring
4. Implementation Spec
5. Code Implementation
6. Final Validation

## 단계별 입출력

### 1) Knowledge Capture
입력:
- 대화 로그, 요구사항, 수식, 설계 아이디어, 실험 계획

출력:
- `design_draft`
- 분리 필드: `fact`, `interpretation`, `decision`, `open_question`

### 2) NotebookLM Storage
입력:
- 단계 1 산출물

출력:
- `source_fact` 또는 `design_draft`

### 3) Structuring
입력:
- NotebookLM approved 소스

출력:
- `design_draft` 또는 `design_approved`
- 구조 분리: architecture / math / paper / code / experiment

### 4) Implementation Spec
입력:
- `design_approved`

출력:
- `implementation_spec`
- 필수: Goal, Modules/Files, Signatures, Shapes/Data Flow, Equation-to-Code, Constraints, Validation Criteria

### 5) Code Implementation
입력:
- `implementation_spec`

출력:
- 코드 변경
- 규칙: 구조 임의 변경 금지, 신규 로직 발명 금지

### 6) Final Validation
입력:
- 코드 + spec + approved design + 문서 서술

출력:
- `validation_report`
- 필수 검증: source / architecture / math-code / paper-code / hidden assumptions / TBD
