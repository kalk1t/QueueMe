# Release 1 Requirements Traceability Matrix

## 1) Baseline to PRD mapping

| Baseline source | Requirement ID | Requirement title | Implementing milestone | Verification milestone | Acceptance evidence | Status |
| --- | --- | --- | --- | --- | --- | --- |
| `00_locked_product_baseline.md` (Target market) | PRD-MKT-001 | US-first release scope | M30 | M30 | Market scope review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Target market) | PRD-MKT-002 | Target: barbershops | M30 | M30 | Market scope review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Target market) | PRD-MKT-003 | Target: hair salons | M30 | M30 | Market scope review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Target market) | PRD-MKT-004 | Target: beauty salons | M30 | M30 | Market scope review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Exclusions) | PRD-MKT-005 | Exclude medical clinics | M30 | M30 | Scope controls | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Exclusions) | PRD-MKT-006 | Exclude restaurants | M30 | M30 | Scope controls | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Exclusions) | PRD-MKT-007 | Exclude appointments | M30 | M30 | Scope controls | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Exclusions) | PRD-MKT-008 | Exclude marketing messages | M30 | M30 | Scope controls | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Exclusions) | PRD-MKT-009 | Exclude customer mobile app | M30 | M30 | Scope controls | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Exclusions) | PRD-MKT-010 | Exclude iOS business app | M30 | M30 | Scope controls | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-001 | Monthly price: 39.99 per active location | M11 | M30 | Invoice formula review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-002 | Annual price: 399.99 per active location | M13 | M30 | Invoice formula review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-003 | No multi-location discount | M13 | M30 | Billing formula review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-004 | 14-day trial | M11 | M30 | Trial lifecycle review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-005 | Payment method required for trial | M11 | M30 | Billing prerequisite validation | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-006 | Admin approval required for trial | M09 | M30 | Admin approval logs | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-007 | 100 trial SMS segments | M12 | M30 | Trial SMS ledger review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-008 | No paid trial overages | M12 | M30 | Trial usage invoice review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-009 | SMS pause after trial allowance exhaustion | M12, M14 | M30 | Trial pause evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-010 | Queue/status continue without SMS | M24 | M30 | Queue continuity evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue and billing behavior) | PRD-SUB-011 | Monthly starts automatically at trial end unless canceled | M11 | M30 | Transition evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-012 | Annual billing only after explicit annual selection | M13 | M30 | Subscription selection review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-013 | 300 segments per monthly messaging cycle | M12 | M30 | Messaging cycle evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-014 | No segment rollover | M12 | M30 | Cycle reset evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-015 | Overages charged at 0.03 USD per segment | M12 | M30 | Billing ledger review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-016 | Default overage limit 50 USD | M14 | M30 | Overage cap review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-017 | New businesses controlled postpaid | M14 | M30 | Entitlement profile review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-018 | Established on location only after two consecutive successfully settled cycles on that same location | M14 | M30 | Billing state review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-019 | Established businesses remain postpaid | M14 | M30 | Entitlement profile review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-020 | Annual software billed annually | M13 | M30 | Software invoice cadence review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Pricing and billing) | PRD-SUB-021 | Annual software + monthly SMS overages | M13, M12 | M30 | Combined billing review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue and ownership) | PRD-TENANT-001 | One owner may manage several locations | M08 | M08 | Multi-location owner workflow | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue and ownership) | PRD-TENANT-002 | One subscription entitlement per active location | M10 | M10 | Location entitlement checks | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue and ownership) | PRD-TENANT-003 | Role-based operations | M09 | M30 | Permission test evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue and ownership) | PRD-TENANT-004 | Unlimited operational staff accounts (V1) | M08 | M30 | Staff count policy review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue and ownership) | PRD-ONBOARD-001 | Admin approval before operational activation | M09 | M30 | Approval-state evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue and ownership) | PRD-ONBOARD-002 | Admin approval required for limit increases | M14 | M30 | Spending-cap workflow evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue and structure) | PRD-LOC-001 | Multiple queues per location | M21 | M30 | Queue list evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue operation) | PRD-QUEUE-001 | One queue entry maps to one customer only and does not represent a party or group | M22 | M30 | Entry validation evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue operation) | PRD-QUEUE-002 | FIFO ordering default | M23 | M30 | Ordering evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue operation) | PRD-QUEUE-003 | Audited manual reordering with reason | M23 | M30 | Reorder audit evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue structure) | PRD-QUEUE-004 | Business-configurable services | M21 | M30 | Service field evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue operation) | PRD-QUEUE-005 | Default 5-minute no-show hold | M24 | M30 | No-show timer evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue operation) | PRD-QUEUE-006 | Customer extension configuration | M24 | M30 | Extension policy evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue operation) | PRD-QUEUE-007 | Configurable max queue size | M21 | M30 | Queue admission tests | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue operation) | PRD-QUEUE-008 | Multiple staff device operations | M23, M29 | M30 | Concurrency evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue operation) | PRD-QUEUE-009 | Internet required for mutations | M29 | M30 | Offline mutation rejection evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue operation) | PRD-QUEUE-010 | Cached read-only queue state during outages | M29 | M30 | Cache read behavior evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Queue operation) | PRD-QUEUE-011 | No priority/VIP ordering in V1 | M30 | M30 | Ordering policy review | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CHECKIN-001 | QR self-check-in | M25 | M30 | QR check-in evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CHECKIN-002 | Staff-assisted manual check-in fallback | M25, M28 | M30 | Staff check-in evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CHECKIN-003 | Mandatory mobile number for check-in | M25 | M30 | Validation evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CHECKIN-004 | Name or nickname required | M25 | M30 | Check-in validation evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CHECKIN-005 | Optional service at check-in | M25 | M30 | Service option behavior evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CHECKIN-006 | Remote joining enabled by location policy via shareable join link; disabled when QR/staff-only mode is used | M25 | M30 | Policy evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CHECKIN-007 | Advance joining is configurable and applies only outside current open walk-in windows when enabled | M25 | M30 | Policy evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CHECKIN-008 | Check-in respects operating hours | M25 | M30 | Queue-hour policy evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CHECKIN-009 | Customers may leave queue immediately | M24, M26 | M30 | Leave behavior evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CUSTOM-001 | Max five active custom questions per queue | M21 | M30 | Question count validation evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CUSTOM-002 | Supported custom question types | M21 | M30 | Question type validation evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CUSTOM-003 | No file-upload custom questions | M21 | M30 | Question input validation evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CUSTOM-004 | Prohibited sensitive content categories | M21 | M30 | Validation evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Customer check-in) | PRD-CUSTOM-005 | Sensitive-data warning required | M21 | M30 | Warning UX evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Messaging) | PRD-SMS-001 | Default SMS event set | M18 | M30 | Event catalog evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Messaging) | PRD-SMS-002 | Disable individual events | M18 | M30 | Event toggle evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Messaging) | PRD-SMS-003 | Template customization | M18 | M30 | Template edit evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Messaging) | PRD-SMS-004 | English-first localization-ready templates | M19 | M30 | Localization evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Messaging) | PRD-SMS-005 | STOP and HELP support | M20 | M30 | Reply handling evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Messaging) | PRD-SMS-006 | "I'm coming" structured reply support | M20 | M30 | Reply routing evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Messaging) | PRD-SMS-007 | Billing per provider-billed segments | M12 | M30 | Billing evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Messaging) | PRD-SMS-008 | Template preview with segment estimate | M18 | M30 | Template preview evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Messaging) | PRD-SMS-009 | One dedicated number per active location | M17 | M30 | Number assignment evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Status and wait) | PRD-STATUS-001 | Private live status experience | M26 | M30 | Status privacy evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Status and wait) | PRD-WAIT-001 | Wait estimates presented to customer | M24 | M30 | Wait-estimation evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (No-show) | PRD-NOSHOW-001 | No-show is only recorded after staff confirmation from CALLED after hold timeout | M24 | M30 | No-show transition evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (No-show) | PRD-NOSHOW-002 | Extension request under policy | M24 | M30 | Extension behavior evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Platform surfaces) | PRD-PLAT-001 | Native Android business application | M27 | M30 | Android app evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Platform surfaces) | PRD-PLAT-002 | Android min version 12 | M27 | M30 | OS target evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Platform surfaces) | PRD-PLAT-003 | Closed pilot distribution path | M30 | M30 | Distribution evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Platform surfaces) | PRD-WEB-001 | Browser-based check-in and status | M30 | M30 | Experience evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Platform surfaces) | PRD-WEB-002 | Business-owner portal capabilities | M30 | M30 | Portal capability evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Platform surfaces) | PRD-WEB-003 | Platform-admin portal capabilities | M09 | M30 | Admin capability evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Platform surfaces) | PRD-WEB-004 | Subscription purchase in website | M11 | M30 | Purchase flow evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Platform surfaces) | PRD-WEB-005 | Kiosk/public display deferred unless pilot | M30 | M30 | Scope evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Privacy and retention) | PRD-PRIV-001 | Retain identifiers for 30 days | M30 | M30 | Retention evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Privacy and retention) | PRD-PRIV-002 | No default phone export | M30 | M30 | Export policy evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Privacy and retention) | PRD-PRIV-003 | Queue SMS consent explicit and separate from marketing; capture must include phone, location, queue entry, timestamp, text version, capture method | M30 | M30 | Consent capture and audit evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Privacy and retention) | PRD-PRIV-004 | No advertising use of phone numbers | M30 | M30 | Privacy policy evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Privacy and retention) | PRD-PRIV-005 | Staff may view full phone numbers | M30 | M30 | Role access evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Privacy and retention) | PRD-PRIV-006 | Phone-number access auditable | M30 | M30 | Access log evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Privacy and retention) | PRD-PRIV-007 | Formal deletion workflow | M30 | M30 | Privacy workflow evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Privacy and retention) | PRD-AUDIT-001 | Audit-sensitive actions | M30 | M30 | Audit evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Privacy and retention) | PRD-AUDIT-002 | Reorders include reason/context | M23 | M30 | Reorder logs evidence | BLOCKED — pending approval |
| `00_locked_product_baseline.md` (Cross-tenant controls) | PRD-SEC-001 | Tenant isolation enforced | M08 | M30 | Isolation evidence | BLOCKED — pending approval |

