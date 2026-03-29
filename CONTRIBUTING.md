# Contributing

## Workflow
1. Create/update artifacts using the generic pipeline.
2. Keep draft/approved states explicit.
3. Update approval registry before implementation/completion.
4. Run gate checks locally before PR:
   - `scripts/pipeline_gate_check.sh pre-implement <topic_slug>`
   - `scripts/pipeline_gate_check.sh pre-complete <topic_slug>`

## Pull Requests
- Include summary of changed artifacts.
- Include validation report or explain why not applicable.
- Ensure CI gate workflow passes.
