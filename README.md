# QueueMe

QueueMe is a queue management platform for service businesses with walk-in traffic.

## Product summary

QueueMe coordinates queue flow, customer check-in, wait estimation, and operator actions for small service teams.

## Initial target market

- US barbershops
- Hair salons
- Beauty salons

## Product interfaces

- Native Android business application
- Customer mobile web check-in
- Business-owner web portal
- Platform administrator web portal

## Current repository state

- Repository foundation and architecture planning complete
- No application functionality is implemented yet
- Milestone 01 is complete
- Milestone 02 is in architecture and decision-review stage
- No framework, build system, backend runtime, cloud environment, payment, or SMS integration is yet initialized

## High-level architecture map

```
QueueMe/
  apps/
    android/   -> Native business operations app (planned)
    web/       -> Customer check-in + portals (planned)
  services/
    api/       -> Authoritative backend services (planned)
  packages/
    contracts/ -> Shared API/event contracts (planned)
    config/    -> Shared repository configuration (planned)
  infrastructure/
    terraform/ -> Infrastructure layout and modules (planned)
  docs/, tests/, scripts/
```

## Key references

- [project-plan/00_locked_product_baseline.md](project-plan/00_locked_product_baseline.md)
- [project-plan/ROADMAP.md](project-plan/ROADMAP.md)
- [project-plan/01_product_specification_lock.md](project-plan/01_product_specification_lock.md)
- [AGENTS.md](AGENTS.md)
- [DEVELOPMENT.md](DEVELOPMENT.md)

## Milestone completion rules

- Milestones are completed only with accepted evidence in `docs/project-status/milestone-reports`.
- A milestone is incomplete if required acceptance evidence is missing.
- No milestone is complete while manual blockers or security dependencies remain unresolved.
- Repository status and working-tree state must be recorded when making milestone changes.

## GitHub initialization and push

After review of this repository layout and filling Git identity:

```bash
git remote add origin <GITHUB_REPOSITORY_URL>
git push -u origin main
```

## Security note

No production secrets belong in source control.
