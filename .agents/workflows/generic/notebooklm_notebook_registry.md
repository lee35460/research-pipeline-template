# NotebookLM Notebook Registry

This file maps each research topic to its dedicated NotebookLM notebook.
Update this file whenever a new topic notebook is created or linked.

## Registry

| topic | notebook_id | notebook_url | linked_at | status | notes |
|---|---|---|---|---|---|
| `toy_topic` | `demo_placeholder_id` | — | 2026-03-29 | demo | Replace with real notebook_id |

---

## How to Register a Notebook

### New notebook (created via MCP)

After running Step 0 prompt or `mcp_notebooklm_notebook_create`:

```
| `<topic>` | `<returned_notebook_id>` | — | YYYY-MM-DD | active | |
```

### Existing notebook (created via notebooklm.google.com)

Get the ID from the URL: `https://notebooklm.google.com/notebook/<NOTEBOOK_ID>`

```
| `<topic>` | `<notebook_id_from_url>` | https://notebooklm.google.com/notebook/<NOTEBOOK_ID> | YYYY-MM-DD | active | linked from web |
```

---

## Status Values

| Status | Meaning |
|---|---|
| `active` | In use — sources are being added / queried |
| `archived` | Topic complete, notebook preserved for reference |
| `demo` | Placeholder row — replace before use |
| `draft` | Notebook created but not yet populated |
