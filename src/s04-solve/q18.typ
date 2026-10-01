// ---------------- 第 18 题 ----------------
#import "../_template.typ": *
#import "../_figs.typ": *

#qhead(18, pts: 17)
设函数 $f(x) = (x - a)^2 (x - b) e^x$（$a, b in RR$）。 \
（1）当 $a = 1, b = 2$ 时，求函数 $f(x)$ 的单调区间； \
（2）设 $a = 2$，若 $x = 2$ 为 $f(x)$ 的一个极大值点，求 $b$ 的取值范围； \
（3）令 $g(x) = e^(-x) f(x)$（$a < b$），设 $x_1, x_2$ 为 $g(x)$ 的两个极值点，$x_3$ 是 $g(x)$ 的一个零点，且 $x_1, x_2, x_3$ 互不相等。问是否存在实数 $x_4$，使得 $x_1, x_2, x_3, x_4$ 按照某种顺序排列后构成等差数列？若存在，求出 $x_4$ 的值（结果用含 $a, b$ 的式子表示）；若不存在，请说明理由。

#sol[
  #block(
    stroke: 0.7pt + rgb("#2a6f97"),
    radius: 4.5pt,
    inset: (x: 10pt, y: 7pt),
    fill: rgb("#f4f9fc"),
    width: 100%,
    [
      #text(weight: "bold", fill: rgb("#014f86"), size: 9pt)[💡 高考求导通法技巧：“$f(x) = g(x) e^x$ 乘积型函数”的特征求导口诀] \
      #v(2pt)
      #text(size: 8.5pt)[
        对于任意可导函数 $g(x)$，考察形如 $f(x) = g(x) e^x$ 的函数。由乘积求导法则与 $(e^x)' = e^x$：
        $ f'(x) = [g(x) e^x]' = g'(x) e^x + g(x) (e^x)' = g'(x) e^x + g(x) e^x = [g(x) + g'(x)] e^x $
        *核心口诀*：#text(weight: "bold", fill: rgb("#014f86"))[“先提取指数 $e^x$，括号内等于『原函数 + 导函数』”]。 \
        在高考导数大题中，先单独化简多项式部分 $g(x) + g'(x)$，能彻底免去在推导中繁复抄写 $e^x$，极大降低计算冗余度与失误率。
      ]
    ]
  )

  #v(2pt)

  *（1）当 $a = 1, b = 2$ 时，求函数 $f(x)$ 的单调区间。*

  此时函数解析式为 $f(x) = (x - 1)^2 (x - 2) e^x$。 \
  应用特征求导法则，先提取 $e^x$，设多项式部分为 $p(x) = (x - 1)^2 (x - 2)$，则：
  $ f'(x) = [p(x) + p'(x)] e^x $

  先计算多项式部分的导数 $p'(x)$：
  $
    p'(x) &= 2 (x - 1) (x - 2) + (x - 1)^2 \
    &= (x - 1) [2 (x - 2) + (x - 1)] \
    &= (x - 1) (3 x - 5).
  $
  将 $p(x)$ 与 $p'(x)$ 提取公因式 $(x - 1)$ 合并：
  $
    p(x) + p'(x) &= (x - 1) [(x - 1)(x - 2) + (3 x - 5)] \
    &= (x - 1) [(x^2 - 3 x + 2) + (3 x - 5)] \
    &= (x - 1) (x^2 - 3).
  $
  由此直接写出导函数为：
  $ f'(x) = (x - 1) (x^2 - 3) e^x = (x - 1) (x - sqrt(3)) (x + sqrt(3)) e^x. $
  因为对任意 $x in RR$，恒有 $e^x > 0$，所以 $f'(x)$ 的符号完全由 $(x - 1)(x - sqrt(3))(x + sqrt(3))$ 决定。 \
  令 $f'(x) = 0$，解得三个零点为：$x = -sqrt(3), quad x = 1, quad x = sqrt(3)$。 \
  列表讨论 $f'(x)$ 的符号及 $f(x)$ 的单调性：

  #align(center)[
    #table(
      columns: (1.5fr, 1.4fr, 1fr, 1.4fr, 1fr, 1.4fr, 1fr, 1.5fr),
      align: center + horizon,
      stroke: 0.5pt + rgb("#bbbbbb"),
      fill: (col, row) => if row == 0 { rgb("#f0f4f9") } else { none },
      [$x$], [$(-\oo, -sqrt(3))$], [$-sqrt(3)$], [$(-sqrt(3), 1)$], [$1$], [$(1, sqrt(3))$], [$sqrt(3)$], [$(sqrt(3), +\oo)$],
      [$f'(x)$], [$-$], [$0$], [$+$], [$0$], [$-$], [$0$], [$+$],
      [$f(x)$], [单调递减 $arrow.br$], [极小值], [单调递增 $arrow.tr$], [极大值], [单调递减 $arrow.br$], [极小值], [单调递增 $arrow.tr$],
    )
  ]

  因此，$f(x)$ 的单调递减区间为 $(-oo, -sqrt(3))$ 和 $(1, sqrt(3))$； \
  $f(x)$ 的单调递增区间为 $(-sqrt(3), 1)$ 和 $(sqrt(3), +oo)$。

  #v(2pt)

  *（2）设 $a = 2$，若 $x = 2$ 为 $f(x)$ 的一个极大值点，求 $b$ 的取值范围。*

  当 $a = 2$ 时，$f(x) = (x - 2)^2 (x - b) e^x$。 \
  同样直接应用上述特征求导法则，先提取 $e^x$，设多项式部分为 $g(x) = (x - 2)^2 (x - b)$，则：
  $ f'(x) = [g(x) + g'(x)] e^x $

  先计算多项式部分的导数 $g'(x)$：
  $
    g'(x) &= 2 (x - 2) (x - b) + (x - 2)^2 \
    &= (x - 2) [2 (x - b) + (x - 2)] \
    &= (x - 2) (3 x - 2 b - 2).
  $
  将 $g(x)$ 与 $g'(x)$ 提取公因式 $(x - 2)$ 合并：
  $
    g(x) + g'(x) &= (x - 2) [(x - 2)(x - b) + (3 x - 2 b - 2)] \
    &= (x - 2) [(x^2 - (b + 2) x + 2 b) + (3 x - 2 b - 2)] \
    &= (x - 2) [x^2 + (1 - b) x - 2].
  $
  由此直接得到导函数为：
  $ f'(x) = (x - 2) [x^2 + (1 - b) x - 2] e^x. $
  令二次函数 $q(x) = x^2 + (1 - b) x - 2$。 \
  因为 $x = 2$ 为 $f(x)$ 的极大值点，所以在 $x = 2$ 左右两侧附近：
  - 当 $x < 2$ 时，$f'(x) > 0$；又因 $x - 2 < 0, e^x > 0$，必有 $q(x) < 0$；
  - 当 $x > 2$ 时，$f'(x) < 0$；又因 $x - 2 > 0, e^x > 0$，亦必有 $q(x) < 0$。 \
  由于二次函数 $q(x)$ 连续，若 $q(2) > 0$，则在 $x = 2$ 邻域内 $q(x) > 0$，此时 $f'(x)$ 符号由负变正，为极小值点，矛盾； \
  若 $q(2) = 0$，将 $x = 2$ 代入 $q(2) = 2^2 + (1 - b) times 2 - 2 = 4 - 2 b = 2 (2 - b) = 0 ==> b = 2$。 \
  当 $b = 2$ 时，$q(x) = x^2 - x - 2 = (x - 2)(x + 1)$，此时 $f'(x) = (x - 2)^2 (x + 1) e^x$。 \
  在 $x = 2$ 附近 $(x - 2)^2 >= 0$ 不变号，故 $x = 2$ 此时不是极值点，亦矛盾。 \
  因此，必有 $q(2) < 0$，即：
  $ q(2) = 2 (2 - b) < 0 ==> 2 - b < 0 ==> b > 2. $
  反之，当 $b > 2$ 时，$q(2) < 0$。由函数连续性，存在 $x = 2$ 的开邻域 $U$，在 $U$ 内 $q(x) < 0$ 恒成立。 \
  此时当 $x in U$ 且 $x < 2$ 时，$f'(x) = (x - 2) q(x) e^x > 0$；当 $x in U$ 且 $x > 2$ 时，$f'(x) = (x - 2) q(x) e^x < 0$。 \
  导数符号在 $x = 2$ 处严格由正变负，故 $x = 2$ 确为 $f(x)$ 的极大值点。 \
  综上所述，$b$ 的取值范围为 $(2, +oo)$（或 $b > 2$）。

  #v(2pt)

  *（3）探究是否存在实数 $x_4$ 构成四项等差数列。*

  由题意，$g(x) = e^(-x) f(x) = (x - a)^2 (x - b)$（其中已知 $a < b$）。

  *第一步：求 $g(x)$ 的极值点* \
  对三次多项式 $g(x)$ 求导：
  $
    g'(x) &= 2 (x - a) (x - b) + (x - a)^2 \
    &= (x - a) [2 (x - b) + (x - a)] \
    &= (x - a) (3 x - a - 2 b).
  $
  令 $g'(x) = 0$，解得两个驻点为：
  $ x = a quad text("或") quad x = frac(a + 2 b, 3). $
  因为已知 $a < b$，所以 $a = frac(3 a, 3) < frac(a + 2 b, 3) < frac(3 b, 3) = b$。 \
  易知 $g'(x)$ 在两驻点两侧均发生符号变化，故 $x = a$ 与 $x = frac(a + 2 b, 3)$ 为 $g(x)$ 的两个极值点。 \
  即极值点集合为 ${x_1, x_2} = {a, frac(a + 2 b, 3)}$。

  *第二步：确定零点 $x_3$* \
  令 $g(x) = (x - a)^2 (x - b) = 0$，解得零点为 $x = a$ 或 $x = b$。 \
  题目明确要求 $x_1, x_2, x_3$ *互不相等*，由于极值点中已经包含数值 $a$，所以零点 $x_3$ 不能取 $a$，只能取：
  $ x_3 = b. $
  因此，已确定的三个实数从小到大依次为：
  $ a, quad frac(a + 2 b, 3), quad b. $

  *第三步：等差数列结构分析与第四项 $x_4$ 的求解* \
  记常数 $Delta = frac(b - a, 3) > 0$（由 $a < b$ 可知 $Delta > 0$）。 \
  计算上述三个已知数之间的相邻距离：
  - 前两数之差：$frac(a + 2 b, 3) - a = frac(2 (b - a), 3) = 2 Delta$；
  - 后两数之差：$b - frac(a + 2 b, 3) = frac(b - a, 3) = Delta$。 \
  两间距之比为精确的 $2 : 1$！ \
  若要使得 $a, frac(a + 2 b, 3), b$ 与某个实数 $x_4$ 按照某种顺序排列后构成公差为 $d$ 的四项等差数列， \
  则在排好序的四项等差数列中，每相邻两项的间距必须恒等于公差 $d$。 \
  由两间距分别为 $2 Delta$ 和 $Delta$ 可知：
  - 间距为 $2 Delta$ 的两项 $a$ 与 $frac(a + 2 b, 3)$ 之间，恰好跨越了 $2$ 个公差（即 $2 d = 2 Delta ==> d = Delta$）；
  - 间距为 $Delta$ 的两项 $frac(a + 2 b, 3)$ 与 $b$ 之间，恰好跨越了 $1$ 个公差（即 $d = Delta$）。 \
  两间距对公差的要求完全吻合！这意味着公差必为 $d = Delta = frac(b - a, 3)$，且待求项 $x_4$ 必唯一插入在 $a$ 与 $frac(a + 2 b, 3)$ 的正中间：
  $ x_4 = a + d = a + frac(b - a, 3) = frac(2 a + b, 3). $
  此时，四项实数按从小到大排列为：
  $ a, quad frac(2 a + b, 3), quad frac(a + 2 b, 3), quad b. $
  验证其相邻差值：
  $
    frac(2 a + b, 3) - a = frac(b - a, 3), \
    frac(a + 2 b, 3) - frac(2 a + b, 3) = frac(b - a, 3), \
    b - frac(a + 2 b, 3) = frac(b - a, 3).
  $
  相邻项之差恒为常数 $frac(b - a, 3)$，严格构成等差数列。 \
  故存在唯一的实数 $x_4 = frac(2 a + b, 3)$ 满足题意。
]

