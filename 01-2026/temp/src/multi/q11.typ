// ---------------- 第 11 题 ----------------
#import "../_template.typ": *
#import "../_figs.typ": *

#qhead(11, pts: 6)
已知正方体 $A B C D - A_1 B_1 C_1 D_1$ 的棱长为 $1$，点 $P$ 在该正方体的内切球表面上运动，且 $B P parallel$ 平面 $A C D_1$，则（    ）

#opts(
  columns: 2,
  (
    [A．$B P ⊥ B_1 D$],
    [B．点 $P$ 的轨迹长度为 $π$],
    [C．$B P$ 长的最小值为 $sqrt(6) / 6$],
    [D．$arrow(B P) · arrow(B C_1)$ 的最小值为 $1 - sqrt(3) / 3$],
  ),
)

#sol[
  以点 $D$ 为原点，$D A$、$D C$、$D D_1$ 所在直线分别为 $x$ 轴、$y$ 轴、$z$ 轴建立空间直角坐标系。
  正方体各顶点坐标为：
  $D(0, 0, 0)$，$A(1, 0, 0)$，$B(1, 1, 0)$，$C(0, 1, 0)$，
  $D_1(0, 0, 1)$，$A_1(1, 0, 1)$，$B_1(1, 1, 1)$，$C_1(0, 1, 1)$。

  正方体内切球的球心为 $O(1/2, 1/2, 1/2)$，半径 $R = 1/2$。
  球面方程为 $(x - 1/2)^2 + (y - 1/2)^2 + (z - 1/2)^2 = 1/4$。

  对于平面 $A C D_1$：由 $A(1, 0, 0)$，$C(0, 1, 0)$，$D_1(0, 0, 1)$，其截距式方程为 $x + y + z = 1$。
  法向量为 $arrow(n) = (1, 1, 1)$。
  注意到 $arrow(B_1 D) = (0 - 1, 0 - 1, 0 - 1) = (-1, -1, -1) = -arrow(n)$，故体对角线 $B_1 D ⊥$ 平面 $A C D_1$。

  对于 A：因为 $B P parallel$ 平面 $A C D_1$，而 $B_1 D ⊥$ 平面 $A C D_1$，垂直于平面的垂线垂直于该平面的所有平行线，故必有 $B P ⊥ B_1 D$ 恒成立。故 A 正确。

  对于 B：过点 $B(1, 1, 0)$ 作平行于平面 $A C D_1$ 的平面 $alpha$。其法向量为 $arrow(n) = (1, 1, 1)$，平面方程为
  $ (x - 1) + (y - 1) + (z - 0) = 0 implies x + y + z = 2. $
  由于 $B P parallel$ 平面 $A C D_1$，直线 $B P$ 落在平面 $alpha$ 内，点 $P$ 又在内切球面上，故点 $P$ 的轨迹为平面 $alpha$ 截内切球面所得的截面圆。
  球心 $O(1/2, 1/2, 1/2)$ 到平面 $alpha$ 的距离为
  $ d = (|1/2 + 1/2 + 1/2 - 2|) / sqrt(1^2 + 1^2 + 1^2) = (1/2) / sqrt(3) = sqrt(3) / 6. $
  由于 $d = sqrt(3)/6 < 1/2 = R$，该截面圆的半径为
  $ r = sqrt(R^2 - d^2) = sqrt((1/2)^2 - (sqrt(3)/6)^2) = sqrt(1/4 - 1/12) = sqrt(1/6) = sqrt(6) / 6. $
  截面圆完整位于正方体内切球面上，故点 $P$ 的轨迹长度即为截面圆周长：
  $ L = 2 π r = 2 π · sqrt(6) / 6 = (sqrt(6) π) / 3 != π, $
  故 B 错误。

  对于 C：截面圆圆心 $O'$ 即为球心 $O$ 在平面 $alpha$ 上的正投影。
  $ O' = (1/2, 1/2, 1/2) + d · arrow(n) / (|arrow(n)|) = (1/2, 1/2, 1/2) + 1/(2 sqrt(3)) · (1, 1, 1)/sqrt(3) = (2/3, 2/3, 2/3). $
  点 $B(1, 1, 0)$ 位于平面 $alpha$ 内，其到圆心 $O'$ 的距离为
  $ |B O'| = sqrt((1 - 2/3)^2 + (1 - 2/3)^2 + (0 - 2/3)^2) = sqrt(1/9 + 1/9 + 4/9) = sqrt(6) / 3. $
  点 $P$ 在平面 $alpha$ 内以 $O'$ 为圆心、半径 $r = sqrt(6)/6$ 的轨迹圆上运动，因此 $B P$ 长的最小值为
  $ |B P|_min = |B O'| - r = sqrt(6) / 3 - sqrt(6) / 6 = sqrt(6) / 6, $
  故 C 正确。

  对于 D：$B(1, 1, 0)$，$C_1(0, 1, 1)$，向量 $arrow(B C_1) = (-1, 0, 1)$。
  注意到 $arrow(B C_1) · arrow(n) = (-1) times 1 + 0 times 1 + 1 times 1 = 0$，说明向量 $arrow(B C_1)$ 平行于平面 $alpha$。其模长 $|arrow(B C_1)| = sqrt((-1)^2 + 0^2 + 1^2) = sqrt(2)$。
  由向量线性性质与三角形法则，$arrow(B P) = arrow(B O') + arrow(O' P)$，于是
  $ arrow(B P) · arrow(B C_1) = arrow(B O') · arrow(B C_1) + arrow(O' P) · arrow(B C_1). $
  其中 $arrow(B O') = (2/3 - 1, 2/3 - 1, 2/3 - 0) = (-1/3, -1/3, 2/3)$，
  $ arrow(B O') · arrow(B C_1) = (-1/3) times (-1) + (-1/3) times 0 + (2/3) times 1 = 1/3 + 2/3 = 1. $
  而向量 $arrow(O' P)$ 是平面 $alpha$ 内模长恒为 $r = sqrt(6)/6$ 的任意方向向量。当 $arrow(O' P)$ 与 $arrow(B C_1)$ 反向时点积取得最小值：
  $ (arrow(O' P) · arrow(B C_1))_min = -r |arrow(B C_1)| = -sqrt(6)/6 · sqrt(2) = -sqrt(12)/6 = -sqrt(3) / 3. $
  因此 $arrow(B P) · arrow(B C_1)$ 的最小值为 $1 - sqrt(3) / 3$。故 D 正确。
]
#ans[选 #text(weight: "bold")[ACD]]

#fcap(
  scale: 0.85,
  caption: [第 11 题  左：正方体轴测投影与内切球截面平面 $alpha$（平行于 $A C D_1$）；右：截面 $alpha$ 内几何解析],
  {
    // ============ 左图：正方体 3D 轴测透视 ============
    let S = 2.4
    // 偏移量以把左图放在左侧
    let ox = -3.8
    let oy = 0.0

    // 辅助轴测投影函数
    let p3(vx, vy, vz) = (ox + vx - 0.42 * vz, oy + vy + 0.42 * vz)

    let d_pt = p3(0.0, 0.0, 0.0)
    let a_pt = p3(S, 0.0, 0.0)
    let c_pt = p3(0.0, 0.0, S)
    let b_pt = p3(S, 0.0, S)

    let d1_pt = p3(0.0, S, 0.0)
    let a1_pt = p3(S, S, 0.0)
    let c1_pt = p3(0.0, S, S)
    let b1_pt = p3(S, S, S)

    // 球心与截面圆心
    let o_3d = p3(S / 2.0, S / 2.0, S / 2.0)
    let op_3d = p3(2.0 * S / 3.0, 2.0 * S / 3.0, 2.0 * S / 3.0)

    // 正方体后方不可见棱（虚线）
    dashed(d_pt, a_pt)
    dashed(d_pt, c_pt)
    dashed(d_pt, d1_pt)

    // 正方体可见外轮廓棱（实线）
    ln(a_pt, b_pt, stroke: s(black, th: 0.9pt))
    ln(c_pt, b_pt, stroke: s(black, th: 0.9pt))
    ln(a_pt, a1_pt, stroke: s(black, th: 0.9pt))
    ln(b_pt, b1_pt, stroke: s(black, th: 0.9pt))
    ln(c_pt, c1_pt, stroke: s(black, th: 0.9pt))
    ln(d1_pt, a1_pt, stroke: s(black, th: 0.9pt))
    ln(a1_pt, b1_pt, stroke: s(black, th: 0.9pt))
    ln(b1_pt, c1_pt, stroke: s(black, th: 0.9pt))
    ln(c1_pt, d1_pt, stroke: s(black, th: 0.9pt))

    // 平面 A C D_1 三角形
    ln(a_pt, c_pt, stroke: sd(blue, th: 0.8pt))
    ln(c_pt, d1_pt, stroke: sd(blue, th: 0.8pt))
    ln(d1_pt, a_pt, stroke: sd(blue, th: 0.8pt))

    // 平面 alpha: 三角形 B A_1 C_1
    ln(b_pt, a1_pt, stroke: s(green, th: 1.1pt))
    ln(a1_pt, c1_pt, stroke: s(green, th: 1.1pt))
    ln(c1_pt, b_pt, stroke: s(green, th: 1.1pt))

    // 体对角线 B_1 D
    dashed(d_pt, b1_pt, color: red, th: 0.9pt)

    // 顶点标记
    pt(a_pt, label: [$A$], r: 0.045, fill: black, dx: 0.08, dy: -0.06, anchor: "north-west")
    pt(b_pt, label: [$B$], r: 0.05, fill: red, dx: 0.08, dy: -0.04, anchor: "west")
    pt(c_pt, label: [$C$], r: 0.045, fill: black, dx: -0.08, dy: -0.04, anchor: "east")
    pt(d_pt, label: [$D$], r: 0.04, fill: gray, dx: -0.08, dy: -0.06, anchor: "north-east")
    pt(d1_pt, label: [$D_1$], r: 0.045, fill: black, dx: -0.08, dy: 0.06, anchor: "south-east")
    pt(a1_pt, label: [$A_1$], r: 0.045, fill: black, dx: 0.08, dy: 0.06, anchor: "south-west")
    pt(b1_pt, label: [$B_1$], r: 0.05, fill: black, dx: 0.08, dy: 0.06, anchor: "south-west")
    pt(c1_pt, label: [$C_1$], r: 0.045, fill: black, dx: -0.08, dy: 0.06, anchor: "south-east")

    // 圆心 O'
    pt(op_3d, label: [$O'$], r: 0.045, fill: purple, dx: 0.06, dy: 0.06, anchor: "south-west")
    txt((ox + 0.6, oy + 3.8), anchor: "center", tsize: 0.13, text(fill: green)[截面 $alpha: B A_1 C_1$])
    txt((ox - 0.4, oy + 1.6), anchor: "center", tsize: 0.13, text(fill: blue)[平面 $A C D_1$])

    // 分隔虚线
    dashed((0.8, -0.6), (0.8, 4.4), color: faint, th: 0.8pt)

    // ============ 右图：截面 alpha 内几何解析 ============
    let rx = 3.8
    let ry = 1.8
    let r_geom = 1.25
    let b_rx = rx - 2.5 * r_geom
    let b_ry = ry

    // 轨迹圆（圆心 O'(rx, ry)，半径 r_geom）
    dot((rx, ry), radius: r_geom, stroke: s(purple, th: 1.2pt), fill: rgb("#f6effa"))
    pt((rx, ry), label: [$O'$], r: 0.05, fill: purple, dx: 0.06, dy: 0.06, anchor: "south-west")

    // 点 B
    pt((b_rx, b_ry), label: [$B$], r: 0.06, fill: red, dx: -0.08, dy: 0.0, anchor: "east")

    // 线段 B O'
    ln((b_rx, b_ry), (rx, ry), stroke: s(black, th: 0.8pt))
    let p_min = (rx - r_geom, ry)
    pt(p_min, label: [$P_0$], r: 0.05, fill: red, dx: 0.0, dy: 0.12, anchor: "south")

    // 标示 |B P|_min
    ln((b_rx, b_ry - 0.4), (p_min.at(0), b_ry - 0.4), stroke: s(gray, th: 0.6pt))
    ln((b_rx, b_ry - 0.3), (b_rx, b_ry - 0.5), stroke: s(gray, th: 0.6pt))
    ln((p_min.at(0), b_ry - 0.3), (p_min.at(0), b_ry - 0.5), stroke: s(gray, th: 0.6pt))
    txt(((b_rx + p_min.at(0)) / 2.0, b_ry - 0.6), anchor: "north", tsize: 0.135, [$|B P|_min = sqrt(6)/6$])

    // 向量 BC_1 方向
    let dir_bc1 = (1.0, 0.0)
    ln((b_rx, b_ry + 1.25), (b_rx + 2.2, b_ry + 1.25), stroke: s(blue, th: 1.2pt))
    txt((b_rx + 1.1, b_ry + 1.4), anchor: "south", tsize: 0.135, text(fill: blue)[$arrow(B C_1)$ 方向])

    // 动点 P 示例（取反方向点 P_dot，点积取得最小）
    let p_dot = (rx - r_geom, ry)
    ln((rx, ry), (rx - r_geom, ry), stroke: s(red, th: 1.3pt))
    txt((rx - r_geom / 2.0, ry + 0.1), anchor: "south", tsize: 0.13, text(fill: red)[$arrow(O' P)$])

    txt((rx, ry + r_geom + 0.35), anchor: "south", tsize: 0.14, text(fill: purple)[轨迹圆 $r = sqrt(6)/6$])
    txt((rx, ry - r_geom - 0.35), anchor: "north", tsize: 0.13, text(fill: black)[$|B O'| = sqrt(6)/3$])
  },
)
