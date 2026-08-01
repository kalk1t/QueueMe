# ADR-0007: Realtime Revision, Reconnect, and Full Resynchronization

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER
- Related milestone: Milestone 02 - Architecture and Decision Records

## Context

Operators require near-real-time updates while tolerating flaky networks.

## Decision

Use revision-based events with last-seen revision handoff; if event history is unavailable, return full snapshot.

## Alternatives considered

- Event-only without snapshot fallback: high failure risk during reconnect.
- Full polling only: poor concurrent operator experience.

## Rationale

Revision + snapshot approach gives reliability and predictable reconciliation.

## Positive consequences

- Deterministic recovery after stale client sessions.
- Clear conflict indicator and re-sync flow.

## Negative consequences

- Snapshot generation requires operational load planning.

## Security implications

- Snapshot payloads remain location-scoped and minimal.

## Cost implications

- Additional compute for snapshot generation under high churn.

## Operational implications

- Reconnect diagnostics and replay buffer duration become key monitoring points.

## Migration implications

- Backward compatible to future protocol versions with clear message schema versions.

## Reversal strategy

If buffer pressure is too high, shorten event windows and increase snapshot cadence.

## Related PRD requirements

- PRD-STATUS-001
- PRD-QUEUE-008

## Related future milestones

- M29
- M26

## Approval state

Pending product-owner review.
