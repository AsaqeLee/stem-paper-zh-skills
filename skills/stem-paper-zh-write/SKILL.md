---
name: stem-paper-zh-write
description: Draft new STEM Chinese thesis/paper sections in LaTeX when the user does not yet have prose. Supports natural drafting by default and source-grounded drafting when the user can provide author intent plus grounding anchors. Use for requests like 写绪论, 写方法, 生成某个 `.tex` 章节, and do not use it to polish an existing draft.
---

# stem-paper-zh-write（理工中文论文 · 从零撰写）

目标：在 **保留学校/模板章节结构** 的前提下，写出可直接写入 `.tex` 的理工中文正文，优先保证可读性、具体性与可归因性。

## 何时使用

- 还没有正文草稿，要从提纲写到某一 `\section`
- 多文件工程：`main.tex` `\input{chapters/...}`
- **不要**用本 skill 润色已有稿 → 用 `stem-paper-zh-polish`

## 必读参考（动手前先 `read_file`）

- `references/banned-phrases.md`
- `references/latex-guardrails.md`
- `references/writing-patterns.md`
- `../shared/references/source-grounded-contract.md`

## 模式

| 模式 | 何时 |
|------|------|
| `natural` | 默认；材料不足、只需要正常起草，或用户未选择模式时 |
| `source-grounded` | 用户明确选择，或材料充分时可建议切换；必须满足共享合同 |

如果用户说“降 AIGC / 过检测”，把需求重述为 `natural` 或 `source-grounded`。不要承诺检测结果，也不要围绕检测器特征优化文本。

## 工作流（严格顺序）

1. 锁定本次只处理的 **一个** `.tex` 文件或其节范围。
2. 确定模式：
   - 用户显式说 `source-grounded` → 按共享合同执行
   - 用户未指定，但已给出足够 anchors → 建议切换，不要静默升级
   - 其余情况默认 `natural`
3. 先做 A2 提纲：
   - 确认文件路径、`section/subsection` 标题
   - 每节列出 3–5 条要点，要求动词开头、可验证、禁止套话
   - `source-grounded` 时，把关键要点与 anchors 对齐
4. 进入 A1 正文：
   - 只写用户点名的文件或节范围
   - 保留学校模板章节层级，不重排整体结构
   - 遵循 `references/writing-patterns.md`
5. `source-grounded` 的缺料处理：
   - 缺 `author intent` 或 anchors 时，明确缺什么
   - 如果用户不补材料，只给结构化提纲，或询问是否降级到 `natural`
   - 绝不在从零写作阶段编造“具体细节”来硬写正文

## 写作规则

- 句子优先写清对象、条件、动作、结果
- 用具体名词、约束、场景和数字替代空泛概括
- 相关工作写“别人做了什么、前提是什么、与本文差在哪里”
- 方法写“输入输出、步骤、复杂度 / 假设 / 失败模式”
- 实验写“设置公平性、指标、结果、异常解释”
- 结论写“做了什么、结果如何、局限是什么”
- `source-grounded` 时，每个关键段落都要能指回用户给出的 anchors；缺依据就保留缺口，不要伪具体

## 输出

- 默认输出：可直接替换的 `.tex` 文件内容，或用户指定节片段
- `source-grounded` 输出：最终回复固定为 `revised text`、`anchor usage`、`gaps / assumptions` 三段，其中 `revised text` 仍然是可替换的 LaTeX

## 绝对禁止

- 套话、官样文章、空泛“意义”
- 编造文献、数据、实验、结论、个人经历
- 未经用户要求新增节标题、图表、公式、引用
- 修改 LaTeX 工程结构、preamble、bib、label
- 为了“过检测”而故意破坏可读性、连贯性或术语一致性
