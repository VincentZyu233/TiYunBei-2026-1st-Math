// ============================================================
//  第 2 题 —— 一、选择题（第 1—8 题）
// ============================================================
#import "../_template.typ": *
#import "../_figs.typ": *

// ---------------- 第 2 题 ----------------
#qhead(2, pts: 5)
设集合 $A = { x | x^2 - 2x - 3 <= 0 }$，$B = { y | x^2 + y^2 = 4 }$，则 $A ∩ B =$（    ）

#opts((
  [A．$[-1, 2]$],
  [B．$[-2, 3]$],
  [C．$[-2, 2]$],
  [D．$[-1, 3]$],
))

#sol[
  对 $A$：因式分解得 $x^2 - 2x - 3 = (x - 3)(x + 1) <= 0$，即 $x ∈ [-1, 3]$。

  对 $B$：由 $x^2 + y^2 = 4$ 知 $y$ 的取值范围为 $[-2, 2]$。

  于是 $A ∩ B = [-1, 3] ∩ [-2, 2] = [-1, 2]$。
]
#ans[$[-1, 2]$，选 #text(weight: "bold")[A]]

#fcap(
  scale: 1.0,
  caption: [第 2 题  $A = [-1, 3]$ 与 $B = [-2, 2]$ 取交得 $[-1, 2]$],
  {
    // 左: 圆, 带坐标轴与刻度
    let cx = -4.6
    dot((cx, 0.0), radius: 2.0, stroke: s(blue, th: 1.2pt))
    // 坐标轴
    ln((cx - 2.9, 0.0), (cx + 2.9, 0.0), stroke: s(black, th: 0.8pt))
    ln((cx, -2.6), (cx, 2.6), stroke: s(black, th: 0.8pt))
    txt((cx + 2.95, 0.0), anchor: "west", dx: 0.06, [$x$])
    txt((cx, 2.65), anchor: "south", [$y$])
    // 刻度 -3..3
    for k in range(-3, 4) {
      let xk = cx + k * 1.0
      ln((xk, -0.09), (xk, 0.09), stroke: s(black, th: 0.6pt))
      txt((xk, -0.13), anchor: "north", dy: -0.05, tsize: 0.14, [$#k$])
    }
    txt((cx, 2.28), anchor: "south", tsize: 0.16, [$x^2 + y^2 = 4$])
    // 上下端点
    pt((cx, 2.0), label: [$(0, 2)$], r: 0.05, fill: red, dx: 0.07, dy: 0.02, anchor: "west", tsize: 0.13)
    pt((cx, -2.0), label: [$(0, -2)$], r: 0.05, fill: red, dx: 0.07, dy: -0.02, anchor: "west", tsize: 0.13)

    // 右: 数轴 (两段区间)
    let nx = 1.6
    ln((nx - 2.6, 0.0), (nx + 3.2, 0.0), stroke: s(black, th: 0.8pt))
    txt((nx + 3.25, 0.0), anchor: "west", dx: 0.06, [$x$])

    // A = [-1, 3]
    ln((nx - 1.0, 0.5), (nx + 3.0, 0.5), stroke: s(red, th: 2.8pt))
    pt((nx - 1.0, 0.5), r: 0.06, fill: red)
    pt((nx + 3.0, 0.5), r: 0.06, fill: red)
    txt((nx + 1.0, 0.5), anchor: "south", dy: 0.1, [$A = [-1,\, 3]$])
    txt((nx - 1.0, 0.5), anchor: "north", dy: -0.07, tsize: 0.13, [$-1$])
    txt((nx + 3.0, 0.5), anchor: "north", dy: -0.07, tsize: 0.13, [$3$])

    // B = [-2, 2]
    ln((nx - 2.0, -0.45), (nx + 2.0, -0.45), stroke: s(green, th: 2.8pt))
    pt((nx - 2.0, -0.45), r: 0.06, fill: green)
    pt((nx + 2.0, -0.45), r: 0.06, fill: green)
    txt((nx, -0.45), anchor: "north", dy: -0.1, [$B = [-2,\, 2]$])
    txt((nx - 2.0, -0.45), anchor: "north", dy: -0.07, tsize: 0.13, [$-2$])
    txt((nx + 2.0, -0.45), anchor: "north", dy: -0.07, tsize: 0.13, [$2$])

    // A ∩ B = [-1, 2]
    ln((nx - 1.0, -1.4), (nx + 2.0, -1.4), stroke: s(purple, th: 2.8pt))
    pt((nx - 1.0, -1.4), r: 0.06, fill: purple)
    pt((nx + 2.0, -1.4), r: 0.06, fill: purple)
    txt((nx + 0.5, -1.4), anchor: "north", dy: -0.1, [$A ∩ B = [-1,\, 2]$])
    txt((nx - 1.0, -1.4), anchor: "north", dy: -0.07, tsize: 0.13, [$-1$])
    txt((nx + 2.0, -1.4), anchor: "north", dy: -0.07, tsize: 0.13, [$2$])
  },
)