#v(2pt)

#ans[
  （1）单调递减区间为 $(-oo, -sqrt(3))$ 和 $(1, sqrt(3))$，单调递增区间为 $(-sqrt(3), 1)$ 和 $(sqrt(3), +oo)$； \
  （2）$b$ 的取值范围为 $(2, +oo)$（或 $b > 2$）； \
  （3）存在满足条件的实数 $x_4$，且 $x_4 = frac(2 a + b, 3)$
]

#v(4pt)

#fcap(
  scale: 1.35,
  caption: [第 18 题（3） 三次函数 $g(x) = (x - a)^2 (x - b)$ 特征点与四项等差数列几何图示],
  {
    // 取示意参数 a = 0, b = 3, 则 Delta = 1, x4 = 1, x2 = 2
    let a_x = 0.0
    let x4 = 1.0
    let c_x = 2.0
    let b_x = 3.0

    // 坐标轴
    axes(-1.2, 4.0, -1.8, 2.0, xl: [$x$], yl: [$y$], arrow: 0.22, tsize: 0.28)
    txt((-0.14, -0.14), anchor: "north-east", tsize: 0.26, weight: "bold", [$O$])

    // 三次曲线 g(x) = (x)^2 (x - 3) = x^3 - 3x^2
    // 在 x in [-0.6, 3.4], 极大值在 x=0 (g=0), 极小值在 x=2 (g=-4), 适当缩小 y 轴尺度 0.35
    let y_sc = 0.35
    param(t => (t, (t * t * (t - 3.0)) * y_sc), -0.65, 3.45, stroke: s(blue, th: 1.5pt))
    txt((3.45, 1.35), anchor: "west", tsize: 0.26, text(fill: blue, weight: "bold")[$g(x) = (x - a)^2 (x - b)$])

    // 四个等差格点在 x 轴上的位置与垂线
    let g_c = 2.0 * 2.0 * (2.0 - 3.0) * y_sc // -1.4
    let g_x4 = 1.0 * 1.0 * (1.0 - 3.0) * y_sc // -0.7 (拐点)

    // 虚线投影到曲线
    dashed((c_x, 0.0), (c_x, g_c), color: gray, th: 0.8pt)
    dashed((x4, 0.0), (x4, g_x4), color: gray, th: 0.8pt)

    // 曲线上的关键特征点
    pt((a_x, 0.0), r: 0.07, fill: purple)
    pt((c_x, g_c), r: 0.07, fill: purple)
    pt((b_x, 0.0), r: 0.07, fill: red)
    pt((x4, g_x4), r: 0.065, fill: orange)

    // 曲线特征点说明
    txt((a_x - 0.12, 0.35), anchor: "south", tsize: 0.25, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: purple, weight: "bold")[极大值点兼切点 $(a, 0)$]])
    txt((c_x + 0.15, g_c - 0.15), anchor: "north-west", tsize: 0.25, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: purple, weight: "bold")[极小值点 $(frac(a + 2 b, 3), g_min)$]])
    txt((b_x + 0.15, 0.28), anchor: "south-west", tsize: 0.25, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: red, weight: "bold")[穿过零点 $(b, 0)$]])
    txt((x4 - 0.15, g_x4 - 0.12), anchor: "north-east", tsize: 0.25, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: orange, weight: "bold")[对称中心（拐点）]])

    // x 轴上四个等距点标注与间隔标尺
    pt((a_x, 0.0), r: 0.06, fill: purple)
    pt((x4, 0.0), r: 0.06, fill: orange)
    pt((c_x, 0.0), r: 0.06, fill: purple)
    pt((b_x, 0.0), r: 0.06, fill: red)

    txt((a_x, -0.28), anchor: "north", tsize: 0.26, text(fill: purple, weight: "bold")[$a$])
    txt((x4, -0.28), anchor: "north", tsize: 0.26, text(fill: orange, weight: "bold")[$x_4 = frac(2 a + b, 3)$])
    txt((c_x, -0.28), anchor: "north", tsize: 0.26, text(fill: purple, weight: "bold")[$frac(a + 2 b, 3)$])
    txt((b_x, -0.28), anchor: "north", tsize: 0.26, text(fill: red, weight: "bold")[$b$])

    // 等间距双向箭头标尺 (在 x 轴下方)
    let bar_y = -0.75
    ln((a_x, bar_y), (b_x, bar_y), stroke: s(rgb("#27ae60"), th: 1.0pt))
    ln((a_x, bar_y - 0.08), (a_x, bar_y + 0.08), stroke: s(rgb("#27ae60"), th: 1.0pt))
    ln((x4, bar_y - 0.08), (x4, bar_y + 0.08), stroke: s(rgb("#27ae60"), th: 1.0pt))
    ln((c_x, bar_y - 0.08), (c_x, bar_y + 0.08), stroke: s(rgb("#27ae60"), th: 1.0pt))
    ln((b_x, bar_y - 0.08), (b_x, bar_y + 0.08), stroke: s(rgb("#27ae60"), th: 1.0pt))

    txt(((a_x + x4) / 2.0, bar_y - 0.12), anchor: "north", tsize: 0.23, text(fill: rgb("#27ae60"), weight: "bold")[$Delta$])
    txt(((x4 + c_x) / 2.0, bar_y - 0.12), anchor: "north", tsize: 0.23, text(fill: rgb("#27ae60"), weight: "bold")[$Delta$])
    txt(((c_x + b_x) / 2.0, bar_y - 0.12), anchor: "north", tsize: 0.23, text(fill: rgb("#27ae60"), weight: "bold")[$Delta$])
  }
)

