# Release 1 Consistency Checklist

## Scope

Date: 2026-08-01  
Status: Draft milestone-1 draft (pending product-owner approval)

## Checklist

| Check | Status | Evidence |
| --- | --- | --- |
| Every baseline bullet is represented as a requirement | PASS | `docs/product/requirements-traceability.md` baseline map contains rows for each locked decision group. |
| No baseline bullet is represented by multiple normative PRD requirements | PASS | Requirement IDs are mapped one-to-one from baseline rows in the traceability file. |
| Every normative requirement has a unique ID | PASS | IDs validated with a repository script in milestone report command log. |
| Every normative requirement has an acceptance condition | PASS | Section 39 rows in `release-1-specification.md` include explicit acceptance conditions for each requirement. |
| Every normative requirement has a future milestone owner | PASS | `requirements-traceability.md` ownership map includes all IDs with milestones. |
| No unresolved placeholders remain | PASS | Scan result shows no unresolved placeholder markers in this milestone’s normative artifacts. |
| Prices are consistent | PASS | 39.99 monthly and 399.99 annual requirements align across PRD and traceability. |
| SMS allowances are consistent | PASS | Trial 100 + monthly cycle 300 + no rollover + overage policy documented consistently. |
| Trial behavior is consistent | PASS | Trial lifecycle and transition state tables reflect all trial constraints from baseline. |
| Annual and monthly billing behavior is consistent | PASS | Separate rules for monthly/annual in Sections 13 and 14 and corresponding requirement rows. |
| Retention periods are consistent | PASS | 30-day retention appears in PRD-CUSTOM-006 and PRD-PRIV-001 and linked in traceability. |
| Excluded industries are consistent | PASS | Explicit exclusions section includes clinic, restaurant, appointment, and marketing exclusions. |
| Android minimum version is consistent | PASS | PRD-PLAT-002 with 12 minimum and mapping to Milestone 27. |
| Check-in rules are consistent | PASS | Section 19 and Section 20 plus PRD-CHECKIN-* rows cover mandatory fields and optional features. |
| Queue and concurrency rules are consistent | PASS | Sections 17–18 and Section 39 queue rows align with constraints and lifecycle wording. |
| Messaging reply behavior is consistent | PASS | SMS reply requirements in Section 25 and Section 39 SMS rows include STOP/HELP/"I'm coming". |
| No marketing consent is inferred | PASS | PRD-PRIV-003 explicitly separates queue and marketing consent. |
| No application implementation is included | PASS | Repository contains no framework source, no provider SDK, and no infrastructure resources. |

## Notes

- Status is `PENDING` because explicit product-owner approval has not been recorded.
- If requirements or IDs are later changed, regenerate the IDs and update traceability in this milestone report before proceeding.
