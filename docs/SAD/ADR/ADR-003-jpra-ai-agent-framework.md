# ADR-003: Use PydanticAI with Conditional ReAct for the JPRA Agent

## Status

Accepted

## Decision Metadata

| Field | Value |
| :--- | :--- |
| Date | 2026-10-03 |
| Decision owners | Product Owner |
| Technical scope | AI agent orchestration, tool use, evidence retrieval, provider abstraction, and structured outputs |
| Related requirements | Analyze Vietnamese job postings, retrieve external evidence, produce reliability assessments, and retain benchmark records |
| Related ADRs | ADR-001, ADR-002, ADR-004 |

## Context and Problem Statement

JPRA needs an AI agent framework that can coordinate job-posting analysis, approved tools, external evidence retrieval, model providers, and structured reports within a six-week Streamlit prototype. The design uses one base agent rather than a team of specialized agents and requires deterministic validation and scoring around limited agent autonomy. The framework must therefore favor Python integration, typed data validation, secure tool boundaries, observable execution, and low infrastructure overhead.

## Decision Drivers

- Typed validation for agent inputs, tool arguments, and final outputs.
- Direct integration with the Python-based Streamlit application.
- Controlled operation of one agent with multiple approved tools.
- Support for multiple configurable LLM providers.
- Observable execution for benchmarking and evaluation.
- Rapid delivery without an additional workflow service.

## Considered Options

### Option A: PydanticAI with Conditional ReAct

Use PydanticAI as the primary agent framework and implement ReAct-style iterative tool use only when the initial analysis lacks sufficient evidence. Pydantic models define tool arguments, intermediate records, and final outputs, while ordinary Python controls URL validation, workflow stages, retry limits, evidence sufficiency, and reliability scoring.

### Option B: Custom ReAct Implementation

Implement the ReAct reasoning-and-action loop directly with provider SDKs and custom Python orchestration. This gives JPRA complete control over evidence-search behavior, but requires the project to build and maintain output validation, tool dispatch, retry handling, provider abstraction, execution records, and termination rules that an agent framework can already provide.

### Option C: CrewAI

Use CrewAI agents, tasks, crews, or flows to coordinate the assessment. CrewAI supports tools, structured outputs, role-based agents, and controlled flows, but its strongest benefits apply to collaboration among specialized agents. JPRA currently requires one base agent, so CrewAI introduces concepts and configuration that do not directly improve the selected workflow.

### Option D: n8n

Use n8n to construct the analysis as a visual workflow containing AI, HTTP, database, and conditional nodes. Its visual automation and integrations could help operate cross-service workflows, but JPRA would need an additional hosted or self-hosted service and a boundary between n8n and Streamlit. This increases deployment and security work for a Python-centered prototype.

## Trade-off Analysis

Scores range from 1 (very poor fit) to 5 (excellent fit):

| Criterion | Weight | A. PydanticAI with ReAct | B. Custom ReAct | C. CrewAI | D. n8n |
| :--- | ---: | ---: | ---: | ---: | ---: |
| Typed validation and structured output | 25% | 5 | 2 | 4 | 3 |
| Streamlit and Python integration | 20% | 5 | 4 | 4 | 2 |
| Single-agent controlled workflow | 20% | 5 | 4 | 3 | 3 |
| Prototype development speed | 15% | 5 | 2 | 3 | 4 |
| LLM-provider portability | 10% | 5 | 3 | 4 | 4 |
| Infrastructure simplicity | 10% | 5 | 5 | 4 | 2 |
| **Weighted result** | **100%** | **5.00** | **3.20** | **3.65** | **2.95** |

The scores represent suitability for JPRA's current prototype constraints rather than universal framework rankings. ReAct is evaluated as a reasoning and tool-use pattern, while the other options provide broader implementation or orchestration capabilities.

## Decision Outcome

**Chosen option:** Option A — PydanticAI with conditional ReAct.

JPRA will use one PydanticAI base agent with a registry of typed tools. Deterministic Python code will validate the submitted URL and reject non-job-posting pages before agent execution. The agent will orchestrate extraction, analysis, and evidence collection, while a hybrid deterministic formula will combine rule-based findings, model results, and agent findings into the final reliability percentage.

