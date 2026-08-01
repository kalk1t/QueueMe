# Repository Topology

## Proposed repository layout

```text
apps/
  android/      # native operator clients
  web/          # owner/admin/customer browser surfaces
services/
  api/          # authoritative backend API and admin command boundary
  worker/       # background job execution and reconciliation
  realtime/     # websocket ingress and fan-out (planned)
packages/
  contracts/    # API/event schema contracts and shared types
  domain/       # shared domain model utilities
  config/       # environment and feature configuration
  observability/# shared tracing, metrics, logging helpers
  testing/      # fixture and scenario utilities (future)
infrastructure/
  terraform/    # platform modules and state definitions
docs/
  architecture/ # architecture and ADR artifacts
  security/     # threat model and controls
scripts/         # repository and release scripts
tests/           # acceptance and verification tests
```

## Sharing rules

- Shared contracts and config packages may be used by backend, web, and Android integration tooling.
- Domain logic is owned by backend and shared only as immutable interfaces; mutable implementations remain service-local.
- Realtime protocol helpers can be shared across web and Android through contracts only.
- Workers share only idempotency schemas, provider interfaces, and event types from contract packages.

## Non-sharing boundaries

- Android local caching implementation should not be imported into backend services.
- Backend persistence models are not reused by client code outside contracts.
- Terraform and infrastructure packages remain deployment artifacts, never imported into runtime code.

## Contracts versioning

- Contract packages use SemVer (`MAJOR.MINOR.PATCH`), with explicit migration notes for breaking changes.
- New stable fields: additive.
- Breaking changes require explicit contract version bump and migration guidance.

## Android contract consumption

- Android receives generated contract snapshots via package publication from `packages/contracts`.
- Runtime clients consume versioned endpoints and event enums through generated artifacts to prevent drift.

## Web/backend sharing

- Web TypeScript packages may share contracts with backend only through generated request/response types.
- Business logic must not be duplicated from backend; client mirrors behavior only.

## Deployment units vs source modules

- Source modules map to at least three runtime units (`api`, `realtime`, `worker`) while sharing contract and config packages.
- Additional packages are optional and can be split without changing domain model contracts.

## Future modularization

- The modular-monolith structure isolates API/realtime/worker behind explicit contract boundaries.
- Individual service extraction requires protocol freeze on contracts and stable queue/event schemas.

## Circular dependency controls

- Contract packages have no dependency on service implementations.
- Service modules depend on domain contracts; domain contracts must not depend on framework packages.
- No bidirectional dependency between web and backend source layers through shared code.
