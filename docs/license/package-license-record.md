# JPRA Package and Tool License Record

## Audit Metadata

| Field | Value |
| :--- | :--- |
| Audit date | 2026-10-03 |
| Project license | Apache License 2.0 |
| Python inventory source | `pyproject.toml`, `uv.lock`, and installed wheel metadata |
| Go inventory source | `go.mod` and `go.sum` |
| Automation inventory source | `.pre-commit-config.yaml`, `magefile.go`, and `.github/workflows/` |
| Review scope | Direct and transitive Python packages, Go/Mage, runtimes, pre-commit tools, CI actions, scanners, browser runtime, database, and hosted services |

This record is an engineering compliance inventory, not legal advice. Licenses were cross-checked against package metadata and authoritative upstream repositories on the audit date. Re-run the audit whenever `uv.lock`, `go.sum`, `.pre-commit-config.yaml`, or a GitHub Action SHA changes.

## Compatibility Finding

JPRA may keep the Apache-2.0 license for its original source code. The runtime libraries are permissively licensed or use weak/file-level reciprocal terms that do not require relicensing JPRA when used as unmodified dependencies. Development and CI tools execute as separate programs and do not change the license of the source they inspect.

This conclusion depends on the following conditions:

1. Do not copy third-party source code into JPRA without recording the source, license, copyright, and modification notice.
2. When distributing a Python environment, executable bundle, container image, browser binary, or other third-party binary, include the applicable third-party license texts and attribution notices.
3. Keep Pylint and Astroid as development tools. If either is embedded, modified, or redistributed, review GPL-2.0-or-later and LGPL-2.1-or-later obligations for that distribution.
4. Preserve Certifi's MPL-2.0 license. If JPRA distributes a modified Certifi file, make that modified file's source available under MPL-2.0.
5. Treat the pinned Gitleaks Action v3 as proprietary/source-available software governed by its EULA. Organization-owned GitHub repositories require a Gitleaks license key; personal-account repositories do not.
6. CodeQL Action is MIT, but its downloaded CodeQL CLI is governed by separate GitHub CodeQL terms. The documented use is allowed for open-source repositories on GitHub and qualifying private repositories with GitHub Advanced Security.
7. API and cloud-service terms are separate from software licenses. Confirm the current Google, Groq, Supabase, Streamlit Community Cloud, and GitHub terms before production or commercial deployment.

## Direct Python Dependencies

| Package | Recorded version | License | Apache-2.0 assessment | Required handling |
| :--- | :--- | :--- | :--- | :--- |
| `google-genai` | 2.25.0 | Apache-2.0 | Compatible | Retain license and NOTICE material if redistributed. |
| `groq` | 1.7.0 | Apache-2.0 | Compatible | Retain license and NOTICE material if redistributed. |
| `pydantic-ai` | 2.51.0 | MIT | Compatible | Retain MIT copyright and license text if redistributed. |
| `python-dotenv` | 1.2.3 | BSD-3-Clause | Compatible | Retain copyright, license, and disclaimer. |
| `streamlit` | 1.64.0 | Apache-2.0 | Compatible | Retain license and NOTICE material if redistributed. |
| `supabase` | 2.31.0 | MIT | Compatible | Retain MIT copyright and license text if redistributed. |

## Direct Development Dependencies

| Package | Recorded version | License | Apache-2.0 assessment | Required handling |
| :--- | :--- | :--- | :--- | :--- |
| `bandit` | 1.9.4 | Apache-2.0 | Compatible tool | Preserve notices if redistributed. |
| `playwright` | 1.63.0 | Apache-2.0 | Compatible | Preserve notices; separately retain browser notices if browser binaries are distributed. |
| `pre-commit` | 4.6.2 | MIT | Compatible tool | Retain MIT notice if redistributed. |
| `pylint` | 4.0.9 | GPL-2.0-or-later | Tool-only use is compatible | Do not incorporate Pylint code into JPRA. GPL obligations apply if Pylint itself is distributed. |
| `pytest` | 9.1.1 | MIT | Compatible tool | Retain MIT notice if redistributed. |
| `pytest-asyncio` | 1.4.0 | Apache-2.0 | Compatible tool | Preserve notices if redistributed. |
| `pip-audit` | Installed dynamically in CI; not locked | Apache-2.0 | Compatible tool | Pin a reviewed version for reproducibility; preserve notices if redistributed. |

