# Architecture Decision Records

This directory stores all Milestone 02 decision records.

## Status

- Each ADR includes status, rationale, alternatives, and implementation implications.
- Approval status can be `PENDING_PRODUCT_OWNER` until milestone acceptance.

## ADR index

- [ADR-0000: Template](0000-adr-template.md)
- [ADR-0001: Monorepo Topology and Source Ownership](0001-monorepo-topology-and-source-ownership.md)
- [ADR-0002: Modular-Monolith-First Backend Architecture](0002-modular-monolith-first-backend-architecture.md)
- [ADR-0003: Backend as Sole Authoritative State Owner](0003-backend-authority-for-queue-and-entitlement.md)
- [ADR-0004: PostgreSQL as Authoritative Store](0004-postgresql-authoritative-store.md)
- [ADR-0005: Redis Responsibilities and Non-authoritative Role](0005-redis-boundaries-and-non-authoritative-role.md)
- [ADR-0006: REST vs WebSocket Responsibilities](0006-rest-vs-websocket-responsibilities.md)
- [ADR-0007: Realtime Revision, Reconnect, and Full Resynchronization](0007-realtime-revision-and-resync.md)
- [ADR-0008: Queue Concurrency, Stale-Write Detection, and Call-Next Conflict Control](0008-queue-concurrency-and-cas-controls.md)
- [ADR-0009: Durable Jobs and Retry Policy](0009-durable-jobs-and-retry-policy.md)
- [ADR-0010: Transactional Outbox and Inbound Event Inbox](0010-transactional-outbox-inbox-strategy.md)
- [ADR-0011: Idempotency-Key Semantics](0011-idempotency-key-semantics.md)
- [ADR-0012: Stripe Provider Abstraction and Billing Adapter](0012-stripe-provider-abstraction.md)
- [ADR-0013: Twilio Provider Abstraction and Messaging Lifecycle](0013-twilio-provider-abstraction.md)
- [ADR-0014: SMS Segment Ledger and Reconciliation Authority](0014-sms-segment-ledger-and-reconciliation.md)
- [ADR-0015: Tenant and Location Isolation Enforcement](0015-tenant-and-location-isolation-controls.md)
- [ADR-0016: Authorization and Entitlement Enforcement Strategy](0016-authz-entitlement-enforcement.md)
- [ADR-0017: Audit Record Integrity and Retention Strategy](0017-audit-record-integrity-and-retention.md)
- [ADR-0018: Privacy Retention and Deletion Controls](0018-retention-and-deletion-controls.md)
- [ADR-0019: Android Architecture, Local Cache, and Degraded Mode](0019-android-architecture-local-cache-and-readonly-mode.md)
- [ADR-0020: Web Surface Topology and Deployment Separation](0020-web-surface-topology-and-deployment.md)
- [ADR-0021: Environment Isolation and Secret Management](0021-environment-isolation-and-secrets.md)
- [ADR-0022: AWS Deployment Baseline](0022-aws-deployment-baseline.md)
- [ADR-0023: Observability and Correlation](0023-observability-correlation-and-diagnostics.md)
- [ADR-0024: Backup, Recovery, Rollback, and Reconciliation](0024-backup-recovery-rollback-reconciliation.md)
- [ADR-0025: API and Event Contract Versioning](0025-api-event-contract-versioning.md)
