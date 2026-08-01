# Milestone 02 — Architecture and Decision Records

## 1) Milestone result

- Milestone: Milestone 02 — Architecture and Decision Records
- Final status: **BLOCKED** (documentation and design evidence complete; product-owner, security, and external ownership approvals pending)
- Start timestamp: 2026-08-01
- Completion timestamp: 2026-08-01

## 2) Repository state at start

- Branch at start: `milestone/02-architecture-and-decision-records`
- Commit at start: `d1ed7e8c272ac2339c055a9dccf885c879e16ef5`
- Working tree at start: clean
- Baseline docs inspected: `project-plan/00_locked_product_baseline.md`, `docs/product/release-1-specification.md`, `docs/project-status/CURRENT_STATUS.md`

## 3) Repository state at completion

- Branch: `milestone/02-architecture-and-decision-records`
- Working tree at completion: clean after final commit
- No application frameworks, databases, providers, or production environments introduced.

## 4) Starting inventory

- Existing architecture documentation: `docs/architecture/README.md` only.
- Existing ADR index: `docs/architecture/adr/README.md` placeholder.
- Security and project docs were already present and baseline-oriented.

## 5) Files created for Milestone 02

- `docs/architecture/system-context.md`
- `docs/architecture/component-model.md`
- `docs/architecture/deployment-model.md`
- `docs/architecture/data-flow.md`
- `docs/architecture/repository-topology.md`
- `docs/architecture/api-and-event-contracts.md`
- `docs/architecture/tenant-isolation-model.md`
- `docs/architecture/transaction-and-concurrency-model.md`
- `docs/architecture/background-jobs-and-idempotency.md`
- `docs/architecture/data-lifecycle-and-retention.md`
- `docs/architecture/observability-and-operations.md`
- `docs/architecture/failure-mode-analysis.md`
- `docs/architecture/architecture-review-checklist.md`
- `docs/architecture/requirements-mapping.md`
- `docs/architecture/review-record.md`
- `docs/security/milestone-02-threat-model.md`
- `docs/adr/README.md`
- `docs/adr/0000-adr-template.md`
- `docs/adr/0001-monorepo-topology-and-source-ownership.md`
- `docs/adr/0002-modular-monolith-first-backend-architecture.md`
- `docs/adr/0003-backend-as-sole-authoritative-state-owner.md`
- `docs/adr/0004-postgresql-authoritative-store.md`
- `docs/adr/0005-redis-boundaries-and-non-authoritative-role.md`
- `docs/adr/0006-rest-vs-websocket-responsibilities.md`
- `docs/adr/0007-realtime-revision-and-resync.md`
- `docs/adr/0008-queue-concurrency-and-cas-controls.md`
- `docs/adr/0009-durable-jobs-and-retry-policy.md`
- `docs/adr/0010-transactional-outbox-inbox-strategy.md`
- `docs/adr/0011-idempotency-key-semantics.md`
- `docs/adr/0012-stripe-provider-abstraction.md`
- `docs/adr/0013-twilio-provider-abstraction.md`
- `docs/adr/0014-sms-segment-ledger-and-reconciliation.md`
- `docs/adr/0015-tenant-and-location-isolation-controls.md`
- `docs/adr/0016-authz-entitlement-enforcement.md`
- `docs/adr/0017-audit-record-integrity-and-retention.md`
- `docs/adr/0018-retention-and-deletion-controls.md`
- `docs/adr/0019-android-architecture-local-cache-and-readonly-mode.md`
- `docs/adr/0020-web-surface-topology-and-deployment.md`
- `docs/adr/0021-environment-isolation-and-secrets.md`
- `docs/adr/0022-aws-deployment-baseline.md`
- `docs/adr/0023-observability-correlation-and-diagnostics.md`
- `docs/adr/0024-backup-recovery-rollback-reconciliation.md`
- `docs/adr/0025-api-event-contract-versioning.md`
- `scripts/validate-milestone-02.ps1`
- `docs/project-status/milestone-reports/milestone-02-architecture-and-decision-records.md`

## 6) Files updated for Milestone 02

- `docs/architecture/README.md`
- `README.md`
- `CHANGELOG.md`
- `docs/project-status/CURRENT_STATUS.md`

## 7) Summary of architectural decisions

