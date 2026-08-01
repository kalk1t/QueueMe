# ADR-0022: AWS Deployment Baseline

## Meta

- Status: ACCEPTED
- Date: 2026-08-01
- Approval state: PENDING_PRODUCT_OWNER

## Context

Roadmap recommends AWS for Release 1 deployment baseline.

## Decision

Adopt AWS-hosted deployment topology as baseline proposal: managed relational DB, managed cache, queueing service, and observability integration.

## Alternatives considered

- Self-hosted VM model.
- Full managed serverless from day one.

## Rationale

AWS baseline balances support and predictable operational primitives for relational workloads.

## Positive consequences

- Mature managed services and operational practices.
- Clear separation of env-specific resources.

## Negative consequences

- Cloud lock-in risk and account ownership requirements.

## Security implications

- IAM and network segmentation essential.

## Cost implications

- Initial infra costs and operational expertise required.

## Operational implications

- Requires deployment path with DR and restore strategies.

## Migration implications

- Multi-region later can be introduced with replication strategy.

## Reversal strategy

- If AWS not approved, migrate deployment modules to equivalent provider services with contract-preserving endpoints.

## Related PRD requirements

- PRD-WEB-001

## Related future milestones

- M05

## Approval state

Pending product-owner review.
