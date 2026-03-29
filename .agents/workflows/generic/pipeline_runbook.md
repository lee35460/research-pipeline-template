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

## Rollback Protocol

아래 상황에서는 파이프라인을 즉시 롤백한다.

트리거:
- 구현 단계에서 스펙 누락/모순 발견
- 검증 단계에서 구조/수식 정합성 실패
- hidden assumption이 구현에 영향을 줄 정도로 치명적

강제 절차:
1. 해당 토픽의 `approval_registry.md`에서 문제 스펙 상태를 `approved`에서 `draft`로 강등
2. `Notes` 컬럼에 롤백 사유와 재진입 조건 명시
3. 단계 복귀:
	- 설계 결함이면 Step 2 또는 Step 3으로 복귀
	- 스펙 표현 결함이면 Step 4로 복귀
4. 재승인 전까지 Step 5(구현/완료 판단) 금지

운영 규칙:
- 롤백은 예외가 아니라 정식 품질 절차로 취급한다.
- `draft` 상태의 스펙을 근거로 코드 구현을 진행하면 안 된다.
