# Walk-In Queue Manager — Release 1 Project Plan

This archive contains one implementation specification for each of the 30 milestones required to deliver the first business-ready Android release.

## Product summary

- Initial market: US barbershops, hair salons, and beauty salons.
- Business application: native Android, Android 12 or newer.
- Customer interface: mobile web through QR code; no customer app.
- Pricing: $39.99 monthly or $399.99 annually per active location.
- Trial: 14 days, payment method and administrator approval required, 100 SMS segments.
- Paid usage: 300 SMS segments included per monthly messaging cycle; $0.03 per additional provider-billed segment.
- Dedicated SMS number: one per active subscribed location.
- Default overage exposure: $50 per location; increases require administrator approval.
- Queue mutations require internet; Android shows cached data read-only during outages.

## Recommended execution order

Milestones are numbered in dependency order. Do not begin a milestone until its listed dependencies are accepted, unless the milestone file explicitly permits parallel preparation.

## Directory contents

- `00_locked_product_baseline.md` — authoritative approved product decisions.
- `01_...md` through `30_...md` — individual implementation milestones.
- `ROADMAP.md` — phase overview, estimates, and critical path.
- `SOURCE_ANSWERS.txt` — the product-owner questionnaire answers supplied for planning.

## Completion rule

A milestone is complete only when:

1. All acceptance criteria pass.
2. Automated tests pass.
3. Required manual verification is complete.
4. Documentation is updated.
5. Completion evidence is committed or referenced.
6. The working tree is clean.
7. External/manual blockers are explicitly recorded rather than hidden.

## Estimate

The plan contains approximately **152 focused development days**, before contingency and external review delays. A solo full-time implementation should be planned as roughly **7–9 months**, depending on experience, pilot availability, provider approvals, and defect rates.
