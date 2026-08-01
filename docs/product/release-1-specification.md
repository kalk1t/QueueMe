# QueueMe Release 1 Product Specification

## 1. Document control

| Field | Value |
| --- | --- |
| Document title | QueueMe Release 1 Product Specification |
| Document ID | `docs/product/release-1-specification.md` |
| Version | `1.0.0` |
| Created for milestone | Milestone 01 — Product Specification Lock |
| Authoritative source | `project-plan/00_locked_product_baseline.md` |
| Previous version | `not applicable` |
| Status | Approved |
| Last updated | 2026-08-01 |
| Approval status | APPROVED |
| Branch at draft | `main` |

## 2. Authority and interpretation

This document is normative for Release 1.

Authoritative precedence for Release 1:

1. `project-plan/00_locked_product_baseline.md` (immutable, source of truth for locked decisions)
2. This PRD (the sole detailed, normative functional specification for Release 1 after product-owner approval)
3. Supporting evidence documents: milestone reports, traceability artifacts, glossary, decision log, and approval records.

Supporting evidence documents are contextual, traceable, and do not override this PRD.

If a conflict appears between the locked baseline and this PRD, approval is blocked until resolved explicitly by the product owner.

## 3. Product vision

QueueMe is a queue-operating product for walk-in small service businesses using browser and business-admin interfaces with a native Android operator app.

## 4. Release objective

Release 1 becomes business-ready only when all requirements in this document are implemented and verified through milestone evidence up to Milestone 30.

## 5. Target market

Release 1 launch is US-first and is targeted to:

- Barbershops
- Hair salons
- Beauty salons

## 6. Product boundaries

Release 1 includes queue operations, queue-entry lifecycle management, messaging, billing control, and operational surfaces required by this specification.

Release 1 excludes non-specified verticals, distribution channels, and feature categories described in Section 38 (Explicit exclusions).

## 7. Actors

Actors:

- Platform administrator
- Business owner
- Location manager
- Queue operator
- Customer

## 8. Roles and permissions

Role and location assignments define permissions. Permissions must be validated before each action and enforced by the authoritative backend state.

### 8.1 Role capabilities

- Platform administrator
  - Review and approve businesses and location onboarding.
  - Suspend and restore operational access.
  - Approve SMS spending-limit increases.
  - Review billing and messaging diagnostics.
  - Audit sensitive operations.
- Business owner
  - Manage organization and locations.
  - Manage subscriptions and payment surfaces.
  - Manage staff assignments.
  - Configure queues, services, custom questions, and messaging.
  - View billing and usage status.
- Location manager
  - Manage permitted location operations.
  - Configure queues and settings only where authorized.
  - Manage staff only when explicitly permitted.
  - View permitted operational reports.
- Queue operator
  - View and operate assigned queues.
  - Add customers manually.
  - Call next, start service, complete service.
  - Mark customer no-show.
  - Reorder queue entries only with required reason.
- Customer
  - Join through QR.
  - Provide required information.
  - View private queue status.
  - Leave queue.
  - Request configured extension.
  - Send supported structured replies.

## 9. Organization and tenant model

Each business may have one or more locations.

Tenant boundaries are immutable across all queue, billing, messaging, and audit data.

## 10. Location and subscription model

Each location is independently subscribed, stateful, and tenant-bound.

An active location entitlement unlocks messaging and operational capabilities for that location only.

### 10.1 Location lifecycle

| Location state | Meaning | Allowed transitions |
| --- | --- | --- |
| CREATED | Location record exists but is not yet operational | -> AWAITING_SUBSCRIPTION_OR_TRIAL |
| AWAITING_SUBSCRIPTION_OR_TRIAL | Location is onboarding and not yet entitled | -> TRIAL_REQUESTED, -> PENDING_ADMIN_APPROVAL |
| TRIAL_REQUESTED | Trial request has been submitted and is being prepared | -> PENDING_ADMIN_APPROVAL |
| PENDING_ADMIN_APPROVAL | Single approval gate for all entitlement paths; payment context is captured | -> TRIAL_ACTIVE, -> PAID_ACTIVE, -> TRIAL_REQUEST_CANCELLED (trial request), -> ONBOARDING_REQUEST_CANCELLED (direct-paid request) |
| TRIAL_ACTIVE | Trial entitlement is active and the 14-day trial clock starts here | -> TRIAL_SMS_PAUSED, -> TRIAL_CANCEL_SCHEDULED, -> MONTHLY_ACTIVE |
| TRIAL_SMS_PAUSED | Trial remains active while SMS sending is paused after allowance exhaustion | -> TRIAL_CANCEL_SCHEDULED, -> MONTHLY_ACTIVE |
| TRIAL_CANCEL_SCHEDULED | Post-activation cancellation request with auto-conversion disabled | -> TRIAL_ENDED |
| TRIAL_REQUEST_CANCELLED | Trial request cancelled or rejected before activation | terminal |
| ONBOARDING_REQUEST_CANCELLED | Direct paid onboarding request cancelled or rejected before activation | terminal |
| TRIAL_ENDED | Trial entitlement is no longer active after trial end or scheduled cancellation | terminal |
| MONTHLY_ACTIVE | Trial reached end without effective cancellation and converted to monthly software entitlement | terminal for trial flow |
| PAID_ACTIVE | Location has active paid entitlement | (billing lifecycle is defined in Section 13) |

