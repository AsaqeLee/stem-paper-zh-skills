# stem-paper-zh-skills — 理工中文论文 Skills

提升 Codex / Claude Code / Grok 写理工中文论文时的文本质量、可归因性与作者性。仓库通过更具体、更有来源锚点的写法，间接降低被判为 AI 文的风险；**不**承诺任何检测结果，也**不**做针对检测器特征的优化。

## Skills

| Skill | 用途 |
|--------|------|
| `stem-paper-zh-write` | **还没写** -> 先提纲（A2）再按节出 LaTeX（A1）；默认 `natural`，材料充足时可用 `source-grounded` |
| `stem-paper-zh-polish` | **已有稿** -> 润色 `.tex`；默认 `natural`，材料充足时可用 `source-grounded` |

领域：**理工**学术论文  
工程：**LaTeX 多文件**（一次处理一个 `\input` 文件）  
润色 **六锁**：公式、图表 label、文献、术语、数值、结论立场

通用长文（报告、博客式说明）**另做 skill**，本仓库暂不包含。

## 模式

- `natural`：默认模式；小到中幅改写，优先可读性、连贯性、术语准确。
- `source-grounded`：更强的具体化和可归因性；要求 `目标文本 + 作者意图 + 至少 3 个 grounding anchors`。
- 用户如果说“降 AIGC / 过检测”，skill 会自动重述为上面两种合法目标；若用户坚持只要规避检测，则停止。

## 安装

```bash
chmod +x install-skills.sh
./install-skills.sh --user
./install-skills.sh --project
./install-skills.sh --both
```

安装位置：

| 工具 | User 路径 |
|------|-----------|
| Grok | `~/.grok/skills/` |
| Claude Code | `~/.agents/skills/` |
| Codex | `~/.codex/skills/` |

安装脚本会同时复制两个 skill 和共享 `skills/shared/` reference，保证 `source-grounded` 合同在安装后仍可被两个 skill 读取。

## 用法

写新章节：

> `/stem-paper-zh-write natural，请先为 chapters/method.tex 的 3.2 节列提纲，再输出可替换 LaTeX`

> `/stem-paper-zh-write source-grounded，目标文本是 chapters/intro.tex 的 1.2 节，作者意图和 anchors 如下 ...`

润色已有稿：

> `/stem-paper-zh-polish natural，请润色 chapters/intro.tex 全文，输出可整文件替换的 LaTeX`

> `/stem-paper-zh-polish source-grounded，目标文本是 chapters/intro.tex 第 2 节，作者意图和 anchors 如下 ...`

## 仓库结构

- `skills/stem-paper-zh-write/`
- `skills/stem-paper-zh-polish/`
- `skills/shared/references/source-grounded-contract.md` — 两个 skill 共享的 `source-grounded` 合同
- `skills/stem-paper-zh-write/references/*`
- `skills/stem-paper-zh-polish/references/*`

## 说明

- 写作与润色都默认一次只处理 **一个** `.tex` 文件或其节范围
- 输出目标是 **可直接替换** 的 LaTeX，不改 preamble / bib / label / 公式
- `source-grounded` 不会静默启用；用户显式选择，或由 skill 在材料充分时建议切换
