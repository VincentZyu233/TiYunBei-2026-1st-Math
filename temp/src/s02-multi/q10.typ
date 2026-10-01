// ---------------- 第 10 题 ----------------
#import "../_template.typ": *
#import "../_figs.typ": *

#qhead(10, pts: 6)
设函数 $f(x) = x^3 - 3x + 1$，则（    ）

#opts(
  columns: 2,
  (
    [A．$x = -1$ 为 $f(x)$ 的一个极小值点],
    [B．$f(x)$ 在区间 $(-1, 1)$ 上单调递减],
    [C．当 $0 < x < 1$ 时，$-1 < f(2x - 1) < 3$],
    [D．当 $x < 1$ 时，$f(2 - x) < f(x)$],
  ),
)

#sol[
  #grid(
    columns: (1.45fr, 1fr),
    gutter: 8pt,
    align: (top + left, top + right),
    [
      对函数求导得：
      $ f'(x) = 3x^2 - 3 = 3(x + 1)(x - 1). $
      令 $f'(x) = 0$，解得极值点 $x_1 = -1$ 与 $x_2 = 1$。
      - 当 $x in (-oo, -1)$ 时，$f'(x) > 0$，$f(x)$ 单调递增；
      - 当 $x in (-1, 1)$ 时，$f'(x) < 0$，$f(x)$ 单调递减；
      - 当 $x in (1, +oo)$ 时，$f'(x) > 0$，$f(x)$ 单调递增。

      *对于 A*：在 $x = -1$ 处导数符号由正变负，为 $f(x)$ 的*极大值点*，极大值 $f(-1) = 3$；在 $x = 1$ 处由负变正，为*极小值点*，极小值 $f(1) = -1$。故 A 错误。
    ],
    [
      #align(center)[
        #cv(scale: 0.65, {
          let xmin = -2.2
          let xmax = 2.2
          let sy = 0.55 // y 轴分度值压缩比例，使 (0, -3) 更靠近原点
          let ymin = -3.5 * sy
          let ymax = 3.6 * sy

          // 坐标轴带箭头
          ln((xmin, 0.0), (xmax + 0.18, 0.0), stroke: s(black, th: 1.0pt), mark: (end: ">", fill: black))
          txt((xmax + 0.30, 0.0), anchor: "west", tsize: 0.24, text(weight: "bold")[$x$])
          ln((0.0, ymin), (0.0, ymax + 0.18), stroke: s(black, th: 1.0pt), mark: (end: ">", fill: black))
          txt((0.0, ymax + 0.35), anchor: "south", tsize: 0.24, text(weight: "bold")[$y$])

          // 刻度（放在轴下方）
          for k in (-1, 1) {
            ln((k * 1.0, -0.10), (k * 1.0, 0.10), stroke: s(black, th: 0.7pt))
            txt((k * 1.0, -0.22), anchor: "north", tsize: 0.22, [$#k$])
          }
          txt((-0.20, -0.20), anchor: "north-east", tsize: 0.22, text(weight: "bold")[$O$])

          // 导函数抛物线 f'(x) = 3x^2 - 3 (纵向按 sy 压缩)
          plot(val => (3.0 * val * val - 3.0) * sy, -1.45, 1.45, stroke: s(blue, th: 1.5pt))
          // 负区间高亮
          plot(val => (3.0 * val * val - 3.0) * sy, -1.0, 1.0, stroke: s(red, th: 2.2pt))

          // 极值点标记（放在轴上方外侧，避开抛物线）
          pt((-1.0, 0.0), label: [极大值点], r: 0.09, fill: red, dx: -0.20, dy: 0.28, anchor: "south-east", tsize: 0.21)
          pt((1.0, 0.0), label: [极小值点], r: 0.09, fill: red, dx: 0.20, dy: 0.28, anchor: "south-west", tsize: 0.21)

          // 顶点 (0, -3) (距离原点缩短)
          pt((0.0, -3.0 * sy), label: [$(0, -3)$], r: 0.08, fill: blue, dx: 0.18, dy: -0.15, anchor: "north-west", tsize: 0.20)

          // 符号判定
          txt((-1.40, 1.8 * sy), anchor: "center", tsize: 0.21, text(fill: green, weight: "bold")[$+$ 递增])
          txt((0.0, -2.0 * sy), anchor: "center", tsize: 0.20, text(fill: red, weight: "bold")[$-$ 递减])
          txt((1.40, 1.8 * sy), anchor: "center", tsize: 0.21, text(fill: green, weight: "bold")[$+$ 递增])

          txt((0.35, 3.7 * sy), anchor: "west", tsize: 0.20, text(fill: blue, weight: "bold")[$f'(x) = 3x^2 - 3$])
        })
        #figcap[导函数 $f'(x)$ 图像与极值点判定]
      ]
    ]
  )

  *对于 B*：在区间 $(-1, 1)$ 内恒有 $f'(x) < 0$，故 $f(x)$ 在区间 $(-1, 1)$ 上严格单调递减，B 正确。

  *对于 C*：令 $t = 2x - 1$。因为 $0 < x < 1$，所以 $t in (-1, 1)$。由于 $f(t)$ 在 $(-1, 1)$ 上严格递减，故 $f(1) < f(2x - 1) < f(-1)$，即 $-1 < f(2x - 1) < 3$，C 正确。

  *对于 D*：取特值检验：令 $x = 0 < 1$，则 $2 - x = 2$。计算得 $f(2) = 2^3 - 3 times 2 + 1 = 3$，$f(0) = 1$。显然 $f(2) > f(0)$，即 $f(2 - x) > f(x)$，与选项矛盾（亦可由代数法：令 $u = 1 - x > 0$，作差得 $f(2 - x) - f(x) = 2(1 - x)^3 > 0$）。故 D 错误。
]
#ans[选 #text(weight: "bold")[BC]]

