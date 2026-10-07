# stem-paper-zh-skills

Installable agent skills that improve **Chinese STEM academic writing** quality, attribution, and authorial voice for Codex, Claude Code, and Grok. Skills target multi-file LaTeX theses and emphasize concrete, source-anchored prose.

This repository does **not** promise any AI-detector outcome and does **not** optimize against detector features. Requests framed only as “bypass detection” are refused or restated into legitimate writing goals.

## Skills

| Skill | Purpose |
|-------|---------|
| `stem-paper-zh-write` | Draft from outline (A2) then section LaTeX (A1). Default mode `natural`; use `source-grounded` when materials are sufficient. |
| `stem-paper-zh-polish` | Polish an existing `.tex` file. Same modes as above. |

- Domain: STEM academic papers
- Engineering focus: multi-file LaTeX (one `\input` file or section range per run)
- Polish “six locks”: formulas, figure/table labels, citations, terminology, numeric claims, conclusion stance

General long-form skills (blogs, reports) are out of scope for this repository.

## Modes

- **`natural`** (default): light-to-moderate rewrite for readability, coherence, and terminology.
- **`source-grounded`**: stronger specificity and attribution. Requires target text, author intent, and at least three grounding anchors.

## Requirements

- One of: Grok skills directory, Claude Code skills, or Codex skills
- Shell (bash) or PowerShell for the install scripts

## Installation

macOS / Linux:

```bash
chmod +x install-skills.sh
./install-skills.sh --user
./install-skills.sh --project
./install-skills.sh --both
```

Windows PowerShell:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install-skills.ps1 -Mode user
.\install-skills.ps1 -Mode project -ProjectDir C:\path\to\thesis-repo
.\install-skills.ps1 -Mode both -ProjectDir C:\path\to\thesis-repo
```

| Tool | User install path |
|------|-------------------|
| Grok | `~/.grok/skills/` |
| Claude Code | `~/.agents/skills/` |
| Codex | `~/.codex/skills/` |

Installers copy both skills and shared `skills/shared/` references so the `source-grounded` contract remains readable after install.

## Usage

Draft:

> `/stem-paper-zh-write natural，请先为 chapters/method.tex 的 3.2 节列提纲，再输出可替换 LaTeX`

> `/stem-paper-zh-write source-grounded，目标文本是 chapters/intro.tex 的 1.2 节，作者意图和 anchors 如下 …`

Polish:

> `/stem-paper-zh-polish natural，请润色 chapters/intro.tex 全文，输出可整文件替换的 LaTeX`

## Project layout

```text
.
├── install-skills.sh
├── install-skills.ps1
├── skills/
│   ├── stem-paper-zh-write/
│   ├── stem-paper-zh-polish/
│   └── shared/references/
├── docs/
└── CONTEXT.md
```

## Status / limitations

- One `.tex` file (or section range) per invocation by design
- Output aims to be drop-in replaceable LaTeX without rewriting preamble, bibliography files, labels, or formulas
- `source-grounded` is never silently enabled; the user must select it or accept an explicit suggestion when materials are sufficient
