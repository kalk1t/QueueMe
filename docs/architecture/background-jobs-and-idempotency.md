# Background Jobs and Idempotency

## Operation split

- Synchronous:
  - Read/write decisions affecting immediate response
  - short command validation
  - permission checks
- Asynchronous jobs:
  - provider send calls
  - webhook reconciliation
  - retention sweeps
  - billing rollups
  - heavy analytics/calculation tasks

## Job ownership

- Queue jobs: background worker process
- Billing jobs: background worker + webhook worker
- Telemetry jobs: background worker

## Queueing model

- Durable queue per milestone with named job categories:
  - `messaging.send`
  - `billing.reconcile`
  - `retention.purge`
  - `webhook.ingest`
  - `snapshot.rebuild`

## Retry policy

- Exponential backoff with jitter:
  - base delay: 2s, then 5s, 15s, 60s
  - max attempts: 5
- Controlled dead-letter after attempts exhaustion.
- Retry allowed only when operation is idempotent or known safe to reapply.

## Correlation and causation

- `correlation_id` flows from API request into all spawned jobs.
- `causation_id` links parent entity or webhook event to downstream operations.

## Deduplication

- Queue and messaging jobs include:
  - actor_id
  - location_id
  - operation_type
  - request_fingerprint
  - desired_result signature

- Duplicate detection policy:
  - same idempotency key + same fingerprint => return stored result
  - same key + different fingerprint => explicit conflict

## Transactional outbox

- API writes state and outbox event in one transaction.
- Worker reads from outbox and emits events/realtime messages exactly once.
- Outbox rows use stable processing state to prevent duplicate events.

## Provider event inbox

- Webhook payloads are stored once before state transitions.
- Replay protection by provider event ID + provider signature + location scope.

## Side-effect recording

- Messaging sends:
  - request command and template version
  - consent evidence reference
  - segment estimate and provider reference
- Billing events:
  - invoice IDs
  - calculation trace

## Idempotency-key contract

| Field | Rule |
| --- | --- |
| Key scope | Endpoint or operation type plus actor tenant scope |
| Tenant/location scope | Must include org and location where applicable |
| Actor scope | Actor identity required |
| Operation type | Command type and target entity type |
| Request fingerprint | Canonicalized body hash |
| Stored result | Full response and side-effect IDs |
| Conflict behavior | Same key+fingerprint returns cached result; different payload is rejected |
| Retention period | 30 days minimum for high-risk operations, aligned with audit schedule |
| Retry behavior | Retry before response expiry reuses cached result |
| Audit fields | actor, scope, key, fingerprint, status |

## Idempotency applicability

- Queue mutation retry and manual operator submits.
- Billing mutations.
- Messaging send operations.
- Provider webhooks with provider event IDs.
- Number provisioning and reconciliation.
- Administrator actions that alter sensitive settings.