## 2) PRD ownership map and verification targets

| Requirement ID | Implementing milestone | Verification milestone |
| --- | --- | --- |
| PRD-MKT-001 | M30 | M30 |
| PRD-MKT-002 | M30 | M30 |
| PRD-MKT-003 | M30 | M30 |
| PRD-MKT-004 | M30 | M30 |
| PRD-MKT-005 | M30 | M30 |
| PRD-MKT-006 | M30 | M30 |
| PRD-MKT-007 | M30 | M30 |
| PRD-MKT-008 | M30 | M30 |
| PRD-MKT-009 | M30 | M30 |
| PRD-MKT-010 | M30 | M30 |
| PRD-ONBOARD-001 | M09 | M09 |
| PRD-ONBOARD-002 | M14 | M14 |
| PRD-SUB-001 | M11 | M11 |
| PRD-SUB-002 | M11 | M11 |
| PRD-SUB-003 | M13 | M13 |
| PRD-SUB-004 | M11 | M11 |
| PRD-SUB-005 | M11 | M11 |
| PRD-SUB-006 | M09 | M09 |
| PRD-SUB-007 | M12 | M12 |
| PRD-SUB-008 | M12 | M12 |
| PRD-SUB-009 | M12, M14 | M30 |
| PRD-SUB-010 | M24 | M30 |
| PRD-SUB-011 | M11 | M11 |
| PRD-SUB-012 | M13 | M13 |
| PRD-SUB-013 | M12 | M12 |
| PRD-SUB-014 | M12 | M12 |
| PRD-SUB-015 | M12 | M12 |
| PRD-SUB-016 | M14 | M14 |
| PRD-SUB-017 | M14 | M14 |
| PRD-SUB-018 | M14 | M14 |
| PRD-SUB-019 | M14 | M14 |
| PRD-SUB-020 | M13 | M13 |
| PRD-SUB-021 | M12, M13 | M30 |
| PRD-TENANT-001 | M08 | M08 |
| PRD-TENANT-002 | M10 | M10 |
| PRD-TENANT-003 | M09 | M09 |
| PRD-TENANT-004 | M08 | M30 |
| PRD-LOC-001 | M21 | M21 |
| PRD-QUEUE-001 | M22 | M22 |
| PRD-QUEUE-002 | M23 | M23 |
| PRD-QUEUE-003 | M23 | M23 |
| PRD-QUEUE-004 | M21 | M21 |
| PRD-QUEUE-005 | M24 | M24 |
| PRD-QUEUE-006 | M24 | M24 |
| PRD-QUEUE-007 | M21 | M21 |
| PRD-QUEUE-008 | M23 | M23 |
| PRD-QUEUE-009 | M29 | M29 |
| PRD-QUEUE-010 | M29 | M29 |
| PRD-QUEUE-011 | M30 | M30 |
| PRD-CHECKIN-001 | M25 | M25 |
| PRD-CHECKIN-002 | M25 | M25 |
| PRD-CHECKIN-003 | M25 | M25 |
| PRD-CHECKIN-004 | M25 | M25 |
| PRD-CHECKIN-005 | M25 | M25 |
| PRD-CHECKIN-006 | M25 | M25 |
| PRD-CHECKIN-007 | M25 | M25 |
| PRD-CHECKIN-008 | M25 | M25 |
| PRD-CHECKIN-009 | M26 | M26 |
| PRD-CUSTOM-001 | M21 | M21 |
| PRD-CUSTOM-002 | M21 | M21 |
| PRD-CUSTOM-003 | M21 | M21 |
| PRD-CUSTOM-004 | M21 | M21 |
| PRD-CUSTOM-005 | M21 | M21 |
| PRD-SMS-001 | M18 | M18 |
| PRD-SMS-002 | M18 | M18 |
| PRD-SMS-003 | M18 | M18 |
| PRD-SMS-004 | M19 | M19 |
| PRD-SMS-005 | M20 | M20 |
| PRD-SMS-006 | M20 | M20 |
| PRD-SMS-007 | M12 | M12 |
| PRD-SMS-008 | M18 | M18 |
| PRD-SMS-009 | M17 | M30 |
| PRD-STATUS-001 | M26 | M26 |
| PRD-WAIT-001 | M24 | M24 |
| PRD-NOSHOW-001 | M24 | M24 |
| PRD-NOSHOW-002 | M24 | M24 |
| PRD-PLAT-001 | M27 | M27 |
| PRD-PLAT-002 | M27 | M27 |
| PRD-PLAT-003 | M30 | M30 |
| PRD-WEB-001 | M30 | M30 |
| PRD-WEB-002 | M30 | M30 |
| PRD-WEB-003 | M30 | M30 |
| PRD-WEB-004 | M11 | M11 |
| PRD-WEB-005 | M30 | M30 |
| PRD-PRIV-001 | M30 | M30 |
| PRD-PRIV-002 | M30 | M30 |
| PRD-PRIV-003 | M30 | M30 |
| PRD-PRIV-004 | M30 | M30 |
| PRD-PRIV-005 | M30 | M30 |
| PRD-PRIV-006 | M30 | M30 |
| PRD-PRIV-007 | M30 | M30 |
| PRD-AUDIT-001 | M30 | M30 |
| PRD-AUDIT-002 | M23 | M23 |
| PRD-SEC-001 | M08 | M30 |
