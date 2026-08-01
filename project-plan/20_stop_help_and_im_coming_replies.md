# Milestone 20 — STOP, HELP, and “I’m Coming” Replies

## Metadata

- **Estimated focused effort:** 5 working days
- **Dependencies:** Milestone 19
- **Release:** Business-Ready Version 1
- **Status:** Not started

## 1. Objective

Process supported inbound SMS replies safely and route them to the correct location and queue entry.

## 2. Business reason

STOP and HELP are essential compliance behavior, while a structured “I’m coming” response improves no-show handling without introducing full two-way chat.

## 3. Starting repository state

Before implementation:

1. Confirm every dependency milestone is accepted, not merely coded.
2. Record the current branch, commit, working-tree status, test status, and deployed environment status.
3. Read `00_locked_product_baseline.md` and verify that this milestone does not change approved product behavior.
4. Identify existing code, migrations, documentation, and provider resources relevant to this milestone.
5. Create a short pre-implementation inventory in the milestone completion report.

## 4. In scope

- Handle STOP, HELP, supported synonyms where provider handles them, and one structured “I’m coming” response.
- Resolve sender number and customer phone to active queue context.
- Record opt-out, send required response, notify staff, and reject unsupported conversation.

## 5. Explicitly out of scope

- Free-form staff chat
- Marketing opt-in
- Voice

## 6. Required deliverables

- Inbound webhook handler
- Reply parser
- Opt-out ledger
- Queue action integration
- Staff notification
- Unsupported-message response

## 7. Architecture and implementation requirements

- Opt-out status applies to the appropriate sender/recipient scope required by the provider and policy.
- Do not guess queue entry when multiple active matches exist; require deterministic resolution.

General requirements:

- Preserve strict organization and location tenant isolation.
- Keep server-side authorization and entitlement checks authoritative.
- Use idempotency for retried commands, jobs, webhooks, and billing operations.
- Record audit evidence for security-sensitive, billing-sensitive, and queue-order-sensitive actions.
- Do not hide external/manual blockers behind a successful code build.

## 8. Database and data-lifecycle changes

- Inbound message, parsed command, opt-out state, linked queue entry, action result.

Every schema change must include:

- Forward migration.
- Rollback or documented non-destructive recovery strategy.
- Index and constraint review.
- Tenant-ownership review.
- Retention and deletion classification.
- Seed or fixture updates when relevant.

## 9. API and event-contract changes

- Provider inbound webhook and internal diagnostics.

API requirements:

- Version contracts when a breaking change is unavoidable.
- Validate all input server-side.
- Return stable machine-readable error codes.
- Add idempotency keys to retryable mutations where relevant.
- Document WebSocket, background-job, and provider-event behavior.

## 10. Android changes

- Show “I’m coming” status to staff.

## 11. Web changes

- Customer status may reflect accepted extension/arrival intent.

## 12. Infrastructure and operations changes

- Inbound webhook alarms and dead-letter handling.

## 13. Security and privacy requirements

- Signature validation, rate limits, message-content minimization, and command-only behavior.

Also verify:

- No secret, access token, payment credential, or provider credential enters source control or logs.
- Cross-tenant access is denied and tested.
- Personal data collection remains within the locked baseline.
- Customer phone numbers are not repurposed for marketing.
- Audit records are immutable or tamper-evident within the application’s trust model.

## 14. Automated tests

- STOP prevents subsequent queue notifications.
- HELP response.
- I’m-coming routing.
- Ambiguous queue matches.
- Unsupported content.
- Duplicate inbound webhook.

Minimum quality gate:

- Existing tests remain green.
- New behavior has unit and integration coverage appropriate to its risk.
- Failure, retry, duplicate, and unauthorized paths are tested where relevant.
- Tests run in CI and locally with exact commands recorded.

## 15. Manual verification

- Test replies from real phones to dedicated pilot numbers.

Manual verification must record:

- Date and environment.
- Tester.
- Exact steps.
- Expected and actual result.
- Screenshots, logs, provider records, or other evidence when useful.

## 16. Observability

Add or update, as relevant:

- Structured logs with correlation identifiers.
- Metrics for success, failure, latency, retries, and limits.
- Alerts for release-critical failure modes.
- Administrator diagnostics that do not expose secrets or unrelated tenant data.
- Runbook steps for common failures.

## 17. Migration and rollback

Before deployment, document:

1. Deployment order.
2. Required environment variables and secrets.
3. Database migration order.
4. Compatibility with the currently deployed Android and web clients.
5. Rollback trigger conditions.
6. Rollback or forward-fix procedure.
7. Data-reconciliation steps after partial provider or billing failure.

## 18. Required documentation

Update all relevant:

- Architecture decisions.
- API contracts.
- Database dictionary.
- Environment setup.
- Operator and administrator runbooks.
- Business-owner help text.
- Privacy, consent, billing, or support text affected by this milestone.

## 19. Acceptance criteria

- STOP suppresses non-required future messages.
- HELP returns correct support information.
- I’m-coming updates only the correct active queue entry.
- Unsupported messages do not create an open conversation.

The milestone must not be marked complete until every criterion has direct evidence.

## 20. Completion evidence

- Inbound test transcripts
- Opt-out records
- Android staff status screenshots
- Webhook logs

The final completion report must also include:

- Commit hashes.
- Clean working-tree confirmation.
- CI run links or identifiers.
- Test commands and exact pass/fail counts.
- Remaining manual or external blockers.
- Explicit final status: `COMPLETE`, `BLOCKED`, or `INCOMPLETE`.

## 21. Codex execution prompt

```text
You are implementing Milestone 20: STOP, HELP, and “I’m Coming” Replies for the Walk-In Queue Manager project.

Primary objective:
Process supported inbound SMS replies safely and route them to the correct location and queue entry.

Required dependencies:
Milestone 19

Read first:
- 00_locked_product_baseline.md
- README.md
- ROADMAP.md
- Every dependency milestone file
- Existing repository documentation and source code

Required scope:
- Handle STOP, HELP, supported synonyms where provider handles them, and one structured “I’m coming” response.
- Resolve sender number and customer phone to active queue context.
- Record opt-out, send required response, notify staff, and reject unsupported conversation.

Expected deliverables:
- Inbound webhook handler
- Reply parser
- Opt-out ledger
- Queue action integration
- Staff notification
- Unsupported-message response

Acceptance criteria:
- STOP suppresses non-required future messages.
- HELP returns correct support information.
- I’m-coming updates only the correct active queue entry.
- Unsupported messages do not create an open conversation.

Execution rules:
- Read the locked product baseline and all dependency milestone files before modifying code.
- Inspect the repository and document the current state before implementation.
- Do not implement out-of-scope features or silently change approved product behavior.
- Prefer small, reviewable commits with descriptive messages.
- Add or update automated tests for every behavior changed.
- Keep tenant isolation, idempotency, auditability, billing traceability, and rollback safety explicit.
- Update documentation and completion evidence before declaring the milestone complete.
- Do not mark the milestone complete when manual verification or external evidence is still pending.

At completion, produce a milestone completion report containing:
1. Repository state and branch/commit information.
2. Files changed and why.
3. Architecture and schema decisions made.
4. Automated tests executed with exact results.
5. Manual verification completed or still pending.
6. Security, privacy, billing, and tenant-isolation checks relevant to this milestone.
7. Migration and rollback instructions.
8. Remaining risks or blockers.
9. Evidence proving every acceptance criterion.
10. A clear final status: COMPLETE, BLOCKED, or INCOMPLETE.
```