## 11. Business onboarding and approval

Business onboarding requires explicit platform-administrator approval before operational activation. Locations with active staff, queueing, or messaging features cannot become operational without approval.

### 11.1 Organization lifecycle (conceptual)

| State | Meaning | Allowed transitions |
| --- | --- | --- |
| REGISTERED | Organization has baseline registration data | -> PENDING_ADMIN_APPROVAL |
| PENDING_ADMIN_APPROVAL | Awaiting platform administrator approval for operational usage | -> APPROVED, -> CANCELLED |
| APPROVED | Approved for operation; locations may proceed to active workflow | -> SUSPENDED, -> CANCELLED |
| SUSPENDED | Temporary disablement for policy/compliance reasons | -> APPROVED, -> CANCELLED |
| CANCELLED | Organization closed to new operations and cannot become active without re-initiation | terminal |

## 12. Trial lifecycle

Trial behavior applies per location when business onboarding enters trial state.

### 12.1 Trial lifecycle table

| State | Meaning | Transition rule | Notes |
| --- | --- | --- | --- |
| TRIAL_REQUESTED | Trial request is submitted and waiting for admin review | -> PENDING_ADMIN_APPROVAL | Timer does not start in this state |
| PENDING_ADMIN_APPROVAL | Payment method and request are captured and waiting for admin decision | -> TRIAL_ACTIVE on approved trial path; -> PAID_ACTIVE on approved paid path; -> TRIAL_REQUEST_CANCELLED when a trial request is explicitly rejected or canceled before activation; -> ONBOARDING_REQUEST_CANCELLED when a paid request is explicitly rejected or canceled before activation | Admin approval is required before the trial clock starts |
| TRIAL_ACTIVE | Trial is active; SMS allowances are being consumed | -> TRIAL_SMS_PAUSED when 100 provider-billed trial segments are consumed; -> MONTHLY_ACTIVE when 14-day trial ends and not canceled; -> TRIAL_CANCEL_SCHEDULED when canceled | Trial length is exactly 14 days |
| TRIAL_SMS_PAUSED | Trial remains active; SMS sending is paused after allowance exhaustion | -> MONTHLY_ACTIVE when 14-day trial ends and not canceled; -> TRIAL_CANCEL_SCHEDULED when canceled | Queue and browser status remain available |
| TRIAL_CANCEL_SCHEDULED | Cancellation requested and accepted after activation; conversion is disabled | -> TRIAL_ENDED at scheduled `trial_end` | Remaining trial entitlement persists until scheduled end |
| TRIAL_REQUEST_CANCELLED | Trial request was rejected before activation | terminal | No `trial_start`, no `trial_end`, and no trial SMS allowance were activated |
| ONBOARDING_REQUEST_CANCELLED | Direct paid request was rejected before activation | terminal | No trial entitlement is activated |
| TRIAL_ENDED | Trial entitlement no longer exists; further entitlement requires paid subscription | terminal |
| MONTHLY_ACTIVE | Trial reached end without active cancellation and converted to monthly software entitlement | terminal conversion outcome |

### 12.2 Cancellation transition

| State before cancellation | State after cancellation | Requirement |
| --- | --- | --- |
| TRIAL_REQUESTED | TRIAL_REQUEST_CANCELLED | Trial request has been captured but not started; access is never activated. |
| PENDING_ADMIN_APPROVAL | TRIAL_REQUEST_CANCELLED | Pending trial requests remain non-operational and cannot start without approval. |
| PENDING_ADMIN_APPROVAL | ONBOARDING_REQUEST_CANCELLED | Paid request was rejected or canceled before approval; no operational entitlement is activated. |
| TRIAL_ACTIVE | TRIAL_CANCEL_SCHEDULED | Trial operations remain, but auto-conversion is disabled. |
| TRIAL_SMS_PAUSED | TRIAL_CANCEL_SCHEDULED | Trial operations remain, SMS is still paused. |

Cancellation policy:

- Record the exact cancellation request time.
- For pre-activation cancellation (`TRIAL_REQUEST_CANCELLED`), no `trial_start`, no `trial_end`, and no trial SMS allowance is activated.
- For post-activation cancellation, the trial has a valid `trial_start` and original `trial_end`.
- Keep current trial access and operations until `trial_end`.
- Allow remaining unused trial SMS allowance to be consumed until either 100 provider-billed segments are reached or `trial_end`.
- Do not generate paid SMS overages during cancellation.
- At `TRIAL_ENDED`, existing trial operations stop unless a paid subscription is active.
- A customer in an active queue at `TRIAL_ENDED` may keep private browser status access until that entry reaches a terminal state.
- The system must not accept new queue entries once the trial entitlement has ended.

### 12.3 Trial rules

