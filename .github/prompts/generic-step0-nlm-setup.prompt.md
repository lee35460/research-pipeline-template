---
name: "Step 0 — NotebookLM Notebook Setup"
description: "Set up or link a NotebookLM notebook for a new or existing research topic."
---

# Step 0 — NotebookLM Notebook Setup

Use this slash prompt at the START of any new research topic, or when you need to
connect an existing NotebookLM notebook created on notebooklm.google.com.

---

## Instructions

### A — New Topic (No Existing Notebook)

1. Confirm the topic slug (must match `[a-z0-9_-]+`).
   If not yet bootstrapped, run first:
   ```
   scripts/bootstrap_domain.sh <topic_slug>
   ```

2. Create a new NotebookLM notebook via MCP:
   ```
   mcp_notebooklm_notebook_create(name="<topic_slug> Research Notebook")
   ```
   → Copy the returned `notebook_id`.

3. Register in `.agents/workflows/generic/notebooklm_notebook_registry.md`:
   ```
   | `<topic_slug>` | `<notebook_id>` | — | YYYY-MM-DD | active | |
   ```

4. Confirm source naming convention is understood:
   → See `.agents/workflows/generic/notebooklm_source_conventions.md`
   → Format: `<topic>_<stage>_<type>_<YYYYMMDD>`

5. Proceed to Step 1 (Knowledge Capture).

---

### B — Existing Notebook (Created via notebooklm.google.com)

1. Open your notebook at: `https://notebooklm.google.com`
2. Copy the notebook ID from the browser URL:
   ```
   https://notebooklm.google.com/notebook/<NOTEBOOK_ID>
   ```

3. Verify the notebook is accessible via MCP:
   ```
   mcp_notebooklm_notebook_get(document_id="<NOTEBOOK_ID>")
   ```
   → If this fails, ensure you are logged in with the correct Google account.
   → Run `nlm login` in terminal if authentication is needed.

4. Optionally list existing sources to understand what's already there:
   ```
   mcp_notebooklm_notebook_describe(document_id="<NOTEBOOK_ID>")
   ```

5. Register in `.agents/workflows/generic/notebooklm_notebook_registry.md`:
   ```
   | `<topic_slug>` | `<NOTEBOOK_ID>` | https://notebooklm.google.com/notebook/<NOTEBOOK_ID> | YYYY-MM-DD | active | linked from web |
   ```

6. Confirm source naming convention for any future sources:
   → Format: `<topic>_<stage>_<type>_<YYYYMMDD>`
   → Existing sources in the web notebook do NOT need to be renamed,
     but all NEW sources added through this pipeline MUST follow the convention.

7. Proceed to Step 1 (Knowledge Capture).

---

## Checklist

- [ ] Topic slug is valid (`[a-z0-9_-]+`)
- [ ] Notebook is created or linked (notebook_id recorded)
- [ ] `notebooklm_notebook_registry.md` updated
- [ ] Source naming convention understood (`<topic>_<stage>_<type>_<YYYYMMDD>`)
- [ ] Ready to proceed to `/generic-step1-capture`
