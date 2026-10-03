# ADR-004: Define the Role of ViReCAX in JPRA

## Status

Proposed

## Decision Metadata

| Field | Value |
| :--- | :--- |
| Date | 2026-10-03 |
| Decision owners | Product Owner |
| Technical scope | Use of the ViReCAX dataset, taxonomy, baseline models, and explanations in Vietnamese job-posting reliability analysis |
| Related requirements | Analyze Vietnamese job postings without training or fine-tuning models; produce evidence-based reliability results and research benchmarks |
| Related ADRs | ADR-001, ADR-002, ADR-003 |

## Context and Problem Statement

JPRA evaluates the reliability of Vietnamese job postings through rule-based checks, AI-agent analysis, and external evidence retrieval without training or fine-tuning models. ViReCAX is closely aligned with this domain and provides 12,054 manually annotated Vietnamese job postings for abnormal-posting classification, aspect-level assessment, and explanation generation. However, abnormality classification does not verify external claims, the public repository primarily presents research code and limited sample data, full dataset access requires an agreement with the authors, and the availability and deployability of pretrained inference weights have not yet been confirmed.

## Decision Drivers

- Direct relevance to Vietnamese recruitment language and platforms.
- Compatibility with JPRA's prohibition on training and fine-tuning.
- Contribution to evidence-based reliability scoring rather than unsupported final judgment.
- Availability, licensing, reproducibility, and provenance of models and data.
- Inference latency and resource use on Streamlit Community Cloud.
- Value for benchmarking JPRA against a published research baseline.

## Considered Options

### Option A: Mandatory ViReCAX Production Model

Require a ViReCAX model to classify every supported posting and use its output as a major component of the JPRA reliability percentage. This gives JPRA a Vietnamese domain-specific detector but creates a hard dependency on unverified pretrained weights, runtime resources, label mapping, and deployment compatibility.

### Option B: Optional ViReCAX Inference Tool and Research Benchmark

Adopt the ViReCAX taxonomy and published work as a research benchmark, then expose a verified pretrained ViReCAX model as one optional PydanticAI tool if its weights, permitted use, reproducibility, and deployment performance are confirmed. Its output contributes a bounded anomaly signal and explanation but cannot independently determine whether a posting is reliable.

### Option C: ViReCAX Benchmark and Taxonomy Only

Use ViReCAX to define Vietnamese abnormal-posting concepts, evaluation cases, comparison metrics, and limitations without running its models in the prototype. This fully respects the no-training boundary and avoids deployment cost, but JPRA loses access to a potentially useful Vietnamese-specific model signal.

### Option D: Exclude ViReCAX

Exclude ViReCAX from implementation and evaluation and rely on rules, cloud LLMs, external evidence, and other published fraud-detection methods. This minimizes dependencies but discards the closest published dataset and system for explainable abnormal job-posting detection on Vietnamese platforms.

## Trade-off Analysis

Scores range from 1 (very poor fit) to 5 (excellent fit):

| Criterion | Weight | A. Mandatory model | B. Optional tool and benchmark | C. Benchmark only | D. Exclude |
| :--- | ---: | ---: | ---: | ---: | ---: |
| Vietnamese recruitment relevance | 25% | 5 | 5 | 4 | 1 |
| Compatibility with no-training scope | 20% | 3 | 5 | 5 | 5 |
| Evidence and scoring safety | 20% | 2 | 5 | 4 | 3 |
| Six-week prototype feasibility | 15% | 2 | 4 | 5 | 5 |
| Reproducibility and dependency control | 10% | 2 | 3 | 5 | 5 |
| Research and benchmarking value | 10% | 4 | 5 | 5 | 1 |
| **Weighted result** | **100%** | **3.15** | **4.65** | **4.55** | **3.20** |

The scores are provisional because pretrained-weight availability, usage conditions, inference requirements, and deployment performance have not yet been verified.

## Decision Outcome

**Proposed option:** Option B — optional ViReCAX inference tool and research benchmark.

JPRA will immediately use the ViReCAX paper, taxonomy, and reported tasks as a foundation for Vietnamese job-posting analysis and comparative evaluation. Operational integration remains conditional. JPRA will add a ViReCAX inference tool only if the Product Owner can obtain or identify pretrained weights, confirm permitted use, reproduce inference without training or fine-tuning, and demonstrate acceptable resource use and latency in the selected deployment environment.