- Trial duration is exactly 14 days.
- Payment method must exist before activation.
- Administrator approval must occur before the trial clock starts.
- At 100 provider-billed segments, SMS sending pauses.
- There is no allowance reset during a single trial period.
- Canceling a trial after activation does not immediately terminate the remaining trial period.
- A canceled trial keeps operations until `trial_end`, then stops unless paid.
- Queue operations, customer check-in, and browser status continue while SMS is paused.
- Trial SMS exhaustion does not stop queue functionality or status checks.
- Annual billing begins only after an explicit annual-plan selection (monthly remains the default at trial conversion).
- Uncanceled trials convert to monthly software subscription via `MONTHLY_ACTIVE`.
- Canceled trials do not auto-convert and do not create indefinite free operational access.
- Direct paid requests canceled or rejected before approval remain non-operational via `ONBOARDING_REQUEST_CANCELLED`.

## 13. Paid subscription lifecycle

Subscription is location-scoped.

### 13.1 Paid subscription table

| State | Meaning | Transition rule |
| --- | --- | --- |
| CREATED | Subscription object exists but inactive | -> TRIAL or -> PAID_ACTIVE |
| AWAITING_PAYMENT | Requires payment method or payment-state confirmation | -> PAID_ACTIVE when resolved |
| PAID_ACTIVE | Paid recurring software entitlement is active | -> PAST_DUE, -> CANCELED |
| PAST_DUE | Billing failed | -> PAID_ACTIVE on recovery, -> SUSPENDED on repeated failure |
| SUSPENDED | Entitlement blocked due to billing/compliance state | -> PAID_ACTIVE on clear, -> CANCELED |
| CANCELED | Subscription ended | terminal for Release 1 |

### 13.2 Subscription specifics

- Monthly price: 39.99 USD per active location per month.
- Annual price: 399.99 USD per active location per year.
- No multi-location discount applies.
- Monthly subscription is the default recurring path.
- Annual billing starts only if the annual option is explicitly selected.
- Annual billing is location-based and does not create per-business discounts.
- Annual software charges are collected annually.
- Annual subscribers still follow monthly SMS billing behavior.
- Trial conversion defaults to monthly unless an explicit annual-plan selection is made.

### 13.3 Established-location definition (location-scoped)

An established location is a **subscribed location** that satisfies all of the following:

- It has a successfully paid initial software subscription.
- It has completed **two consecutive successfully settled billing cycles**.
- It has no unresolved failed or disputed invoice.
- A monthly messaging cycle with zero amount due counts as successfully settled.
- Monthly and annual software subscription paths use the same establishment rule.

Additional establishment rules:

- Retention of billing and entitlement state is **per location** only.
- SMS allowance and spending limit are retained per location.
- Establishment status does not transfer between locations, even when in the same organization.

## 14. SMS billing lifecycle

SMS billing is usage-first and postpaid by segment usage.

### 14.1 Monthly messaging cycle table

| State | Meaning | Transition rule |
| --- | --- | --- |
| CONFIGURED | Cycle configuration active for location | -> BILLING_ACTIVE |
| BILLING_ACTIVE | Cycle counts usage for provider-billed segments | -> BILLING_CLOSED on cycle end |
| BILLING_CLOSED | Cycle complete and rolled to next cycle | -> CONFIGURED |
| SMS_RESTRICTED | Spend cap reached and enforcement active | -> BILLING_ACTIVE after reset or explicit admin action |

### 14.2 SMS rules

- Messaging cycles provide 300 included provider-billed segments.
- Included segments do not roll over.
- Additional provider-billed segments are charged at 0.03 USD per segment.
- Default per-location overage limit is 50 USD per cycle.
- Overage limit increases require platform-admin approval.
- New locations start in postpaid control mode per location and remain controlled by overage caps.
- Annual software entitlement does not alter segment inclusion amount.
- Overages are invoiced monthly even for annual software subscribers.
- Failed overage payment moves location messaging to SMS_RESTRICTED until payment issue resolution.

## 15. Messaging-number lifecycle

One dedicated number is required per active subscribed location.

### 15.1 Messaging number states

| State | Meaning | Transition rule |
| --- | --- | --- |
| READY | Configured for potential allocation | -> ASSIGNED to eligible active location |
| ASSIGNED | Bound to exactly one active subscribed location | -> PENDING_DECOMMISSION on cancellation/suspension |
| PENDING_DECOMMISSION | Number reserved for reassignment or teardown workflow | -> DECOMMISSIONED on resolution |
| DECOMMISSIONED | Unavailable for active usage | terminal unless re-provisioned later |
| REPLACEMENT_PENDING | Number replacement requested/reviewed | -> ASSIGNED |

### 15.2 Number-specific requirements

- Active subscribed location => exactly one dedicated number.
- Number allocation is location-scoped and location-exclusive.
- Cancellation or long suspension transitions numbers out of active use.
- No location sharing of an active dedicated number.

## 16. Queue configuration

- Locations may define multiple queues.
- Queue config includes:
  - service support settings
  - max queue size
  - no-show hold time
  - extension policy
  - messaging event configuration

## 17. Queue-entry lifecycle

Lifecycle states:

- WAITING
- CALLED
- SERVING
- COMPLETED
- CANCELLED
- NO_SHOW
- REMOVED

Lifecycle transitions are normative and testable:

