# Release 1 Glossary

| Term | Definition |
| --- | --- |
| Account | An authenticated identity for a person or system role in QueueMe. |
| Organization | A business entity that owns one or more locations and users. |
| Business | Synonym for Organization in Release 1. |
| Location | A staffed physical or operational unit under one organization. |
| Active location | A location currently approved and subscribed for operational service. |
| Staff member | A person authorized to operate queues for a location. |
| Owner | The business account user with full organization configuration rights. |
| Manager | A role authorized for some operational and configuration actions at location level. |
| Queue operator | A role that performs check/serve/complete/no-show actions for entries. |
| Platform administrator | QueueMe operator responsible for business approval, limits, and diagnostics. |
| Queue | A waiting line owned by a location, with ordered queue entries. |
| Queue entry | One customer record inside a single queue. |
| Service | A configurable service/category value associated with a queue entry. |
| Custom question | A configurable prompt shown at check-in and stored as answer data. |
| Queue position | The current sequence index of an active queue entry in a queue. |
| Called | Queue state indicating customer has been selected for service. |
| Serving | Queue state indicating service is currently in progress for the entry. |
| Completed | Queue state indicating service for entry is finished. |
| No-show | Queue state indicating customer did not appear within allowed no-show window. |
| Called hold | The configured interval that starts when an entry enters `CALLED` and ends when hold-based no-show confirmation becomes required. |
| No-show confirmation | The explicit staff action that transitions an entry from `CALLED` to `NO_SHOW` after the called hold expiry. |
| Customer extension | A temporary hold allowing a customer more time to arrive/return. |
| Trial | Temporary subscription state lasting 14 days with reduced SMS entitlement. |
| Billing cycle | Calendar period used to compute location software charges for recurring subscription. |
| Monthly messaging cycle | Recurring cycle that resets SMS allowance and usage each month. |
| Included SMS segment | Segment quota that does not generate overage charges in the cycle. |
| Overage segment | Additional provider-billed segment beyond allowance that may incur cost. |
| Provider-billed segment | SMS segment count reported by provider telemetry for chargeability. |
| Spending limit | Per-location maximum amount enforceable for SMS overage charges. |
| Established location | Location that completed two consecutive successfully settled billing cycles and has no unresolved failed/disputed invoice. |
| Dedicated messaging number | Single outbound/inbound message-capable phone number assigned to one active subscribed location. |
| Consent | Explicit user agreement required for the requested communication action. |
| Queue consent | Consent specific to queue operational messaging only. |
| Marketing consent | Consent for commercial marketing; separate from queue consent. |
| Identifiable customer data | Data that can identify an individual customer, including name, phone, and custom answers. |
| Remote joining | A check-in pathway that allows customers to join using a non-codescan route, typically via a standard link. |
| Advance joining | A check-in capability allowing customers to join before/after a queue is actively open according to configured operating-hours rules. |
| QR join route | A check-in path where queue entry creation begins from a location QR scan entry point. |
| Shareable join link | A reusable link that routes to a queue check-in entry point while not guaranteeing physical presence. |
| Tenant | One organization and all resources that must be isolated from other organizations. |
| Tenant isolation | Enforced separation of data and actions between organizations. |
| Audit event | An immutable (or tamper-evident) record of a security, billing, or state action. |
| Authoritative backend state | Source of truth for all queue, billing, and entitlement data. |
| Cached read-only state | Local temporary view of backend data that cannot accept mutations. |
| Release 1 | The first production-intended business release targeted in this milestone chain. |
| Business-ready release | Final milestone state requiring pilot operation, billing reconciliation, and security/privacy checks. |
