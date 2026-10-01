// ============================================================
//  第 7 题 —— 一、选择题（第 1—8 题）
// ============================================================
#import "../_template.typ": *
#import "../_figs.typ": *

// ---------------- 第 7 题 ----------------
#qhead(7, pts: 5)
已知定义在 $RR$ 上的奇函数 $f(x)$ 在 $(-oo, 0)$ 上单调递增，且 $f(3) = 0$，
则满足 $x f(x + 1) >= 0$ 的 $x$ 的取值范围为（    ）

#opts((
  [A．$(-oo, -2] ∪ [0, 1] ∪ [4, +oo)$],
  [B．$(-oo, -4] ∪ {0} ∪ [2, +oo)$],
  [C．$(-oo, -4] ∪ [-1, 0] ∪ [2, +oo)$],
  [D．$[-4, -1] ∪ [0, 2)$],
), columns: 2)

#sol[
  由奇函数定义 $f(-x) = -f(x)$，且必有 $f(0) = 0$。

  *关于单调性*：设 $0 < x_1 < x_2$，则 $-x_2 < -x_1 < 0$。因 $f(x)$ 在 $(-oo, 0)$ 上单调递增，
  $f(-x_2) < f(-x_1)$，即 $-f(x_2) < -f(x_1)$，两边同乘 $-1$ 得 $f(x_2) > f(x_1)$。
  故 $f(x)$ 在 $(0, +oo)$ 上也单调递增。

  *关于零点与函数值符号*：由 $f(3) = 0$ 及奇函数对称性知 $f(-3) = -f(3) = 0$。
  结合 $f(x)$ 分别在 $(-oo, 0)$ 和 $(0, +oo)$ 上单调递增，其正负符号分布为：
  - 当 $t in (-oo, -3)$ 时，$f(t) < f(-3) = 0$（负）；
  - 当 $t in (-3, 0)$ 时，$f(t) > f(-3) = 0$（正）；
  - 当 $t = 0$ 时，$f(0) = 0$；
  - 当 $t in (0, 3)$ 时，$f(t) < f(3) = 0$（负）；
  - 当 $t in (3, +oo)$ 时，$f(t) > f(3) = 0$（正）。

  *解不等式*：$x f(x + 1) >= 0$ 要求 $x$ 与 $f(x + 1)$ 同号或乘积为零。令 $t = x + 1$ 分类讨论：
  1. 当 $x = 0$ 时：$0 times f(1) = 0 >= 0$，恒成立，故 $x = 0$ 满足；
  2. 当 $x > 0$ 时：需 $f(x + 1) >= 0$。因 $x > 0 ==> x + 1 > 1$。由上述符号分布，在 $t > 1$ 上使 $f(t) >= 0$ 的充要条件为 $t >= 3$，即 $x + 1 >= 3 ==> x >= 2$；
  3. 当 $x < 0$ 时：需 $f(x + 1) <= 0$。因 $x < 0 ==> x + 1 < 1$。在 $t < 1$ 上使 $f(t) <= 0$ 的区间为 $t <= -3$ 或 $0 <= t < 1$：
    - 由 $x + 1 <= -3 ==> x <= -4$；
    - 由 $0 <= x + 1 < 1 ==> -1 <= x < 0$。

  综上，合并各项解集得 $x in (-oo, -4] union [-1, 0] union [2, +oo)$。
]
#ans[$(-oo, -4] union [-1, 0] union [2, +oo)$，选 #text(weight: "bold")[C]]

