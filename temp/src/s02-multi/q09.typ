// ---------------- 第 9 题 ----------------
#import "../_template.typ": *
#import "../_figs.typ": *

#qhead(9, pts: 6)
设复数 $z_1 = 3 + i$，$z_2 = 1 - 3i$，则（    ）

#opts((
  [A．$|z_1 + z_2| = 3$],
  [B．$z_1 z_2 = 6 - 8i$],
  [C．$z_1 - z_2 = 2 + 4i$],
  [D．$z_1 / z_2 = 1 + i$],
))

#sol[
  逐项检验如下：

  对于 A：$z_1 + z_2 = (3 + 1) + (1 - 3)i = 4 - 2i$。其模长为
  $ |z_1 + z_2| = sqrt(4^2 + (-2)^2) = sqrt(16 + 4) = sqrt(20) = 2 sqrt(5) != 3, $
  故 A 错误。

  对于 B：根据复数乘法法则与 $i^2 = -1$，
  $ z_1 z_2 = (3 + i)(1 - 3i) = 3 - 9i + i - 3 i^2 = 3 - 8i + 3 = 6 - 8i, $
  故 B 正确。

  对于 C：$z_1 - z_2 = (3 - 1) + [1 - (-3)]i = 2 + 4i$，故 C 正确。

  对于 D：分子分母同乘分母的共轭复数 $1 + 3i$ 得
  $ z_1 / z_2 = (3 + i) / (1 - 3i) = ((3 + i)(1 + 3i)) / (1^2 + (-3)^2) = (3 + 9i + i - 3) / (1 + 9) = (10i) / 10 = i != 1 + i, $
  故 D 错误。
]
#ans[选 #text(weight: "bold")[BC]]

#fcap(
  scale: 0.52,
  caption: [第 9 题  复平面内复数的向量表示：四则运算（和、差、积、商）],
  {
    // 坐标系
    axes(-1.4, 7.2, -8.8, 4.8, xl: [$"Re"$], yl: [$"Im"$])
    // 刻度
    for k in (-1, 1, 2, 3, 4, 5, 6) {
      ln((k * 1.0, -0.09), (k * 1.0, 0.09), stroke: s(black, th: 0.5pt))
      txt((k * 1.0, -0.14), anchor: "north", tsize: 0.15, [$#k$])
    }
    for k in (-8, -6, -4, -3, -2, -1, 1, 2, 3, 4) {
      ln((-0.09, k * 1.0), (0.09, k * 1.0), stroke: s(black, th: 0.5pt))
      txt((-0.14, k * 1.0), anchor: "east", tsize: 0.15, [$#k$])
    }
    txt((-0.14, -0.14), anchor: "north-east", tsize: 0.15, [$O$])

    let o = (0.0, 0.0)
    let z1 = (3.0, 1.0)
    let z2 = (1.0, -3.0)
    let z_add = (4.0, -2.0)
    let z_sub = (2.0, 4.0)
    let z_mul = (6.0, -8.0)
    let z_div = (0.0, 1.0)

    // 平行四边形虚线 (加法)
    dashed(z1, z_add, color: gray)
    dashed(z2, z_add, color: gray)

    // z_mul 投影虚线 (乘法)
    dashed((6.0, 0.0), z_mul, color: gray)
    dashed((0.0, -8.0), z_mul, color: gray)

    // 向量与端点
    // z1
    ln(o, z1, stroke: s(blue, th: 1.3pt))
    pt(z1, label: [$z_1(3, 1)$], r: 0.07, fill: blue, dx: 0.12, dy: 0.12, anchor: "south-west", tsize: 0.16)

    // z2
    ln(o, z2, stroke: s(green, th: 1.3pt))
    pt(z2, label: [$z_2(1, -3)$], r: 0.07, fill: green, dx: 0.12, dy: -0.12, anchor: "north-west", tsize: 0.16)

    // z1 + z2
    ln(o, z_add, stroke: s(purple, th: 1.4pt))
    pt(z_add, label: [$z_1 + z_2(4, -2)$], r: 0.07, fill: purple, dx: 0.12, dy: -0.06, anchor: "north-west", tsize: 0.16)

    // z1 - z2
    ln(o, z_sub, stroke: s(red, th: 1.4pt))
    pt(z_sub, label: [$z_1 - z_2(2, 4)$], r: 0.07, fill: red, dx: 0.12, dy: 0.12, anchor: "south-west", tsize: 0.16)
    dashed(z2, z1, color: red, th: 1.0pt)
    txt((2.2, -1.0), anchor: "west", tsize: 0.15, [$arrow(z_2 z_1)$])

    // z1 * z2
    ln(o, z_mul, stroke: s(rgb("#b9770e"), th: 1.5pt))
    pt(z_mul, label: [$z_1 z_2(6, -8)$], r: 0.08, fill: rgb("#b9770e"), dx: 0.14, dy: -0.12, anchor: "north-west", tsize: 0.16)

    // z1 / z2 (位于虚轴上)
    ln(o, z_div, stroke: s(rgb("#117a65"), th: 2.2pt))
    pt(z_div, label: [$z_1 / z_2(0, 1)$], r: 0.07, fill: rgb("#117a65"), dx: -0.14, dy: 0.1, anchor: "south-east", tsize: 0.16)
  },
)
