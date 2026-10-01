// ============================================================
//  第 3 题 —— 一、选择题（第 1—8 题）
// ============================================================
#import "../_template.typ": *
#import "../_figs.typ": *

// ---------------- 第 3 题 ----------------
#qhead(3, pts: 5)
设平面向量 $vec(a), vec(b)$ 满足 $|vec(a) + vec(b)| = sqrt(3)$，$|vec(a) - vec(b)| = 1$，
则 $vec(a) · vec(b) =$（    ）

#opts((
  [A．$1$],
  [B．$-1$],
  [C．$1/2$],
  [D．$-1/2$],
))

#sol[
  由向量模的平方公式，对任意 $u, v$ 有 $|u + v|^2 = |u|^2 + |v|^2 + 2 u · v$。

  于是
  $
    |vec(a) + vec(b)|^2 = |vec(a)|^2 + |vec(b)|^2 + 2 vec(a) · vec(b) = 3,
  $
  $
    |vec(a) - vec(b)|^2 = |vec(a)|^2 + |vec(b)|^2 - 2 vec(a) · vec(b) = 1,
  $
  两式相减得 $4 vec(a) · vec(b) = 3 - 1 = 2$，故 $vec(a) · vec(b) = 1/2$。
]
#ans[$vec(a) · vec(b) = 1/2$，选 #text(weight: "bold")[C]]

#fcap(
  scale: 1.0,
  caption: [第 3 题  平行四边形：红色为 $|a+b| = sqrt(3)$，蓝色为 $|a-b| = 1$ 对应的对角线],
  {
    let o = (0.25, 0.25)
    let a = (2.05, 0.25)
    let b = (1.35, 1.75)
    let c = (3.15, 1.75)

    ln(o, a, stroke: s(black, th: 1.1pt))
    ln(o, b, stroke: s(black, th: 1.1pt))
    ln(a, c, stroke: sd(gray, th: 1.0pt))
    ln(b, c, stroke: sd(gray, th: 1.0pt))
    ln(o, c, stroke: s(red, th: 1.3pt))
    ln(a, b, stroke: s(blue, th: 1.3pt))

    pt(o, r: 0.05, fill: black)
    txt(o, anchor: "north-east", dx: -0.06, dy: -0.05, [$O$])
    pt(a, r: 0.055, fill: green)
    txt(a, anchor: "north-west", dx: -0.05, dy: 0.05, [$A$])
    pt(b, r: 0.055, fill: green)
    txt(b, anchor: "south-east", dx: 0.05, dy: -0.05, [$B$])
    pt(c, r: 0.055, fill: red)
    txt(c, anchor: "south-west", dx: -0.05, dy: -0.05, [$C$])

    txt((0.95, 0.25), anchor: "north", dy: -0.06, [$vec(a)$])
    txt((0.62, 1.0), anchor: "north-east", dx: -0.05, dy: -0.04, [$vec(b)$])
    txt((1.72, 1.08), anchor: "south", tsize: 0.14, [$|a+b| = sqrt(3)$])
    txt((1.68, 0.9), anchor: "north", tsize: 0.14, [$|a-b| = 1$])
  },
)
