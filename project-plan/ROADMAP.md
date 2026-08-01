# Release 1 Roadmap

## Phases

### Phase I — Product and Engineering Foundation

- Milestone 1: Product Specification Lock — 3 working days
- Milestone 2: Architecture and Decision Records — 3 working days
- Milestone 3: Repository and Engineering Standards — 4 working days
- Milestone 4: Continuous Integration and Environment Skeleton — 4 working days

### Phase II — Infrastructure and Data Platform

- Milestone 5: AWS Development and Staging Foundation — 5 working days
- Milestone 6: Core Database Schema — 5 working days
- Milestone 7: Authentication and Session Security — 5 working days
- Milestone 8: Organizations, Locations, Staff, and Roles — 6 working days
- Milestone 9: Administrator Approval and Business Lifecycle — 5 working days

### Phase III — Subscription and Usage Billing

- Milestone 10: Subscription Entitlement Engine — 6 working days
- Milestone 11: Stripe Monthly, Annual, and Trial Billing — 6 working days
- Milestone 12: SMS Allowance and Overage Ledger — 5 working days
- Milestone 13: Annual Software and Monthly SMS Billing — 4 working days
- Milestone 14: Spending Limits, Payment Failure, and Dunning — 5 working days

### Phase IV — Messaging and Compliance

- Milestone 15: Twilio ISV Tenancy Architecture — 5 working days
- Milestone 16: Business Messaging Registration Workflow — 5 working days
- Milestone 17: Dedicated Number Provisioning — 6 working days
- Milestone 18: Consent, Templates, and Segment Preview — 5 working days
- Milestone 19: Outbound Messaging and Delivery Receipts — 4 working days
- Milestone 20: STOP, HELP, and “I’m Coming” Replies — 5 working days

### Phase V — Queue Domain

- Milestone 21: Queue, Service, and Custom-Question Configuration — 5 working days
- Milestone 22: Queue-Entry State Machine — 5 working days
- Milestone 23: Ordering, Manual Movement, and Concurrency — 6 working days
- Milestone 24: Wait Estimation, No-Show, and Extension — 5 working days

### Phase VI — Customer Web Experience

- Milestone 25: QR-Code Customer Check-In — 4 working days
- Milestone 26: Live Customer Status Page — 5 working days

### Phase VII — Android Business Application

- Milestone 27: Android Foundation and Device Enrollment — 5 working days
- Milestone 28: Android Queue Operations — 5 working days
- Milestone 29: Android Synchronization, Cache, and Operational Polish — 6 working days

### Phase VIII — Release Certification

- Milestone 30: Business-Ready Release Certification — 10 working days

## Critical path

Specification → Architecture → Repository/CI → Infrastructure → Schema/Auth/Tenancy → Billing → Messaging compliance → Queue domain → Customer web → Android → Pilot and production certification.

## Estimate

- Focused implementation estimate: 152 working days.
- Add 15–25% contingency for defects, provider changes, compliance review, pilot feedback, and external approvals.
- External waiting time does not make a milestone complete; record it as a blocking acceptance item.

## Parallel work guidance

Visual design exploration, legal review, pilot recruitment, provider account setup, and store asset preparation may begin earlier, but they may not bypass milestone acceptance gates or introduce unapproved scope.
