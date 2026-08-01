# AGENTS.md

QueueMe governance for future Codex sessions.

This file is mandatory and does not override the locked product baseline or active milestone acceptance criteria.

## Session startup requirements

- Read `project-plan/00_locked_product_baseline.md` before implementation.
- Read `project-plan/ROADMAP.md` before implementation.
- Read the active milestone file in `project-plan/` before implementation.
- Read all dependency completion reports in `docs/project-status/milestone-reports/`.

## Git hygiene requirements

- Inspect repository status before editing:
  - `git status --short`
  - `git branch --show-current`
  - `git status --porcelain` (or equivalent clean-state check) before finalizing.
- Include branch name, commit hash, and working-tree state in milestone notes.
- Record test command and result context when milestones are modified.
- Keep a local branch strategy aligned to the active milestone and create only milestone-scoped changes.

## Milestone discipline

- Implement only the active milestone unless explicitly authorized to do otherwise.
- Do not skip acceptance evidence.
- Do not mark a milestone complete until every required acceptance condition and evidence exists.
- Never claim completion when manual blockers remain unresolved.
- Add `COMPLETE`, `BLOCKED`, or `INCOMPLETE` to milestone evidence with supporting detail.

## Core platform rules

- Backend state is authoritative.
- Preserve strict tenant and location isolation across all state transitions.
- Preserve billing traceability for every charging event and entitlement decision.
- Use idempotency for retried commands, jobs, webhooks, and billing operations.
- Preserve queue-order auditability for all queue mutations.

## Safety and confidentiality

- Never commit secrets or customer personal data.
- Keep secrets out of docs, scripts, tests, and sample fixtures.
- Never commit production credentials or exports.

## Work quality

- Add tests and documentation for changed behavior.
- Keep changes scoped to active milestone intent.
- Avoid silent deferred-feature additions.
- Record manual or external blockers honestly.
- Do not introduce hidden framework assumptions before their milestone.
