# QueueMe Architecture Documentation

Milestone 02 defines the production architecture before feature implementation starts.

## Purpose

- Document trusted boundaries for QueueMe Release 1.
- Define authoritative backend responsibilities.
- Capture tenant and location isolation, concurrency, idempotency, provider abstraction, and operations strategy.
- Provide acceptance evidence for architecture review.

## Document set

### Context and boundaries

- [System context](system-context.md)
- [Component model](component-model.md)
- [Repository topology](repository-topology.md)
- [Deployment model](deployment-model.md)
- [Data flow](data-flow.md)

### Domain decisions

- [Tenant isolation model](tenant-isolation-model.md)
- [Transaction and concurrency model](transaction-and-concurrency-model.md)
- [Background jobs and idempotency](background-jobs-and-idempotency.md)
- [Provider contract and messaging/billing strategy](api-and-event-contracts.md)
- [Data lifecycle and retention](data-lifecycle-and-retention.md)
- [Failure-mode analysis](failure-mode-analysis.md)
- [Threat model](../security/milestone-02-threat-model.md)
- [Observability and operations](observability-and-operations.md)

### Milestone artifacts

- [Architecture requirements mapping](requirements-mapping.md)
- [Architecture review checklist](architecture-review-checklist.md)
- [Review record](review-record.md)

## ADR index

ADR documents are stored under `docs/adr/` and track irreversible technical decisions.

## Status

- Milestone: Architecture and Decision Records
- Current result: documentation complete and under acceptance review.
- No production account resources or application framework initialization is introduced in this milestone.
