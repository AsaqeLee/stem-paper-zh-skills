---
name: stem-paper-zh-polish
description: Polish existing STEM Chinese thesis LaTeX while preserving locked facts, formulas, labels, citations, numbers, and claims. Supports natural polishing by default and source-grounded polishing when the user can provide author intent plus grounding anchors. Use when the user already has a `.tex` draft and wants a replaceable polished file or section.
---

# stem-paper-zh-polish（理工中文论文 · 已有稿润色）

目标：在 **六锁** 前提下改写中文表述，提升可读性、具体性与可归因性，输出 **整文件或可替换片段的 LaTeX**。

## 何时使用

- 已有 `.tex` 正文，需要润色后 **直接替换文件**
- 多文件工程：一次只处理用户指定的 **一个** `\input` 文件或节范围
- **不要**用本 skill 从零写章 → 用 `stem-paper-zh-write`

## 必读参考（动手前先 `read_file`）

- `references/banned-phrases.md`
- `references/latex-guardrails.md`
- `references/polish-modes.md`
- `../shared/references/source-grounded-contract.md`

## 模式

| 模式 | 何时 |
|------|------|
| `natural` | 默认；优先可读、连贯、像认真写论文的人 |
| `source-grounded` | 用户明确选择，或材料充分时可建议切换；必须满足共享合同 |

如果用户说“降 AIGC / 过检测”，把需求重述为 `natural` 或 `source-grounded`。不要承诺检测结果，也不要围绕检测器特征优化文本。

## 六锁（绝对禁止改动）

1. **公式、符号、变量名**：数学环境内容与编号不变
2. **图表编号与 `\label` / `\ref`**：键名不变
3. **文献 `\cite{...}`**：key 与顺序不变，不增删引用
4. **术语与缩写**：已定术语、单位、记号保持一致
5. **数值与实验设置**：不改数字、阈值、数据集、超参
6. **结论立场**：不增强、不弱化、不偷换比较对象

## 工作流

1. 确认本次处理的文件路径或节范围。
2. 确定模式：
   - 用户显式说 `source-grounded` → 按共享合同执行
   - 用户未指定，但 anchors 充足 → 建议切换，不要静默升级
   - 其余情况默认 `natural`
3. 阅读目标文本，标记：
   - 套话、空泛总结、万能过渡
   - 连续排比衔接和机械对称句
   - 指代不清、没有对象或条件的表述
4. `source-grounded` 的缺料处理：
   - 缺 `author intent` 或 anchors 时，明确缺什么
   - 用户不补材料时，自动降级到 `natural`
   - 绝不编造来源、经历、数据或伪具体细节
5. 在 **六锁** 前提下逐段改写：
   - `natural`：小到中幅润色，删套话、改语序、拆长句、补明确指代
   - `source-grounded`：中幅润色，允许在段内重组句序，但关键改写必须能映射到 anchors
6. 输出可直接替换的 LaTeX；`source-grounded` 时最终回复固定为 `revised text`、`anchor usage`、`gaps / assumptions` 三段

## 绝对禁止

- 改公式、改 `\cite`、改数字、改结论强弱
- 编造实验、文献、数据、个人经历
- 改 LaTeX 工程结构、preamble、bib、label
- 为了“过检测”而故意破坏可读性、连贯性或术语一致性
- 输出解释多于正文