If those conditions are not satisfied within the prototype schedule, JPRA will automatically adopt Option C and use ViReCAX only as a benchmark and theoretical foundation. This fallback does not require a new ADR unless the intended scope changes.

### Role in the JPRA Pipeline

- ViReCAX is an anomaly detector and supporting signal, not a fact-verification authority.
- Its `CLEAN`, `WARNING`, and `SEEDING` classes must remain distinct from JPRA's reliable or unreliable result.
- A `CLEAN` prediction cannot prove that a posting or employer claim is authentic.
- A `WARNING` or `SEEDING` prediction cannot independently prove fraud.
- External evidence, deterministic rules, and other approved model signals remain necessary.
- The PydanticAI agent may call ViReCAX through a typed tool when Vietnamese posting text is available.
- A ViReCAX result must include the model identifier, output label, confidence where supported, explanation, latency, and any preprocessing version required to reproduce it.

### Reliability-Score Boundary

ViReCAX output may contribute only a bounded component of the hybrid reliability formula. Its weight and label mapping must be documented and calibrated on JPRA evaluation cases before affecting user-visible percentages. Missing, failed, or unavailable ViReCAX inference must be reported as an unavailable signal rather than treated as evidence that a posting is reliable or unreliable.

### Explanation Boundary

ViReCAX explanations describe textual patterns associated with abnormal postings. JPRA must present them as model-generated analysis and keep them separate from externally retrieved evidence. The system must not transform an explanation into a verified factual claim without an attributable source.

### Adoption Gates

Before enabling ViReCAX inference, the project must verify:

1. A specific pretrained model and immutable version are available.
2. Model, code, and dataset terms permit the intended prototype and research use.
3. Inference reproduces documented labels and required preprocessing without training or fine-tuning.
4. The model can run within Streamlit Community Cloud resource and startup constraints, or through an approved existing inference provider.
5. Latency fits the JPRA workflow and 30-minute cache design.
6. Output can be validated through a typed Pydantic schema and stored with complete provenance.
7. Evaluation identifies an explicit mapping from ViReCAX outputs to a bounded JPRA scoring contribution.

## Rationale

Option B captures ViReCAX's strong Vietnamese-domain and research value without allowing a text classifier to replace evidence-based verification. Conditional adoption respects JPRA's no-training boundary and prevents an unavailable or resource-intensive model from blocking the prototype. The benchmark-only fallback remains valuable because ViReCAX supplies the closest published task formulation for abnormal Vietnamese job postings.

## Consequences

### Positive

- JPRA gains a Vietnamese recruitment-specific taxonomy and comparison baseline.
- A verified model can add a complementary local anomaly signal.
- The final reliability result continues to combine rules, models, agent analysis, and external evidence.
- Conditional adoption prevents model availability from blocking prototype delivery.
- Explicit provenance supports benchmarking and academic reporting.

### Negative

- ViReCAX labels do not directly match JPRA's binary reliability result.
- Moderate annotation agreement indicates meaningful ambiguity in the classification tasks.
- Dataset access requires an agreement with the authors.
- Public availability of production-ready pretrained weights has not been confirmed.
- Local inference may exceed Streamlit Community Cloud resource or latency limits.
- Benchmark-only fallback provides theoretical value but no runtime detection signal.
- Score calibration requires evaluation work before user-visible use.

## References

- [V. Q. H. Nguyen et al., “Abnormal job postings detection with explanation on Vietnamese job hunter platforms,” Neural Computing and Applications, vol. 38, art. no. 445, 2026](https://doi.org/10.1007/s00521-026-12153-5)
- [Official ViReCAX repository](https://github.com/quocnguyenx43/ViReCAX)
- [S. Mahbub, E. Pardede, and A. S. M. Kayes, “Online recruitment fraud detection: A study on contextual features in Australian job industries,” IEEE Access, 2022](https://doi.org/10.1109/ACCESS.2022.3197225)
- [H. Tabassum et al., “Detecting online recruitment fraud using machine learning,” 2021 9th International Conference on Information and Communication Technology](https://doi.org/10.1109/ICoICT52021.2021.9527477)
- [T. Bhatia and J. Meena, “Detection of fake online recruitment using machine learning techniques,” 2022 4th International Conference on Advances in Computing, Communication Control and Networking](https://doi.org/10.1109/ICAC3N56670.2022.10074276)
