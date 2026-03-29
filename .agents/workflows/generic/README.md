# Generic Research Pipeline Entry

이 문서는 특정 프로젝트에 종속되지 않는 NotebookLM-MCP 기반 연구-설계-구현-검증 파이프라인의 단일 진입점이다.

## Start Here
1. 시스템 프롬프트 적용
- 파일: `.agents/workflows/generic/copilot_system_prompt.md`

2. 세션 시작 체크
- 파일: `.agents/workflows/generic/session_start_checklist.md`

3. 표준 실행 절차
- 파일: `.agents/workflows/generic/pipeline_runbook.md`

4. 정보 배치 규칙
- 파일: `.agents/workflows/generic/pipeline_info_map.md`

5. 아티팩트 템플릿
- 파일: `.agents/workflows/generic/artifact_templates.md`

6. 승인 상태 레지스트리
- 파일: `.agents/workflows/generic/approval_registry.md`

7. 빠른 실행(5단계)
- 파일: `.agents/workflows/generic/short_prompts_5step.md`

8. 슬래시 프롬프트 세트
- 파일: `.github/prompts/generic-step1-capture.prompt.md`
- 파일: `.github/prompts/generic-step2-structure.prompt.md`
- 파일: `.github/prompts/generic-step3-spec.prompt.md`
- 파일: `.github/prompts/generic-step4-implement.prompt.md`
- 파일: `.github/prompts/generic-step5-validate.prompt.md`

## Mandatory Gates
- implementation_spec 없으면 코드 생성 금지
- validation_report 없으면 완료 선언 금지
- draft는 구현 근거로 사용 금지
- approved만 구현 기준으로 사용

## Automated Gate Check
- 구현 전: `scripts/pipeline_gate_check.sh pre-implement .agents/workflows/generic/approval_registry.md`
- 완료 전: `scripts/pipeline_gate_check.sh pre-complete .agents/workflows/generic/approval_registry.md`

## Artifact Types
- source_fact
- design_draft
- design_approved
- implementation_spec
- validation_report

## Stage Order
1. Knowledge Capture
2. NotebookLM Storage
3. Structuring
4. Implementation Spec
5. Code Implementation
6. Final Validation

## Topic Rule Location
- Base (generic): `.agents/rules/generic_workspace_rules.md`
- Topic-specific: `.agents/rules/<topic>_workspace_rules.md`
- Example: `.agents/rules/vision_anomaly_workspace_rules.md`

운영 방식:
- 공통 정책은 generic 규칙에 유지
- 연구 주제 고유 분류/용어/금지 가정은 topic 규칙 파일에 추가

## Auto Generation
- Run: `scripts/bootstrap_domain.sh <topic_slug>`
- Example: `scripts/bootstrap_domain.sh vision_anomaly`
- Creates research/development folders + topic rule + folder-rule map
