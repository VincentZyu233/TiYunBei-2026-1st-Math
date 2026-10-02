# 2026 年第一届“提云杯”线上联考 · 数学参考解答

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-%E6%B5%8F%E8%A7%88%E5%99%A8%E7%82%B9%E5%87%BB%E6%89%93%E5%BC%80%E9%A2%98%E8%A7%A3%E5%9C%A8%E7%BA%BF%E7%AB%99%E5%8F%B0-blue?style=flat-square&logo=github)](https://vincentzyu233.github.io/TiYunBei-2026-1st-Math/)
[![Release](https://img.shields.io/github/v/release/VincentZyu233/TiYunBei-2026-1st-Math?style=flat-square&color=emerald)](https://github.com/VincentZyu233/TiYunBei-2026-1st-Math/releases/tag/v0.2.0)
[![Typst](https://img.shields.io/badge/Powered%20by-Typst-239dad?style=flat-square)](https://typst.app/)
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

## 署名与归档

- **试题命制 / 出题人**：提尔 sSwar (QQ: 1210183458)
- **解答排版 / 写题人**：VincentZyu (QQ: 1830540513)
- **排版与推演引擎**：Typst + CeTZ + Lean 4 (Mathlib)
- **全套离线高清包**：请前往 [GitHub Releases (v0.2.0)](https://github.com/VincentZyu233/TiYunBei-2026-1st-Math/releases/tag/v0.2.0) 下载 `TiYunBei_2026_Math_Solution_v0.2.0.zip`。
