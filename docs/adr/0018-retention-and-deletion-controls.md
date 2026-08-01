# ADR-0018: Privacy Retention and Deletion Controls

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Release 1 requires explicit retention, especially customer identifiers.

## Decision

Use policy-driven retention jobs with legal and operational override controls; enforce 30-day retention for identifiable names, phone, and custom answers.

## Alternatives considered

- On-demand deletion only without retention jobs.
- Long indefinite retention with manual purges.

## Rationale

Automated retention avoids unbounded growth and policy drift.

## Positive consequences

- Clear compliance posture.
- Lower risk of stale personally identifiable data retention.

## Negative consequences

- Requires scheduled jobs and monitoring.

## Security implications

- Reduces data exposure window.

## Cost implications

- Additional job/storage overhead for retention sweeps.

## Operational implications

- Retention failures must alert and require manual follow-up.

## Migration implications

- Past records can be migrated to retention workflow during phase-in.

## Reversal strategy

- Freeze deletion jobs only with explicit legal review and temporary override.

## Related PRD requirements

- PRD-PRIV-001
- PRD-PRIV-007

## Related future milestones

- M30

## Approval state

Pending product-owner review.
