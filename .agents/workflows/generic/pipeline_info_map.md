# Generic Pipeline 정보 배치 가이드

## 목적
- 연구 -> 설계 -> 명세 -> 구현 -> 검증의 재사용 가능한 운영 체계 제공

## 어디에 무엇을 둘지

1. `.agents/rules/`
- 전역 정책

2. `.agents/skills/`
- 역할별 실행 절차

3. `.agents/workflows/generic/`
- 프로젝트 독립 플레이북/템플릿

## 문서 타입별 권장 저장 위치

1. `source_fact`
- `research/raw/`, `research/history/`

2. `design_draft`
- `research/candidates/`, `research/notes/`

3. `design_approved`
- `research/selected/`, `research/math/`

4. `implementation_spec`
- `research/selected/` 또는 `research/notes/`

5. `validation_report`
- `research/history/`, `research/ablations/`

## 상태 규칙
- draft: 구현 근거 사용 금지
- approved: 구현 근거 사용 가능

## 실행 게이트
1. approved 설계 없이 구현 금지
2. implementation_spec 없이 코드 생성 금지
3. validation_report 없이 완료 선언 금지
