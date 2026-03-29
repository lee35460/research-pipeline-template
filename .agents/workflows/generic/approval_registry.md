# Generic Approval Registry

## Rules
- draft는 구현 근거로 사용 금지
- approved만 implementation_spec 근거로 사용
- validation pass 없으면 완료 선언 금지

## Design Approval Ledger

| Topic | Date | Artifact | Type | Status | Approved By | Evidence Sources | Notes |
|---|---|---|---|---|---|---|---|
|  |  |  | design_draft/design_approved | draft/approved |  |  |  |

## Spec Approval Ledger

| Topic | Date | Artifact | Type | Status | Approved By | Based on Approved Design | Notes |
|---|---|---|---|---|---|---|---|
|  |  |  | implementation_spec | draft/approved |  |  |  |
| toy_topic | 2026-03-29 | toy_spec_v1 | implementation_spec | approved | demo_user | toy_design_v1 | demo pass for pre-implement |

## Validation Ledger

| Topic | Date | Artifact | Risk Level | Final Verdict | Blocking Issues | Notes |
|---|---|---|---|---|---|---|
|  |  |  | low/medium/high | pass/fail |  |  |
| toy_topic | 2026-03-29 | toy_validation_v1 | low | pass | none | demo pass for pre-complete |
