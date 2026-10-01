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
  scale: 1.05,
  caption: [第 6 题　三棱锥补成长方体：$P A$、$P B$、$P C$ 沿三条坐标轴且两两垂直，等于体对角线的一半],
  {
    // 长方体顶点: P 在原点, A/B/C 落在三坐标轴正方向, M 为体对角顶点
    let p0 = (0.0, 0.0, 0.0)
    let pa = (2.4, 0.0, 0.0) // A 在 x 轴
    let pb = (0.0, 2.0, 0.0) // B 在 y 轴
    let pc = (0.0, 0.0, 1.8) // C 在 z 轴
    let n = (2.4, 2.0, 0.0)  // 底面第四点 A+B
    let m = (2.4, 2.0, 1.8)  // 体对角顶点
    let u = (2.4, 0.0, 1.8)  // A+C
    let w = (0.0, 2.0, 1.8)  // B+C

    // 1. 底层: 长方体其余六条不可见棱 (灰色虚线)
    for (a, b) in ((pa, n), (pb, n), (pa, u), (pc, u), (pb, w), (pc, w)) {
      dashed(proj3(a), proj3(b), color: gray, th: 0.75pt)
    }
    // 汇于 M 的三条棱
    for (a, b) in ((n, m), (u, m), (w, m)) {
      dashed(proj3(a), proj3(b), color: gray, th: 0.75pt)
    }

    // 2. 截面三角形 ABC 轮廓线 (黑色实线)
    ln(proj3(pa), proj3(pb), stroke: s(black, th: 1.0pt))
    ln(proj3(pb), proj3(pc), stroke: s(black, th: 1.0pt))
    ln(proj3(pc), proj3(pa), stroke: s(black, th: 1.0pt))

    // 3. 空间直角坐标系: x, y, z 轴带箭头延伸线 (黑色)
    let x_axis_end = (3.5, 0.0, 0.0)
    let y_axis_end = (0.0, 2.9, 0.0)
    let z_axis_end = (0.0, 0.0, 2.6)

    ln(proj3(p0), proj3(x_axis_end), stroke: s(black, th: 0.9pt))
    arrowhead(proj3(x_axis_end), -1.0, 1.0, size: 0.26, filled: true)
    txt(proj3(x_axis_end), anchor: "south-east", dx: -0.04, dy: -0.1, tsize: 0.28, [text(weight: "bold")[$x$]])

    ln(proj3(p0), proj3(y_axis_end), stroke: s(black, th: 0.9pt))
    arrowhead(proj3(y_axis_end), 1.0, 0.0, size: 0.26, filled: true)
    txt(proj3(y_axis_end), anchor: "north", dy: 0.12, tsize: 0.28, [text(weight: "bold")[$y$]])

    ln(proj3(p0), proj3(z_axis_end), stroke: s(black, th: 0.9pt))
    arrowhead(proj3(z_axis_end), 0.0, 1.0, size: 0.26, filled: true)
    txt(proj3(z_axis_end), anchor: "south", dy: 0.14, tsize: 0.28, [text(weight: "bold")[$z$]])

    // 4. 最顶层染色: 三条两两垂直的侧棱 PA(红), PB(蓝), PC(绿) —— 线宽 2.0pt 置于最上层
    ln(proj3(p0), proj3(pa), stroke: s(red, th: 2.0pt))
    ln(proj3(p0), proj3(pb), stroke: s(blue, th: 2.0pt))
    ln(proj3(p0), proj3(pc), stroke: s(green, th: 2.0pt))

    // 5. 顶点标记与圆点 (顶层显示, 避免被线条覆盖)
    let ts = 0.26
    dot(proj3(p0), radius: 0.075, fill: black, stroke: none)
    txt(proj3(p0), anchor: "south-east", dx: -0.10, dy: 0.08, tsize: ts, text(weight: "bold")[$P$])

    dot(proj3(pa), radius: 0.07, fill: red, stroke: none)
    txt(proj3(pa), anchor: "south-east", dx: -0.10, dy: 0.02, tsize: ts, text(weight: "bold")[$A$])

    dot(proj3(pb), radius: 0.07, fill: blue, stroke: none)
    txt(proj3(pb), anchor: "north-west", dx: 0.06, dy: -0.08, tsize: ts, text(weight: "bold")[$B$])

    dot(proj3(pc), radius: 0.07, fill: green, stroke: none)
    txt(proj3(pc), anchor: "east", dx: -0.10, dy: 0.06, tsize: ts, text(weight: "bold")[$C$])

    dot(proj3(m), radius: 0.06, fill: gray, stroke: none)
    txt(proj3(m), anchor: "west", dx: 0.10, tsize: ts * 0.9, text(fill: gray)[$M$])
  },
)