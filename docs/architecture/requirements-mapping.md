# Architecture Requirements Mapping

## Mapping principle

Each architecture decision is linked to PRD requirements and future milestones where validation is expected.

| Requirement ID | Architected area | Decision/Artifact | ADR | Future implementation milestone | Verification milestone | Risk class |
| --- | --- | --- | --- | --- | --- | --- |
| PRD-SEC-001 | Tenant isolation enforcement | tenant-isolation-model | ADR-0003, ADR-0015 | M08 | M30 | Critical |
| PRD-TENANT-001 | Multi-location organization model | repository-topology, component-model | ADR-0001 | M08 | M08 | Medium |
| PRD-TENANT-002 | Location-scoped operations | system-context, tenant-isolation-model | ADR-0002, ADR-0003 | M10 | M10 | High |
| PRD-ONBOARD-001 | Admin approval workflow | component-model, api-and-event-contracts | ADR-0013, ADR-0014 | M09 | M09 | High |
| PRD-SUB-004 | 14-day trial lifecycle | api-and-event-contracts, failure-mode-analysis | ADR-0014, ADR-0019, ADR-0021 | M11 | M11 | Medium |
| PRD-SUB-005 | Payment method before activation | transactions model, component ownership | ADR-0014, ADR-0019 | M11 | M11 | High |
| PRD-SUB-006 | Admin approval required for trial | component-model, tenant scope | ADR-0013, ADR-0014 | M09 | M09 | High |
| PRD-SUB-007 | Trial SMS entitlement cap | background-jobs-and-idempotency, failure-mode-analysis | ADR-0012, ADR-0019 | M12 | M12 | Medium |
| PRD-SUB-008 | No paid trial overages | background-jobs-and-idempotency | ADR-0019, ADR-0021 | M12 | M12 | High |
| PRD-SUB-011 | Trial conversion and cancellation | api-and-event-contracts, transaction model | ADR-0014, ADR-0019 | M11 | M11 | High |
| PRD-SUB-018 | Location establishment per location | data-lifecycle-and-retention | ADR-0011, ADR-0019 | M14 | M14 | Medium |
| PRD-SUB-019 | Established location does not transfer | tenant-isolation-model | ADR-0003, ADR-0011 | M14 | M14 | Medium |
| PRD-SUB-012 | Explicit annual plan selection | API/event model, deployment model | ADR-0014 | M13 | M13 | High |
| PRD-SUB-013 | SMS cycle cap and billing cycles | background-jobs-and-idempotency, requirements mapping | ADR-0019 | M12 | M12 | Medium |
| PRD-LOC-001 | Multiple queues per location | component-model, transaction model | ADR-0002 | M21 | M21 | Medium |
| PRD-QUEUE-001 | One customer per entry | component-model, queue-entry model | ADR-0002, ADR-0022 | M22 | M22 | High |
| PRD-QUEUE-002 | FIFO by default | transaction model, component-model | ADR-0007 | M23 | M23 | High |
| PRD-QUEUE-003 | Manual reorder with reason | component-model, transaction model | ADR-0007, ADR-0023 | M23 | M23 | High |
| PRD-QUEUE-008 | Concurrent operator mutation | transaction model | ADR-0010 | M29 | M29 | High |
| PRD-QUEUE-009 | Internet required for mutations | architecture, deployment model | ADR-0016, ADR-0020 | M29 | M30 | High |
| PRD-QUEUE-010 | Cache read-only behavior | API/event contracts | ADR-0020 | M29 | M30 | High |
| PRD-CHECKIN-001 | QR check-in | data-flow, component-model | ADR-0018 | M25 | M25 | Medium |
| PRD-CHECKIN-002 | Staff-assisted check-in | component-model | ADR-0018 | M25 | M25 | High |
| PRD-CHECKIN-006 | Remote joining modes | api-and-event-contracts, failure-mode-analysis | ADR-0018 | M25 | M25 | Medium |
| PRD-CHECKIN-007 | Advance joining | api-and-event-contracts | ADR-0018 | M25 | M25 | Medium |
| PRD-SMS-009 | Dedicated number per location | api-and-event-contracts, component-model | ADR-0001, ADR-0017 | M17 | M30 | High |
| PRD-PRIV-001 | 30-day retention for identifiables | data-lifecycle-and-retention | ADR-0024 | M30 | M30 | High |
| PRD-PRIV-003 | Queue-SMS explicit consent | tenant model, component-model | ADR-0015 | M30 | M30 | High |
| PRD-AUDIT-001 | Sensitive actions audited | component-model, observability | ADR-0008 | M30 | M30 | High |
| PRD-AUDIT-002 | Reorder audits include reason/context | component-model | ADR-0007, ADR-0008 | M23 | M23 | High |
| PRD-PLAT-001 | Android native operator client | system-context, deployment model | ADR-0005 | M27 | M27 | Medium |
| PRD-PLAT-002 | Android minimum version 12 | platform contract | ADR-0005 | M27 | M30 | Medium |
| PRD-PLAT-003 | Closed pilot distribution | security and operations dependencies | ADR-0005, ADR-0025 | M30 | M30 | High |
| PRD-PRIV-002 | No default phone export | data-lifecycle-and-retention | ADR-0004 | M30 | M30 | Medium |
| PRD-WEB-001 | Browser check-in and status | architecture/system-context | ADR-0005, ADR-0016 | M26 | M30 | Medium |
| PRD-WEB-002 | Business-owner portal surface | deployment model, api contract | ADR-0005, ADR-0016 | M30 | M30 | High |