| Current state | Next states | Rule |
| --- | --- | --- |
| WAITING | CALLED, CANCELLED, REMOVED | Entry is admitted, may be cancelled or removed before call. |
| CALLED | SERVING, NO_SHOW, CANCELLED, REMOVED | No-show hold timer starts when entry becomes `CALLED`. |
| SERVING | COMPLETED | Service must be started before completion. |
| COMPLETED | (terminal) | No further transitions are allowed. |
| CANCELLED | (terminal) | No further transitions are allowed. |
| NO_SHOW | (terminal) | No further transitions are allowed. |
| REMOVED | (terminal) | No further transitions are allowed. |

No-show behavior:

- The no-show hold timer starts when the entry enters `CALLED` and ends at `called_at + configured hold` (default five minutes).
- The only valid incoming transition to `NO_SHOW` is from `CALLED`.
- A `CALLED` entry at hold expiry MUST be manually confirmed by staff as `NO_SHOW`.
- `WAITING` and `SERVING` entries MAY NOT transition directly to `NO_SHOW`.
- The system MAY expose a visible `called hold expired` indicator.

Simultaneous-operation controls:

- Only one transition for a queue entry is valid within a single conflict domain.
- Concurrent conflicting mutations for the same queue entry MUST be conflict-checked.
- Stale writes MUST be rejected; only one valid transition may be committed.
- Invalid transitions MUST fail atomically with an explicit operator-visible conflict or state error.

## 18. Queue ordering and concurrency rules

- FIFO is the default queue ordering rule.
- Manual reordering requires explicit reason and is audit-logged.
- Multiple authorized staff devices may operate one queue simultaneously.
- Mutation commands require connectivity.
- During outages, reads may use cached read-only state; mutations MUST be rejected in read-only mode.

## 19. Customer check-in

Check-in is QR-first with mandatory fields and configurable policies.

### 19.1 Check-in fields and policy

- Required: mobile number and name or nickname.
- Optional: service selection.
- Remote joining is configurable:
  - Enabled: location may expose a standard shareable join link.
  - Disabled: customer joining is limited to the QR route and staff-assisted check-in only.
- Advance joining is configurable:
  - Enabled: customers may join outside normal walk-in period where explicitly allowed.
  - Disabled: customers join only while walk-in period is open.
- Mobile QR links are shareable; no physical-presence guarantee is implied by static QR sharing.
- Geolocation enforcement, rotating presence codes, and anti-sharing controls are deferred unless separately approved.
- Operating-hours policy applies to customer joining unless explicitly overridden for advance joining.

## 20. Staff-assisted check-in

Staff-assisted manual check-in MUST remain available as a fallback path when customer self-check-in is not possible.
- Staff-assisted check-in must apply the same queue-SMS consent capture requirements as QR check-in.

## 21. Services and custom questions

Queue services are optional and business-configurable.

Custom questions constraints:

- At most five active questions per queue.
- Allowed types: short text, yes/no, single select, multi-select.
- No file-upload questions.
- Prohibited inputs include medical information, government identification, payment-card data, passwords, and account credentials.
- No prohibited input type may be accepted.
- The system MUST show a visible sensitive-data warning before question answers are shown.
- Business owners MUST attest that custom questions are not collecting prohibited data.
- The system MUST block prohibited input types and must flag obvious prohibited labels/patterns.
- Automated detection is defense-in-depth and is not a perfect semantic classifier.
- Administrators MUST be able to investigate, disable questions, and suspend violating locations.
- All sensitive-question enforcement actions and violations MUST be auditable.

## 22. Customer status experience

Customers receive a browser-based private queue-status experience tied to their check-in context.

Status must show current queue position and permitted wait estimate details.

## 23. Wait estimation

Wait estimation is queue-state and historical-service-time based per queue policy.

## 24. No-show and extension behavior

- Default no-show hold = five minutes.
- `NO_SHOW` is only reachable from `CALLED`.
- `WAITING` and `SERVING` cannot transition directly to `NO_SHOW`.
- No-show in `CALLED` requires explicit staff confirmation after hold expiry.
- Businesses may configure extension behavior.
- Extensions are bounded by policy, per-business settings, and location controls.

## 25. SMS notifications and replies

Default SMS events:

- joined
- almost ready
- your turn
- missed/no-show

Businesses may disable any default event and customize templates within configured segment limits.

Replies supported:

- STOP
- HELP
- ONE structured "I'm coming" reply

Notification semantics:

- Billing must be charged by provider-billed segment usage, not send-operation count.
- Template previews MUST show predicted segment count.
- Templates must be English-first and localization-ready.

Consent for queue SMS:

- Queue SMS MUST be sent only after explicit queue messaging consent is captured.
- Consent capture MUST record phone number, location, queue entry, timestamp, consent-text version, and capture method.
- Queue consent MUST be separate from marketing consent.
- Customers who decline queue SMS consent must not receive SMS but retain browser-status access.
- Staff-assisted and QR join must use identical queue-consent behavior.

## 26. Android business application requirements

- Dedicated native Android business app is the primary business operator surface.
- Android minimum supported version is 12.
- Release begins in closed pilot and is not public launch.

## 27. Business-owner portal requirements

- Portal MUST support:
  - organization and location setup
  - queue and custom-question configuration
  - subscription visibility and management
  - staff invitation and role assignment
  - SMS event and template controls

