# Writing Skills

This repo defines Codex writing skills for STEM Chinese thesis and paper drafting or polishing in LaTeX. The context exists to keep product language consistent when discussing originality, authorship, and detector-related requests.

## Language

**Attributable authorship**: Writing whose claims, examples, and structure can be traced to the user's notes, sources, project details, or reasoning.  
_Avoid_: 像人写就行, 去 AI 味

**Text quality improvement**: Rewriting that improves clarity, specificity, coherence, and technical readability without changing locked facts or claims.  
_Avoid_: 降 AI 率, 过检测优化

**AI-text false-positive risk**: The risk that readable, grounded writing is still judged to be AI-written. This repo may reduce that risk indirectly through better writing and better source grounding.  
_Avoid_: AIGC 率

**Detector evasion**: Wording changes aimed at exploiting assumed detector signals rather than improving meaning, evidence, readability, or attributable authorship. This is not a supported goal in this repo.  
_Avoid_: 过 AIGC, 规避检测, detect-safe

**Natural mode**: The default polishing mode that prioritizes readability, fluency, and technical clarity with small-to-medium edits. It removes boilerplate and awkward phrasing without pretending to add missing evidence.  
_Avoid_: 默认降 AI 模式

**Source-grounded mode**: The repo's formal second mode. It increases specificity, disambiguates references, and ties prose more tightly to user-provided notes, sources, or project facts. Its purpose is attributable authorship, not detector evasion.  
_Avoid_: detect-safe, attributable mode, 过检测模式

**Grounding anchor**: A user-provided factual input that can justify wording choices in a rewritten passage, such as notes, citations, experiment settings, project constraints, class concepts, or lived experience. Source-grounded mode requires enough anchors to support its stronger specificity.  
_Avoid_: 凭空补细节, 假具体

**Mode fallback**: When the user requests source-grounded mode but does not provide enough grounding anchors, the skill must explicitly ask for the missing anchors and, if they are not provided, fall back to natural mode. It must not fabricate sources, experience, numbers, or specifics.  
_Avoid_: 硬上 source-grounded

**Author intent**: The user's statement of what the target passage must express and what must remain unchanged. If intent is underspecified, the skill may propose likely intent options for the user to confirm rather than silently assuming one.  
_Avoid_: 直接按措辞改, 不问立场

**Source-grounded input contract**: The minimum required input for source-grounded mode is the target text, the author's intent, and at least three grounding anchors. At least one anchor must come from a checkable source, experiment setting, project constraint, class concept, or real lived experience.  
_Avoid_: 只给一段稿子就强行做 source-grounded

**Output contract**: Source-grounded output must include three sections: revised text, anchor usage, and gaps or assumptions. The rewritten passage alone is not enough, because attributable authorship requires showing which anchors justified which wording choices and where support is still missing.  
_Avoid_: 只给改写正文

**Cross-skill capability**: Source-grounded is a repo-level capability shared by drafting and polishing skills, not a polishing-only feature. The repo should collect and preserve author intent and grounding anchors across the whole writing flow rather than generate a generic draft first and patch specificity later.  
_Avoid_: 只在 polish 里补救

**Drafting fallback**: In `stem-paper-zh-write`, source-grounded drafting may produce full prose only when author intent and grounding anchors are sufficient. When they are not, the skill must ask for missing inputs and, if they are still not provided, return a structured outline or ask permission to downgrade to natural mode.  
_Avoid_: 从零写作时硬编具体细节

**Success criteria**: The repo is judged by attributable authorship, specificity, readability, and conservatism rather than detector scores. In source-grounded mode, key rewrites must map to user-provided anchors, specificity should replace vague template prose, readability and LaTeX replaceability must remain intact, and no new unsupported facts or experiences may be introduced.  
_Avoid_: 以检测分数验收

**Mode trigger rule**: Source-grounded may be explicitly selected by the user, or suggested by the skill when enough anchors are already present, but it must never be enabled silently. If the user does not select a mode and the material is insufficient, the default remains natural mode.  
_Avoid_: 静默升级到 source-grounded

**Detector-language remapping**: Phrases such as "降 AIGC" or "过检测" are treated as user-language, not product terminology. The skill must not promise detector outcomes or optimize against presumed detector features; instead it should remap the request to natural mode or, when anchors are available, source-grounded mode. If the user insists on detector evasion without attributable support, the skill must stop.  
_Avoid_: 按过检测目标继续执行

**Shared source-grounded contract**: The rules for source-grounded mode should live in a shared reference used by both drafting and polishing skills, rather than being duplicated independently. Shared rules include the input contract, output contract, trigger rules, fallback behavior, detector-language remapping, and success criteria.  
_Avoid_: 两个 skill 各写一套