## Go, Build, and Runtime Tools

| Component | Recorded version or use | License or terms | Assessment and handling |
| :--- | :--- | :--- | :--- |
| Python | `>=3.14` | PSF License Agreement; incorporated components have separate notices | Compatible. Retain the PSF license and incorporated-software acknowledgements if Python is bundled. |
| Go toolchain | `go 1.26.8` in `go.mod` | BSD-3-Clause/BSD-style | Compatible. Retain license notice if the toolchain is redistributed. |
| Mage | 1.17.2 | Apache-2.0 | Compatible. This is the only Go module in `go.mod`; retain license/NOTICE if redistributed. |
| uv | CI and local package manager | MIT OR Apache-2.0 | Compatible. Keep one chosen license and required notices with redistributed uv binaries. |
| Bash | Invoked by Mage scripts and CI | GPL-3.0-or-later for GNU Bash | Separate executable; compatible as a tool. Do not bundle it without its GPL materials. |
| curl | Health checks in CI | curl License | Permissive tool use; preserve its notice if redistributed. |
| GitHub CLI (`gh`) | Failure-reporting CI step | MIT | Compatible separate tool; hosted runner supplies it. |
| PostgreSQL | Managed through Supabase | PostgreSQL License | Permissive and compatible. Supabase service terms still apply. |
| Chromium | Installed by Playwright in CI | BSD-style Chromium code plus many component licenses | Test-only download. If a browser bundle is distributed, ship the exact browser's generated credits and component notices. |

## Pre-commit Repositories

| Repository and revision | License | Assessment |
| :--- | :--- | :--- |
| `pre-commit/pre-commit-hooks` v6.0.0 | MIT | Compatible tool; retain notice if redistributed. |
| `astral-sh/ruff-pre-commit` v0.16.10 | MIT OR Apache-2.0 | Compatible tool; choose and preserve one license when redistributing. |
| `gitleaks/gitleaks` v8.30.0 | MIT | The local pre-commit CLI is MIT and distinct from the Gitleaks Action EULA. |
| `woodruffw/zizmor-pre-commit` v1.30.1 | MIT | Compatible tool; retain notice if redistributed. |

## GitHub Actions and CI Scanners

| Action or scanner | Pinned revision/use | License or terms | Assessment |
| :--- | :--- | :--- | :--- |
| `actions/checkout` | `3d3c42e5…` | MIT | Compatible. |
| `astral-sh/setup-uv` | `c18668ad…` | MIT | Compatible. Downloaded uv remains MIT OR Apache-2.0. |
| `github/codeql-action` | `2892aa5e…` | MIT; CodeQL CLI has separate GitHub terms | Conditional service/tool use; do not describe the CLI as MIT. |
| `gitleaks/gitleaks-action` | `e0c47f4f…`, v3 migration commit | Gitleaks Action EULA | Not open source. A license key is required for organization-owned repositories. |
| `aquasecurity/trivy-action` | `ed142fd0…` | Apache-2.0 | Compatible; retain notices if redistributed. |
| `zaproxy/action-baseline` | `de8ad967…` | Apache-2.0 | Compatible. Its ZAP container includes third-party components under additional licenses. |
| `zizmorcore/zizmor-action` | `cc914d7f…` | MIT | Compatible tool. |
| Gitleaks CLI | Invoked by the action and pre-commit hook | MIT | Compatible, but the GitHub Action wrapper has its own EULA. |
| OWASP ZAP | Container invoked by baseline action | Apache-2.0 with documented third-party notices | Compatible for CI use; retain the container's legal notices if redistributed. |
| Trivy | Invoked through Trivy Action | Apache-2.0 | Compatible tool. |

## Hosted Services and External APIs

These services are not relicensed as part of JPRA, but use is governed by their current service agreements, acceptable-use rules, privacy terms, and model/data terms.

