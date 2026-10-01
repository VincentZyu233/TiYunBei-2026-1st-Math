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
  caption: [第 6 题　三棱锥补成长方体：$P A$、$P B$、$P C$ 沿三条坐标轴且两两垂直，等于体对角线的一半],
  {
    // 长方体顶点: P 在原点, A/B/C 落在三坐标轴正方向, M 为体对角顶点
    let p0 = (0.0, 0.0, 0.0)
    let pa = (2.3, 0.0, 0.0) // A 在 x 轴
    let pb = (0.0, 1.9, 0.0) // B 在 y 轴
    let pc = (0.0, 0.0, 1.7) // C 在 z 轴
    let n = (2.3, 1.9, 0.0) // 底面第四点 A+B
    let m = (2.3, 1.9, 1.7) // 体对角顶点
    let u = (2.3, 0.0, 1.7) // A+C
    let w = (0.0, 1.9, 1.7) // B+C

    // 三条侧棱 (沿坐标轴, 醒目)
    ln(proj3(p0), proj3(pa), stroke: s(red, th: 1.4pt))
    ln(proj3(p0), proj3(pb), stroke: s(blue, th: 1.4pt))
    ln(proj3(p0), proj3(pc), stroke: s(green, th: 1.4pt))

    // 底面三角形 ABC (可见棱)
    ln(proj3(pa), proj3(pb), stroke: s(black, th: 1.1pt))
    ln(proj3(pb), proj3(pc), stroke: s(black, th: 1.1pt))
    ln(proj3(pc), proj3(pa), stroke: s(black, th: 1.1pt))

    // 长方体其余六条棱 (被遮挡, 虚线)
    for (a, b) in ((pa, n), (pb, n), (pa, u), (pc, u), (pb, w), (pc, w)) {
      dashed(proj3(a), proj3(b), color: gray, th: 0.7pt)
    }
    // 汇于 M 的三条棱
    for (a, b) in ((n, m), (u, m), (w, m)) {
      dashed(proj3(a), proj3(b), color: gray, th: 0.7pt)
    }

    // 顶点标注 (tsize 要够大, 否则截图里几乎看不清)
    let ts = 0.32
    dot(proj3(p0), radius: 0.07, fill: red, stroke: none)
    txt(proj3(p0), anchor: "south-east", dx: -0.08, dy: 0.08, tsize: ts, [$P$])

    dot(proj3(pa), radius: 0.07, fill: black, stroke: none)
    txt(proj3(pa), anchor: "north-west", dx: 0.06, dy: 0.02, tsize: ts, [$A$])

    dot(proj3(pb), radius: 0.07, fill: black, stroke: none)
    txt(proj3(pb), anchor: "west", dx: 0.1, tsize: ts, [$B$])

    dot(proj3(pc), radius: 0.07, fill: black, stroke: none)
    txt(proj3(pc), anchor: "south", dy: 0.08, tsize: ts, [$C$])

    dot(proj3(m), radius: 0.06, fill: gray, stroke: none)
    txt(proj3(m), anchor: "east", dx: 0.12, tsize: ts * 0.85, [$M$])

    // 坐标轴 (教材标准画法)。A 占住了 x 轴, 故 x 轴画得更长让标签落在其后。
    axes3(
      xlen: 4.6,
      ylen: 2.9,
      zlen: 2.6,
      xlab: [$x$],
      ylab: [$y$],
      zlab: [$z$],
      tsize: 0.3,
    )
  },
)