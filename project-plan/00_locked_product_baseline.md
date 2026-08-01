# Locked Product Baseline

This file is the functional source of truth for Release 1. Milestones may refine implementation details but may not silently change these decisions.

## Target market

- US-first release
- Barbershops
- Hair salons
- Beauty salons

## Explicit exclusions

- Medical clinics
- Restaurants
- Appointments
- Marketing messages
- Customer mobile app
- iOS business app

## Pricing and billing

- $39.99 per active location per month
- $399.99 per active location per year
- No multi-location discount
- 14-day trial with payment method and administrator approval
- 100 SMS segments included during trial
- 300 SMS segments included per monthly messaging cycle
- $0.03 per additional provider-billed SMS segment
- $50 default SMS overage limit per location
- Limit increases require platform-administrator approval
- A business becomes established after two successfully paid billing cycles

## Queue operation

- Multiple queues per location
- One person per queue entry
- Optional, business-configurable service selection
- FIFO ordering with audited manual reordering
- Five-minute default no-show hold
- Business-configurable extension
- Maximum queue size configurable by business
- Several staff devices may operate one queue simultaneously
- Internet required for mutations; cached read-only queue during outages

## Customer check-in

- QR self-check-in
- Staff-assisted manual check-in fallback
- Mandatory mobile number
- Name or nickname
- Optional service
- Up to five custom questions: short text, yes/no, single select, multi-select
- No files, medical data, government IDs, payment card data, passwords, or credentials
- Remote joining and advance joining are business-configurable

## Messaging

- One dedicated messaging number per active subscribed location
- Default notifications: joined, almost ready, your turn, missed/no-show
- Businesses may disable individual events
- Businesses may customize templates within character and segment limits
- English-first templates, localization-ready storage
- Supported replies: STOP, HELP, and one structured “I’m coming” reply
- Charge per provider-billed segment, not per send operation

## Privacy and retention

- Identifiable customer name, phone, and custom answers retained for 30 days
- No default export of customer phone numbers
- Queue consent is not marketing consent
- No advertising use of queue phone numbers
- Staff may view complete phone numbers; access remains auditable

## Android and distribution

- Native Android business application
- Android 12 minimum supported version
- Closed pilot before public Google Play release
- Subscription purchase and billing occur on the website
- Customer experience is browser-based
- Kiosk and public display are deferred unless a pilot requires them

## Additional locked rules

- Staff-assisted manual check-in is required as a fallback.
- Trial SMS stops when 100 segments are consumed; queue and live status continue.
- Annual subscribers are charged software annually and SMS overage monthly.
- The 300-segment allowance resets monthly for both monthly and annual subscribers and does not roll over.
- Established businesses remain postpaid and may request higher limits, subject to administrator approval.
- Completed identifiable custom-question answers follow the same 30-day retention rule.
- Platform administrator approval is required before a business becomes operational.
