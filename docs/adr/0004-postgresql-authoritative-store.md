# ADR-0004: PostgreSQL as Authoritative Transactional Store

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER
- Related milestone: Milestone 02 - Architecture and Decision Records

## Context

The project requires transactional integrity for queue ordering, billing, consent, and audit events.

## Decision

Use PostgreSQL as the single authoritative persistent store for all durable business and entitlement data.

## Alternatives considered

- NoSQL primary store: high-scale advantages, weaker transactional guarantees for ordering.
- Multiple DBs per domain: early complexity and join/cross-domain consistency risk.

## Rationale

Need strong ACID properties for state transitions and audit immutability within domain constraints.

## Positive consequences

- Strong transactions and constraints.
- Mature tooling for snapshots/backups.

## Negative consequences

- Requires disciplined schema design for high-write workloads.

## Security implications

- Central access point for sensitive customer and financial data needs hardened IAM and audit.

## Cost implications

- Managed PostgreSQL costs acceptable for Release 1 scale targets.

## Operational implications

- Requires backup, PITR, and retention management.

## Migration implications

- Future read replicas and read-optimized schemas can be introduced without changing authority.

## Reversal strategy

Could migrate to distributed SQL only if scale or compliance requirements demand it.

## Related PRD requirements

- PRD-PRIV-001
- PRD-SEC-001
- PRD-AUDIT-001

## Related future milestones

- M06
- M10

## Approval state

Pending product-owner review.
