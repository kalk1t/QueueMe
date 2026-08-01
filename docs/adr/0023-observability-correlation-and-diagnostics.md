# ADR-0023: Observability, Correlation IDs, and Diagnostics

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Troubleshooting concurrency, billing, and provider incidents requires cross-layer traceability.

## Decision

Mandate correlation and causation IDs across API, jobs, and webhooks; centralize required metrics and operational alerts.

## Alternatives considered

- Minimal logging without correlation.
- Vendor logs without standardized fields.

## Rationale

Cross-service traceability lowers MTTR and improves audit quality.

## Positive consequences

- Faster incident diagnosis.
- Better reconciliation of failed jobs and webhooks.

## Negative consequences

- Additional logging discipline and schema governance.

## Security implications

- Mask sensitive customer data and provider credentials.

## Cost implications

- Observability tooling and storage costs increase.

## Operational implications

- SRE process must include correlation-based runbook patterns.

## Migration implications

- Standard fields become part of API contracts and wrappers.

## Reversal strategy

- Remove non-critical metrics if cost constrained; keep identifiers mandatory.

## Related PRD requirements

- PRD-AUDIT-001
- PRD-PRIV-006

## Related future milestones

- M04

## Approval state

Pending product-owner review.