The ordinary workflow will follow predefined analysis stages. ReAct-style iterative tool selection will begin only when the initial evidence is insufficient. A ReAct cycle may perform no more than three iterations. The agent may declare that it has sufficient evidence and stop earlier, while hard iteration, time, token, and cost limits remain authoritative.

### Agent and Workflow Rules

- JPRA uses one base agent rather than a multi-agent crew.
- The agent may choose among registered search, retrieval, rule, local-model, database, and scoring tools.
- Tool inputs and outputs must conform to typed schemas.
- Components exchange typed objects during execution and persist structured audit records in PostgreSQL.
- The agent may revise an earlier finding once after obtaining new evidence.
- Contradictory findings remain visible and reduce the resulting reliability percentage.
- The final output contains a binary classification, reliability percentage, explanation, and evidence list.
- Individual stage evaluation will initially use manual inspection rather than a separate automated benchmark for every stage.

### Validation and Failure Handling

If an LLM returns an invalid structured result, PydanticAI will request a corrected result within a bounded retry policy. Tool failures will first receive a limited retry, then use an approved fallback where available. If neither succeeds, JPRA will continue only when it can clearly report the missing evidence and reduce confidence; otherwise, the analysis fails safely and is not cached as a valid result.

Generated code may only execute through a dedicated execution tool after syntax, policy, argument, resource, and isolation checks succeed. The tool must use an allowlist, prevent unrestricted filesystem and network access, enforce time and resource limits, and record the execution. Generated text must never be passed directly to `eval`, `exec`, a shell, or an unrestricted interpreter. This capability should remain disabled until those controls are implemented and tested.

### Model Providers

PydanticAI will expose a common interface for supported cloud and local model providers. The Streamlit UI will allow the user to select from approved models or providers. Provider selection must not change the final report schema or bypass tool validation.

Automatic fallback to another provider may be added if it remains simple and predictable. A fallback must be explicitly configured, recorded in the analysis trace, and limited so that provider failures cannot create an uncontrolled retry chain.

### Observability and Reproducibility

JPRA will retain tool calls, evidence, processing stages, timings, token usage, model identity, retry events, and stage results for benchmarking. It will also record the versions or identifiers of the model, prompts, tools, evidence, and relevant configuration. Private model chain-of-thought must not be requested or stored.

## Rationale

PydanticAI best matches JPRA's single-agent, Python-first architecture and its need for typed tools and predictable reports. Conditional ReAct preserves adaptive external evidence gathering without making the entire workflow autonomous. CrewAI adds multi-agent concepts that JPRA does not require, while n8n adds infrastructure and a visual workflow boundary that provide limited value within the prototype schedule.

## Consequences

### Positive

- Typed schemas constrain agent inputs, tool arguments, and final reports.
- One Python framework integrates directly with Streamlit and JPRA tools.
- Conditional ReAct allows additional evidence retrieval only when needed.
- Provider abstraction permits approved model selection through the UI.
- Deterministic validation and scoring remain outside the LLM.
- Structured execution records support benchmarking and reproducibility.
- No separate workflow automation service is required.

### Negative

- The agent can still make incorrect tool choices or stop with insufficient evidence.
- An agent-declared evidence threshold is less predictable than a fully deterministic stopping rule.
- Limiting ReAct to three iterations may leave difficult claims unresolved.
- Supporting several providers increases testing and configuration work.
- Manual stage evaluation may miss systematic errors during early development.
- Safe generated-code execution requires significant isolation and security work.
- PydanticAI becomes a central dependency of the prototype.

## References

- [PydanticAI documentation](https://ai.pydantic.dev/)
- [PydanticAI agents](https://ai.pydantic.dev/agents/)
- [PydanticAI function tools](https://ai.pydantic.dev/tools/)
- [PydanticAI output handling](https://ai.pydantic.dev/output/)
- [PydanticAI models](https://ai.pydantic.dev/models/)
- [Pydantic Evals](https://ai.pydantic.dev/evals/)
- [CrewAI introduction](https://docs.crewai.com/core-concepts/Agents)
- [CrewAI structured output annotations](https://docs.crewai.com/learn/using-annotations)
- [n8n documentation](https://docs.n8n.io/)
- [n8n security audit](https://docs.n8n.io/hosting/securing/security-audit/)
- [ReAct: Synergizing Reasoning and Acting in Language Models](https://arxiv.org/abs/2210.03629)