## 28. Platform-administrator portal requirements

- Portal MUST support:
  - business approval and onboarding control
  - business suspension and restore
  - spending-limit increase approval
  - billing diagnostics review
  - audit access
  - suspension and exception management

## 29. Connectivity and degraded operation

- Queue mutations MUST require network.
- Mobile/desktop outages MAY allow read-only cached views.
- Offline mutations MUST be blocked.

## 30. Privacy and retention

Retention policy:

- Customer-identifiable data (name, phone, custom answers) is retained for 30 days.
- No default phone-number export.
- Queue consent is distinct from marketing consent.
- Queue phone numbers are never used for advertising.
- Staff with right role may view complete phone numbers.
- Phone-number access is auditable.
- Customer may leave active queue immediately.
- Deletion follows privacy workflow after approved process requirements.

## 31. Auditability

Actions requiring auditability MUST be recorded with actor, tenant, location, action type, timestamp, and immutable context:

- administrative approvals
- manual reorder with reason
- state transitions
- billing overrides and limit changes
- phone-number views

## 32. Security requirements

- Authoritative backend state is mandatory for all authorization and billing decisions.
- Tenant isolation MUST prevent cross-tenant reads/writes.
- Sensitive actions MUST be role-gated.

## 33. Billing traceability

Billing calculations must be attributable per location, per cycle, and per tenant context.

Evidence of:

- entitlement
- allowance
- overage
- payment status
- exception states

must be linkable for audit and reconciliation.

## 34. Error and failure behavior

- Trial/subscription transitions MUST fail atomically.
- Payment failures MUST block entitlement-dependent operations while preserving operational queue state.
- Messaging restrictions from SMS spend ceilings MUST be explicit and logged.

## 35. Success metrics

### 35.1 Product success indicators

- Successful check-in rate
- Successful queue-operation rate
- Pilot-completion health

### 35.2 Engineering acceptance gates

- Duplicate-call prevention rate
- Cross-tenant access prevention rate
- Queue-event audit coverage
- Multi-device state convergence
- 30-day retention enforcement rate

### 35.3 Operational monitoring indicators

- SMS usage reconciliation accuracy
- Billing reconciliation accuracy
- Severity-1 and severity-2 defect thresholds

### 35.4 Business targets

- No numeric thresholds are finalized in this locked specification.
- All metrics in this section are release-planning targets requiring later confirmation.

## 36. Release-level definition of done

Release 1 is complete only when every required milestone through Milestone 30 is accepted and evidence confirms:

- Real pilot operation
- Subscription renewal behavior
- Annual software + monthly SMS billing operation
- SMS allowance and overage reconciliation
- Spending-limit enforcement
- Payment-failure handling
- Multi-device queue operation
- Backup and restore behavior
- Security and privacy checks
- No unresolved release-blocking defects
- Approved path for Android distribution

## 37. Assumptions

- Wait-estimation exact formula is implemented in Milestones 24 and 23-29.
- Refund policy is legal/commercially governed and is not a product-behavior lock.
- Infrastructure, provider, and deployment details are out of scope for Milestone 1.

## 38. Explicit exclusions

- Medical clinics
- Restaurants and restaurant table management
- Appointments
- Marketing messages
- Customer mobile application
- iOS business application
- Public API
- White labeling
- Priority/VIP queue ordering
- Multi-device offline mutations
- Voice notifications
- WhatsApp messaging
- Full two-way staff/customer chat
- Calendar/POS integrations
- Loyalty and reviews
- File-upload custom questions
- Kiosk mode (unless pilot trigger)
- Public waiting-room displays (unless pilot trigger)

## 39. Requirement index

### 39.1 General market and surface requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-MKT-001 | Release 1 MUST be US-first in initial launch scope. | Evidence shows initial commercialization scoped to the US-first plan before broader expansion. | M30 | Product strategy / market materials | Medium |
| PRD-MKT-002 | Release 1 MUST target barbershops. | Queue and billing behavior align with walk-in barbershop operation in documentation and evidence. | M30 | Business surfaces | Low |
| PRD-MKT-003 | Release 1 MUST target hair salons. | Queue and check-in behavior supports walk-in hair salon operations. | M30 | Business surfaces | Low |
| PRD-MKT-004 | Release 1 MUST target beauty salons. | Product behavior and scope include beauty-salon usage assumptions. | M30 | Business surfaces | Low |
| PRD-MKT-005 | Medical clinics MUST be excluded in Release 1. | No clinic workflow is shipped in Release 1 evidence. | M30 | Product scope controls | Medium |
| PRD-MKT-006 | Restaurants MUST be excluded in Release 1. | No restaurant/table-management behavior appears in Release 1 scope artifacts. | M30 | Product scope controls | Medium |
| PRD-MKT-007 | Appointment workflows MUST be excluded in Release 1. | No appointment booking or slot booking state path is implemented as released behavior. | M30 | Queue behavior | Medium |
| PRD-MKT-008 | Marketing messaging MUST NOT be part of Release 1. | Outbound templates are queue-related only and not campaign-oriented. | M30 | Messaging behavior | Medium |
| PRD-MKT-009 | Customer mobile application MUST NOT be part of Release 1. | No customer mobile app is delivered as part of Release 1. | M30 | Product scope | High |
| PRD-MKT-010 | iOS business application MUST NOT be part of Release 1. | No iOS business app scope, project structure, or delivery is present in Release 1. | M30 | Product scope | High |
| PRD-WEB-001 | Customer check-in and status MUST be browser-based. | Customers complete check-in/status through mobile browser URLs and web check-in pages. | M30 | Customer surface | High |

