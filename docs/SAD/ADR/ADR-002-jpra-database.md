# ADR-002: Use Supabase-Managed PostgreSQL for Persistent Storage and Caching

## Status

Accepted

## Decision Metadata

| Field | Value |
| :--- | :--- |
| Date | 2026-10-03 |
| Decision owners | Product Owner |
| Technical scope | Persistent storage, managed database services, caching, and cloud compatibility |
| Related requirements | Store job-posting analyses, evidence, reliability results, benchmark records, and cached reports |
| Related ADRs | ADR-001 |

## Context and Problem Statement

JPRA needs persistent cloud storage for job-posting analyses, extracted content, external evidence, reliability results, benchmarking records, abuse-prevention data, and cached reports. The Product Owner has approximately six weeks to deliver the Streamlit prototype, so the database must integrate quickly with Streamlit while supporting structured records, flexible AI-generated data, concurrent access, and later system evaluation.

## Decision Drivers

- Integrate quickly with the Streamlit client-server architecture.
- Provide cloud availability without requiring database-server maintenance.
- Reliably retain analysis and benchmarking data.
- Support relational records and flexible AI-generated structures.
- Prevent duplicate requests, spam, and concurrent processing conflicts.
- Keep prototype costs low while supporting reasonable workload growth.

## Considered Options

### Option A: Supabase-Managed PostgreSQL

Use Supabase as the managed PostgreSQL provider and PostgreSQL as JPRA's authoritative system of record. Streamlit connects from the server through `st.connection`, SQLAlchemy, and a pooled PostgreSQL connection. Supabase provides a hosted database, management dashboard, backups, connection pooling, and standard PostgreSQL capabilities without requiring JPRA to operate a database server.

### Option B: Another Managed PostgreSQL Provider

Use a managed PostgreSQL platform such as Neon, Railway, Render, or an equivalent provider. This preserves PostgreSQL compatibility and may provide similar scaling or pricing, but it requires additional provider evaluation and integration without a clear prototype benefit over the selected Supabase platform.

### Option C: Self-Hosted PostgreSQL

Deploy and administer PostgreSQL on a virtual machine or container platform. This provides the greatest infrastructure control and portability but introduces database provisioning, security, monitoring, backup, networking, and recovery responsibilities that do not fit the prototype schedule.

### Option D: SQLite or Local Streamlit Storage

Store application data in SQLite or local files associated with the Streamlit deployment. This is simple for local development but unsuitable as the authoritative cloud database because local storage may be ephemeral, does not coordinate multiple application instances well, and provides limited support for concurrent analysis requests.

## Trade-off Analysis

Scores range from 1 (very poor fit) to 5 (excellent fit):

| Criterion | Weight | A. Supabase PostgreSQL | B. Other managed PostgreSQL | C. Self-hosted PostgreSQL | D. SQLite or local storage |
| :--- | ---: | ---: | ---: | ---: | ---: |
| Development and deployment speed | 25% | 5 | 4 | 2 | 5 |
| Streamlit integration | 20% | 5 | 4 | 4 | 2 |
| Structured and flexible benchmark data | 15% | 5 | 5 | 5 | 2 |
| Managed operations, backups, and pooling | 15% | 5 | 4 | 1 | 1 |
| Concurrency and growth | 10% | 4 | 4 | 4 | 1 |
| Portability and infrastructure control | 10% | 3 | 4 | 5 | 4 |
| Prototype cost | 5% | 5 | 5 | 2 | 5 |
| **Weighted result** | **100%** | **4.65** | **4.25** | **3.20** | **2.85** |

The scores represent suitability for JPRA's prototype constraints rather than universal database rankings.

## Decision Outcome

**Chosen option:** Option A — Supabase-managed PostgreSQL.

