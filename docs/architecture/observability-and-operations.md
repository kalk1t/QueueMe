# Observability and Operations

## Logging model

- Structured JSON logs for all API and worker handlers.
- Required fields:
  - `correlation_id`
  - `causation_id`
  - `tenant_id`
  - `location_id`
  - `actor_id`
  - `request_id`
  - `job_id` (where applicable)
  - `provider_event_id` (when applicable)
  - `error_code`
  - `outcome`
  - `latency_ms`
  - `retry_count`

- Prohibitions:
  - raw provider tokens
  - full phone numbers in general logs unless role-scoped masked format is required

## Metrics (initial)

- API success/failure/latency by endpoint
- WebSocket connects, disconnects, replay/resync count
- Queue mutations: total, conflicts, stale revisions, retry count
- Job success/failure/retry/dead-letter by category
- Webhook validation failures and replay counts
- SMS segment allowance usage, SMS cap breaches
- Overage event totals
- Tenant/location isolation denials
- Authentication failures and permission denies
- Retention deletion failures

## Alerts

- High queue mutation conflicts
- Queue snapshot resync failures
- Repeated webhook replay rejection spikes
- Job dead-letter growth
- Billing reconciliation mismatch
- Websocket connection churn above threshold

## Incident response

- Incident ticket includes:
  - affected tenant/location
  - correlation ID range
  - command and webhook sample IDs
  - queue/job/audit state snapshot

## Runbook expectations

- Correlate all queue incidents using revision and correlation IDs.
- Start with audit trace before external retries.
- Validate entitlement state before attempting forceful operational overrides.

## Health checks

- Liveness: API responsiveness and queue worker heartbeat
- Readiness: DB/cache connectivity, outbox drain health
- Realtime health: event fanout queue length and snapshot delivery success
