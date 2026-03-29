# NotebookLM Integration Guide

## Overview

This pipeline uses **NotebookLM MCP** (`mcp_notebooklm_*` tools) to store and query
all research knowledge grounding. Each research topic has its own dedicated notebook.

---

## 1. Notebook Lifecycle

### 1-A. Brand New Topic → Create Notebook

When starting a topic that has never been researched before:

1. Run `/generic-step0-nlm-setup` slash prompt in Copilot Chat
2. The prompt will invoke:
   ```
   mcp_notebooklm_notebook_create(name="<topic> Research Notebook")
   ```
3. Copy the returned `notebook_id`
4. Register it in `.agents/workflows/generic/notebooklm_notebook_registry.md`

### 1-B. Existing Notebook (created via web notebooklm.google.com) → Connect

1. Open `notebooklm.google.com` and locate your notebook
2. Copy the notebook ID from the URL:
   ```
   https://notebooklm.google.com/notebook/<NOTEBOOK_ID>
   ```
3. Run `/generic-step0-nlm-setup` → choose "link existing"
4. The prompt registers the ID in the notebook registry

### Notebook Registry File

`.agents/workflows/generic/notebooklm_notebook_registry.md`

| topic | notebook_id | notebook_url | linked_at | status | notes |
|---|---|---|---|---|---|
| `toy_topic` | `demo_placeholder` | — | 2026-03-29 | demo | replace with real ID |

---

## 2. Source Naming Convention

All sources added to a NotebookLM notebook MUST follow this naming format:

```
<topic>_<stage>_<type>_<YYYYMMDD>[_<seq>]
```

### Fields

| Field | Values | Description |
|---|---|---|
| `topic` | slug (e.g. `ai_ops`) | Must match bootstrap topic slug |
| `stage` | `s1` `s2` `s3` `s4` `s5` | Pipeline stage where source was captured |
| `type` | see table below | Nature of the source material |
| `YYYYMMDD` | date | Date added |
| `_seq` (optional) | `_01` `_02` … | Disambiguate same-day duplicates |

### Source Type Values

| Type | Meaning |
|---|---|
| `paper` | Academic paper / preprint |
| `note` | Session discussion note |
| `discussion` | Research meeting / conversation log |
| `summary` | Synthesized summary of multiple sources |
| `ref` | External reference or documentation |
| `raw` | Unprocessed capture |
| `draft` | Draft spec or design candidate |
| `approved` | Approved artifact (spec / design) |
| `validation` | Validation or ablation report |

### Examples

| Source Name | Meaning |
|---|---|
| `ai_ops_s1_paper_20260329` | Step 1 paper capture for ai_ops, 2026-03-29 |
| `ai_ops_s2_note_20260329_01` | Step 2 session note, first of day |
| `vision_anomaly_s3_draft_20260330` | Step 3 design draft for vision_anomaly |
| `ai_ops_s4_approved_20260329` | Approved implementation spec |
| `ai_ops_s5_validation_20260330` | Final validation report |

---

## 3. Adding Sources via MCP

### Text source (session note or discussion)

```
mcp_notebooklm_source_add(
  document_id="<notebook_id>",
  source_type="text",
  text="<content>",
  title="<topic>_<stage>_<type>_<YYYYMMDD>"
)
```

### URL source (web paper or reference)

```
mcp_notebooklm_source_add(
  document_id="<notebook_id>",
  source_type="url",
  url="<url>",
  title="<topic>_s1_paper_<YYYYMMDD>"
)
```

### File source (local PDF or document)

```
mcp_notebooklm_source_add(
  document_id="<notebook_id>",
  source_type="file",
  file_path="<absolute_path>",
  title="<topic>_s1_ref_<YYYYMMDD>"
)
```

---

## 4. Querying the Notebook

Use `mcp_notebooklm_notebook_query` at any pipeline step:

```
mcp_notebooklm_notebook_query(
  document_id="<notebook_id>",
  query="What approaches did we consider for <topic>?"
)
```

Cross-notebook query (when multiple topics exist):

```
mcp_notebooklm_cross_notebook_query(
  query="Compare anomaly detection approaches across all topics"
)
```

---

## 5. Source Management Rules

- **Do not rename sources** after adding — notebook queries rely on consistent IDs
- **Do not duplicate** — check `mcp_notebooklm_source_describe` before adding
- **Stage prefix is mandatory** — `s1_` through `s5_` ensures traceability
- **One notebook per topic** — never mix topics in a single notebook
- If a source grows stale, use `mcp_notebooklm_source_delete` and re-add with updated date