Supabase-managed PostgreSQL will be JPRA's authoritative database. Database access will occur on the Streamlit server through `st.connection` and SQLAlchemy, credentials will be stored in Streamlit secrets, and Alembic will manage schema migrations. The schema will use normalized relational tables for stable entities and relationships and PostgreSQL `JSONB` columns for variable extraction results, evidence structures, scoring details, and structured agent execution records. `pgvector` will only be enabled after JPRA has a verified semantic-search or retrieval use case.

JPRA will retain the original submitted URL, normalized job-posting text and extracted fields, evidence metadata and excerpts, reliability scores, the final user-visible report, structured processing events, tool calls, durations, model metadata, errors, and abuse-prevention events. Structured traces describe observable processing activity and must not store private model chain-of-thought or hidden reasoning.

### Cache and Duplicate-Request Rules

- The cache key is the exact URL submitted by the user.
- A successfully completed report remains cached for 30 minutes.
- Failed or incomplete analyses are not cached as valid results.
- The UI rejects an exact URL that is already being processed.
- A database uniqueness or transactional locking rule backs the UI restriction.
- Cached records contain the final report and the supporting stored information required to display and audit it.

### User and Abuse Identification

JPRA will derive a pseudonymous user identifier from the request IP address, preferably with a keyed hash such as HMAC rather than an ordinary unsalted hash. The raw IP address will not be stored as the primary user identifier. A VPN or network change produces a different identity, while users behind the same shared public IP address may be treated as one user. Abuse records may also contain the pseudonymous IP value, user-agent information, and request timestamps.

### Retention and Recovery

Analysis records, structured traces, errors, and security events will remain available until prototype evaluation is complete and the Product Owner performs a deliberate manual deletion. The prototype will initially use Supabase's available backup facilities and periodic manual logical exports, accepting the recovery limits associated with free-tier infrastructure. The expected workload is 100–1,000 analyses per day with fewer than five simultaneous analyses during the prototype.

## Rationale

Supabase-managed PostgreSQL provides the best balance of rapid Streamlit integration, persistent cloud storage, flexible data modelling, concurrency support, and low operational cost. PostgreSQL also keeps the JPRA data model portable if the project later moves to another compatible provider.

## Consequences

### Positive

- JPRA can persist extensive evidence and benchmark data across Streamlit sessions.
- PostgreSQL supports transactional duplicate-request protection.
- Relational tables and `JSONB` accommodate stable entities and evolving AI output.
- Supabase reduces deployment and database-administration work.
- SQLAlchemy and Alembic keep data access and schema changes explicit.
- Stored evidence and structured execution records support later evaluation and auditing.

### Negative

- Exact URL matching allows cache bypass through URL aliases, redirects, or tracking parameters.
- IP-derived identity can group unrelated users behind a shared public network.
- VPN use or network changes create different user identities.
- Extensive benchmarking records may consume the free storage allowance quickly.
- Manual deletion and export procedures depend on consistent Product Owner action.
- Free-tier backup and recovery capabilities may be insufficient for production use.
- Supabase operational features create some provider dependency even though the database remains PostgreSQL-compatible.

## References

- [Supabase database overview](https://supabase.com/docs/guides/database/overview)
- [Supabase connections to Postgres](https://supabase.com/docs/guides/database/connecting-to-postgres)
- [Supabase connection pooling and limits](https://supabase.com/docs/guides/database/connecting-to-postgres/pooling-and-limits)
- [Supabase database security](https://supabase.com/docs/guides/database/secure-data)
- [Supabase database backups](https://supabase.com/docs/guides/platform/backups)
- [Streamlit PostgreSQL connection tutorial](https://docs.streamlit.io/develop/tutorials/databases/postgresql)
- [Streamlit secrets management](https://docs.streamlit.io/deploy/concepts/secrets)
- [PostgreSQL JSON types](https://www.postgresql.org/docs/current/datatype-json.html)
- [PostgreSQL constraints](https://www.postgresql.org/docs/current/ddl-constraints.html)
- [PostgreSQL advisory lock functions](https://www.postgresql.org/docs/current/functions-admin.html)
- [Alembic documentation](https://alembic.sqlalchemy.org/)
