# ADR-0006: REST vs WebSocket Responsibility Split

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER
- Related milestone: Milestone 02 - Architecture and Decision Records

## Context

Queue operations need durable mutations and low-latency visibility across clients.

## Decision

Use REST for all command validation/state mutation and snapshots; WebSocket for event propagation and incremental updates only.

## Alternatives considered

- Event-driven full command path over WebSocket: increases complexity in authorization and replay handling.
- Poll-only architecture: simpler but poor user experience for active operator work.

## Rationale

This split aligns with authoritative backend requirement and resilient reconnection.

## Positive consequences

- Consistent validation location.
- Deterministic recovery on reconnection.

## Negative consequences

- More endpoint surface area to maintain.

## Security implications

- Authorization enforced at REST boundary, not transport.

## Cost implications

- Moderate operations overhead for websocket infrastructure.

## Operational implications

- Requires snapshot fallback mechanism and revision tracking.

## Migration implications

- API clients can be versioned independently from websocket protocol updates.

## Reversal strategy

Can switch to Event Sourcing transport in future while keeping REST state boundary.

## Related PRD requirements

- PRD-QUEUE-008
- PRD-QUEUE-009

## Related future milestones

- M29
- M30

## Approval state

Pending product-owner review.
