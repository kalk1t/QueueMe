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
| Status | Draft |
| Last updated | 2026-08-01 |
| Approval status | PENDING PRODUCT-OWNER APPROVAL |
| Branch at draft | `main` |

## 2. Authority and interpretation

This document is normative for Release 1.

Priority:

1. `project-plan/00_locked_product_baseline.md`
2. Product decisions and approvals recorded in this milestone’s supporting files
3. This PRD

Conflicts are resolved by taking the immutable locked baseline as priority.

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

Release 1 excludes non-specified verticals, distribution channels, and feature categories described in Sections 38 and 6.1.

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
| AWAITING_SUBSCRIPTION_OR_TRIAL | Location exists and awaits subscription or trial initiation | -> AWAITING_ADMIN_APPROVAL |
| AWAITING_ADMIN_APPROVAL | Preconditions are complete but administrator approval is pending | -> TRIAL_ACTIVE, -> PAID_ACTIVE, -> CANCELLED |
| TRIAL_ACTIVE | Trial is active with admin gating and payment prerequisites | -> PAID_ACTIVE, -> TRIAL_EXHAUSTED, -> CANCELLED |
| PAID_ACTIVE | Location has active paid entitlement | -> PAST_DUE, -> SMS_RESTRICTED, -> SUSPENDED, -> CANCELLED |
| PAST_DUE | Payment failed and entitlements are restricted pending recovery | -> PAID_ACTIVE, -> SUSPENDED |
| SMS_RESTRICTED | Overage spending cap has been reached or failed | -> PAID_ACTIVE, -> SUSPENDED |
| SUSPENDED | Operations suspended for compliance or policy reasons | -> PAID_ACTIVE, -> CANCELLED |
| CANCELLED | Location terminated; no entitlement remains | terminal |

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
| CREATED | Trial registration requested | -> AWAITING_APPROVAL after approval gating | Clock does not start before admin approval |
| AWAITING_APPROVAL | All prerequisites collected, waiting on admin review | -> TRIAL_ACTIVE on approval, remains while blocked otherwise | Payment method requirement is mandatory |
| TRIAL_ACTIVE | Trial currently active | -> TRIAL_EXHAUSTED on 100 segment usage, -> TRIAL_CANCELLED on cancellation, -> TRIAL_TO_PAID on completion without cancel | Trial length is 14 days unless otherwise terminated |
| TRIAL_EXHAUSTED | Trial SMS allowance exceeded | -> TRIAL_ACTIVE if SMS limit reset only by plan end; queue and status remain active; SMS dispatch restricted | Queue and live status remain available |
| TRIAL_CANCELLED | Business cancelled trial | terminal with no paid conversion | SMS and queue behavior follow cancellation policy |
| TRIAL_TO_PAID | Trial ends by time or conversion | -> PAID_TRIAL_CONVERT if not canceled, -> TRIAL_CANCELLED if canceled | Monthly starts automatically unless canceled |

### 12.2 Trial rules

- Trial duration is 14 days.
- Trial requires payment method on file before trial activation.
- Trial requires platform-administrator approval before activation.
- Trial includes 100 included SMS segments.
- Trial does not generate paid overages.
- On SMS allowance exhaustion, trial messaging pauses while queue and live status remain available.
- Trial may continue for status/check-in features without SMS sending.
- Monthly paid subscription is not automatically started until trial ends and approval conditions remain valid.

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
- Trial-to-paid transition is to monthly unless explicit annual selection exists.

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
- New businesses start in postpaid model and remain controlled by overage caps.
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
- EXPIRED

Transition intent and normative rules:

- WAITING → CALLED is triggered by queue operator action.
- CALLED → SERVING is triggered when service starts.
- SERVING → COMPLETED when operator finalizes service.
- WAITING → NO_SHOW after hold window expiration.
- WAITING → CANCELLED when customer requests leave.
- CALLED → REMOVED for manual removal.
- Serving/active entries may transition to NO_SHOW if policy allows and state checks permit.
- Any terminal state requires immutable audit record.
- EXPIRED is terminal and must not transition to active states.
- Invalid transitions (for example WAITING→COMPLETED, COMPLETED→WAITING, SERVING→CALLED) are invalid and MUST fail atomically with explicit operator-visible errors.
- Simultaneous-operation conflicts:
  - Concurrent mutations for the same queue entry must be conflict-checked.
  - Stale writes MUST be rejected deterministically; only one valid state transition may be committed.

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
- Optional business policy controls remote join and advance join.
- Operating-hours policy applies to customer joining unless explicitly overridden.

## 20. Staff-assisted check-in

Staff-assisted manual check-in MUST remain available as a fallback path when customer self-check-in is not possible.

## 21. Services and custom questions

Queue services are optional and business-configurable.

Custom questions constraints:

- At most five active questions per queue.
- Allowed types: short text, yes/no, single select, multi-select.
- No file-upload questions.
- No collection of medical, government ID, payment-card, password, or credential details.
- Sensitive-data warning MUST be shown before collection.

## 22. Customer status experience

Customers receive a browser-based private queue-status experience tied to their check-in context.

Status must show current queue position and permitted wait estimate details.

## 23. Wait estimation

Wait estimation is queue-state and historical-service-time based per queue policy.

## 24. No-show and extension behavior

