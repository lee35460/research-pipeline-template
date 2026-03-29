---
description: "Generic Step 5: Create validation_report and enforce completion gate."
---

Before completion decision, run:
- `scripts/pipeline_gate_check.sh pre-complete <topic_slug> research/<topic_slug>/approval_registry.md`

If gate fails, keep status incomplete and list required fixes.

Generate `validation_report` with:
- source grounding
- architecture consistency
- math-to-code consistency
- paper-to-code consistency
- hidden assumptions
- unresolved TBD

Output:
1. Validation Target
2. Checked Items
3. Consistency Findings
4. Mismatches
5. Risk Level
6. Required Fixes
7. Final Verdict
8. Registry Row: 사용자가 approval_registry.md에 복사-붙여넣기 할 수 있도록 마크다운 테이블 행(Row) 1줄을 코드 블록으로 출력해 주세요. 단, 컬럼 구조는 반드시 | Topic | Date | Artifact | Risk Level | Final Verdict | Blocking Issues | Notes | 스키마에 정확히 맞춰야 합니다.
