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

## 特色与设计规范

1. **绝对矢量与无限放大**：
   - 网页展台采用 Typst 原生编译的纯矢量 SVG，所有公式符号内嵌矢量路径，几何图形由 CeTZ 驱动，支持无限缩放不模糊；
   - 离线长图统一采用 **333 DPI 超清标准**（正文宽达 `2321 px`），完美适配 4K 屏与高倍打印。
2. **🔬 Lean 4 定理形式化推演与单步调试器 (lean-snapshot)**：
   - 在 `lean/TiYunBei/` 下为精选的 5 道代表性试题（03、07、08、09、19）编写了完整的 Lean 4 + Mathlib 形式化证明源码；
   - 在线展台集成专属「单步调试播放器」，支持代码逐行高亮、Tactic State（目标与假设）动态流转、定时自动播放、拖拽跳转与 Q.E.D. 闭合判定。
3. **规范与深度推导**：
   - **第 3 题**：平行四边形定比放大并对角线智能避让，视觉舒适；
   - **第 8 题**：规范正弦分式与指数上标排版，新增圆角矩形深度探究框（含 $t < \tan t$ 严谨求导证明与 $y = \tan t$ vs $y = t$ 左右分栏函数图像对比）；
   - **第 9 题**：复平面几何向量可视化，复数除法分母完整呈现平方差展开与代换细节；
   - **第 17 题**：规范建立高中数学教材标准空间直角坐标系，立体几何标点全面完整；
   - **第 18 题**：提炼导数结构特征求导圆角框，并采用优美的四项等差数列比例构造法秒出结论；
   - **第 19 题**：规范数列下标，采用首末项等差求和表述，简化数学归纳与等价证明。

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