### 39.2 Organization, tenant, and approval requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-TENANT-001 | One owner MAY manage multiple locations. | Demonstrated in data model and approval flow for organization/location associations. | M08 | Business-owner controls | Medium |
| PRD-TENANT-002 | Every active location MUST have its own subscription entitlement. | Operations requiring entitlement fail when the location is not subscribed/active. | M10 | Location management | High |
| PRD-TENANT-003 | All operations MUST be role-authorized and location-scoped. | Unauthorized action attempts are denied with explicit permission errors. | M09 | All surfaces | High |
| PRD-TENANT-004 | Unlimited operational staff accounts are allowed in Release 1. | No enforced cap exists for operational staff account count. | M08 | Owner/admin surfaces | Low |
| PRD-ONBOARD-001 | Platform administrator approval MUST occur before operational activation. | Operations cannot start without admin approval state. | M09 | Admin portal | High |
| PRD-ONBOARD-002 | Platform administrator approval MUST be required for spending-limit increases. | Overage-cap increases fail without admin approval token/action. | M14 | Admin portal | High |

### 39.3 Pricing, trial, and subscription requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-SUB-001 | Monthly software price MUST be 39.99 USD per active location per month. | Billing calculation equals 39.99 × active subscribed locations. | M11 | Billing engine | High |
| PRD-SUB-002 | Annual software price MUST be 399.99 USD per active location per year. | Annual invoice line for software equals 399.99 per active location. | M11, M13 | Billing engine | High |
| PRD-SUB-003 | Multi-location discounts MUST NOT be applied. | No discount logic modifies location-level pricing. | M13 | Billing engine | Medium |
| PRD-SUB-004 | Trial clock MUST be 14 days from configured start event. | Trial transition timeline reflects exactly 14 days. | M11 | Trial workflow | Medium |
| PRD-SUB-005 | Trial activation MUST require a payment method. | Trial transitions cannot begin without payment method. | M11 | Billing/onboarding | High |
| PRD-SUB-006 | Trial activation MUST require platform-administrator approval. | Trial state remains disabled until admin approval. | M09 | Onboarding flow | High |
| PRD-SUB-007 | Trial MUST include exactly 100 SMS segments. | Trial message usage starts at 0 and hard-stops at 100 non-billed usage. | M11, M12 | Billing/usage | Medium |
| PRD-SUB-008 | Trial MUST NOT generate paid overages. | Overages are not invoiced while trial state is active. | M12, M14 | Billing/usage | High |
| PRD-SUB-009 | Trial SMS MUST pause after allowance exhaustion. | After 100 trial segments, SMS send dispatch is restricted while queue stays active. | M12, M14 | Messaging | High |
| PRD-SUB-010 | Queue and live status MUST remain functional when trial SMS is paused. | Queue operations and status pages remain available in SMS-paused trial state. | M24 | Queue/status | High |
| PRD-SUB-011 | Monthly subscription MUST start automatically at trial end unless canceled. | Uncanceled trials transition to `MONTHLY_ACTIVE` at trial end; canceled trials do not auto-convert. | M11 | Billing workflow | High |
| PRD-SUB-012 | Annual billing MUST require explicit annual selection. | No annual invoice can be generated without explicit annual selection. | M13 | Billing workflow | High |
| PRD-SUB-013 | Monthly messaging cycle MUST include 300 provider-billed segments. | Messaging cycle credits reset to 300 each cycle. | M12 | Usage engine | High |
| PRD-SUB-014 | Included SMS segments MUST NOT roll over. | Unused segments at cycle end are not carried to next cycle. | M12 | Usage engine | Medium |
| PRD-SUB-015 | Overage segments MUST cost 0.03 USD each. | Reconciliation formulas show 0.03 per additional provider-billed segment. | M12 | Billing engine | High |
| PRD-SUB-016 | Default monthly overage limit MUST be 50 USD per location. | Overages stop when 50 USD is reached without override. | M14 | Billing engine | High |
| PRD-SUB-017 | New locations MUST be treated as controlled postpaid businesses. | New paid businesses are in controlled postpaid mode. | M14 | Billing model | Medium |
| PRD-SUB-018 | A location MUST become established only after two consecutive successfully settled billing cycles on that same location. | State is achieved when the location has two paid billing settlements, including zero-overage settlements, with no unresolved failed/disputed invoice. | M14 | Billing model | Medium |
| PRD-SUB-019 | Established locations MUST remain in postpaid mode on that location only. | Established status is retained per location and does not transfer to other locations or organizations. | M14 | Billing policy | Medium |
| PRD-SUB-020 | Annual software charges MUST be billed annually. | Annual plan charge occurs once per year per active location. | M13 | Billing engine | High |
| PRD-SUB-021 | Annual subscribers MUST receive monthly SMS overage billing. | Overage invoices are generated per monthly messaging cycle. | M13, M12 | Billing engine | Medium |

