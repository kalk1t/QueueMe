# QueueMe Repository Layout

QueueMe uses a monorepo to keep requirements, interfaces, backend services, and operations documentation in one reviewable place while keeping responsibilities separated by directory.

## Ownership boundaries

- `apps/android`: Native Android staff business application.
- `apps/web`: Web interfaces for customers and staff/admin.
- `services/api`: Authoritative service layer for business logic and state.
- `packages/contracts`: Canonical contract boundary for APIs/events/errors.
- `packages/config`: Shared configuration conventions.
- `infrastructure`: Environment and deployment topology ownership.
- `docs` and `project-plan`: Requirements, design, and status evidence.
- `scripts` and `tests`: Operational scripts and validation workspaces.

## Dependency direction

```text
apps/android ─┐
apps/web    ──┼──> packages/contracts
services/api ─┘

services/api ──> infrastructure-managed runtime services

project-plan and docs define requirements but must not import application code
```

## Shared contracts

Shared API and event contracts live in `packages/contracts`, consumed by apps and services only when milestones initialize implementation.

## Milestone evidence

All completion evidence and acceptance material is stored in `docs/project-status/milestone-reports`.

## Infrastructure ownership

`infrastructure/terraform` holds environment structure and module folders only during this phase. Live provider/resource definitions are intentionally deferred to later milestones.

## Prohibited contents

- Production credentials
- Exported customer data
- Signed artifacts and signing keys
- Compiled outputs and generated application artifacts
- Hardcoded secrets in code, docs, or configuration

## Framework deferral rationale

This repository foundation intentionally avoids scaffolded Android, web, API, and cloud frameworks. Framework dependencies, build tooling, and runtime modules will be selected and committed during Milestones 2 and 3 after plan gates and ownership decisions.
