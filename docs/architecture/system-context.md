# System Context

## Scope

Milestone 02 captures the production context for Release 1 and does not implement features.

## System actors and dependencies

```mermaid
flowchart TD
    subgraph External["External systems"]
        C[Customer]
        QO[Queue operator (mobile session)]
        LM[Location manager]
        BO[Business owner]
        PA[Platform administrator]
        Stripe[Stripe]
        Twilio[Twilio]
        GPlay[Google Play distribution]
        AWS[AWS / Hosting infrastructure]
        Mail[Email / SMTP providers]
    end

    subgraph QueueMePlatform["QueueMe platform (authoritative system)"]
        direction LR
        API[Authoritative Backend API]
        WS[WebSocket / Realtime Gateway]
        W[Next.js web surfaces]
        A[Android business application]
        Worker[Background worker]
        JobQ[Durable job queue]
        PG[(PostgreSQL)]
        Redis[(Redis)]
        Obj[Object storage]
        Obs[Observability platform]
        Rev[Provider adapters]
    end

    C -->|check-in/status API + websocket| W
    QO -->|auth + commands| API
    QO -->|real-time updates| WS
    BO -->|subscription/settings/admin ops| W
    LM -->|location + staffing actions| W
    PA -->|approval controls| W
    API --> WS
    API --> Rev
    WS -->|events| A
    W -->|queue state API and status sync| API
    A -->|mutations and reconciliation| API
    API --> PG
    API --> Redis
    API --> Worker
    Worker --> JobQ
    JobQ --> Worker
    Worker --> Rev
    Rev --> Stripe
    Rev --> Twilio
    API --> Obs
    Worker --> Obs
    WS --> Obs
    AWS --> PG
    AWS --> Redis
    AWS --> JobQ
    AWS --> Obj
    W --> Mail
```

## Trust boundaries

- **External trust boundary**: Customer and client sessions are untrusted and provide identity assertions only.
- **Platform boundary**: All durable business and entitlement state is inside the authoritative API/DB boundary.
- **Provider boundary**: Stripe and Twilio are external systems; identifiers from providers are normalized through adapters and inboxes.
- **Operator boundary**: Platform-admin and business-owner tools are separate actor capabilities with elevated privileges.
- **Data transfer boundary**: Realtime transport (`WS`) is non-authoritative and can lag; clients must resync from REST snapshots.

## Tenant boundaries

- Organization and location isolation is enforced in authoritative data queries and authorization checks.
- Every cross-surface action must include org/location scope and be rejected when scope mismatches.

## Personal-data boundaries

- Full identifiable names/phone/custom answers are in QueueMe authoritative storage only and only exposed under explicit role checks.
- Realtime payloads contain minimal identity to avoid unnecessary data replication.

## Authoritative systems

- Authoritative queue state, queue ordering, ownership, entitlement, SMS ledgers, and audits reside in PostgreSQL owned by backend services and background jobs.

## Provider boundaries

- Messaging content and delivery events flow through `Twilio` adapter through retry-aware job processing and reconciliation.
- Billing events flow through `Stripe` adapter with signed webhook ingestion and replay-safe dedupe.
