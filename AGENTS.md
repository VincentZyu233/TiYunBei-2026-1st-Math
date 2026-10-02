# AGENTS.md

本仓库用于整理「提云杯」数学竞赛试题的**解答排版**。核心工作流：把题目 PDF 转成
可编译的 Typst 源码，输出分栏目的参考解答 PDF。

## 命名规范（强制）

### 章节：`sNN-<slug>`

目录名与装配入口文件名统一用 `sNN-<slug>`，`NN` 是**试卷上的大题序号**。
这样 VS Code 文件树按名字排序就等于试卷顺序，不需要再靠别的手段对齐。

| 章节 | 目录 | 装配入口 | 单题文件 | 命令别名 |
|---|---|---|---|---|
| 一、选择题 1—8 | `s01-select/` | `s01-select.typ` | `q01.typ` … `q08.typ` | `select` |
| 二、多选题 9—11 | `s02-multi/` | `s02-multi.typ` | `q09.typ` … `q11.typ` | `multi` |
| 三、填空题 12—14 | `s03-fill/` | `s03-fill.typ` | `q12.typ` … `q14.typ` | `fill` |
| 四、解答题 15—19 | `s04-solve/` | `s04-solve.typ` | `q15.typ` … `q19.typ` | `solve` |

`src/` 与 `out/` 用**同名**章节目录，一一对应。

### 单题：`qNN.typ`

`NN` 是**试卷上的题号**（两位，不足补零），与章节前缀无关。
因此 `q01`–`q08`、`q09`–`q11`、`q12`–`q14`、`q15`–`q19` 在各自目录里都是连续的。

### 脚本：`动词_名词.py`

| 脚本 | 职责 |
|---|---|
| `build_pdf.py` | 编译章节 → `out/<章节>/<章节>.pdf` |
| `shoot_figs.py` | 按题切图 → `out/<章节>/<章节>-qNN.png` |
| `build_svg.py` | 编译纯矢量 SVG 与清单 → `site/svg/`、`site/manifest.json` |
| `pack_zip.py` | 调用 7z 极致压缩打包全套离线资源包 → `archive/` (自动读取 `VERSION`) |
| `fix_punct.py` | 句末西文句点 → 中文句号 |
| `norm_math.py` | LaTeX → Typst 数学写法规范化 |

`_chapters.py` 是内部模块（下划线前缀），存章节配置与本地字体解析的**唯一来源**，
被 `build_pdf.py`、`shoot_figs.py` 与 `build_svg.py` 共用。新增章节只改这一处。

### 新增章节的步骤

1. 在 `_chapters.py` 的 `CHAPTERS` 里加一项（含 `entry` / `title` / `qnos`）
2. 在 `ALIASES` 里加短名（可选，但建议加）
3. 建 `src/sNN-slug/` 目录，放 `qNN.typ`
4. 建 `src/sNN-slug.typ` 装配入口：只写标题块 + `#include` + `#qsep`
5. `uv run python scripts/build_pdf.py sNN-slug` 验证

## 项目结构

```
01-2026/                      ← 仓库根
├─ .gitignore / .gitattributes
├─ AGENTS.md                  本文件
├─ AGENTS.local.example.md    本地配置模板（入库）
├─ AGENTS.local.md            个人偏好/字体绝对路径（gitignore，不入库）
├─ problem/                   题面 PDF（不进追踪）
├─ site/                      GitHub Pages 前端静态站 (SVG/PDF/WebFont)
├─ scripts/                   见上表
├─ src/
│  ├─ _template.typ           字体 / 页面 / 题目骨架 / 答案框
│  ├─ _math.typ               数学简写 (vec, RR, oo ...)
│  ├─ _figs.typ               绘图辅助 (cetz 封装)
│  ├─ s01-select/  s01-select.typ
│  ├─ s02-multi/   s02-multi.typ
│  ├─ s03-fill/    s03-fill.typ
│  └─ s04-solve/   s04-solve.typ
└─ out/
   ├─ s01-select/s01-select.pdf + s01-select-q01.png …
   ├─ s02-multi/s02-multi.pdf   + s02-multi-q09.png …
   ├─ s03-fill/s03-fill.pdf     + s03-fill-q12.png …
   └─ s04-solve/s04-solve.pdf   + s04-solve-q15.png …
```

产物为四个 PDF，每个大题一个目录：

