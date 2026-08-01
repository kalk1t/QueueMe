# ADR-0011: Idempotency-Key Semantics

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Network retries and duplicate submits are expected for operator and webhook workflows.

## Decision

Require idempotency keys for selected mutations and provider-triggered operations with strict fingerprint conflict checks.

## Alternatives considered

- No idempotency except unique DB constraints: weak against timing replay.
- Full global dedupe everywhere: complexity and unnecessary storage.

## Rationale

Targeted idempotency balances safety and storage cost.

## Positive consequences

- Prevents duplicate SMS charges and duplicate queue transitions.
- Better user experience for flaky networks.

## Negative consequences

- Need storage and conflict telemetry.

## Security implications

- Replay attempts become detectable.

## Cost implications

- Additional storage/index overhead.

## Operational implications

- Must document TTL and conflict policies.

## Migration implications

- Existing endpoints can opt in incrementally.

## Reversal strategy

- Disable for non-risky operations without affecting critical commands.

## Related PRD requirements

- PRD-CHECKIN-003
- PRD-QUEUE-008

## Related future milestones

- M10
- M29

## Approval state

Pending product-owner review.
