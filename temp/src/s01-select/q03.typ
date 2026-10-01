// ============================================================
//  第 3 题 —— 一、选择题（第 1—8 题）
// ============================================================
#import "../_template.typ": *
#import "../_figs.typ": *

// ---------------- 第 3 题 ----------------
#qhead(3, pts: 5)
设平面向量 $arrow(a), arrow(b)$ 满足 $|arrow(a) + arrow(b)| = sqrt(3)$，$|arrow(a) - arrow(b)| = 1$，
则 $arrow(a) cdot arrow(b) =$（    ）

#opts((
  [A．$1$],
  [B．$-1$],
  [C．$1/2$],
  [D．$-1/2$],
))

#sol[
  由向量模的平方公式，对任意向量 $arrow(u), arrow(v)$ 有 $|arrow(u) + arrow(v)|^2 = |arrow(u)|^2 + |arrow(v)|^2 + 2 arrow(u) cdot arrow(v)$。

  于是
  $
    |arrow(a) + arrow(b)|^2 = |arrow(a)|^2 + |arrow(b)|^2 + 2 arrow(a) cdot arrow(b) = 3,
  $
  $
    |arrow(a) - arrow(b)|^2 = |arrow(a)|^2 + |arrow(b)|^2 - 2 arrow(a) cdot arrow(b) = 1,
  $
  两式相减得 $4 arrow(a) cdot arrow(b) = 3 - 1 = 2$，故 $arrow(a) cdot arrow(b) = 1/2$。
]
#ans[$arrow(a) cdot arrow(b) = 1/2$，选 #text(weight: "bold")[C]]

#fcap(
  scale: 3.5,
  caption: [第 3 题  平行四边形：红色为 $|arrow(a)+arrow(b)| = sqrt(3)$，蓝色为 $|arrow(a)-arrow(b)| = 1$ 对应的对角线],
  {
    let o = (0.25, 0.25)
    let a = (2.05, 0.25)
    let b = (1.35, 1.75)
    let c = (3.15, 1.75)

    ln(o, a, stroke: s(black, th: 1.2pt))
    ln(o, b, stroke: s(black, th: 1.2pt))
    ln(a, c, stroke: sd(gray, th: 1.0pt))
    ln(b, c, stroke: sd(gray, th: 1.0pt))
    ln(o, c, stroke: s(red, th: 1.4pt))
    ln(a, b, stroke: s(blue, th: 1.4pt))

    pt(o, r: 0.045, fill: black)
    txt(o, anchor: "north-east", dx: -0.05, dy: -0.05, tsize: 0.35, [$O$])
    pt(a, r: 0.045, fill: green)
    txt(a, anchor: "north", dy: -0.06, tsize: 0.35, [$A$])
    pt(b, r: 0.045, fill: green)
    txt(b, anchor: "south", dy: 0.06, tsize: 0.35, [$B$])
    pt(c, r: 0.045, fill: red)
    txt(c, anchor: "south-west", dx: 0.05, dy: 0.04, tsize: 0.35, [$C$])

    txt((1.15, 0.25), anchor: "north", dy: -0.06, tsize: 0.35, [$arrow(a)$])
    txt((0.75, 1.05), anchor: "east", dx: -0.06, tsize: 0.35, [$arrow(b)$])
    txt((2.35, 1.42), anchor: "south-east", dy: 0.05, tsize: 0.33, [$|arrow(a)+arrow(b)| = sqrt(3)$])
    txt((1.75, 0.70), anchor: "east", dx: -0.06, tsize: 0.33, [$|arrow(a)-arrow(b)| = 1$])
  },
)
