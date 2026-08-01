# Milestone 01 — Product Specification Lock

## Metadata

- **Estimated focused effort:** 3 working days
- **Dependencies:** None
- **Release:** Business-Ready Version 1
- **Status:** Not started

## 1. Objective

Convert every approved product decision into a versioned, testable product specification that becomes the sole functional source of truth for Release 1.

## 2. Business reason

Implementation must not depend on conversational context or ambiguous assumptions. A locked specification prevents scope drift and contradictory behavior across Android, web, billing, queue, and messaging components.

## 3. Starting repository state

Before implementation:

1. Confirm every dependency milestone is accepted, not merely coded.
2. Record the current branch, commit, working-tree status, test status, and deployed environment status.
3. Read `00_locked_product_baseline.md` and verify that this milestone does not change approved product behavior.
4. Identify existing code, migrations, documentation, and provider resources relevant to this milestone.
5. Create a short pre-implementation inventory in the milestone completion report.

## 4. In scope

- Create a complete Release 1 product requirements document.
- Define all actors, roles, permissions, workflows, states, limits, prices, billing cycles, retention rules, and exclusions.
- Define the lifecycle of organizations, locations, subscriptions, trials, messaging numbers, queues, and queue entries.
- Define success metrics and the release-level definition of done.
- Create a requirements traceability matrix mapping each locked decision to later milestones and acceptance tests.

## 5. Explicitly out of scope

- Application code
- Database migrations
- Provider integrations
- Visual design implementation

## 6. Required deliverables

- docs/product/release-1-specification.md
- docs/product/requirements-traceability.md
- docs/product/glossary.md
- docs/product/release-1-out-of-scope.md
- Versioned approval record

## 7. Architecture and implementation requirements

- Treat this specification as normative. Later architecture decisions may refine implementation but may not silently change product behavior.
- Assign stable requirement identifiers such as PRD-BILL-001 and PRD-QUEUE-001.

General requirements:

- Preserve strict organization and location tenant isolation.
- Keep server-side authorization and entitlement checks authoritative.
- Use idempotency for retried commands, jobs, webhooks, and billing operations.
- Record audit evidence for security-sensitive, billing-sensitive, and queue-order-sensitive actions.
- Do not hide external/manual blockers behind a successful code build.

## 8. Database and data-lifecycle changes

- No production schema changes. Define conceptual entities and retention classifications.

Every schema change must include:

- Forward migration.
- Rollback or documented non-destructive recovery strategy.
- Index and constraint review.
- Tenant-ownership review.
- Retention and deletion classification.
- Seed or fixture updates when relevant.

## 9. API and event-contract changes

- No endpoints. Define required capabilities and actor permissions.

API requirements:

- Version contracts when a breaking change is unavoidable.
- Validate all input server-side.
- Return stable machine-readable error codes.
- Add idempotency keys to retryable mutations where relevant.
- Document WebSocket, background-job, and provider-event behavior.

## 10. Android changes

- Define screen inventory and role-specific actions without implementing screens.

## 11. Web changes

- Define customer, business-owner, and administrator journeys.

## 12. Infrastructure and operations changes

- Define environment classes and release evidence expectations.

## 13. Security and privacy requirements

- Classify personal data and prohibited custom-question content.
- Document tenant isolation as a non-negotiable requirement.

Also verify:

- No secret, access token, payment credential, or provider credential enters source control or logs.
- Cross-tenant access is denied and tested.
- Personal data collection remains within the locked baseline.
- Customer phone numbers are not repurposed for marketing.
- Audit records are immutable or tamper-evident within the application’s trust model.

## 14. Automated tests

- Review every approved answer against the PRD.
- Run a requirements consistency checklist.
- Confirm each requirement has a measurable acceptance condition.

Minimum quality gate:

- Existing tests remain green.
- New behavior has unit and integration coverage appropriate to its risk.
- Failure, retry, duplicate, and unauthorized paths are tested where relevant.
- Tests run in CI and locally with exact commands recorded.

## 15. Manual verification

- Product owner reads and approves the complete specification.
- Resolve any contradiction before marking complete.

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

- All locked decisions appear exactly once as authoritative requirements.
- Every requirement is testable and assigned to a future milestone.
- No unresolved TBD blocks implementation.
- The product owner approves the versioned specification.

The milestone must not be marked complete until every criterion has direct evidence.

## 20. Completion evidence

- Approved PRD commit
- Traceability matrix
- Decision log
- Clean repository status

The final completion report must also include:

- Commit hashes.
- Clean working-tree confirmation.
- CI run links or identifiers.
- Test commands and exact pass/fail counts.
- Remaining manual or external blockers.
- Explicit final status: `COMPLETE`, `BLOCKED`, or `INCOMPLETE`.

## 21. Codex execution prompt

```text
You are implementing Milestone 1: Product Specification Lock for the Walk-In Queue Manager project.

Primary objective:
Convert every approved product decision into a versioned, testable product specification that becomes the sole functional source of truth for Release 1.

Required dependencies:
None

Read first:
- 00_locked_product_baseline.md
- README.md
- ROADMAP.md
- Every dependency milestone file
- Existing repository documentation and source code

Required scope:
- Create a complete Release 1 product requirements document.
- Define all actors, roles, permissions, workflows, states, limits, prices, billing cycles, retention rules, and exclusions.
- Define the lifecycle of organizations, locations, subscriptions, trials, messaging numbers, queues, and queue entries.
- Define success metrics and the release-level definition of done.
- Create a requirements traceability matrix mapping each locked decision to later milestones and acceptance tests.

Expected deliverables:
- docs/product/release-1-specification.md
- docs/product/requirements-traceability.md
- docs/product/glossary.md
- docs/product/release-1-out-of-scope.md
- Versioned approval record

Acceptance criteria:
- All locked decisions appear exactly once as authoritative requirements.
- Every requirement is testable and assigned to a future milestone.
- No unresolved TBD blocks implementation.
- The product owner approves the versioned specification.

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