| Service | Project use | License-record treatment |
| :--- | :--- | :--- |
| Streamlit Community Cloud | Application hosting | Service terms are separate from Streamlit's Apache-2.0 source license. |
| Supabase | Managed PostgreSQL and cloud data platform | Service terms are separate from the MIT-licensed Python client and PostgreSQL License. |
| Google Gemini API | Cloud model provider through `google-genai` | API/model terms are separate from the SDK's Apache-2.0 license. |
| Groq API | Cloud inference provider through `groq` | API/model terms are separate from the SDK's Apache-2.0 license. |
| GitHub and GitHub Actions | Source hosting, CI, security results, and Dependabot | GitHub service and additional-product terms apply independently of action repository licenses. |

## Locked Python Dependency Inventory

The following table records every installed distribution corresponding to the current `uv.lock`. `aijmc-jpra` itself is excluded because it is the project being audited. “Compatible” means the dependency does not require JPRA's original source to be relicensed when used normally as a separate package. Distribution obligations still apply.

| Package | Locked/installed version | License expression | Assessment |
| :--- | :--- | :--- | :--- |
| `aiofile` | 3.12.3 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `altair` | 6.3.0 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `annotated-types` | 0.8.0 | MIT | Compatible; preserve license/notices if distributed |
| `anthropic` | 1.8.0 | MIT | Compatible; preserve license/notices if distributed |
| `anyio` | 4.15.1 | MIT | Compatible; preserve license/notices if distributed |
| `argcomplete` | 3.7.2 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `astroid` | 4.0.4 | LGPL-2.1-or-later | Tool dependency; LGPL applies to Astroid distribution |
| `attrs` | 26.1.0 | MIT | Compatible; preserve license/notices if distributed |
| `Authlib` | 1.8.0 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `bandit` | 1.9.4 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `beartype` | 0.22.9 | MIT | Compatible; preserve license/notices if distributed |
| `cachetools` | 7.2.0 | MIT | Compatible; preserve license/notices if distributed |
| `caio` | 0.12.9 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `certifi` | 2026.7.22 | MPL-2.0 | Compatible; MPL file-level obligations apply |
| `cffi` | 2.1.1 | MIT-0 | Compatible; preserve license/notices if distributed |
| `cfgv` | 3.5.0 | MIT | Compatible; preserve license/notices if distributed |
| `charset-normalizer` | 3.5.1 | MIT | Compatible; preserve license/notices if distributed |
| `click` | 8.5.0 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `colorama` | 0.4.6 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `cryptography` | 50.0.1 | Apache-2.0 OR BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `deprecation` | 2.1.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `dill` | 0.4.1 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `distlib` | 0.4.3 | PSF-2.0 | Compatible; preserve license/notices if distributed |
| `distro` | 1.9.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `dnspython` | 2.8.0 | ISC | Compatible; preserve license/notices if distributed |
| `docstring_parser` | 0.18.0 | MIT | Compatible; preserve license/notices if distributed |
| `email-validator` | 2.3.0 | Unlicense | Compatible; preserve license/notices if distributed |
| `exceptiongroup` | 1.3.1 | MIT | Compatible; preserve license/notices if distributed |
| `executing` | 2.2.1 | MIT | Compatible; preserve license/notices if distributed |
| `fastmcp-slim` | 4.0.10 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `filelock` | 4.0.4 | MIT | Compatible; preserve license/notices if distributed |
| `genai-prices` | 0.1.9 | MIT | Compatible; preserve license/notices if distributed |
| `google-auth` | 2.58.1 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `google-genai` | 2.25.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `googleapis-common-protos` | 1.75.4 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `greenlet` | 3.5.6 | MIT AND PSF-2.0 | Compatible; preserve license/notices if distributed |
| `griffelib` | 2.3.0 | ISC | Compatible; preserve license/notices if distributed |
| `groq` | 1.7.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `h11` | 0.16.0 | MIT | Compatible; preserve license/notices if distributed |
| `h2` | 4.4.1 | MIT | Compatible; preserve license/notices if distributed |
| `hpack` | 4.2.0 | MIT | Compatible; preserve license/notices if distributed |
| `httpcore` | 1.0.9 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `httpcore2` | 2.13.1 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `httptools` | 0.8.0 | MIT | Compatible; preserve license/notices if distributed |
| `httpx` | 0.28.1 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `httpx2` | 2.13.1 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `httpx2-jsfetch` | 1.0 | BSD-3-Clause | Platform-specific locked package; preserve license/notices if distributed |
| `hyperframe` | 6.1.0 | MIT | Compatible; preserve license/notices if distributed |
| `identify` | 2.6.20 | MIT | Compatible; preserve license/notices if distributed |
| `idna` | 3.20 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `iniconfig` | 2.3.0 | MIT | Compatible; preserve license/notices if distributed |
| `isort` | 9.0.1 | MIT | Compatible; preserve license/notices if distributed |
| `itsdangerous` | 2.2.0 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `jaraco.classes` | 3.4.0 | MIT | Compatible; preserve license/notices if distributed |
| `jaraco.context` | 6.1.2 | MIT | Compatible; preserve license/notices if distributed |
| `jaraco.functools` | 4.6.0 | MIT | Compatible; preserve license/notices if distributed |
| `jeepney` | 0.9.0 | MIT | Platform-specific locked package; preserve license/notices if distributed |
| `Jinja2` | 3.1.6 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `jiter` | 0.17.0 | MIT | Compatible; preserve license/notices if distributed |
| `joserfc` | 1.7.5 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `jschema-to-python` | 1.2.3 | MIT | Compatible; preserve license/notices if distributed |
| `jsonpickle` | 4.1.2 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `jsonschema` | 4.26.0 | MIT | Compatible; preserve license/notices if distributed |
| `jsonschema-specifications` | 2025.9.1 | MIT | Compatible; preserve license/notices if distributed |
| `keyring` | 25.7.0 | MIT | Compatible; preserve license/notices if distributed |
| `logfire` | 5.1.1 | MIT | Compatible; preserve license/notices if distributed |
| `logfire-api` | 5.1.1 | MIT | Compatible; preserve license/notices if distributed |
| `markdown-it-py` | 4.2.0 | MIT | Compatible; preserve license/notices if distributed |
| `MarkupSafe` | 3.0.3 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `mccabe` | 0.7.0 | MIT | Compatible; preserve license/notices if distributed |
| `mcp` | 2.2.0 | MIT | Compatible; preserve license/notices if distributed |
| `mcp-types` | 2.2.0 | MIT | Compatible; preserve license/notices if distributed |
| `mdurl` | 0.1.2 | MIT | Compatible; preserve license/notices if distributed |
| `more-itertools` | 11.1.0 | MIT | Compatible; preserve license/notices if distributed |
| `multidict` | 7.0.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `mypy_extensions` | 1.1.0 | MIT | Compatible; preserve license/notices if distributed |
| `narwhals` | 2.26.0 | MIT | Compatible; preserve license/notices if distributed |
| `nodeenv` | 1.11.0 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `numpy` | 2.5.3 | BSD-3-Clause AND 0BSD AND MIT AND Zlib AND CC0-1.0 | Compatible; preserve bundled third-party notices |
| `openai` | 3.19.2 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `opentelemetry-api` | 1.44.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `opentelemetry-exporter-otlp-proto-common` | 1.44.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `opentelemetry-exporter-otlp-proto-http` | 1.44.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `opentelemetry-instrumentation` | 0.65b0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `opentelemetry-instrumentation-httpx` | 0.65b0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `opentelemetry-proto` | 1.44.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `opentelemetry-sdk` | 1.44.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `opentelemetry-semantic-conventions` | 0.65b0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `opentelemetry-util-http` | 0.65b0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `packaging` | 26.3 | Apache-2.0 OR BSD-2-Clause | Compatible; preserve license/notices if distributed |
| `pandas` | 3.0.6 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `pbr` | 7.0.3 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `pillow` | 12.3.0 | MIT-CMU | Compatible; preserve license/notices if distributed |
| `platformdirs` | 4.12.0 | MIT | Compatible; preserve license/notices if distributed |
| `playwright` | 1.63.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `pluggy` | 1.6.0 | MIT | Compatible; preserve license/notices if distributed |
| `postgrest` | 2.31.0 | MIT | Compatible; preserve license/notices if distributed |
| `pre_commit` | 4.6.2 | MIT | Compatible; preserve license/notices if distributed |
| `prompt_toolkit` | 3.0.53 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `propcache` | 0.5.4 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `protobuf` | 7.36.2 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `py-key-value-aio` | 0.4.6 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `pyarrow` | 25.0.1 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `pyasn1` | 0.6.4 | BSD-2-Clause | Compatible; preserve license/notices if distributed |
| `pyasn1_modules` | 0.4.2 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `pycparser` | 3.0 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `pydantic` | 2.13.5 | MIT | Compatible; preserve license/notices if distributed |
| `pydantic_core` | 2.46.5 | MIT | Compatible; preserve license/notices if distributed |
| `pydantic-ai` | 2.51.0 | MIT | Compatible; preserve license/notices if distributed |
| `pydantic-ai-slim` | 2.51.0 | MIT | Compatible; preserve license/notices if distributed |
| `pydantic-evals` | 2.51.0 | MIT | Compatible; preserve license/notices if distributed |
| `pydantic-graph` | 2.51.0 | MIT | Compatible; preserve license/notices if distributed |
| `pydantic-settings` | 2.15.0 | MIT | Compatible; preserve license/notices if distributed |
| `pydeck` | 0.9.3 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `pyee` | 13.0.1 | MIT | Compatible; preserve license/notices if distributed |
| `Pygments` | 2.21.0 | BSD-2-Clause | Compatible; preserve license/notices if distributed |
| `PyJWT` | 2.15.0 | MIT | Compatible; preserve license/notices if distributed |
| `pylint` | 4.0.9 | GPL-2.0-or-later | Tool only; GPL applies to Pylint distribution |
| `pyperclip` | 1.11.0 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `pytest` | 9.1.1 | MIT | Compatible; preserve license/notices if distributed |
| `pytest-asyncio` | 1.4.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `python-dateutil` | 2.9.0.post0 | BSD-3-Clause OR Apache-2.0 | Compatible; preserve license/notices if distributed |
| `python-discovery` | 1.6.1 | MIT | Compatible; preserve license/notices if distributed |
| `python-dotenv` | 1.2.3 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `python-multipart` | 0.0.32 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `pywin32` | 312 | PSF-2.0 | Compatible; preserve license/notices if distributed |
| `pywin32-ctypes` | 0.2.3 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `PyYAML` | 6.0.3 | MIT | Compatible; preserve license/notices if distributed |
| `realtime` | 2.31.0 | MIT | Compatible; preserve license/notices if distributed |
| `referencing` | 0.37.0 | MIT | Compatible; preserve license/notices if distributed |
| `regex` | 2026.9.10 | Apache-2.0 AND CNRI-Python | Compatible; preserve license/notices if distributed |
| `requests` | 2.34.2 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `rich` | 15.0.0 | MIT | Compatible; preserve license/notices if distributed |
| `rpds-py` | 2026.6.3 | MIT | Compatible; preserve license/notices if distributed |
| `sarif-om` | 1.0.4 | MIT | Compatible; preserve license/notices if distributed |
| `secretstorage` | 3.5.0 | BSD-3-Clause | Platform-specific locked package; preserve license/notices if distributed |
| `setuptools` | 84.0.0 | MIT | Compatible; preserve license/notices if distributed |
| `six` | 1.17.0 | MIT | Compatible; preserve license/notices if distributed |
| `sniffio` | 1.3.1 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `sse-starlette` | 3.4.11 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `starlette` | 1.7.0 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `stevedore` | 5.9.1 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `storage3` | 2.31.0 | MIT | Compatible; preserve license/notices if distributed |
| `streamlit` | 1.64.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `StrEnum` | 0.4.15 | MIT | Compatible; preserve license/notices if distributed |
| `supabase` | 2.31.0 | MIT | Compatible; preserve license/notices if distributed |
| `supabase-auth` | 2.31.0 | MIT | Compatible; preserve license/notices if distributed |
| `supabase-functions` | 2.31.0 | MIT | Compatible; preserve license/notices if distributed |
| `tenacity` | 9.1.4 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `tiktoken` | 0.14.0 | MIT | Compatible; preserve license/notices if distributed |
| `toml` | 0.10.2 | MIT | Compatible; preserve license/notices if distributed |
| `tomlkit` | 0.15.1 | MIT | Compatible; preserve license/notices if distributed |
| `truststore` | 0.10.4 | MIT | Compatible; preserve license/notices if distributed |
| `typing_extensions` | 4.16.0 | PSF-2.0 | Compatible; preserve license/notices if distributed |
| `typing-inspection` | 0.4.4 | MIT | Compatible; preserve license/notices if distributed |
| `tzdata` | 2026.4 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `urllib3` | 2.8.0 | MIT | Compatible; preserve license/notices if distributed |
| `uvicorn` | 0.54.0 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `virtualenv` | 21.13.0 | MIT | Compatible; preserve license/notices if distributed |
| `watchdog` | 6.0.0 | Apache-2.0 | Compatible; preserve license/notices if distributed |
| `wcwidth` | 0.9.1 | MIT | Compatible; preserve license/notices if distributed |
| `websockets` | 15.0.1 | BSD-3-Clause | Compatible; preserve license/notices if distributed |
| `wrapt` | 2.5.0 | BSD-2-Clause | Compatible; preserve license/notices if distributed |
| `yarl` | 1.25.1 | Apache-2.0 | Compatible; preserve license/notices if distributed |