| 目录 | PDF 内容 | 分值 | 截图 |
|---|---|---|---|
| `out/s01-select/` | 选择题 1—8 | 40 | `s01-select-q01..q08.png` |
| `out/s02-multi/`  | 多选题 9—11 | 18 | `s02-multi-q09..q11.png` |
| `out/s03-fill/`   | 填空题 12—14 | 15 | `s03-fill-q12..q14.png` |
| `out/s04-solve/`  | 解答题 15—19 | 77 | `s04-solve-q15..q19.png` |

截图不是"只截插图"，而是**该题在 PDF 里的完整版面**：
含题干、选项、解答、答案框、配图；第一题的截图额外包含章节标题块。

## 常用命令

章节参数可写规范名（`s01-select`）或短别名（`select`），两种都行。

```bash
cd 01-2026

# 编译全部 PDF（推荐入口）
uv run python scripts/build_pdf.py

# 只编译某几份
uv run python scripts/build_pdf.py select solve
uv run python scripts/build_pdf.py s01-select s04-solve

# 监听 src/ 自动重编译
uv run python scripts/build_pdf.py --watch

# 把每题单独截成 PNG（需 pymupdf，默认 333 DPI 高清出图，正文宽约 2321 px）
uv pip install pymupdf
uv run python scripts/shoot_figs.py                    # 全部章节（默认 333 DPI）
uv run python scripts/shoot_figs.py select             # 指定章节
uv run python scripts/shoot_figs.py select --dpi 333   # 可自定义指定 DPI（默认 333）
uv run python scripts/shoot_figs.py select --keep-pdf  # 保留中间 PDF

# 编译全卷单题纯矢量 SVG 与发布索引 (供 GitHub Pages 交互使用)
uv run python scripts/build_svg.py

# 调用 7z 极致压缩打包全套离线资源包到 archive/（自动读取 VERSION）
uv run python scripts/pack_zip.py

# 句末西文句点 → 中文句号（写之前先 --check）
uv run python scripts/fix_punct.py --check
uv run python scripts/fix_punct.py

# 把源码里的 LaTeX 写法批量改成 Typst 写法
uv run python scripts/norm_math.py --check   # 先看会改什么
uv run python scripts/norm_math.py           # 实际写入
```

## 环境

- **Typst 0.14+**（`typst --version` 自检）。`cetz` 固定用 `0.5.2`。
- Python 用 `uv` 管理，虚拟环境在 `01-2026/.venv`（无 pip，一律用 `uv pip` / `uv run`）。
- **字体与本地环境配置（强制锁定 Mono 变体）**：
  - 仓库不再内置数百兆字体，而是通过 `--font-path` 参数直接挂载本机字体目录。
  - 本地开发者请参考 `AGENTS.local.example.md` 在仓库根目录新建 `AGENTS.local.md`（该文件已在 `.gitignore` 中）：
    ```ini
    FONT_DIR=X:\字体\霞鹜文楷LXGW_WenKai\lxgw-wenkai-v1.520
    ```
  - 若缺失 `AGENTS.local.md`，编译脚本会输出醒目高亮警告提示开发者补充配置。
  - 正文字体已锁定单一等宽变体：`"LXGW WenKai Mono"`。

## 写 Typst 数学的几个硬性约束

这几条是实测踩出来的，违反会直接编译失败，改源码前务必记住：

1. **`body` 必须放在参数列表最末。**
   `#let f(a, b: 1, body) = ...` ✅ ／ `#let f(a, body, b: 1)` ❌

2. **不能在 `=` 后换行。**
   `#let f(x) =` 换行再写表达式会报 `expected expression`。要用 `{ ... }` 包起来。

3. **参数名不能叫 `t`。** `t` 是 Typst 的时间单位关键字（`0.5s`）。

4. **不能在自定义函数里裸调 `line`。**
   必须写 `cetz.draw.line`。裸 `line` 会解析到 Typst 内置的 line 元素。

5. **坐标元组元素必须是 int/float/length，长度 2 或 3。**
   混入非数值会 `panic "Failed to resolve coordinate"`。

6. **stroke 不能写成 `color + 0.8pt + (dash: 3)`。**
   color 与字典不能相加，必须整体写成字典，且 `dash` 要用具名样式（`"dashed"`）
   或数组，不能是裸整数。用 `_figs.typ` 里的 `s()` / `sd()` 封装。

7. **多字母几何记号要拆开。**
   Typst 数学模式把 `ABC` 当成 `A·B·C`，几何里它是顶点名，应写 `A B C`。
   （`norm_math.py` 会自动处理大部分，但 `ABC` 这类在 `KEEP_WHOLE` 白名单里，
   需要时手动改。）

