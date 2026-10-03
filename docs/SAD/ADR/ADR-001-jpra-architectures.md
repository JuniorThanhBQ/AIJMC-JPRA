# ADR-001: Select the JPRA Prototype Architecture

## Status

Accepted

## Decision Metadata

| Field | Value |
| :--- | :--- |
| Date | 2026-10-03 |
| Decision owners | Product Owner |
| Technical scope | Overall application and deployment architecture of the JPRA prototype |
| Related requirements | Six-week prototype schedule; URL-based job-posting analysis; evidence retrieval; reliability scoring; cloud deployment |
| Related ADRs | ADR-002, ADR-003, ADR-004 |

## Context and Problem Statement

JPRA must deliver a functional research prototype within approximately six weeks. The Product Owner has experience with Streamlit and needs to integrate Python-based AI agents, retrieval tools, benchmarks, caching, and persistence quickly. Streamlit already provides a browser client and Python application server, so independently developing and deploying frontend and backend projects would add API design, integration, testing, and operational costs without directly improving the prototype's primary research contribution.

## Decision Drivers

- Deliver a usable prototype within approximately six weeks.
- Reuse the Product Owner's existing Streamlit experience.
- Integrate Python AI agents, retrieval tools, and evaluation benchmarks directly.
- Deploy through Streamlit Community Cloud with minimal operational work.
- Maintain clear internal separation between presentation, orchestration, verification, caching, and persistence.
- Preserve a practical migration path for later integration into AIJMC.

## Considered Options

### Option A: Streamlit-Based Modular Monolith

Develop and deploy JPRA as one Streamlit application while separating presentation, workflow orchestration, AI-agent integration, evidence retrieval, reliability scoring, caching, and persistence into internal Python modules. The browser remains the client and the Streamlit Python process remains the application server.

### Option B: Streamlit Frontend with a Separate API Backend

Use Streamlit for presentation and create a separate backend service, such as FastAPI, for analysis and persistence. This creates a reusable service boundary but adds API contracts, serialization, service communication, error handling, testing, and an additional deployment.

### Option C: Independent Web Frontend and API Backend

Develop a React, Vue, or similar frontend connected to a separately deployed Python API. This provides the greatest interface and scaling flexibility but requires substantially more frontend knowledge, security configuration, integration testing, and operational work than the prototype schedule allows.

### Option D: Alternative Python Web Framework

Replace Streamlit with Gradio, Dash, or Reflex. Gradio is effective for rapidly demonstrating models and Python functions, Dash is strong for callback-driven analytical dashboards, and Reflex provides a Python-defined React frontend with a FastAPI backend; however, changing framework would add learning and migration costs without a clear prototype advantage over the existing Streamlit workflow.

## Trade-off Analysis

Scores range from 1 (very poor fit) to 5 (excellent fit):


| Criterion | Weight | A. Streamlit modular monolith | B. Streamlit with API | C. Independent web stack | D1. Gradio | D2. Dash | D3. Reflex |
| :--- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Development speed | 30% | 5 | 3 | 1 | 5 | 3 | 3 |
| Python AI and benchmark integration | 25% | 5 | 4 | 3 | 5 | 4 | 4 |
| Deployment simplicity | 15% | 5 | 3 | 1 | 4 | 3 | 3 |
| Maintainability and testability | 15% | 4 | 5 | 5 | 3 | 4 | 4 |
| Scalability and independent deployment | 10% | 2 | 4 | 5 | 3 | 4 | 4 |
| Future migration flexibility | 5% | 3 | 4 | 5 | 3 | 4 | 4 |
| **Weighted result** | **100%** | **4.45** | **3.70** | **2.70** | **4.25** | **3.55** | **3.55** |

The scores represent suitability for JPRA's current prototype constraints rather than universal framework rankings.

## Decision Outcome

**Chosen option:** Option A — Streamlit-based modular monolith.

JPRA will be deployed as one Streamlit application using Streamlit's built-in client-server runtime. Presentation, application workflow, validation, extraction, AI-agent orchestration, evidence retrieval, reliability scoring, caching, database access, and logging will remain separate internal modules. No independently deployed frontend or application API will be introduced during the prototype phase.

## Rationale

Option A has the highest weighted score and best matches the schedule, existing experience, Python-centered research workflow, and selected deployment platform. It provides rapid development without forcing the prototype into a single script, while keeping later extraction of reusable services possible.

## Consequences

### Positive

- One application service can be developed and deployed quickly.
- Python AI, retrieval, and benchmarking components can be integrated directly.
- Internal modules preserve separation of responsibilities.
- More project time remains available for research implementation and evaluation.

### Negative

- Presentation and server-side execution remain coupled to Streamlit.
- Frontend and backend resources cannot be scaled independently.
- Script reruns, long-running analysis, caching, and WebSocket sessions require careful handling.
- Later AIJMC integration may require selected services to be extracted behind an API.

## References

- [Streamlit client-server architecture](https://docs.streamlit.io/develop/concepts/architecture/architecture)
- [Streamlit application model](https://docs.streamlit.io/get-started/fundamentals/summary)
- [Streamlit multipage applications](https://docs.streamlit.io/develop/concepts/multipage-apps)
- [Streamlit Page and navigation structure](https://docs.streamlit.io/develop/concepts/multipage-apps/page-and-navigation)
- [Deploying applications on Streamlit Community Cloud](https://docs.streamlit.io/deploy/streamlit-community-cloud/deploy-your-app/deploy)
- [Gradio documentation](https://www.gradio.app/docs)
- [Gradio quickstart](https://www.gradio.app/guides/quickstart)
- [Dash deployment documentation](https://dash.plotly.com/deployment)
- [Reflex architecture](https://reflex.dev/docs/advanced-onboarding/how-reflex-works/)
- [Reflex self-hosting architecture](https://reflex.dev/docs/hosting/self-hosting/)
