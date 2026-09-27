<div align="center">

  # AIJMC - Job Postings Reliability Analysis

  <img src="https://res.cloudinary.com/dfolk8pz2/image/upload/v1790424345/AIJ_1_-modified_1_afzibo.png" alt="AIJMC Logo" width="280" />

  <p><strong>AI IT Job Market Consultant - Job Postings Reliability Analysis</strong></p>
  <p>
    <a href="https://streamlit.io/"><img src="https://img.shields.io/badge/Streamlit-1.64.0-FF4B4B?logo=streamlit&logoColor=white" alt="Streamlit" /></a>
    <a href="https://colab.research.google.com/"><img src="https://img.shields.io/badge/Google%20Colab-F9AB00?logo=googlecolab&logoColor=white" alt="Google Colab" /></a>
    <a href="https://playwright.dev/"><img src="https://img.shields.io/badge/Playwright-1.63.0-2EAD33?logo=playwright&logoColor=white" alt="Playwright" /></a>
    <a href="https://ai.pydantic.dev/"><img src="https://img.shields.io/badge/PydanticAI-2.51.0-E92063?logo=pydantic&logoColor=white" alt="PydanticAI" /></a>
    <a href="https://ai.google.dev/"><img src="https://img.shields.io/badge/Google%20Gen%20SDK-2.24.0-8E75B2?logo=googlegemini&logoColor=white" alt="Google Gen SDK" /></a>
    <a href="https://groq.com/"><img src="https://img.shields.io/badge/Groq%20SDK-1.7.0-F55036?logo=groq&logoColor=white" alt="Groq SDK" /></a>
    <a href="https://doi.org/10.1007/s00521-026-12153-5"><img src="https://img.shields.io/badge/ViReCAX%20models-(under%20consideration)-orange" alt="ViReCAX models (under consideration)" /></a>
    <a href="https://www.postgresql.org/"><img src="https://img.shields.io/badge/PostgreSQL-18-4169E1?logo=postgresql&logoColor=white" alt="PostgreSQL" /></a>
    <a href="https://supabase.com/"><img src="https://img.shields.io/badge/Supabase-3ECF8E?logo=supabase&logoColor=white" alt="Supabase" /></a>
  </p>
</div>

<div align="justify">

## I. Introduction
The JPRA project, or Job Postings Reliability Analysis, is a separate study from the original AIJMC project aimed at finding solutions to assess the safety and reliability of a specific job posting within the Vietnamese job market. The expected assessment techniques to be applied are rule-based, AI agent, and local models such as ViReCAX. Details of the references are presented in [docs/reference/jpra-ieee-reference.md](docs/reference/jpra-ieee-reference.md).

## II. JPRA Primary Goal
The overall goal of JPRA is to rapidly develop a prototype capable of binary classification of a job posting as reliable or unreliable, with the input being a URL link and the output being a reliability percentage along with a detailed assessment explaining the reasons behind that percentage.