8. **数学里写自定义符号要在顶层 `#let`。**
   见 `_math.typ`。数学模式中没有 `math.scope`；`accent` / `sym` 等构造器
   不能直接在数学模式里用。

9. **Typst 的 `range()` 不支持步长。**
   `range(0, 24, 4)` 会报 `unexpected argument`。要步长就直接列出元素：
   `for k in (0, 4, 8, 12) { ... }`。

10. **`\u{201C}` 这类转义要写在 Typst 里，不要用中文引号字符。**
    在 Typst 字符串中直接写 `"` / `"` 会导致解析失败（报 `expected comma`），
    一律用 `\u{201C}` / `\u{201D}`。

## 标点规范（强制）

**所有句末一律使用中文句号 `。`（U+3002），禁止使用西文句点 `.`。**

原因：Typst 按 CJK 断行规则把西文句点当作可换行点，夹在中文正文里的
`$ … = 1.$` 会把句号甩到下一行行首，出现「于是」单独占一行的怪象。
中文句号不断行，也不会与西文句点混淆。

正确 / 错误对照：

| 场景 | ❌ 错误 | ✅ 正确 |
|---|---|---|
| 行内公式收尾 | `有 $x = 1$。` → 写成 `$x = 1$.` | `$x = 1$。` |
| 独立公式收尾 | `$ … = 1.$` | `$ … = 1,`（行末用逗号）或块外补句号 |
| 中文句子收尾 | `结论很好.` | `结论很好。` |

**例外**（保持西文句点 / 不改）：

- 小数：`0.55pt`、`3.15`、`1.0`
- 链式调用与属性：`.at(0)`、`.first()`、`.map()`
- 文件名与扩展名：`select.typ`、`temp/scripts/`
- 英文缩写：`e.g.`、`etc.`
- 代码行与注释行

批量检查用 `fix_punct.py`，它已内置上述例外规则：

```bash
uv run python temp/scripts/fix_punct.py --check    # 只报告
uv run python temp/scripts/fix_punct.py            # 写入
```

注意：`fix_punct.py` 只处理**单行数学块**（`$ … $` 起止在同一行）。
跨行的 `$\n … \n$` 块需要手工调整——把句末的 `.` 改成 `,`，
让中文句号落在块外的下一段，或直接省掉（公式列表用逗号分隔即可）。

## 多 Agent 并行协作守则（强制）

为了支持多个 Agent（如单选 Agent、多选 Agent、解答题 Agent）同时推进任务而不产生写冲突与覆盖：

1. **一题一文件，原子修改**：
   - 每道题的题干、选项、推导与配图一律独立存放在 `src/<章节>/qNN.typ` 中。
   - 每个 Agent 仅认领并编辑自己负责的题目文件，严禁修改他人正在编写的题目。
2. **章节装配入口保持极简**：
   - `sNN-slug.typ` 装配入口仅保留大标题块 `#title-block` 和若干 `#include` 与 `#qsep`，不写题目内容或绘图逻辑。
   - 不要在聚合入口中直接编写题目或绘图逻辑。
3. **公共设施防写保护**：
   - `_template.typ`、`_figs.typ`、`_math.typ` 属于基础共用设施。除非全体对公共规范达成一致，否则严禁单方面随意修改，避免引发其他 Agent 编译中断。

## 内容规范

- 每题必须写**完整过程**，不能只给答案。选择题也要写出关键推导。
- **默认每题都出图**（即使你觉得纯代数就够），先画出来给用户看效果；
  之后由用户决定删掉哪些图。不要自行判断"这题不用图"。
- 配图优先用 `_figs.typ` 的封装：
  - 函数图像 / 曲线 → `plot()` 或 `param()`
  - 平面几何 → 直接 `cetz.draw.*`
  - 立体几何 → `proj3()` 做轴测投影（**方向不可改**：z 垂直向上、
    y 水平向右、x 斜向左下，这是教材标准画法）
