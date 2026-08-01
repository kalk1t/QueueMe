# ADR-0013: Twilio Provider Abstraction and Messaging Lifecycle

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Queue SMS and customer replies depend on external messaging behavior.

## Decision

Use a Twilio adapter with number-assignment service abstraction and callback normalization.

## Alternatives considered

- Hard-coded Twilio client calls from API handlers.
- Vendor-agnostic generic SMS with no provider model.

## Rationale

Adapter centralizes parsing, retry, error translation, and STOP/HELP semantics.

## Positive consequences

- Clean handling of callbacks and delivery receipts.
- Safer testing against provider responses.

## Negative consequences

- Additional contract surface to maintain.

## Security implications

- Webhook signature validation and replay protection required.

## Cost implications

- Ongoing support overhead for template/segment testing.

## Operational implications

- Per-location number lifecycle and rate limit observability required.

## Migration implications

- Adapter can evolve to multi-provider later.

## Reversal strategy

- Roll back number assignment integration while keeping abstraction contracts intact.

## Related PRD requirements

- PRD-SMS-005
- PRD-SMS-006
- PRD-SMS-009

## Related future milestones

- M17
- M18
- M20

## Approval state

Pending product-owner review.
