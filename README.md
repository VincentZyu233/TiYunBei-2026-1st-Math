# 2026 年第一届“提云杯”线上联考 · 数学参考解答

[![Release](https://img.shields.io/github/v/release/VincentZyu233/TiYunBei-2026-1st-Math?style=flat-square&color=emerald&logo=github)](https://github.com/VincentZyu233/TiYunBei-2026-1st-Math/releases/tag/v0.2.0)
[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-%E6%B5%8F%E8%A7%88%E5%99%A8%E7%82%B9%E5%87%BB%E6%89%93%E5%BC%80%E9%A2%98%E8%A7%A3%E5%9C%A8%E7%BA%BF%E7%AB%99%E5%8F%B0-blue?style=flat-square&logo=github)](https://vincentzyu233.github.io/TiYunBei-2026-1st-Math/)
[![原题试卷 PDF](https://img.shields.io/badge/原题试卷-下载%20PDF-e05d44?style=flat-square&logo=adobeacrobatreader&logoColor=white)](./problem/2026年第一届提云杯线上联考.pdf)
[![Typst](https://img.shields.io/badge/Powered%20by-Typst-239dad?style=flat-square&logo=typst&logoColor=white)](https://typst.app/)
[![Lean 4](https://img.shields.io/badge/Formalized%20with-Lean%204-6c3483?style=flat-square)](https://lean-lang.org/)

本仓库为 2026 年第一届“提云杯”线上联考数学科目的完整解答与高清排版项目，采用现代科学排版系统 **Typst** 进行全套编写与矢量渲染，并为重点试题提供了 **Lean 4** 交互式定理形式化验证。

🌐 **浏览器点击打开题解在线站台**：[https://vincentzyu233.github.io/TiYunBei-2026-1st-Math/](https://vincentzyu233.github.io/TiYunBei-2026-1st-Math/)  
*(支持鼠标滚轮与移动端触控的无限平滑缩放，纯矢量数学公式与几何绘图，放大 1000% 依然绝对锐利无锯齿；新增 Lean 4 单步推演调试器)*

---

## 试卷结构与内容

| 章节 | 题号 | 分值 | 产物目录 | 在线单题卡 | Lean 4 推演 |
|---|---|---|---|---|---|
| **一、单项选择题** | 1—8 题 | 40 分 | `out/s01-select/` | `q01.svg` ~ `q08.svg` | **03**、**07**、**08** |
| **二、多项选择题** | 9—11 题 | 18 分 | `out/s02-multi/` | `q09.svg` ~ `q11.svg` | **09** |
| **三、填空题** | 12—14 题 | 15 分 | `out/s03-fill/` | `q12.svg` ~ `q14.svg`、`q14_bonus.svg` | — |
| **四、解答题** | 15—19 题 | 77 分 | `out/s04-solve/` | `q15.svg` ~ `q19.svg` | **19** |

---

## 项目亮点

1. **全程 Typst 题解与纯矢量图形展示**：
   - 全套试卷参考解答基于 **Typst** 科学排版系统编写，每道题目均配有高精度 CeTZ 几何与函数图像（Figure Graph）；
   - 在线展台采用原生纯矢量 SVG，支持鼠标滚轮与手势的无限平滑缩放（放大无模糊与锯齿），并提供 333 DPI 超清离线图集。
2. **🔬 Lean 4 形式化推导与单步交互调试 (Q.E.D.)**：
   - 精选代表性试题（03、07、08、09、19）编写严谨的 **Lean 4 + Mathlib** 形式化推导与机器证明源码；
   - 网页端集成单步推导调试播放器，动态呈现每一步证明的目标（Goal）与上下文假设（Hypotheses）流转，支持代码逐行高亮与自动播放，直观展示推导过程直至定理闭合（Q.E.D.）。

---

## 排版与推演引擎

| 维度 / 模块 | 技术与引擎 | 徽标 Badge | 职责与特性 |
|---|---|---|---|
| **科学排版** | **Typst (0.14+)** | [![Typst](https://img.shields.io/badge/Typst-0.14+-239dad?style=flat-square&logo=typst&logoColor=white)](https://typst.app/) | 现代科学排版系统，负责全卷数学公式排版、试卷分栏与纯矢量 SVG/PDF 渲染编译 |
| **矢量绘图** | **CeTZ (0.5.2)** | [![CeTZ](https://img.shields.io/badge/CeTZ-0.5.2-1f883d?style=flat-square)](https://github.com/cetz-package/cetz) | Typst 原生图形库，负责高精度函数图像、导数切线、空间直角坐标系及几何构造解析 |
| **形式化推演** | **Lean 4 + Mathlib** | [![Lean 4](https://img.shields.io/badge/Lean_4-Mathlib-6c3483?style=flat-square)](https://lean-lang.org/) | 交互式定理证明器，负责代表性试题的严格公理化机器推演与状态流转证明 |
| **自动化管线** | **Python + uv** | [![Python](https://img.shields.io/badge/Python-3.10+-3776ab?style=flat-square&logo=python&logoColor=white)](https://www.python.org/) [![uv](https://img.shields.io/badge/uv-fast-de5d43?style=flat-square)](https://github.com/astral-sh/uv) | 自动化流水线，负责标点与公式治理、333 DPI 截图、SVG 提取及 7z 离线资源打包 |

---

## 本地编译与构建

项目基于 `uv` 与 Python 工具链管理：

```bash
# 1. 安装依赖 (PyMuPDF 用于切图)
uv pip install pymupdf

# 2. 编译全卷分章节 PDF
uv run python scripts/05_build_pdf.py

# 3. 按题切割 333 DPI 超清矢量图 (输出到 out/)
uv run python scripts/06_shoot_figs.py

# 4. 构建 GitHub Pages 纯矢量 SVG 展台 (输出到 site/)
uv run python scripts/07_build_svg.py

# 5. 打包全套离线高清发布包 (输出到 archive/)
uv run python scripts/08_pack_zip.py

# 6. Lean 4 形式化源码验证 (需安装 elan / lake)
cd lean
lake build
```

---

## 署名

| 分工角色 | 贡献成员 | 即时沟通 |
|---|---|---|
| **试题命制 / 出题人** | **提尔 sSwar** | [![QQ: 1210183458](https://img.shields.io/badge/QQ-1210183458-12B7F5?style=flat-square&logo=qq&logoColor=white)](tencent://message/?uin=1210183458) |
| **解答排版 / 写题人** | **VincentZyu** | [![QQ: 1830540513](https://img.shields.io/badge/QQ-1830540513-12B7F5?style=flat-square&logo=qq&logoColor=white)](tencent://message/?uin=1830540513) |
