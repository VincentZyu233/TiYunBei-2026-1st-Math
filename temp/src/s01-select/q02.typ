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
    txt((cx + 2.95, 0.0), anchor: "west", dx: 0.06, tsize: 0.28, [$x$])
    txt((cx, 2.65), anchor: "south", tsize: 0.28, [$y$])
    // 刻度 -3..3。圆半径 2 而半轴长 2.9, 故刻度数字标在轴【上方】
    // 且紧贴圆外侧, 否则会落进圆内与圆周重叠。
    for k in range(-3, 4) {
      let xk = cx + k * 1.0
      ln((xk, 0.09), (xk, 0.22), stroke: s(black, th: 0.6pt))
      // 圆内的刻度 (±2 以内) 用小字标在圆内上方, 圆外的用大字
      let inside = calc.abs(k) <= 1
      txt(
        (xk, 0.24),
        anchor: "south",
        dy: 0.03,
        tsize: if inside { 0.22 } else { 0.26 },
        [$#k$],
      )
    }
    // 圆方程标注移到圆上方远处, 避开 (0,±2) 端点标签
    txt((cx, 2.95), anchor: "south", dy: 0.06, tsize: 0.28, [$x^2 + y^2 = 4$])
    // 上下端点 (标在圆右侧空白处, 避开圆方程与圆周)
    pt((cx, 2.0), label: [$(0, 2)$], r: 0.055, fill: red, dx: 0.1, dy: -0.02, anchor: "south-west", tsize: 0.27)
    pt((cx, -2.0), label: [$(0, -2)$], r: 0.055, fill: red, dx: 0.1, dy: 0.02, anchor: "north-west", tsize: 0.27)

    // 右: 数轴 (三段区间)。标签字号放大后需拉开纵向间距, 避免互相挤压。
    let nx = 1.6
    ln((nx - 2.6, 0.0), (nx + 3.2, 0.0), stroke: s(black, th: 0.8pt))
    txt((nx + 3.25, 0.0), anchor: "west", dx: 0.06, tsize: 0.28, [$x$])

    // A = [-1, 3]
    ln((nx - 1.0, 0.9), (nx + 3.0, 0.9), stroke: s(red, th: 2.8pt))
    pt((nx - 1.0, 0.9), r: 0.065, fill: red)
    pt((nx + 3.0, 0.9), r: 0.065, fill: red)
    txt((nx + 1.0, 0.9), anchor: "south", dy: 0.12, tsize: 0.28, [$A = [-1, 3]$])
    txt((nx - 1.0, 0.9), anchor: "north", dy: -0.09, tsize: 0.26, [$-1$])
    txt((nx + 3.0, 0.9), anchor: "north", dy: -0.09, tsize: 0.26, [$3$])

    // B = [-2, 2]
    ln((nx - 2.0, -0.5), (nx + 2.0, -0.5), stroke: s(green, th: 2.8pt))
    pt((nx - 2.0, -0.5), r: 0.065, fill: green)
    pt((nx + 2.0, -0.5), r: 0.065, fill: green)
    txt((nx, -0.5), anchor: "north", dy: -0.12, tsize: 0.28, [$B = [-2, 2]$])
    txt((nx - 2.0, -0.5), anchor: "north", dy: -0.09, tsize: 0.26, [$-2$])
    txt((nx + 2.0, -0.5), anchor: "north", dy: -0.09, tsize: 0.26, [$2$])

    // A ∩ B = [-1, 2]
    ln((nx - 1.0, -1.9), (nx + 2.0, -1.9), stroke: s(purple, th: 2.8pt))
    pt((nx - 1.0, -1.9), r: 0.065, fill: purple)
    pt((nx + 2.0, -1.9), r: 0.065, fill: purple)
    txt((nx + 0.5, -1.9), anchor: "north", dy: -0.12, tsize: 0.28, [$A ∩ B = [-1, 2]$])
    txt((nx - 1.0, -1.9), anchor: "north", dy: -0.09, tsize: 0.26, [$-1$])
    txt((nx + 2.0, -1.9), anchor: "north", dy: -0.09, tsize: 0.26, [$2$])
  },
)
