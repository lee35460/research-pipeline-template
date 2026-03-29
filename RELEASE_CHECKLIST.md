# Release Checklist

Use this checklist before publishing a new release.

## 1. Core Pipeline Health
- [ ] Gate script is executable: scripts/pipeline_gate_check.sh
- [ ] pre-implement gate passes
- [ ] pre-complete gate passes
- [ ] approval registry is up to date

## 2. Documentation Completeness
- [ ] README has current quick-start steps
- [ ] MCP Types and Roles section is accurate
- [ ] Domain bootstrap instructions are accurate
- [ ] 5-minute demo links are valid

## 3. Repository Governance
- [ ] LICENSE exists and is correct
- [ ] CONTRIBUTING.md exists and is current
- [ ] CODE_OF_CONDUCT.md exists and is current
- [ ] SECURITY.md exists and is current

## 4. CI and Automation
- [ ] .github/workflows/pipeline-gates.yml exists
- [ ] CI runs on pull_request
- [ ] CI status is passing on default branch

## 5. Template Quality
- [ ] Generic rules contain no project-specific assumptions
- [ ] Generic prompts are aligned with runbook stages
- [ ] Example files are runnable without hidden dependencies
- [ ] Folder/rule mapping reflects current structure

## 6. Final Publish Steps
- [ ] Version/tag decided
- [ ] CHANGELOG updated (if used)
- [ ] README badges updated with real owner/repo
- [ ] Final sanity test run completed