## Distribution Checklist

Before publishing a wheel, executable, container image, offline installer, or copied virtual environment:

- Generate a fresh software bill of materials from the final artifact rather than relying only on this source-tree inventory.
- Include the project `LICENSE` and a `THIRD_PARTY_NOTICES` file containing all licenses, copyright notices, Apache NOTICE content, and required reciprocal-license notices from the shipped artifact.
- Run a license scan that fails on unknown, forbidden, or unreviewed strong-copyleft runtime components.
- Confirm that Pylint, Astroid, Bash, CI actions, scanners, and browser test binaries are not unintentionally included in the application artifact.
- Include MPL-2.0 materials for Certifi and make any modified MPL-covered files available as required.
- Include PSF and incorporated-component acknowledgements if Python is bundled.
- Include the exact Chromium credits if Playwright browser binaries are bundled.
- Review model weights, datasets, fonts, images, and other non-package assets separately; this record covers software packages and tools only.

## Authoritative Sources

- [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- [Python licensing and incorporated software](https://docs.python.org/3/license.html)
- [Go project license statement](https://go.dev/project)
- [Mage repository and Apache-2.0 license](https://github.com/magefile/mage)
- [uv dual-license statement](https://github.com/astral-sh/uv)
- [PostgreSQL License](https://www.postgresql.org/about/licence/)
- [CodeQL Action licensing and CodeQL CLI distinction](https://github.com/github/codeql-action)
- [Gitleaks Action v3 EULA at the pinned revision](https://github.com/gitleaks/gitleaks-action/blob/e0c47f4f8be36e29cdc102c57e68cb5cbf0e8d1e/LICENSE.txt)
- [Gitleaks Action license-key requirements](https://github.com/gitleaks/gitleaks-action)
- [Trivy Action Apache-2.0 license](https://github.com/aquasecurity/trivy-action/blob/master/LICENSE)
- [ZAP legal notice and third-party licenses](https://github.com/zaproxy/zaproxy/blob/main/LEGALNOTICE.md)
- [zizmor Action MIT license](https://github.com/zizmorcore/zizmor-action)
- [pre-commit MIT license](https://github.com/pre-commit/pre-commit/blob/main/LICENSE)
- [Ruff pre-commit dual-license statement](https://github.com/astral-sh/ruff-pre-commit)
