# Generic Short Prompts (5-Step)

1) Capture
"Summarize discussion into design_draft. Separate fact / interpretation / decision / open_question."

**[Post-Step Action: NotebookLM Sync]**
문서 또는 코드 생성이 완료되면, 반드시 `mcp_notebooklm_source_add` 툴을 호출하여 이 단계의 핵심 결과물을 NotebookLM에 동기화하세요.

2) Structure
"Using approved NotebookLM sources, structure architecture / mathematical formulation / paper structure. Mark TBD."

**[Post-Step Action: NotebookLM Sync]**
문서 또는 코드 생성이 완료되면, 반드시 `mcp_notebooklm_source_add` 툴을 호출하여 이 단계의 핵심 결과물을 NotebookLM에 동기화하세요.

3) Spec
"Convert approved design to implementation_spec with modules, signatures, shapes, equation-code mapping, constraints, validation criteria. Do not code yet. Output a one-line Bash append command in a code block: `echo "| Topic | Date | Artifact | Type | Status | Approved By | Based on Approved Design | Notes |" >> research/<topic_slug>/approval_registry.md`. Status must be exactly lowercase `approved` or `draft` only."

**[Post-Step Action: NotebookLM Sync]**
문서 또는 코드 생성이 완료되면, 반드시 `mcp_notebooklm_source_add` 툴을 호출하여 이 단계의 핵심 결과물을 NotebookLM에 동기화하세요.

4) Implement
"Generate code strictly from implementation_spec. Do not modify architecture or invent logic."

**[Post-Step Action: NotebookLM Sync]**
문서 또는 코드 생성이 완료되면, 반드시 `mcp_notebooklm_source_add` 툴을 호출하여 이 단계의 핵심 결과물을 NotebookLM에 동기화하세요.

5) Validate
"Generate validation_report for source grounding, architecture consistency, math-code consistency, paper-code consistency, hidden assumptions, and TBD. Output a one-line Bash append command in a code block: `echo "| Topic | Date | Artifact | Risk Level | Final Verdict | Blocking Issues | Notes |" >> research/<topic_slug>/approval_registry.md`. Final Verdict must be exactly lowercase `pass` or `fail` only."

**[Post-Step Action: NotebookLM Sync]**
문서 또는 코드 생성이 완료되면, 반드시 `mcp_notebooklm_source_add` 툴을 호출하여 이 단계의 핵심 결과물을 NotebookLM에 동기화하세요.
