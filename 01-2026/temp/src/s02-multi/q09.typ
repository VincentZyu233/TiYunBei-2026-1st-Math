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
  scale: 0.85,
  caption: [第 9 题  复平面内复数的向量表示：和向量（平行四边形法则）与差向量],
  {
    // 坐标系
    axes(-1.3, 5.3, -3.8, 4.8, xl: [$"Re"$], yl: [$"Im"$])
    // 刻度
    for k in (-1, 1, 2, 3, 4, 5) {
      ln((k * 1.0, -0.08), (k * 1.0, 0.08), stroke: s(black, th: 0.5pt))
      txt((k * 1.0, -0.13), anchor: "north", tsize: 0.13, [$#k$])
    }
    for k in (-3, -2, -1, 1, 2, 3, 4) {
      ln((-0.08, k * 1.0), (0.08, k * 1.0), stroke: s(black, th: 0.5pt))
      txt((-0.13, k * 1.0), anchor: "east", tsize: 0.13, [$#k$])
    }
    txt((-0.12, -0.12), anchor: "north-east", tsize: 0.13, [$O$])

    let o = (0.0, 0.0)
    let z1 = (3.0, 1.0)
    let z2 = (1.0, -3.0)
    let z_add = (4.0, -2.0)
    let z_sub = (2.0, 4.0)

    // 平行四边形虚线
    dashed(z1, z_add, color: gray)
    dashed(z2, z_add, color: gray)

    // 向量与端点
    ln(o, z1, stroke: s(blue, th: 1.2pt))
    pt(z1, label: [$z_1(3, 1)$], r: 0.06, fill: blue, dx: 0.1, dy: 0.1, anchor: "south-west")

    ln(o, z2, stroke: s(green, th: 1.2pt))
    pt(z2, label: [$z_2(1, -3)$], r: 0.06, fill: green, dx: 0.1, dy: -0.1, anchor: "north-west")

    ln(o, z_add, stroke: s(purple, th: 1.3pt))
    pt(z_add, label: [$z_1 + z_2(4, -2)$], r: 0.06, fill: purple, dx: 0.1, dy: -0.05, anchor: "north-west")

    ln(o, z_sub, stroke: s(red, th: 1.3pt))
    pt(z_sub, label: [$z_1 - z_2(2, 4)$], r: 0.06, fill: red, dx: 0.1, dy: 0.1, anchor: "south-west")

    dashed(z2, z1, color: red, th: 0.9pt)
    txt((2.2, -1.0), anchor: "west", tsize: 0.13, [$arrow(z_2 z_1)$])
  },
)