### 39.4 Queueing and check-in requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-LOC-001 | Locations MUST support multiple queues. | Multiple queue entities may be active per location. | M21 | Location management | Medium |
| PRD-QUEUE-001 | Each queue entry MUST represent one customer only and may not represent a party or group. | One queue entry maps to one customer record only; the same person may rejoin with a new entry later. | M22 | Queue model | High |
| PRD-QUEUE-002 | Queue ordering MUST default to FIFO. | By default, later entrants join at the tail unless reorder action is used. | M23 | Queue behavior | High |
| PRD-QUEUE-003 | Manual reorder MUST require a non-empty reason and MUST be audited. | All reorder events include reason and audit record. | M23 | Queue operations | High |
| PRD-QUEUE-004 | Service selection is optional and business-configurable. | Queue entry may omit service while retaining valid state transitions. | M21 | Queue configuration | Medium |
| PRD-QUEUE-005 | Default no-show hold MUST be 5 minutes. | Default timer value is 5 minutes absent business configuration. | M24 | Queue timing | Medium |
| PRD-QUEUE-006 | Customer extension MUST be business-configurable. | Extensions only occur under active queue operator controls and configured limits. | M24 | Queue operations | Medium |
| PRD-QUEUE-007 | Maximum queue size MUST be configurable per queue. | Queue admission is blocked at configured cap. | M21 | Queue configuration | Medium |
| PRD-QUEUE-008 | Multiple staff devices MAY operate the same queue concurrently. | Concurrent mutation requests are synchronized to avoid loss or corruption. | M29 | Queue operations | High |
| PRD-QUEUE-009 | Queue mutations MUST require network. | Mutations return explicit offline/mutation-block results without state mutation. | M29 | Queue operations | High |
| PRD-QUEUE-010 | Cached queue state MUST be read-only during outages. | Read operations may succeed from cache; writes are prohibited with stale-write indicators. | M29 | Queue operations | High |
| PRD-QUEUE-011 | Priority and VIP ordering MUST NOT be implemented in Release 1. | No priority or VIP ordering logic is delivered as a shipped behavior. | M30 | Ordering behavior | Medium |
| PRD-CHECKIN-001 | Customers MUST be able to self-check-in with QR. | Valid QR check-in joins a queue when required fields are provided. | M25 | Customer check-in | High |
| PRD-CHECKIN-002 | Staff-assisted check-in MUST exist as fallback. | Staff can add entries without QR when required. | M25, M28 | Staff check-in | High |
| PRD-CHECKIN-003 | Mobile number MUST be required. | Submissions without valid phone number are rejected. | M25 | Customer check-in | High |
| PRD-CHECKIN-004 | Name or nickname MUST be required. | Submission without display name is rejected. | M25 | Customer check-in | Medium |
| PRD-CHECKIN-005 | Service MUST be optional at check-in. | Service may be omitted without preventing entry creation. | M25, M21 | Customer check-in | Low |
| PRD-CHECKIN-006 | Remote joining MUST be configurable per location. | Remote joining enabled allows a standard shareable join link; disabled joins are restricted to QR route and staff-assisted check-in. | M25 | Business policy | Medium |
| PRD-CHECKIN-007 | Advance joining MUST be configurable per location. | Advance joining is active only when enabled and applies only outside the currently open walk-in period. | M25 | Business policy | Medium |
| PRD-CHECKIN-008 | Check-in must respect operating-hours policy by default. | Joins outside hours are rejected or deferred per policy setting. | M25 | Business policy | Medium |
| PRD-CHECKIN-009 | Customers MUST be able to leave queue immediately. | A customer-initiated leave transitions queue state to CANCELLED. | M24, M26 | Customer status | Medium |

### 39.5 Custom questions and customer data requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-CUSTOM-001 | A queue MUST expose at most five active custom questions. | Validation prevents active custom question count above five. | M21 | Queue configuration | Medium |
| PRD-CUSTOM-002 | Allowed question types MUST be short text, yes/no, single select, and multi-select. | Validation allows only those type values. | M21 | Queue configuration | Medium |
| PRD-CUSTOM-003 | File-upload custom questions MUST NOT be supported. | Upload input is rejected and not exposed. | M21 | Queue configuration | Medium |
| PRD-CUSTOM-004 | Medical information, government ID, payment-card, password, and account credentials MUST NOT be requested. | Prohibited data types and patterns are blocked or flagged; a visible warning and owner attestation are required; admins can investigate, disable questions, suspend violating locations, and all actions are auditable; automation is defense-in-depth and not perfect. | M21 | Check-in data policy | High |
| PRD-CUSTOM-005 | Sensitive-data warning MUST be shown before question display. | Warning appears before any custom-question answer flow. | M21 | Customer check-in | Medium |

