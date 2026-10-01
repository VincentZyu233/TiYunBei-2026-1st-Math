// ============================================================
//  第 6 题 —— 一、选择题（第 1—8 题）
// ============================================================
#import "../_template.typ": *
#import "../_figs.typ": *

// ---------------- 第 6 题 ----------------
#qhead(6, pts: 5)
已知三棱锥 $P - A B C$ 的三条侧棱两两垂直，且 $A B = sqrt(5)$，$B C = sqrt(7)$，$A C = 2$，
则该三棱锥的外接球体积为（    ）

#opts((
  [A．$4 pi / 3$],
  [B．$8 sqrt(2) pi / 3$],
  [C．$4 pi$],
  [D．$8 pi$],
))

#sol[
  以 $P$ 为原点，令 $P A = (a, 0, 0)$，$P B = (0, b, 0)$，$P C = (0, 0, c)$。因三条侧棱两两垂直，
  $
    A B^2 = a^2 + b^2 = 5, quad quad B C^2 = b^2 + c^2 = 7, quad quad A C^2 = a^2 + c^2 = 4,
  $
  三式相加：$2(a^2 + b^2 + c^2) = 5 + 7 + 4 = 16$，故 $a^2 + b^2 + c^2 = 8$。

  把三棱锥补成长方体，则外接球球心为长方体体对角线的中点，半径
  $R = 1/2 sqrt(a^2 + b^2 + c^2) = 1/2 sqrt(8) = sqrt(2)$。

  故 $V = 4/3 pi R^3 = 4/3 pi · 2 sqrt(2) = 8 sqrt(2) pi / 3$。
]
#ans[$V = 8sqrt(2) pi / 3$，选 #text(weight: "bold")[B]]

#fcap(
  scale: 0.9,
  caption: [第 6 题　补成长方体：$P A$、$P B$、$P C$ 沿三坐标轴，两两垂直；$P$ 与体对角顶点 $M$ 连成外接球直径],
  {
    // 三棱锥补成的长方体: P 在原点, A/B/C 分别落在三坐标轴正方向
    let p0 = (0.0, 0.0, 0.0)
    let pa = (2.3, 0.0, 0.0) // A 在 x 轴
    let pb = (0.0, 1.9, 0.0) // B 在 y 轴
    let pc = (0.0, 0.0, 1.7) // C 在 z 轴
    let m = (2.3, 1.9, 1.7) // 体对角顶点 M

    // 长方体另外三条棱 (虚线)
    dashed(proj3((2.3, 1.9, 0.0)), proj3(m))
    dashed(proj3((2.3, 0.0, 1.7)), proj3(m))
    dashed(proj3((0.0, 1.9, 1.7)), proj3(m))

    // 底面三角形 ABC
    ln(proj3(pa), proj3(pb), stroke: s(black, th: 1.1pt))
    ln(proj3(pb), proj3(pc), stroke: s(black, th: 1.1pt))
    ln(proj3(pc), proj3(pa), stroke: s(black, th: 1.1pt))

    // 三条侧棱 (即三条坐标轴方向)
    ln(proj3(p0), proj3(pa), stroke: s(red, th: 1.3pt))
    ln(proj3(p0), proj3(pb), stroke: s(blue, th: 1.3pt))
    ln(proj3(p0), proj3(pc), stroke: s(green, th: 1.3pt))

    // 外接球直径 PM
    ln(proj3(p0), proj3(m), stroke: sd(red, th: 1.1pt))

    // 顶点
    dot(proj3(p0), radius: 0.06, fill: red, stroke: none)
    txt(proj3(p0), anchor: "north-east", dx: -0.07, dy: -0.06, [$P$])
    dot(proj3(pa), radius: 0.055, fill: black, stroke: none)
    txt(proj3(pa), anchor: "north-west", dx: -0.05, dy: 0.05, [$A$])
    dot(proj3(pb), radius: 0.055, fill: black, stroke: none)
    txt(proj3(pb), anchor: "south-east", dx: 0.06, dy: -0.06, [$B$])
    dot(proj3(pc), radius: 0.055, fill: black, stroke: none)
    txt(proj3(pc), anchor: "south", dy: -0.1, [$C$])
    dot(proj3(m), radius: 0.05, fill: gray, stroke: none)
    txt(proj3(m), anchor: "north-east", dx: 0.06, dy: 0.06, tsize: 0.14, [$M$])

    // 坐标轴 (教材标准画法)
    axes3(
      xlen: 3.3,
      ylen: 2.9,
      zlen: 2.5,
      xlab: [$x$],
      ylab: [$y$],
      zlab: [$z$],
      origin: (0.0, 0.0, 0.0),
    )

    // 直径标注
    let mid = proj3((1.15, 0.95, 0.85))
    txt(mid, anchor: "north-east", dx: -0.1, dy: 0.05, tsize: 0.145, [$2R = sqrt(8)$])
  },
)