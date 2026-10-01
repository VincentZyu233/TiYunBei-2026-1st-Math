// ---------------- 第 14 题 ----------------
#import "../_template.typ": *
#import "../_figs.typ": *

#qhead(14, pts: 5)
已知椭圆 $C: x^2 / 4 + y^2 / 3 = 1$ 的左焦点为 $F$，不经过点 $F$ 且斜率为 $sqrt(3)$ 的直线交 $C$ 于 $A, B$ 两点，当 $triangle F A B$ 的周长最大时，$|A B| =$ #blank()。

#sol[
  由椭圆方程 $x^2/4 + y^2/3 = 1$ 可知：
  $ a^2 = 4 ==> a = 2, quad b^2 = 3 ==> b = sqrt(3), quad c = sqrt(a^2 - b^2) = sqrt(4 - 3) = 1. $
  因此左焦点为 $F(-1, 0)$，右焦点为 $F'(1, 0)$。

  *第一步：确定 $triangle F A B$ 周长最大时的直线几何特征。*

  由椭圆的第一定义，椭圆上的任意点到两焦点的距离之和恒等于长轴长 $2a = 4$：
  $ |F A| + |F' A| = 2a = 4, quad |F B| + |F' B| = 2a = 4. $
  于是 $triangle F A B$ 的周长为：
  $
    C_(triangle F A B) &= |F A| + |F B| + |A B| \
    &= (4 - |F' A|) + (4 - |F' B|) + |A B| \
    &= 8 - (|F' A| + |F' B| - |A B|).
  $
  在 $triangle F' A B$ 中，根据两点之间线段最短（三角形两边之和大于等于第三边）：
  $ |F' A| + |F' B| >= |A B|, $
  当且仅当点 $F'$ 落在两端点 $A, B$ 构成的线段上时等号成立。
  此时 $|F' A| + |F' B| - |A B| = 0$，三角形周长取得最大值：
  由于直线斜率为 $sqrt(3) != 0$，且过点 $F'(1, 0)$，显然不过左焦点 $F(-1, 0)$，符合题意。因此，*周长最大时，直线 $A B$ 必经过椭圆的右焦点 $F'(1, 0)$*。

  *第二步：求直线 $A B$ 被椭圆截得的弦长 $|A B|$。*

  直线经过点 $F'(1, 0)$ 且斜率 $k = sqrt(3)$，其点斜式方程为：
  $ y = sqrt(3)(x - 1). $
  将直线方程代入椭圆方程 $x^2/4 + y^2/3 = 1$：
  $
    x^2/4 + (3(x - 1)^2)/3 = 1 &==> x^2/4 + (x - 1)^2 = 1 \
    &==> x^2/4 + x^2 - 2x + 1 = 1 \
    &==> 5/4 x^2 - 2x = 0 \
    &==> x(5/4 x - 2) = 0.
  $
  解得两交点的横坐标分别为 $x_1 = 0, x_2 = 8/5$。
  由弦长公式，弦长为：
  $
    |A B| = sqrt(1 + k^2) |x_1 - x_2| = sqrt(1 + 3) times |8/5 - 0| = 2 times 8/5 = 16/5.
  $
]
#ans[$16/5$（或 $3.2$）]

#fcap(
  scale: 1.25,
  caption: [第 14 题  周长最大时直线 $A B$ 必过右焦点 $F'(1, 0)$，此时 $|F' A| + |F' B| = |A B|$，周长达最大值 $4a = 8$],
  {
    let a = 2.0
    let b = calc.sqrt(3.0)

    // 坐标轴
    axes(-2.8, 2.9, -2.5, 2.5, xl: [$x$], yl: [$y$], arrow: 0.25, tsize: 0.32)
    txt((-0.16, -0.16), anchor: "north-east", tsize: 0.30, weight: "bold", [$O$])

    // 椭圆曲线
    param(t => (a * calc.cos(t), b * calc.sin(t)), 0.0, 2.0 * calc.pi, stroke: s(blue, th: 1.6pt))
    txt((1.5, -1.6), anchor: "west", tsize: 0.28, text(fill: blue, weight: "bold")[$C: frac(x^2, 4) + frac(y^2, 3) = 1$])

    // 左右焦点
    let f_pt = (-1.0, 0.0)
    let fp_pt = (1.0, 0.0)
    pt(f_pt, label: [$F(-1, 0)$], r: 0.08, fill: red, dx: -0.16, dy: -0.18, anchor: "north-east", tsize: 0.28)
    pt(fp_pt, label: [$F'(1, 0)$], r: 0.08, fill: purple, dx: 0.16, dy: 0.16, anchor: "south-west", tsize: 0.28)

    // 交点 A, B
    let a_pt = (0.0, -calc.sqrt(3.0))
    let b_pt = (1.6, 3.0 * calc.sqrt(3.0) / 5.0)

    // 三角形 FAB 区域微填充
    ln(f_pt, a_pt, b_pt, close: true, fill: rgb(214, 137, 16, 14%), stroke: none)

    // 割线 AB（斜率为 sqrt(3) 的直线，穿过右焦点 F'，两端延伸）
    let line_ext1 = (-0.4, -calc.sqrt(3.0) - 0.4 * calc.sqrt(3.0))
    let line_ext2 = (1.95, 3.0 * calc.sqrt(3.0) / 5.0 + 0.35 * calc.sqrt(3.0))
    ln(line_ext1, line_ext2, stroke: s(green, th: 1.5pt))
    txt((line_ext2.at(0) + 0.08, line_ext2.at(1) + 0.06), anchor: "south-west", tsize: 0.28, text(fill: green, weight: "bold")[直线 $A B$ ($k=sqrt(3)$)])

    // 三角形连线 FA, FB (虚线，红色)
    dashed(f_pt, a_pt, color: red, th: 1.0pt)
    dashed(f_pt, b_pt, color: red, th: 1.0pt)

    // 交点标注
    pt(a_pt, label: [$A(0, -sqrt(3))$], r: 0.08, fill: green, dx: -0.16, dy: -0.14, anchor: "north-east", tsize: 0.28)
    pt(b_pt, label: [$B(frac(8, 5), frac(3 sqrt(3), 5))$], r: 0.08, fill: green, dx: 0.18, dy: -0.10, anchor: "north-west", tsize: 0.28)

    // 周长关系标注
    txt((-2.5, 2.0), anchor: "north-west", tsize: 0.28, text(fill: orange, weight: "bold")[$triangle F A B$ 周长最大值 $= 4a = 8$])
    txt((0.9, -0.8), anchor: "center", tsize: 0.28, text(fill: purple, weight: "bold")[$|A B| = frac(16, 5)$])
  },
)