- Backend authoritative state for queue, billing, entitlement, and consent.
- Modular-monolith-first topology with explicit service boundaries.
- PostgreSQL authoritative persistence with Redis for coordination and non-durable state.
- REST + snapshot-first model with WebSocket non-authoritative deltas.
- Queue concurrency control with revision/CAS and call-next locking.
- Durable jobs, idempotency keys, outbox/inbox, and provider callback dedupe.
- Tenant/location isolation enforced in data and runtime scopes.
- Defined deployment model across local, development, staging, and production (proposed only).
- Threat model and failure modes documented for all critical paths.

## 8) Repository-topology decision

- Keep monorepo with service modules and package layers:
  - `services/api`, `services/worker`, `services/realtime`
  - `apps/android`, `apps/web`
  - shared `packages/contracts`, `packages/config`, `packages/domain`, `packages/observability`, and `packages/testing` (planned)

## 9) Component ownership and data boundaries

- Ownership recorded in `docs/architecture/component-model.md`.
- Data class ownership and retention recorded in `docs/architecture/data-lifecycle-and-retention.md`.
- Tenant model recorded in `docs/architecture/tenant-isolation-model.md`.

## 10) API and WebSocket decisions

- REST mutation and snapshot APIs are authoritative.
- WebSocket is for propagation only, with revision-based reconnect and full-snapshot fallback.
- Event contracts include revisions, stable error codes, and duplicate tolerances.

## 11) Concurrency and queue controls

- `docs/architecture/transaction-and-concurrency-model.md` defines revision checks, advisory lock, conflict behavior, and stale-write handling.
- Idempotency policy documented in `docs/architecture/background-jobs-and-idempotency.md`.

## 12) Provider abstractions

- Stripe and Twilio abstractions documented under ADR-0012 and ADR-0013.
- Webhook signature validation, dedupe, and ordering controls in architecture and threat docs.

## 13) Environment and deployment decisions

- Proposed local/dev/staging/prod model in `docs/architecture/deployment-model.md`.
- Environment isolation and secret management in ADR-0021.

## 14) Security and tenant-isolation review

- Tenant-isolation and threat-model controls cross-referenced in architecture and ADR set.
- Review record remains blocked pending external verification and approvals.

## 15) Failure-mode review

- 20 required scenarios documented in `docs/architecture/failure-mode-analysis.md`.

## 16) Validation commands and results

- `git status --short`
- `git branch --show-current`
- `git log -10 --oneline`
- `git diff --check`
- `git status --porcelain`
- `git diff --name-only`
- `git diff -- project-plan/00_locked_product_baseline.md`
- `git diff -- project-plan/01_product_specification_lock.md`
- `git diff -- project-plan/ROADMAP.md`
- `git diff -- project-plan/02_architecture_and_decision_records.md`
- `powershell -ExecutionPolicy Bypass -File scripts/validate-milestone-02.ps1`
- Secret pattern scan and forbidden implementation scan performed as part of `validate-milestone-02.ps1`

## 17) Manual validation status

- Milestone 1 is approved and complete.
- Milestone 2 architecture artifacts are completed.
- Product-owner and security/cost approvals are still pending.
- External account ownership checks are still pending for AWS/Stripe/Twilio/Google Play/domain/email.

## 18) Acceptance evidence

- `docs/architecture/system-context.md`
- `docs/architecture/component-model.md`
- `docs/architecture/deployment-model.md`
- `docs/architecture/data-flow.md`
- `docs/architecture/architecture-review-checklist.md`
- `docs/architecture/failure-mode-analysis.md`
- `docs/architecture/requirements-mapping.md`
- `docs/architecture/review-record.md`
- `docs/security/milestone-02-threat-model.md`
- `docs/adr/` ADR set

## 19) Commit lineage

- Starting commit: `d1ed7e8c272ac2339c055a9dccf885c879e16ef5`
- Architecture specification commit: `<docs commit for milestone 2 architecture>` (recorded at finalization)
- Review record commit: `<docs review commit>`
- Validation commit: `<validation/reference commit>`
- Evidence/ completion commit: `<evidence commit>`

## 20) Validation status

- `scripts/validate-milestone-02.ps1` executed and required checks are documented.
- `FORBIDDEN_ARTIFACT_HITS` and `SECRET_HITS` are expected to be zero.

## 21) Clean working tree check

- Final status expected to be clean after evidence commit and before push.

## 22) Final status interpretation

- Current final status remains `BLOCKED` due to required external and manual approvals.
