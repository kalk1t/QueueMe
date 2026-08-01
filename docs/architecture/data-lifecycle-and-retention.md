# Data Lifecycle and Retention

## Retention classes

| Class | Data examples | Owner | Authoritative store | Retention | Deletion trigger | Backup treatment | Redaction | Audit |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Durable business configuration | plans, queue settings, queue templates, org/location metadata | Product operations | PostgreSQL | Indefinite while active; deactivated entries retained for audit | Organization closure or migration | Backed up with DB snapshots | No PII by default | Yes |
| Billing records | subscriptions, invoices, credits, disputes, overage events | Billing team | PostgreSQL | 7 years (accounting); reduced as policy evolves | Invoice finalized + compliance retention window | Encrypted backup | Mask financial account references in logs | Yes |
| Provider reconciliation records | webhook payloads, provider IDs, reconciliation outputs | Billing/platform | PostgreSQL + signed object storage | 2 years | Reconcile success + retention policy | Securely backed up | Redact raw secrets in object logs | Yes |
| Queue operational records | queue entries, positions, state history | Queue operations | PostgreSQL | 90 days active + compliance extension | Manual purge policy and disputes | Partially retained with anonymization | Full phone masked in analytics views | Yes |
| Customer-identifiable data | name, phone, custom answers | Privacy owner | PostgreSQL | 30 days (`PRD-PRIV-001`) | Automatic retention expiry | delete or pseudonymize identifiers on expiry | Yes |
| Consent evidence | phone, location, queue entry, timestamp, version, method | Privacy owner | PostgreSQL | 30 days or legal extension if required | Expiry policy + policy change | Redact answer content not needed; keep hash references | Yes |
| Audit records | security-sensitive, billing, queue-order changes | Security owner | PostgreSQL + append store | long-term per compliance | Disposition schedule with legal hold support | Log fields redacted | Tamper-evident required |
| Idempotency records | idempotency key, request fingerprint, result | API reliability | PostgreSQL/Redis | 30 days minimum | TTL expiry or retention window | Store request hash not full payload | Yes |
| Job records | attempts, failures, dead-letter | Operations owner | PostgreSQL + durable queue | 180 days | Completion + retention policy | Minimal payload fields | Yes |
| Logs and metrics | request/queue metrics, alerts | Operations/SRE | Central log/metric store | 90 days | Observability policy | Never log tokens/secret/provider credentials | Yes |
| Cached data | websocket snapshot state, local read caches | Client boundary | Redis / client local | session or 30 minutes | Session end / stale TTL | No customer full values by default | Not authoritative |

## Key retention rule

- Identifiable customer names, phone numbers, and custom answers: **30 days**.
- `PRD-PRIV-001` is the only authoritative rule for this retention period.

## Storage and deletion behavior

- Deletions are implemented as lifecycle sweeps with explicit job ownership.
- Legal/compliance retention override can extend non-identifiable operational records but not identifiable customer data.
- Deletion actions produce evidence and are auditable.
