# NotebookLM Source Naming Conventions

## Convention Format

```
<topic>_<stage>_<type>_<YYYYMMDD>[_<seq>]
```

All sources added to any NotebookLM notebook in this pipeline MUST follow this format.

---

## Field Reference

| Field | Format | Required | Example |
|---|---|---|---|
| `topic` | `[a-z0-9_-]+` | Yes | `ai_ops`, `vision_anomaly` |
| `stage` | `s1`–`s5` | Yes | `s1`, `s3` |
| `type` | see table below | Yes | `paper`, `note` |
| `YYYYMMDD` | `20260329` | Yes | `20260329` |
| `_seq` | `_01`, `_02`, … | Only if duplicates exist | `_02` |

---

## Stage Codes

| Code | Pipeline Step | Description |
|---|---|---|
| `s1` | Step 1 — Knowledge Capture | Sources gathered in raw capture phase |
| `s2` | Step 2 — NotebookLM Storage | Notes created during storage/organization |
| `s3` | Step 3 — Structuring | Structured summaries, design candidates |
| `s4` | Step 4 — Implementation Spec | Spec drafts and approved spec |
| `s5` | Step 5 — Validation | Validation reports, ablation results |

---

## Source Type Codes

| Type | Meaning | Typical Stage |
|---|---|---|
| `paper` | Academic paper or preprint | `s1` |
| `ref` | Technical reference, documentation, blog | `s1` |
| `raw` | Unprocessed capture or dump | `s1` |
| `note` | Session note or working memo | `s1`–`s5` |
| `discussion` | Research meeting log or Q&A transcript | `s1`–`s3` |
| `summary` | Synthesized summary of multiple inputs | `s2`–`s3` |
| `draft` | Draft spec or design candidate | `s3`–`s4` |
| `approved` | Approved implementation spec | `s4` |
| `validation` | Validation or ablation report | `s5` |

---

## Examples

| Source Name | Interpretation |
|---|---|
| `ai_ops_s1_paper_20260329` | ai_ops topic, Step 1, paper, 2026-03-29 |
| `ai_ops_s1_paper_20260329_02` | Same topic/stage/type/date, second source |
| `vision_anomaly_s2_note_20260330` | vision_anomaly topic, Step 2 storage note |
| `ai_ops_s3_draft_20260329` | Step 3 design candidate draft |
| `ai_ops_s4_approved_20260329` | Approved implementation spec |
| `ai_ops_s5_validation_20260330` | Final validation report |

---

## Rules

1. **Never skip the stage prefix** — `s1_`–`s5_` is mandatory for traceability
2. **Never mix topics** in one notebook — one notebook per topic slug
3. **Do not rename sources** after adding — rely on consistent IDs for notebook queries
4. **Check before adding** — use `mcp_notebooklm_source_describe` to avoid duplicates
5. **Use `_seq` suffix** on the same day when adding multiple sources of the same type

---

## Quick Add Checklist

Before adding any source to NotebookLM:

- [ ] Correct `topic` slug matches bootstrap and registry
- [ ] Correct `stage` code (`s1`–`s5`) matches current pipeline step
- [ ] Correct `type` code from the table above
- [ ] Date is today in `YYYYMMDD` format
- [ ] No duplicate exists in the notebook already
- [ ] Source name does not contain spaces or uppercase letters