The overall objectives, divided equally over six weeks of development, are as follows:
1. Synthesize relevant works on determining the reliability of job postings, researching methods for applying AI techniques in analysis. Additionally, research how to present the paper according to the [IEEE Conference Template](https://www.overleaf.com/latex/templates/ieee-conference-template/grfzhhncsfqn). Results must be completed in week 1, from September 28, 2026 to October 4, 2026.

2. Design and build a prototype based on the techniques researched in week 1. Results should be completed in weeks 2-3, from October 5, 2026 to October 18, 2026.

3. Evaluate the prototype results, comparing them with other research works based on clear measurement scales.

4. Finalize the JPRA IEEE Conference report and submit it to the supervising lecturer for feedback in week 6, from November 2, 2026 to November 8, 2026.



## III. Architecture and Tech Stack

| Components | Technology | Version / Stack | Reason for use |
| :--- | :--- | :--- | :--- |
| **Frontend** | Streamlit | 1.64.0 | Rapid development of interactive data dashboards and analytical interfaces for inspecting job reliability. |
| **Cloud Environment** | Google Colab | Cloud Platform | Cloud-hosted Jupyter environment for ML experimentation, model fine-tuning, and exploratory data analysis. |
| **Data Scraping** | Playwright | 1.63.0 | Resilient headless browser automation for scraping and extracting dynamic recruitment job posts across platforms. |
| **AI Agent Framework** | PydanticAI | 2.51.0 | Type-safe, production-grade LLM orchestration with schema validation and structured evaluation workflows. |
| **LLM Provider** | Google Gen SDK | 2.24.0 | Advanced multimodal and text generation capabilities using Gemini models for deep job content analysis. |
| **Inference Engine** | Groq SDK | 1.7.0 | Ultra-fast LPU inference for high-throughput, low-latency screening and initial assessment of job postings. |
| **Detection Models** | ViReCAX models | Under consideration | Specialized research-driven models for Vietnamese abnormal job posting detection and explainable reliability classification. |
| **Database** | PostgreSQL | 18 | Robust, ACID-compliant relational database for persisting job postings, analysis results, and system audits. |
| **Backend-as-a-Service** | Supabase | BaaS / Cloud | Managed Postgres ecosystem providing authentication, instant APIs, database management, and vector capabilities. |
| **Tools automation** | Magefile Go | 1.17.2 | Go-based build and task automation providing type-safe, maintainable, and self-documenting project automation targets. |

## IV. JPRA Project Management

To ensure steady progress across research, engineering, and academic reporting within the project timeline, two methods are implemented:

### 1. Agile Kanban Management (Jira)
* **Workspace:** [AIJMC-JPRA](https://aijmc.atlassian.net/jira/software/projects/JPRA/boards/2?filter=&groupBy=none)
* **Scope:** Research milestones, sprint planning, and high-level deliverables.
* **Reason for use:**
  * **Agile Visualization:** Visualizes the end-to-end research and development flow from backlog to completion, making it easy to spot blockers and manage work-in-progress (WIP) across project phases (research, prototyping, evaluation, and paper writing).
  * **Milestone and Schedule Control:** Aligns tasks directly with weekly deliverables (Weeks 1 to 6) to ensure the prototype and IEEE conference report meet strict submission deadlines.
  * **Structured Work Breakdown:** Supports structured decomposition of complex R&D initiatives into epics, user stories, and actionable sub-tasks.

### 2. Defect and Bug Tracking (GitHub Projects / Issues)
* **Workspace:** [JPRA GitHub Bug Tracker](https://github.com/JuniorThanhBQ/AIJMC-JPRA/issues)
* **Scope:** Code-level bug reports, technical debt, scraping pipeline failures, and repository maintenance.
* **Reason for use:**
  * **Seamless Codebase Integration:** Directly connects issues with git branches, commits, pull requests, and automation workflows.
  * **Rapid Technical Triage:** Streamlines capturing stack traces, reproduction steps, and debugging discussions close to the source code (e.g., handling breaking changes on target recruitment portals or API shifts).
  * **Separation of Concerns:** Keeps strategic roadmap planning and academic goals organized in Jira, while technical fixes and defect resolution remain localized and developer-accessible on GitHub.

## V. Installation and Usage Guidance
Not available

## VI. Showcase
Not available

## VII. References
1. Package License: [package-license-record](docs/license/package-license-record.md)
2. JPRA Showcase Image: [image](docs/image/)
3. Acceptance Testing: [testing](docs/testing/)
4. JPRA SRS: [software Requirements Specification](docs/SRS/)
5. JPRA SAD: [software Architecture Document](docs/SAD/)
7. References: [references](docs/reference/)

## VIII. Additional Note
- Personal contact email: thanh.vantrung2005@gmail.com
- School contact email: 2351050164thanh@ou.edu.vn
- Recruitment of research collaborators: Not yet open.

## IX. Repository Tree (Temporarily)

<pre>
AIJMC-JPRA/
├── .github/
│   └── workflows/
├── app/
│   └── README.md
├── docs/
│   ├── ADR/
│   │   └── ADR-001-jpra-architectures.md
│   ├── C4-diagram/
│   │   └── README.md
│   ├── image/
│   │   └── image-fake.png
│   ├── license/
│   │   └── package-license-record.md
│   ├── reference/
│   │   └── jpra-ieee-reference.md
│   ├── SRS/
│   │   └── README.md
│   └── testing/
│       └── test-case-report.xlsx
├── notebooks/
│   └── README.md
├── scripts/
│   └── README.md
├── tools/
│   └── README.md
├── .gitignore
├── .pre-commit-config.yaml
├── LICENSE
├── magefile.go
└── README.md
</pre>

</div>