#v(4pt)

#rect(
  fill: rgb("#f6f9fe"),
  stroke: rgb("#1a4d8f") + 0.8pt,
  radius: 5pt,
  inset: (x: 12pt, y: 8.5pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#1a4d8f"), size: 9.5pt)[💡 高观点背景：三次函数“对称中心与四等分比例定理”（卡尔达诺-牛顿几何美学）] \
  #v(2pt)
  #text(size: 9pt)[
    *1. 三次多项式天然的内蕴等差结构*： \
    #h(1em) 考察一般带二重根的三次多项式 $g(x) = (x - a)^2 (x - b)$（$a < b$）。其四个核心特征点分别为：
    - 切点零点（兼极大值点）：$x = a$；
    - 对称中心（拐点，二阶导数零点 $g''(x) = 0$）：$x_text("inflection") = frac(2 a + b, 3)$；
    - 极小值点（一阶导数另一零点）：$x_text("min") = frac(a + 2 b, 3)$；
    - 穿过零点（一重单根）：$x = b$。 \
    *2. “1 : 1 : 1” 完美三等分定理*： \
    #h(1em) 这四个特征点在横轴上自左向右排列为：
    $ a, quad frac(2 a + b, 3), quad frac(a + 2 b, 3), quad b. $
    #h(1em) 相邻两点之间的横向跨度恒为：
    $ d = frac(b - a, 3). $
    #h(1em) 换言之，*三次曲线的拐点与极小值点，恰好将切点 $a$ 与交点 $b$ 之间的闭区间 $[a, b]$ 进行了严格的三等分！* \
    *3. 命题意图揭秘*： \
    #h(1em) 本题第（3）问命题人精心给出的两个极值点 $a, frac(a + 2 b, 3)$ 以及另一单零点 $b$，正是三次函数特征点中除去拐点之外的其余三项。因此，只要考生熟悉三次多项式的对称中心结构，即可一眼看出缺失的第四项 $x_4$ 正是三次函数的 *拐点（对称中心横坐标）* $frac(2 a + b, 3)$！
  ]
]
