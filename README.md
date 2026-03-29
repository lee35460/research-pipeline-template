# Research Pipeline Template

[![Pipeline Gates](https://github.com/lee35460/research-pipeline-template/actions/workflows/pipeline-gates.yml/badge.svg)](https://github.com/lee35460/research-pipeline-template/actions/workflows/pipeline-gates.yml)
[![Link Validation](https://github.com/lee35460/research-pipeline-template/actions/workflows/link-validation.yml/badge.svg)](https://github.com/lee35460/research-pipeline-template/actions/workflows/link-validation.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

This is a standalone, GitHub-ready template for a NotebookLM-MCP research-to-implementation pipeline.

## Included
- `.agents/rules/generic_workspace_rules.md`
- `.agents/workflows/generic/` — runbooks, registry, NLM conventions
- `.github/prompts/generic-step0-nlm-setup` through `generic-step5`
- `scripts/pipeline_gate_check.sh`, `bootstrap_domain.sh`, `setup.sh`
- `tests/run_smoke_tests.sh`
- `.github/workflows/pipeline-gates.yml`, `link-validation.yml`
- `docs/` — pipeline diagram, MCP routing, NotebookLM integration guide
- `examples/toy_topic/`

## Quick Start
```bash
bash scripts/setup.sh   # first-time setup: permissions + optional bootstrap
```
1. Open `.agents/workflows/generic/README.md`
2. Apply `.agents/workflows/generic/copilot_system_prompt.md`
3. Use `/generic-step0-nlm-setup` to create or link your NotebookLM notebook
4. Follow `generic-step1` → `generic-step5` slash prompts in order
5. Track approval status in `research/<topic_slug>/approval_registry.md`

## Gate Commands
- scripts/pipeline_gate_check.sh pre-implement research/<topic_slug>/approval_registry.md <topic_slug>
- scripts/pipeline_gate_check.sh pre-complete research/<topic_slug>/approval_registry.md <topic_slug>

## MCP Types and Roles

| MCP / Model | Tool Name | Role | Not For |
|---|---|---|---|
| **NotebookLM MCP** | `mcp_notebooklm_*` | Research grounding, source synthesis, design structuring, failure analysis | Code generation, code modification |
| **Sequential Thinking MCP** | `mcp_sequentialthi_sequentialthinking` | Ambiguity resolution, multi-candidate comparison, decision trace construction | Source-of-truth storage |
| **Personal DeepSeek Coder 33b** | `mcp_personaldeeps_*` (Ollama local) | Code generation, debugging, refactoring — runs fully offline via local Ollama | Architecture redesign, bypassing gates |
| **Gemini** (via Copilot / API) | GitHub Copilot Chat | General reasoning assist, quick Q&A, doc review | Replacing sequential-thinking for design decisions |

### Routing Rules
- Research knowledge → **NotebookLM MCP** first, always
- Design ambiguity / candidate comparison → **Sequential Thinking MCP** before any spec
- Code tasks (approved spec exists) → **Personal DeepSeek Coder 33b** preferred (offline, no data leak)
- Gemini → supplementary only; never the primary decision engine for architecture

### Tool Relationships
- **Gemini → NotebookLM → Copilot** (아키텍처 무손실 전달 경로): Gemini가 설계한 아키텍처를 NotebookLM 소스로 저장 → Copilot이 NLM MCP로 쿼리 = 왜곡·축약 없는 수신. Gemini 출력을 Copilot에 직접 붙여넣으면 컨텍스트 의존적 왜곡 발생.
- **NotebookLM = 무손실 중계 저장소**: Gemini(설계) + 논문/참고자료(연구) 모두 NLM에 소스로 저장. 이후 모든 단계는 NLM 쿼리로만 참조.
- **Copilot → DeepSeek**: Copilot = 오케스트레이터, DeepSeek = 코드 실행자. 반드시 승인된 스펙만 전달. 아키텍처 재정의 금지.
- 전체 관계도: `docs/mcp_routing.md`

## CI
- **Pipeline gates + smoke tests**: `.github/workflows/pipeline-gates.yml` — runs on PR and `workflow_dispatch`
- **Link validation**: `.github/workflows/link-validation.yml` — checks all critical file paths exist on every push to `main`

## Repository Meta Files
- LICENSE
- CONTRIBUTING.md
- CODE_OF_CONDUCT.md
- SECURITY.md

## Ops Docs
- Release checklist: `RELEASE_CHECKLIST.md`
- Frequently asked questions: `FAQ.md`
- Changelog: `CHANGELOG.md`
- Current version: `VERSION` (default `0.1.0`)

## 5-Minute Demo
- Guide: `examples/toy_topic/README.md`
- Sample rows: `examples/toy_topic/approval_registry.sample.md`

## Domain Bootstrap (Research + Development)
Create topic-specialized folders and rule mapping automatically:

- scripts/bootstrap_domain.sh <topic_slug>
- Example: scripts/bootstrap_domain.sh vision_anomaly

Generated outputs:
- `research/` and `development/` folder trees
- `.agents/rules/<topic>_workspace_rules.md`
- `.agents/workflows/generic/<topic>_folder_rule_map.md`
- NotebookLM notebook registration prompt (create new OR link existing)

## NotebookLM Integration
- Create or link a notebook per topic: `docs/notebooklm_integration.md`
- Source naming convention: `<topic>_<stage>_<type>_<YYYYMMDD>`
- Notebook registry: `.agents/workflows/generic/notebooklm_notebook_registry.md`
- Source convention rules: `.agents/workflows/generic/notebooklm_source_conventions.md`

## Docs
- Pipeline flow diagram (Mermaid): `docs/pipeline_diagram.md`
- MCP routing decision tree: `docs/mcp_routing.md`
- NotebookLM full guide: `docs/notebooklm_integration.md`

## Notes
- Replace `<OWNER>/<REPO>` in the badge URLs after creating your GitHub repository.
- Recommended first tag: `v0.1.0`