### 39.6 Messaging requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-SMS-001 | Default events MUST include joined, almost ready, your turn, and missed/no-show. | All four default event identifiers exist and are operationally available. | M18 | Messaging | Medium |
| PRD-SMS-002 | Businesses MAY disable individual default event notifications. | Disabling one event prevents only that event. | M18 | Messaging config | Medium |
| PRD-SMS-003 | SMS templates MUST be customizable within segment constraints. | Template updates validate against segment and text boundaries. | M18, M21 | Messaging templates | Medium |
| PRD-SMS-004 | Messaging storage MUST be English-first and localization-ready. | English remains default and locale metadata supports extension. | M19 | Messaging templates | Medium |
| PRD-SMS-005 | Incoming replies MUST support STOP and HELP. | Messages with STOP/HELP are processed per policy. | M20 | Messaging replies | High |
| PRD-SMS-006 | Incoming reply support MUST include one structured "I'm coming" response. | Exactly one structured variant is supported and handled. | M20 | Messaging replies | Medium |
| PRD-SMS-007 | Billing MUST be based on provider-billed segment counts. | Overage computation uses provider segment counts from trusted events. | M19 | Billing | High |
| PRD-SMS-008 | Template preview MUST show predicted segment count. | Preview renders predicted segments before save. | M18, M21 | Messaging templates | Medium |
| PRD-SMS-009 | Every active location MUST have exactly one dedicated messaging number. | State model reports one number per active subscribed location only. | M17 | Number provisioning | Medium |

### 39.7 Status, no-show, and extension requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-STATUS-001 | Customer status experience MUST be private. | Each customer sees only own queue status and queue entry context. | M26 | Customer status page | High |
| PRD-WAIT-001 | Wait estimation MUST be provided where supported. | Status page presents wait estimation in supported states. | M24 | Customer status | Medium |
| PRD-NOSHOW-001 | No-show must be recorded only when explicitly confirmed by staff after hold expiry in `CALLED`. | NO_SHOW cannot be auto-applied and must not occur from `WAITING` or `SERVING`. | M24 | Queue operations | High |
| PRD-NOSHOW-002 | Extension MUST follow policy and policy limits. | Extension is accepted only when allowed and within configured limits. | M24 | Customer/queue operations | Medium |

### 39.8 Platform surfaces and operations requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-PLAT-001 | Business operators MUST use native Android app as operator client. | Core operator flows are available on Android as a first operator surface. | M27 | Android app | High |
| PRD-PLAT-002 | Android minimum version MUST be 12. | Android OS check enforces minimum version 12. | M27 | Android app | Medium |
| PRD-PLAT-003 | Android release path MUST be closed pilot first. | Public release is explicitly deferred until approved pilot stage criteria are met. | M27, M30 | Distribution process | High |
| PRD-WEB-002 | Business-owner portal MUST support queue, location, staff, subscription, and messaging configuration. | Portal includes management controls for all listed areas. | M30 | Owner portal | High |
| PRD-WEB-003 | Platform-admin portal MUST support approval, suspension, restore, spending-limit approval, and auditing. | Admin workflows include listed actions and emit audit evidence. | M09 | Admin portal | High |
| PRD-WEB-004 | Subscription and billing purchase MUST occur on website surfaces. | No alternative non-web purchase surface is required for Release 1. | M11, M30 | Billing portals | Medium |
| PRD-WEB-005 | Kiosk and public display modes MUST be deferred unless pilot trigger is met. | These modes remain unshipped and are documented as deferred. | M30 | Product scope | Medium |

### 39.9 Security, privacy, and audit requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-PRIV-001 | Identifiable customer data (name, phone, custom answers) MUST be retained for 30 days. | Data lifecycle deletes or archives entries after 30 days as specified. | M30 | Data lifecycle | High |
| PRD-PRIV-002 | Customer phone export MUST NOT occur by default. | No default export path includes phone fields. | M30 | Admin/owner tools | Medium |
| PRD-PRIV-003 | Queue-SMS consent must be explicit and separate from marketing consent. | Queue-SMS messaging is sent only after capturing queue-SMS consent with phone, location, queue entry, timestamp, text version, and capture method; declined consent suppresses SMS only. | M30 | Consent flows | Medium |
| PRD-PRIV-004 | Queue phone numbers MUST NOT be used for advertising. | No ad-targeting behavior may consume queue phone numbers. | M30 | Messaging/policy | High |
| PRD-PRIV-005 | Authorized staff MAY view complete customer phone numbers. | Authorized roles can access complete values. | M30 | Queue operations | Medium |
| PRD-PRIV-006 | Phone-number access MUST be auditable. | Every full-number view action is logged. | M30 | Audit layer | High |
| PRD-PRIV-007 | Formal deletion MUST follow the privacy workflow. | Deletion follows documented privacy process and controls. | M30 | Privacy workflow | Medium |
| PRD-AUDIT-001 | Sensitive and privileged actions MUST emit audit events. | At minimum, sensitive operations appear in auditable records. | M30 | Audit subsystem | High |
| PRD-AUDIT-002 | Manual reorder actions MUST be auditable with reason/context. | Reorder records include reason, actor, and authorization context. | M23 | Queue operations | High |
| PRD-SEC-001 | Tenant isolation MUST be enforced across all operations. | Negative tests show no cross-tenant read/write across locations/organizations. | M08, M30 | All surfaces | Critical |