#fcap(
  scale: 0.68,
  caption: [第 10 题  函数 $f(x) = x^3 - 3x + 1$ 的图像与单调性分析：极大值 $(-1, 3)$，极小值 $(1, -1)$],
  {
    let sx = 1.7 // 横轴适度拉伸，使波峰波谷更舒展
    let xmin = -4.5
    let xmax = 4.5
    let ymin = -1.8
    let ymax = 3.8

    // 左侧：单调性与极值速查卡片（充分利用左侧空白）
    box2((-10.4, -0.3), (-4.8, 3.6), fill: rgb("#f6f9fc"), stroke: s(rgb("#a5c0dc"), th: 0.8pt), radius: 0.25)
    txt((-10.0, 3.2), anchor: "north-west", tsize: 0.22, text(weight: "bold", fill: blue)[【函数单调性与极值】])
    txt((-10.0, 2.5), anchor: "north-west", tsize: 0.19, [• 对称中心：拐点 $(0, 1)$])
    txt((-10.0, 1.8), anchor: "north-west", tsize: 0.19, text(fill: red)[• 极大值：$f(-1) = 3$])
    txt((-10.0, 1.1), anchor: "north-west", tsize: 0.19, text(fill: red)[• 极小值：$f(1) = -1$])
    txt((-10.0, 0.4), anchor: "north-west", tsize: 0.19, text(fill: purple)[• 减区间：$(-1, 1)$（红线）])

    // 右侧：选项 C、D 几何直观卡片（充分利用右侧空白）
    box2((4.8, -0.3), (10.4, 3.6), fill: rgb("#fcfaf6"), stroke: s(rgb("#dfcfb5"), th: 0.8pt), radius: 0.25)
    txt((5.2, 3.2), anchor: "north-west", tsize: 0.22, text(weight: "bold", fill: rgb("#9c6500"))[【选项 C、D 图像直观】])
    txt((5.2, 2.5), anchor: "north-west", tsize: 0.19, text(fill: green)[• 选项 C：$x in (0, 1)$ 时])
    txt((5.6, 1.9), anchor: "north-west", tsize: 0.185, [$t in (-1, 1) implies -1 < f(t) < 3$])
    txt((5.2, 1.2), anchor: "north-west", tsize: 0.19, text(fill: red)[• 选项 D：$x < 1$ 时])
    txt((5.6, 0.6), anchor: "north-west", tsize: 0.185, [特值 $f(2) = 3 > f(0) = 1$（矛盾）])

    // 中间：坐标轴（带箭头）
    ln((xmin, 0.0), (xmax + 0.18, 0.0), stroke: s(black, th: 1.0pt), mark: (end: ">", fill: black))
    txt((xmax + 0.30, 0.0), anchor: "west", tsize: 0.25, text(weight: "bold")[$x$])
    ln((0.0, ymin), (0.0, ymax + 0.18), stroke: s(black, th: 1.0pt), mark: (end: ">", fill: black))
    txt((0.0, ymax + 0.32), anchor: "south", tsize: 0.25, text(weight: "bold")[$y$])

    // 刻度（横轴按 sx 变换）
    for k in (-2, -1, 1, 2) {
      ln((k * sx, -0.12), (k * sx, 0.12), stroke: s(black, th: 0.7pt))
      txt((k * sx, -0.22), anchor: "north", tsize: 0.22, [$#k$])
    }
    for k in (-1, 1, 2, 3) {
      ln((-0.12, k * 1.0), (0.12, k * 1.0), stroke: s(black, th: 0.7pt))
      txt((-0.22, k * 1.0), anchor: "east", tsize: 0.22, [$#k$])
    }
    txt((-0.22, -0.22), anchor: "north-east", tsize: 0.24, text(weight: "bold")[$O$])

    // 原函数曲线 f(x) = x^3 - 3x + 1
    param(t => (t * sx, t * t * t - 3.0 * t + 1.0), -2.15, 2.15, stroke: s(blue, th: 1.5pt))

    // 单调递减区间高亮
    param(t => (t * sx, t * t * t - 3.0 * t + 1.0), -1.0, 1.0, stroke: s(red, th: 2.4pt))

    // 极值点与对称中心
    dashed((-1.0 * sx, 0.0), (-1.0 * sx, 3.0), color: gray, th: 0.8pt)
    dashed((0.0, 3.0), (-1.0 * sx, 3.0), color: gray, th: 0.8pt)
    pt((-1.0 * sx, 3.0), label: [极大值 $(-1, 3)$], r: 0.10, fill: red, dx: -0.18, dy: 0.18, anchor: "south-east", tsize: 0.23)

    dashed((1.0 * sx, 0.0), (1.0 * sx, -1.0), color: gray, th: 0.8pt)
    dashed((0.0, -1.0), (1.0 * sx, -1.0), color: gray, th: 0.8pt)
    pt((1.0 * sx, -1.0), label: [极小值 $(1, -1)$], r: 0.10, fill: red, dx: 0.18, dy: -0.18, anchor: "north-west", tsize: 0.23)

    pt((0.0, 1.0), label: [对称中心 $(0, 1)$], r: 0.09, fill: purple, dx: 0.18, dy: 0.18, anchor: "south-west", tsize: 0.22)

    txt((0.35, 2.8), anchor: "west", tsize: 0.21, text(fill: blue, weight: "bold")[$f(x) = x^3 - 3x + 1$])
    txt((0.15, 0.3), anchor: "west", tsize: 0.20, text(fill: red, weight: "bold")[$(-1, 1)$ 单调递减])
  },
)