#grid(
  columns: (auto, 1fr),
  gutter: 14pt,
  align: horizon,
  figure(
    cv(
      scale: 0.50,
      yscale: 1.05,
      pad: 0.08,
      {
        // 直角坐标轴 (瘦版: x 轴分度紧凑，y 轴高度充分拉开，箭头和轴标签更大)
        axes(-4.6, 4.6, -3.3, 3.3, xl: [$x$], yl: [$y$], arrow: 0.28, tsize: 0.28)

        // 函数曲线
        plot(
          t => 1.15 * (1.0 - 3.0 / t),
          0.92,
          4.4,
          stroke: s(blue, th: 1.6pt),
        )
        plot(
          t => -1.15 * (1.0 + 3.0 / t),
          -4.4,
          -0.92,
          stroke: s(blue, th: 1.6pt),
        )

        // 原点 (标记与标签加大)
        pt((0.0, 0.0), label: [text(weight: "bold")[$O$]], r: 0.08, fill: black, dx: -0.22, dy: -0.20, anchor: "north-east", tsize: 0.27)

        // 零点标注 (-3, 0) 与 (3, 0) 加大红点与字号，置于 x 轴下方
        pt((-3.0, 0.0), label: [text(weight: "bold")[$-3$]], r: 0.09, fill: red, dx: 0.0, dy: -0.18, anchor: "north", tsize: 0.29)
        pt((3.0, 0.0), label: [text(weight: "bold")[$3$]], r: 0.09, fill: red, dx: 0.0, dy: -0.18, anchor: "north", tsize: 0.29)

        // 函数图像曲线标签 (字号加大)
        txt((3.9, 0.8), anchor: "south", tsize: 0.25, text(fill: blue, weight: "bold")[$y = f(x)$])
        txt((-3.9, -0.8), anchor: "north", tsize: 0.25, text(fill: blue, weight: "bold")[$y = f(x)$])

        // 各区间正负号明确标注 (字号加大，避开曲线与轴线)
// 左半区 (-3, 3): f > 0
    txt((-2.2, 1.8), anchor: "center", tsize: 0.27, text(fill: green, weight: "bold")[$f > 0$])
    // 右半区: f < 0
    txt((2.2, -1.8), anchor: "center", tsize: 0.27, text(fill: red, weight: "bold")[$f < 0$])
    // 两端外侧: 左 f<0, 右 f>0
    txt((-3.5, -1.9), anchor: "center", tsize: 0.27, text(fill: red, weight: "bold")[$f < 0$])
    txt((3.5, 1.9), anchor: "center", tsize: 0.27, text(fill: green, weight: "bold")[$f > 0$])
      },
    ),
    caption: figcap([第 7 题  奇函数性质与符号示意图]),
    gap: 4pt,
  ),
  rect(
    width: 100%,
    stroke: s(blue, th: 1.2pt),
    fill: rgb("#f4f8fd"),
    radius: 6pt,
    inset: (x: 10pt, y: 9pt),
    [
      #set text(size: 9pt)
      #align(center)[#text(weight: "bold", fill: blue, size: 10.5pt)[【偷懒解法：特例构造代入秒杀】]]
      #v(2pt)
      构造满足题设的奇函数（平移反比例函数）：
      $
        f(x) = cases(
          -1/x + 1/3\, & quad x > 0,
          0\, & quad x = 0,
          -1/x - 1/3\, & quad x < 0.
        )
      $
      易验 $f(3) = 0$，$f(-3) = 0$，且在 $(-oo, 0)$ 与 $(0, +oo)$ 均单调递增，完全契合题设！

      直接代入不等式 $x f(x + 1) >= 0$：
      - $x = 0$ 时：$0 >= 0$ 恒成立，得 $x = 0$；
      - $x > 0$ 时：$x + 1 > 1 > 0$，需 $f(x + 1) >= 0$：
        $ -1/(x + 1) + 1/3 >= 0 ==> 1/(x + 1) <= 1/3 ==> x + 1 >= 3 ==> x >= 2; $
      - $x < 0$ 时：需 $f(x + 1) <= 0$：
        - 若 $x + 1 > 0$（即 $-1 < x < 0$）：$f(x + 1) = -1/(x+1) + 1/3 < 0$ 恒成立；且 $x = -1$ 时 $x f(0) = 0$ 亦成立，故区间 $[-1, 0)$ 满足；
        - 若 $x + 1 < 0$（即 $x < -1$）：
          $ -1/(x + 1) - 1/3 <= 0 ==> 1/(-(x+1)) <= 1/3 ==> -(x + 1) >= 3 ==> x <= -4. $
      综合立得：$x in (-oo, -4] union [-1, 0] union [2, +oo)$，直接秒选 #text(weight: "bold", fill: red)[C]！
    ],
  ),
)
