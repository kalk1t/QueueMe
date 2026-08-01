# ADR-0010: Transactional Outbox and Inbound Event Inbox

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Asynchronous side-effects must not produce lost updates or duplicate events.

## Decision

Use database transactional outbox for outbound notifications/events and provider-event inbox tables for inbound webhooks.

## Alternatives considered

- Direct API calls in transaction scope: can lose events on restart.
- Pure queue-first without persistence: higher event-loss risk.

## Rationale

Outbox+inbox yields consistent eventing and replay-safe semantics.

## Positive consequences

- Durable event record and deterministic recovery.
- Simplifies audits and debugging.

## Negative consequences

- Requires worker polling and cleanup.

## Security implications

- Provider events validated once before entering inbox.

## Cost implications

- Additional table and processing overhead.

## Operational implications

- Need monitoring for backlog growth and processing age.

## Migration implications

- Can migrate event payload versions alongside schema migrations.

## Reversal strategy

- If complexity is unacceptable, switch to broker-native transaction integration later.

## Related PRD requirements

- PRD-AUDIT-001
- PRD-SEC-001

## Related future milestones

- M11
- M19

## Approval state

Pending product-owner review.
