# Milestone 11 — Stripe Monthly, Annual, and Trial Billing

## Metadata

- **Estimated focused effort:** 6 working days
- **Dependencies:** Milestone 10
- **Release:** Business-Ready Version 1
- **Status:** Not started

## 1. Objective

Implement fixed software subscription billing, checkout, trials, renewals, cancellations, invoices, and webhook-driven synchronization.

## 2. Business reason

The product must reliably collect $39.99 monthly or $399.99 annually per location while requiring a payment method and supporting administrator-approved trials.

## 3. Starting repository state

Before implementation:

1. Confirm every dependency milestone is accepted, not merely coded.
2. Record the current branch, commit, working-tree status, test status, and deployed environment status.
3. Read `00_locked_product_baseline.md` and verify that this milestone does not change approved product behavior.
4. Identify existing code, migrations, documentation, and provider resources relevant to this milestone.
5. Create a short pre-implementation inventory in the milestone completion report.

## 4. In scope

- Create Stripe products/prices and customer records.
- Implement Checkout, billing portal, 14-day trial, payment-method requirement, renewal, cancellation, refunds, and webhook processing.
- Map subscriptions to locations.

## 5. Explicitly out of scope

- SMS metering
- Spending limits
- Tax automation beyond baseline configuration

## 6. Required deliverables

- Stripe integration
- Webhook endpoint
- Billing portal flow
- Invoice synchronization
- Reconciliation command
- Billing documentation

## 7. Architecture and implementation requirements

- Stripe is the payment processor; local database is the application entitlement source synchronized by signed webhooks.
- All webhook events are idempotent and order-tolerant.

General requirements:

- Preserve strict organization and location tenant isolation.
- Keep server-side authorization and entitlement checks authoritative.
- Use idempotency for retried commands, jobs, webhooks, and billing operations.
- Record audit evidence for security-sensitive, billing-sensitive, and queue-order-sensitive actions.
- Do not hide external/manual blockers behind a successful code build.

## 8. Database and data-lifecycle changes

- Stripe customer, subscription, price, invoice, payment-intent references and event-processing ledger.

Every schema change must include:

- Forward migration.
- Rollback or documented non-destructive recovery strategy.
- Index and constraint review.
- Tenant-ownership review.
- Retention and deletion classification.
- Seed or fixture updates when relevant.

## 9. API and event-contract changes

- Create checkout, open portal, get billing status, cancel/renew actions where allowed, webhook.

API requirements:

- Version contracts when a breaking change is unavoidable.
- Validate all input server-side.
- Return stable machine-readable error codes.
- Add idempotency keys to retryable mutations where relevant.
- Document WebSocket, background-job, and provider-event behavior.

## 10. Android changes

- Read-only billing status and instruction to manage billing on website.

## 11. Web changes

- Plan selection, checkout return, invoice list, billing portal link.

## 12. Infrastructure and operations changes

- Stripe secrets and webhook signing secrets per environment.

## 13. Security and privacy requirements

- Verify signatures, store event IDs, prevent client-supplied prices, restrict billing portal ownership.

Also verify:

- No secret, access token, payment credential, or provider credential enters source control or logs.
- Cross-tenant access is denied and tested.
- Personal data collection remains within the locked baseline.
- Customer phone numbers are not repurposed for marketing.
- Audit records are immutable or tamper-evident within the application’s trust model.

## 14. Automated tests

- Webhook duplication and out-of-order tests.
- Trial conversion.
- Monthly and annual renewal.
- Cancellation at period end and immediate cancellation policy.
- Payment failure.

Minimum quality gate:

- Existing tests remain green.
- New behavior has unit and integration coverage appropriate to its risk.
- Failure, retry, duplicate, and unauthorized paths are tested where relevant.
- Tests run in CI and locally with exact commands recorded.

## 15. Manual verification

- Configure Stripe account, business identity, statement descriptor, products, prices, webhook endpoints, and test clocks.

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

- Monthly and annual subscriptions activate only the intended location.
- Trial begins only after administrator approval and payment method availability.
- Duplicate webhooks do not duplicate state.
- Invoices appear in the owner portal.

The milestone must not be marked complete until every criterion has direct evidence.

## 20. Completion evidence

- Stripe test-clock scenarios
- Webhook ledger
- Invoice screenshots
- Reconciliation report

The final completion report must also include:

- Commit hashes.
- Clean working-tree confirmation.
- CI run links or identifiers.
- Test commands and exact pass/fail counts.
- Remaining manual or external blockers.
- Explicit final status: `COMPLETE`, `BLOCKED`, or `INCOMPLETE`.

## 21. Codex execution prompt

```text
You are implementing Milestone 11: Stripe Monthly, Annual, and Trial Billing for the Walk-In Queue Manager project.

Primary objective:
Implement fixed software subscription billing, checkout, trials, renewals, cancellations, invoices, and webhook-driven synchronization.

Required dependencies:
Milestone 10

Read first:
- 00_locked_product_baseline.md
- README.md
- ROADMAP.md
- Every dependency milestone file
- Existing repository documentation and source code

Required scope:
- Create Stripe products/prices and customer records.
- Implement Checkout, billing portal, 14-day trial, payment-method requirement, renewal, cancellation, refunds, and webhook processing.
- Map subscriptions to locations.

Expected deliverables:
- Stripe integration
- Webhook endpoint
- Billing portal flow
- Invoice synchronization
- Reconciliation command
- Billing documentation

Acceptance criteria:
- Monthly and annual subscriptions activate only the intended location.
- Trial begins only after administrator approval and payment method availability.
- Duplicate webhooks do not duplicate state.
- Invoices appear in the owner portal.

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