- 图题统一用 `fcap(...)` 并写中文图注，说明"这图在证明什么"。
- 坐标系图要画坐标轴 + 刻度，只标关键几个刻度即可。
- **坐标轴必须带箭头 + 轴名（强制）**：无论平面还是立体，坐标轴末端一律画
  箭头，并标注轴名。用 `_figs.typ` 的封装，不要手写坐标轴：
  - 平面 → `axes(xmin, xmax, ymin, ymax, xl: [...], yl: [...])`，箭头已内置
  - 立体 → `axes3(xlen:, ylen:, zlen:, xlab:, ylab:, zlab:, origin:)`，箭头已内置
  - 轴名按实际含义给，不要一律写 `x`/`y`：
    | 场景 | 写法 |
    |---|---|
    | 直角坐标系 | `xl: [$x$]`, `yl: [$y$]` |
    | 复平面 | `xl: [实轴 $"Re"$]`, `yl: [虚轴 $"Im"$]` |
    | 数轴（单轴） | `txt((xmax, 0), [数轴])` 配 `arrowhead()` |
  - 手写坐标轴时用 `arrowhead(tip, dirx, diry)` 补箭头，
    或用 cetz 的 `mark: (end: ">")`（如 `q09.typ` 的实轴/虚轴）。
- **函数图像的定义域要留边距**：坐标轴范围要比曲线范围宽，
  否则曲线端点会顶在轴端或被箭头压住。曲线参数区间取轴范围的 60%–70%。
- 布局优先**左右并列**而非上下堆叠，省版面。
- **图内标签字号下限 0.22，轴名与关键标注加粗（强制）**。
  `tsize` 是绝对字号（按 1cm 换算），不随 `fcap(scale:)` 缩放，333 DPI 切图下
  小于 0.22 几乎看不清。规范值：
  | 元素 | tsize | 字重 |
  |---|---|---|
  | 坐标轴名 `$x$`/`$y$`/`$z$`/`$Re$` | 0.24–0.28 | **bold** |
  | 原点 `$O$`、关键点标签 | 0.24–0.28 | **bold** |
  | 刻度数值 | 0.22–0.25 | bold |
  | 曲线名 / 公式标注 | 0.24–0.29 | bold |
  批量调整用 `bump_tsize.py`（改字号）与 `bold_labels.py`（加粗），
  两者都支持 `--check` 预演。`axes()` / `axes3()` 的轴名已由
  `axisweight` 默认加粗，不需再包。
- **放大标签后必须复查重叠**。字号变大常把原本凑得下的标注挤到
  曲线/圆周/相邻标签上。改完逐题看切图，尤其注意：
  刻度数字落在图元内部、轴标签压住箭头（`mark:` 箭头尤其会盖字，
  优先改用 `arrowhead()` 并给标签留足偏移）、并列区间标签互相挤压。
- 图要放大就调 `fcap(scale:)`（1 坐标单位 = scale cm），它同时放大图形与
  刻度间距；但**标签字号 `tsize` 不随之缩放**，需按需同步调大。
- **想让曲线"更扁/更高"用 `fcap(yscale:)`，不要靠调坐标范围**。
  坐标范围只决定画多少，等比坐标系里改范围只是整体缩放，不会改变形状比例。
  `yscale` 是 y 单位的物理长度（`yscale < scale` 即压扁），且**不改变定义域**。
  cetz 的 `canvas(length:, x:, y:)` 本就支持每轴独立单位。
  ⚠️ 非等比坐标系下图上线段长度 ≠ 坐标值，涉及距离/角度的标注会失真 ——
  此时应直接标坐标值（如把"线段长 1"改成"横坐标 = 1"）。
- 图形变形（非等比坐标被拉伸）**不是 cetz 的问题** —— 实测 cetz 按 bounding
  box 定尺寸但不做非等比拉伸。看起来不对时先查 `padding` 与标签是否溢出。
  `vb:` 只是外框留白，不是"锁比例"手段，多数情况不需要传。
- 答案用 `#ans[...]` 包起来，标明选项字母。
- 中文正文用霞鹜文楷；数学交给 Typst 默认数学字体（New Computer Modern Math）。
- **出图分辨率标准（强制）**：切图脚本 `shoot_figs.py` 统一默认使用 **333 DPI**（横向正文宽度约 `2321 px`），保证公式上下标、根号分式、微小刻度与几何线段在 4K 屏或双指放大时绝对清晰锐利，无锯齿或发虚。

## 提交约定

- `temp/` 与 `problem/` 均在 `.gitignore` 中，**不要**为了提交产物去改忽略规则。
  需要入库的排版成果请另建目录（例如 `answer/`）并显式加入追踪。
- `.gitattributes` 里 `.typ` 走 `eol=lf`，字体/PDF/PNG 标记 binary。
- 不要提交 `temp/out/` 里的中间 PDF，它们每次编译都会变。