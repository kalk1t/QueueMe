# Milestone 02 Threat Model

## Purpose

Identify architectural risks before feature implementation and define controls for each.

## Threat scenarios

| Threat | Asset | Actor | Attack path | Preventive controls | Detective controls | Recovery controls | Residual risk | Future milestone |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Cross-tenant data access | Queue, billing, customer data | Malicious user in same environment | Predictable IDs or missing scope check | Mandatory org/location scope checks on every query | Tenant isolation audit tests | Quarantine tenant and invalidate sessions | Medium | M08, M30 |
| Cross-location privilege escalation | Location-scoped records | Privileged staff or owner | Weak location scoping in queue/billing commands | Role + location matrix and query scoping | Denial anomaly logs | Force logout and reset role assignments | Medium | M09 |
| Stolen Android device | Operator credentials | User device lost | Session replay from cached token | Short-lived sessions and revocation list | Device login anomaly telemetry | Remote session revoke and reset credentials | Medium | M27 |
| Stolen or replayed session | API session | Attacker | Captured token | Rotation, signing, expiry, IP anomalies | Invalid token alert and concurrent session checks | Session revoke and MFA for operators | Medium | M07 |
| Forged Stripe webhook | Billing state | External attacker | Signed webhook payload spoofing | Signature verification and secret rotation | Webhook signature failures | Invalidate key and replay-safe inbox | Low | M11 |
| Forged Twilio webhook | SMS ledger / queue messages | External attacker | Endpoint replay/spoof | Signature verification + source restriction | Duplicate source alerts | Pause SMS intake and rotate secrets | Medium | M20 |
| Duplicate webhook | Billing/usage consistency | Provider retry or attacker | Same webhook replay | Dedupe by provider event ID + tenant scope | Replay metrics and dedupe counters | Ignore duplicate and continue with replay evidence | Low | M11 |
| Out-of-order webhook | Billing, queue messaging | Network/proxy delay | Reordered deliveries | Sequence checks and event time handling | Sequence anomaly alert | Reconcile sequence and reapply idempotent transitions | Low | M11 |
| SMS abuse | SMS entitlement | Spammer via compromised operator | Flooding message sends | Rate-limiting and per-location caps | SMS spike alerts | Rate cap enforcement and incident review | Medium | M12 |
| Billing replay | Charges and ledger | Network replay | Reuse payment callbacks or command retries | Idempotency contracts and signatures | Duplicate invoice detection | Dedupe and manual review before posting | Medium | M11 |
| Queue mutation replay | Queue ordering and state | Disconnected client | Repeated POST attempts | Idempotency keys + revision checks | Duplicate transition counters | Deterministic no-op responses when idempotent | Low | M29 |
| Simultaneous “Call Next” | Queue ordering integrity | Two operator sessions | Race between calls | Advisory lock + transaction CAS | Conflict metrics | Recompute queue head and resume one actor | Low | M23 |
| Malicious manual reorder | Fairness and audit integrity | Operator abuse | Reorder without reason or repeated reorder | Reason required + permission checks | Audit anomaly detection | Reversal and review | Low | M23 |
| Administrator misuse | Privileges, compliance | Insider admin | Excessive actions without dual control | Approvals + detailed audit trail | Admin action alerts | Manual investigation and account rotation | Medium | M09 |
| Full phone-number misuse | Customer privacy | Internal operator or external actor | Unauthorized access and export | Role checks and masked logs | Phone-access auditing | Access revocation and evidence report | High | M30 |
| Sensitive custom-question misuse | Privacy compliance | Owner/admin abuse or misconfigured policies | Prohibited question types configured | Validation plus explicit warnings | Content-pattern alerts | Suspend violating locations and audit | Medium | M21 |
| Log leakage | Personal data in logs | Misconfigured logging | Logging full payloads | Redaction policy and linting | Log scan for PII markers | Rotate/redact logs and rotate credentials | Medium | M04 |
| Secret leakage | Credentials | Misconfigured repository or compromised CI | Committing secrets | `.gitignore`, manual review, scan scripts | Secret scanner results | Revoke, rotate, invalidate | Low | Ongoing |
| WebSocket subscription abuse | Tenant confidentiality | Compromised session | Unauthorized subscription subscription to other tenants | Session-to-scope validation | Unauthorized-subscribe alerts | Disconnect sessions and invalidate token | Medium | M30 |
| Cached data after role removal | Customer and queue data | Former staff device | Cached full phone / queued state retained | Session invalidation and cache invalidation | Cache miss and stale-token metrics | Cache clear and forced logout | Medium | M27 |
| Provider outage | Messaging/billing continuity | Infrastructure issue | Twilio/Stripe unavailable | Queueing and graceful fallback | External dependency health checks | Retry with exponential backoff | High | M11 |
| Database outage | Entire business state | Infrastructure failure | DB unavailable during commands | DB health checks and read fallback | Immediate outage alarm | Read-only mode + restoration runbook | High | M06 |
| Redis outage | Realtime/concurrency aids | Cache unavailability | Redis unavailable during lock operations | Retry with DB fallback and strict CAS | Cache miss alerts | Resume with DB-native revision checks | Medium | M06 |
| Job-queue outage | Side-effect processing | Infrastructure failure | Queue workers idle | Health checks + dead-letter monitoring | Replay queue on recovery | Requeue and reconcile side effects | Medium | M06 |
