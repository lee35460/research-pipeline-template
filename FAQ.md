# FAQ

## Q1) Why does gate check fail by default?
Because the approval registry starts mostly empty. Add approved spec and validation pass rows in:
- .agents/workflows/generic/approval_registry.md

## Q2) Which MCP should I use for each stage?
- NotebookLM MCP: source grounding, synthesis, design structuring
- Sequential Thinking MCP: ambiguity resolution, candidate comparison
- Coding MCP/Model: implementation, debugging, refactoring

## Q3) Can I skip implementation_spec and code directly?
No. The pipeline requires approved design -> implementation_spec -> code.

## Q4) How do I adapt this template to a new research topic?
Run:
- scripts/bootstrap_domain.sh <topic_slug>
This creates topic-specific folders, rules, and folder-rule mapping.

## Q5) Where do topic-specific constraints belong?
In:
- .agents/rules/<topic>_workspace_rules.md
Generic constraints stay in:
- .agents/rules/generic_workspace_rules.md

## Q6) What does draft vs approved mean?
- draft: exploratory, not allowed as implementation basis
- approved: validated basis for spec and implementation

## Q7) Why does CI fail on pull request?
Most often due to gate failures:
- Missing approved implementation_spec row
- Missing validation pass row
- Outdated approval registry

## Q8) Can I keep demo rows in approval registry?
Yes for demo-first template distribution. For strict production use, replace demo rows with project rows.
