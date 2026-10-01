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
  
  + 对于 A：$z_1 + z_2 = (3 + 1) + (1 - 3)i = 4 - 2i$，其模长 $|z_1 + z_2| = sqrt(4^2 + (-2)^2) = 2 sqrt(5) != 3$，故 A 错误。
  + 对于 B：$z_1 z_2 = (3 + i)(1 - 3i) = 3 - 9i + i - 3 i^2 = 6 - 8i$，故 B 正确。
  + 对于 C：$z_1 - z_2 = (3 - 1) + [1 - (-3)]i = 2 + 4i$，故 C 正确。
  + 对于 D：$z_1 / z_2 = (3 + i) / (1 - 3i) = ((3 + i)(1 + 3i)) / ((1 - 3i)(1 + 3i)) = (3 + 9i + i + 3i^2) / (1 - 9i^2) = (10i) / (1 + 9) = (10i) / 10 = i != 1 + i$，故 D 错误。
]
#ans[选 #text(weight: "bold")[BC]]

#fcap(
  scale: 0.80,
  caption: [第 9 题  复平面内复数的向量表示：四则运算（和、差、积、商）几何图解],
  {
    let o = (0.0, 0.0)
    let z1 = (3.0, 1.0)
    let z2 = (1.0, -3.0)
    let z_add = (4.0, -2.0)
    let z_sub = (2.0, 4.0)
    let z_mul = (6.0, -8.0)
    let z_div = (0.0, 1.0)

    // 左侧：复数四则运算速查框（加大字号，布局饱满）
    box2((-8.2, -0.4), (-2.0, 4.6), fill: rgb("#f6f9fc"), stroke: s(rgb("#a5c0dc"), th: 0.8pt), radius: 0.25)
    txt((-7.8, 4.15), anchor: "north-west", tsize: 0.25, text(weight: "bold", fill: blue)[【复数四则运算速查】])
    txt((-7.8, 3.35), anchor: "north-west", tsize: 0.22, [• $z_1 = 3 + i$，$z_2 = 1 - 3i$])
    txt((-7.8, 2.55), anchor: "north-west", tsize: 0.22, text(fill: purple)[• 和：$z_1 + z_2 = 4 - 2i$])
    txt((-7.8, 1.75), anchor: "north-west", tsize: 0.22, text(fill: red)[• 差：$z_1 - z_2 = 2 + 4i$])
    txt((-7.8, 0.95), anchor: "north-west", tsize: 0.22, text(fill: rgb("#b9770e"))[• 积：$z_1 z_2 = 6 - 8i$])
    txt((-7.8, 0.15), anchor: "north-west", tsize: 0.22, text(fill: rgb("#117a65"))[• 商：$z_1 / z_2 = i$])

    // 右侧：坐标系（带实轴、虚轴箭头与大字号标注）
    let xmin = -1.6
    let xmax = 7.8
    let ymin = -8.8
    let ymax = 4.8

    // 实轴 (Re)
    ln((xmin, 0.0), (xmax, 0.0), stroke: s(black, th: 1.1pt), mark: (end: ">", fill: black))
    txt((xmax + 0.18, 0.0), anchor: "west", tsize: 0.28, text(weight: "bold")[实轴 $"Re"$])

    // 虚轴 (Im)
    ln((0.0, ymin), (0.0, ymax), stroke: s(black, th: 1.1pt), mark: (end: ">", fill: black))
    txt((0.0, ymax + 0.28), anchor: "south", tsize: 0.28, text(weight: "bold")[虚轴 $"Im"$])

    // 刻度线与更大字号数字
    for k in (-1, 1, 2, 3, 4, 5, 6) {
      ln((k * 1.0, -0.14), (k * 1.0, 0.14), stroke: s(black, th: 0.8pt))
      txt((k * 1.0, -0.24), anchor: "north", tsize: 0.25, [$#k$])
    }
    for k in (-8, -6, -4, -3, -2, -1, 1, 2, 3, 4) {
      ln((-0.14, k * 1.0), (0.14, k * 1.0), stroke: s(black, th: 0.8pt))
      txt((-0.24, k * 1.0), anchor: "east", tsize: 0.25, [$#k$])
    }
    txt((-0.25, -0.25), anchor: "north-east", tsize: 0.28, text(weight: "bold")[$O$])

    // 辅助虚线 (加法平行四边形)
    dashed(z1, z_add, color: gray, th: 0.8pt)
    dashed(z2, z_add, color: gray, th: 0.8pt)

    // 辅助虚线 (乘法正交投影)
    dashed((6.0, 0.0), z_mul, color: gray, th: 0.8pt)
    dashed((0.0, -8.0), z_mul, color: gray, th: 0.8pt)

    // 向量与端点标记（带箭头，加大标注字号）
    // z1
    ln(o, z1, stroke: s(blue, th: 1.8pt), mark: (end: ">", fill: blue))
    pt(z1, label: [$z_1(3, 1)$], r: 0.10, fill: blue, dx: 0.18, dy: 0.18, anchor: "south-west", tsize: 0.28)

    // z2 (置于点右下方，避开虚轴上的 -3 刻度线与下方的积向量)
    ln(o, z2, stroke: s(green, th: 1.8pt), mark: (end: ">", fill: green))
    pt(z2, label: [$z_2(1, -3)$], r: 0.10, fill: green, dx: 0.16, dy: -0.16, anchor: "north-west", tsize: 0.28)

    // 和向量 z1 + z2
    ln(o, z_add, stroke: s(purple, th: 2.0pt), mark: (end: ">", fill: purple))
    pt(z_add, label: [$z_1 + z_2(4, -2)$], r: 0.10, fill: purple, dx: 0.18, dy: -0.06, anchor: "north-west", tsize: 0.28)

    // 差向量 z1 - z2
    ln(o, z_sub, stroke: s(red, th: 2.0pt), mark: (end: ">", fill: red))
    pt(z_sub, label: [$z_1 - z_2(2, 4)$], r: 0.10, fill: red, dx: 0.18, dy: 0.18, anchor: "south-west", tsize: 0.28)
    ln(z2, z1, stroke: sd(red, th: 1.3pt), mark: (end: ">", fill: red))
    txt((2.2, -1.0), anchor: "west", tsize: 0.25, text(fill: red)[$arrow(z_2 z_1)$])

    // 乘积向量 z1 * z2
    ln(o, z_mul, stroke: s(rgb("#b9770e"), th: 2.0pt), mark: (end: ">", fill: rgb("#b9770e")))
    pt(z_mul, label: [$z_1 z_2(6, -8)$], r: 0.12, fill: rgb("#b9770e"), dx: 0.20, dy: -0.16, anchor: "north-west", tsize: 0.29)

    // 商向量 z1 / z2 (位于正虚轴上，标签置于右上方开阔区域)
    ln(o, z_div, stroke: s(rgb("#117a65"), th: 2.8pt), mark: (end: ">", fill: rgb("#117a65")))
    pt(z_div, label: [$z_1 / z_2 = i$], r: 0.10, fill: rgb("#117a65"), dx: 0.22, dy: 0.16, anchor: "south-west", tsize: 0.28)
  },
)
