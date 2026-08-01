# ADR-0012: Stripe Provider Abstraction and Billing Adapter

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Billing behavior spans trials, subscriptions, overages, and dunning states.

## Decision

Introduce provider abstraction layer for Stripe, with normalized domain objects and adapter-based webhook handling.

## Alternatives considered

- Direct Stripe SDK usage across all services: hard to test and replace.
- Offline billing calculations: breaks operational consistency.

## Rationale

Adapter layer reduces provider coupling and supports retries/reconciliation.

## Positive consequences

- Clear provider boundary and easier simulation.
- Centralized reconciliation logic.

## Negative consequences

- More plumbing for onboarding and testing.

## Security implications

- Webhook signature, replay protection, and secret rotation required.

## Cost implications

- SDK or integration support overhead per lifecycle.

## Operational implications

- Need webhook reconciliation jobs and event ordering handling.

## Migration implications

- Supports future provider alternatives.

## Reversal strategy

- Replace provider adapter with alternate vendor behind stable internal interfaces.

## Related PRD requirements

- PRD-SUB-004
- PRD-SUB-001
- PRD-SUB-002

## Related future milestones

- M11
- M14

## Approval state

Pending product-owner review.