- Default no-show hold = five minutes.
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
| PRD-SUB-011 | Monthly subscription MUST start automatically at trial end unless canceled. | Trial expiry transitions into monthly subscription by default when not canceled. | M11 | Billing workflow | High |
| PRD-SUB-012 | Annual billing MUST require explicit annual selection. | No annual invoice can be generated without explicit annual selection. | M13 | Billing workflow | High |
| PRD-SUB-013 | Monthly messaging cycle MUST include 300 provider-billed segments. | Messaging cycle credits reset to 300 each cycle. | M12 | Usage engine | High |
| PRD-SUB-014 | Included SMS segments MUST NOT roll over. | Unused segments at cycle end are not carried to next cycle. | M12 | Usage engine | Medium |
| PRD-SUB-015 | Overage segments MUST cost 0.03 USD each. | Reconciliation formulas show 0.03 per additional provider-billed segment. | M12 | Billing engine | High |
| PRD-SUB-016 | Default monthly overage limit MUST be 50 USD per location. | Overages stop when 50 USD is reached without override. | M14 | Billing engine | High |
| PRD-SUB-017 | New locations MUST be treated as controlled postpaid businesses. | New paid businesses are in controlled postpaid mode. | M14 | Billing model | Medium |
| PRD-SUB-018 | A business MUST be considered established after two successful paid cycles. | State becomes established after two paid cycles complete. | M14 | Billing model | Medium |
| PRD-SUB-019 | Established businesses MUST remain in postpaid mode. | Established state does not downgrade from postpaid. | M14 | Billing policy | Medium |
| PRD-SUB-020 | Annual software charges MUST be billed annually. | Annual plan charge occurs once per year per active location. | M13 | Billing engine | High |
| PRD-SUB-021 | Annual subscribers MUST receive monthly SMS overage billing. | Overage invoices are generated per monthly messaging cycle. | M13, M12 | Billing engine | Medium |

### 39.4 Queueing and check-in requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-LOC-001 | Locations MUST support multiple queues. | Multiple queue entities may be active per location. | M21 | Location management | Medium |
| PRD-QUEUE-001 | Each queue entry MUST represent one person only. | Duplicate person-attribution per active entry is prevented by queue-entry invariants. | M22 | Queue model | High |
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
| PRD-CHECKIN-006 | Remote joining MUST be configurable. | The policy setting directly controls whether remote joining is allowed. | M25 | Business policy | Medium |
| PRD-CHECKIN-007 | Advance joining MUST be configurable. | Advance-join behavior appears only when configured. | M25 | Business policy | Medium |
| PRD-CHECKIN-008 | Check-in must respect operating-hours policy by default. | Joins outside hours are rejected or deferred per policy setting. | M25 | Business policy | Medium |
| PRD-CHECKIN-009 | Customers MUST be able to leave queue immediately. | A customer-initiated leave transitions queue state to CANCELLED. | M24, M26 | Customer status | Medium |

### 39.5 Custom questions and customer data requirements

| Requirement ID | Requirement statement | Acceptance condition | Responsible future milestone | Actor/Surface | Risk |
| --- | --- | --- | --- | --- | --- |
| PRD-CUSTOM-001 | A queue MUST expose at most five active custom questions. | Validation prevents active custom question count above five. | M21 | Queue configuration | Medium |
| PRD-CUSTOM-002 | Allowed question types MUST be short text, yes/no, single select, and multi-select. | Validation allows only those type values. | M21 | Queue configuration | Medium |
| PRD-CUSTOM-003 | File-upload custom questions MUST NOT be supported. | Upload input is rejected and not exposed. | M21 | Queue configuration | Medium |
| PRD-CUSTOM-004 | Medical information, government ID, payment-card, password, and credentials MUST NOT be requested. | Validation blocks these categories. | M21 | Check-in data policy | High |
| PRD-CUSTOM-005 | Sensitive-data warning MUST be shown before question display. | Warning appears before any custom-question answer flow. | M21 | Customer check-in | Medium |
| PRD-CUSTOM-006 | Identifiable custom answers MUST be retained for 30 days. | Answer records are deleted or de-identified after 30 days. | M30 | Data lifecycle | High |

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
| PRD-NOSHOW-001 | No-show transition MUST occur after configured hold period. | NO_SHOW occurs automatically when hold window elapses unresponsive. | M24 | Queue operations | High |
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
| PRD-PRIV-003 | Queue consent and marketing consent MUST be kept distinct. | UX language and data model distinguish queue consent only. | M30 | Consent flows | Medium |
| PRD-PRIV-004 | Queue phone numbers MUST NOT be used for advertising. | No ad-targeting behavior may consume queue phone numbers. | M30 | Messaging/policy | High |
| PRD-PRIV-005 | Authorized staff MAY view complete customer phone numbers. | Authorized roles can access complete values. | M30 | Queue operations | Medium |
| PRD-PRIV-006 | Phone-number access MUST be auditable. | Every full-number view action is logged. | M30 | Audit layer | High |
| PRD-PRIV-007 | Formal deletion MUST follow the privacy workflow. | Deletion follows documented privacy process and controls. | M30 | Privacy workflow | Medium |
| PRD-AUDIT-001 | Sensitive and privileged actions MUST emit audit events. | At minimum, sensitive operations appear in auditable records. | M30 | Audit subsystem | High |
| PRD-AUDIT-002 | Manual reorder actions MUST be auditable with reason/context. | Reorder records include reason, actor, and authorization context. | M23 | Queue operations | High |
| PRD-SEC-001 | Tenant isolation MUST be enforced across all operations. | Negative tests show no cross-tenant read/write across locations/organizations. | M08, M30 | All surfaces | Critical |
