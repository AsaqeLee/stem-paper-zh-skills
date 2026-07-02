# LaTeX 多文件工程 — 操作护栏

## 默认假设

- 主文件 `main.tex` + `\input{...}` / `\include{...}` 分章
- 一次任务只处理用户 **点名的一个 `.tex` 文件**（或文件内指定 `\section` 范围）

## 禁止擅自修改（除非用户显式要求）

- preamble：`\documentclass`、宏包、`\newcommand`、字体、页边距
- `\bibliography`、`\bibliographystyle`、`thebibliography` 环境内条目
- `\appendix` 及附录整体结构
- 图表浮动体中的 **\label** 与 **\ref** 键名（可改 caption 中文表述，不改 label）
- 数学环境中的 **符号含义**（可改文字说明，不改公式结构）

## 必须原样保留

- 所有 `equation` / `align` / `gather` 等环境中的公式与编号
- `\cite{...}` 键与顺序（润色时勿改 key、勿合并条目）
- 表格列格式、`\toprule` 等结构命令（只改 cell 内中文措辞）
- 图片 `\includegraphics` 路径与参数

## 输出格式（写作 / 润色）

- 输出 **完整可替换** 的该 `.tex` 文件内容（从第一行到最后一行），或用户指定的 `\section`…`\section` 片段
- 使用 **合法 LaTeX**：特殊符号转义、中文与公式之间空格习惯与原文一致
- 不要包裹 markdown 代码围栏以外的解释性正文进 `.tex` 文件

## 分节建议

- 单次生成目标：**≤1500 汉字** 或 **≤80 行** 正文 LaTeX（不含长表），过长则拆 `\subsection`