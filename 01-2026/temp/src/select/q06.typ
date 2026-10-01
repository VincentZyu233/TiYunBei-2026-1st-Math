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
  以 $P$ 为原点，令 $P A = (p, 0, 0)$，$P B = (0, q, 0)$，$P C = (0, 0, r)$。因三条侧棱两两垂直，
  $
    A B^2 = p^2 + q^2 = 5, quad quad B C^2 = q^2 + r^2 = 7, quad quad A C^2 = p^2 + r^2 = 4,
  $
  三式相加：$2(p^2 + q^2 + r^2) = 5 + 7 + 4 = 16$，故 $p^2 + q^2 + r^2 = 8$。

  把三棱锥补成长方体，则外接球球心为长方体体对角线的中点，半径
  $R = 1/2 sqrt(p^2 + q^2 + r^2) = 1/2 sqrt(8) = sqrt(2)$。

  故 $V = 4/3 pi R^3 = 4/3 pi · 2 sqrt(2) = 8 sqrt(2) pi / 3$。
]
#ans[$V = 8sqrt(2) pi / 3$，选 #text(weight: "bold")[B]]

#fcap(
  scale: 0.95,
  caption: [第 6 题  补成长方体，$P$ 与体对角顶点 $M$ 连成外接球直径，$2R = sqrt(8) = 2sqrt(2)$],
  {
    let p0 = (0.0, 0.0, 0.0)
    let a = (2.5, 0.0, 0.0)
    let b = (0.0, 2.0, 0.0)
    let c = (0.0, 0.0, 1.8)
    let m = (2.5, 2.0, 1.8)

    // 长方体其余三条棱
    dashed(proj3((2.5, 2.0, 0.0)), proj3((2.5, 2.0, 1.8)))
    dashed(proj3((2.5, 0.0, 1.8)), proj3((2.5, 2.0, 1.8)))
    dashed(proj3((0.0, 2.0, 1.8)), proj3((2.5, 2.0, 1.8)))

    // 底面三角形
    ln(proj3(a), proj3(b), stroke: s(black, th: 1.1pt))
    ln(proj3(b), proj3(c), stroke: s(black, th: 1.1pt))
    ln(proj3(c), proj3(a), stroke: s(black, th: 1.1pt))
    // 三条侧棱
    ln(proj3(p0), proj3(a), stroke: s(red, th: 1.3pt))
    ln(proj3(p0), proj3(b), stroke: s(blue, th: 1.3pt))
    ln(proj3(p0), proj3(c), stroke: s(green, th: 1.3pt))
    // 直径 PM
    ln(proj3(p0), proj3(m), stroke: sd(red, th: 1.0pt))

    dot(proj3(p0), radius: 0.06, fill: red, stroke: none)
    txt(proj3(p0), anchor: "north-east", dx: -0.07, dy: -0.06, [$P$])
    dot(proj3(a), radius: 0.055, fill: black, stroke: none)
    txt(proj3(a), anchor: "south-east", dx: 0.06, dy: -0.06, [$A$])
    dot(proj3(b), radius: 0.055, fill: black, stroke: none)
    txt(proj3(b), anchor: "north-east", dx: 0.06, dy: 0.06, [$B$])
    dot(proj3(c), radius: 0.055, fill: black, stroke: none)
    txt(proj3(c), anchor: "south-west", dx: -0.06, dy: -0.06, [$C$])
    dot(proj3(m), radius: 0.05, fill: gray, stroke: none)
    txt(proj3(m), anchor: "north-west", dx: 0.06, tsize: 0.14, [$M$])

    let mid = ((proj3(p0).at(0) + proj3(m).at(0)) / 2, (proj3(p0).at(1) + proj3(m).at(1)) / 2 + 0.45)
    txt(mid, tsize: 0.145, [$2R = sqrt(8)$])
  },
)
