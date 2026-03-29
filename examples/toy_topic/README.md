# Toy Topic Demo (5 Minutes)

## Goal
Run a minimal end-to-end flow for a sample topic.

## Steps
1. Bootstrap topic folders and rules:
   - `./scripts/bootstrap_domain.sh toy_topic`
2. Open topic rule file and add 3 constraints:
   - `.agents/rules/toy_topic_workspace_rules.md`
3. Add one approved spec row in:
   - preferred: `research/toy_topic/approval_registry.md`
   - or shared registry: `.agents/workflows/generic/approval_registry.md`
4. Run pre-implement gate:
   - `./scripts/pipeline_gate_check.sh pre-implement .agents/workflows/generic/approval_registry.md toy_topic`
5. Add one validation pass row in registry and run pre-complete gate.

## Expected
- pre-implement passes only with approved implementation_spec row.
- pre-complete passes only with validation pass row.
