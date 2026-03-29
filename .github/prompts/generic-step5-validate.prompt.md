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
8. Registry Append Command: 표 오염 방지를 위해 마크다운 행 자체가 아니라, 터미널에서 실행할 Bash append 명령어 1줄을 코드 블록으로 출력해 주세요. 반드시 `echo "\\| Topic \\| Date \\| Artifact \\| Risk Level \\| Final Verdict \\| Blocking Issues \\| Notes \\|" >> research/<topic_slug>/approval_registry.md` 형식으로 파이프(`\\|`)를 이스케이프해야 합니다.
