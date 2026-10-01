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

#fcap(
  scale: 0.78,
  caption: [第 11 题  左：正方体标准轴测透视与截面平面 $B A_1 C_1$（平行于 $A C D_1$）；右：截面平面 $B A_1 C_1$ 内轨迹几何解析],
  {
    // 左右两栏标题（两边外移）
    txt((-4.6, 7.5), anchor: "south", tsize: 0.25, text(weight: "bold", fill: blue)[【正方体轴测透视与截面】])
    txt((5.6, 7.5), anchor: "south", tsize: 0.25, text(weight: "bold", fill: purple)[【截面 $B A_1 C_1$ 内轨迹几何解析】])

    // 中间分隔线：改为灰色实线，留出两侧间距增强视觉分割感
    ln((0.0, -0.1), (0.0, 7.6), stroke: s(rgb("#c0c0c0"), th: 1.0pt))

    // ============ 左图：正方体标准轴测透视（放大约 1.1x，原点左移避开分割线） ============
    // 原点 D 在后左下方；底面 ABCD 前左 A、前右 B、后右 C、后左 D；顶面对应 A1 B1 C1 D1
    let L = 3.95    // 水平棱长 (放大)
    let H = 3.95    // 垂直棱长 (放大)
    let dx = 1.48   // x轴倾斜水平分量（指向前左）
    let dy = 1.26   // x轴倾斜垂直分量（指向前左）
    let bx = -5.4   // 原点 D 坐标 (左移，与中间分割线拉开距离)
    let by = 1.7

    // 顶点映射：p(x, y, z) 其中 x沿DA(前左), y沿DC(向右), z沿DD1(向上)
    let p3(vx, vy, vz) = (
      bx - vx * dx + vy * L,
      by - vx * dy + vz * H,
    )

    let d_pt = p3(0.0, 0.0, 0.0)      // D (0, 0, 0) 原点
    let a_pt = p3(1.0, 0.0, 0.0)      // A (1, 0, 0) 前左下
    let b_pt = p3(1.0, 1.0, 0.0)      // B (1, 1, 0) 前右下
    let c_pt = p3(0.0, 1.0, 0.0)      // C (0, 1, 0) 后右下

    let d1_pt = p3(0.0, 0.0, 1.0)     // D1 (0, 0, 1) 后左上
    let a1_pt = p3(1.0, 0.0, 1.0)     // A1 (1, 0, 1) 前左上
    let b1_pt = p3(1.0, 1.0, 1.0)     // B1 (1, 1, 1) 前右上
    let c1_pt = p3(0.0, 1.0, 1.0)     // C1 (0, 1, 1) 后右上

    // 球心 O(1/2, 1/2, 1/2) 与截面圆心 O'(2/3, 2/3, 2/3)
    let o_3d = p3(0.5, 0.5, 0.5)
    let op_3d = p3(2.0 / 3.0, 2.0 / 3.0, 2.0 / 3.0)

    // 正方体后方不可见棱（虚线：交于 D 的三条棱 DA, DC, DD1）
    dashed(d_pt, a_pt, color: gray, th: 0.9pt)
    dashed(d_pt, c_pt, color: gray, th: 0.9pt)
    dashed(d_pt, d1_pt, color: gray, th: 0.9pt)

    // 正方体前方可见棱（实线）
    ln(a_pt, b_pt, stroke: s(black, th: 1.1pt))
    ln(b_pt, c_pt, stroke: s(black, th: 1.1pt))
    ln(a_pt, a1_pt, stroke: s(black, th: 1.1pt))
    ln(b_pt, b1_pt, stroke: s(black, th: 1.1pt))
    ln(c_pt, c1_pt, stroke: s(black, th: 1.1pt))
    ln(d1_pt, a1_pt, stroke: s(black, th: 1.1pt))
    ln(a1_pt, b1_pt, stroke: s(black, th: 1.1pt))
    ln(b1_pt, c1_pt, stroke: s(black, th: 1.1pt))
    ln(c1_pt, d1_pt, stroke: s(black, th: 1.1pt))

    // 坐标轴向外延伸箭头线（标准高中直角坐标系）
    let x_end = (a_pt.at(0) - 0.7 * dx, a_pt.at(1) - 0.7 * dy)
    ln(a_pt, x_end, stroke: s(black, th: 0.9pt), mark: (end: ">", fill: black))
    txt((x_end.at(0) - 0.12, x_end.at(1) - 0.08), anchor: "north-east", tsize: 0.22, text(weight: "bold")[$x$])

    let y_end = (c_pt.at(0) + 0.8, c_pt.at(1))
    ln(c_pt, y_end, stroke: s(black, th: 0.9pt), mark: (end: ">", fill: black))
    txt((y_end.at(0) + 0.12, y_end.at(1)), anchor: "west", tsize: 0.22, text(weight: "bold")[$y$])

    let z_end = (d1_pt.at(0), d1_pt.at(1) + 0.85)
    ln(d1_pt, z_end, stroke: s(black, th: 0.9pt), mark: (end: ">", fill: black))
    txt((z_end.at(0), z_end.at(1) + 0.15), anchor: "south", tsize: 0.22, text(weight: "bold")[$z$])

    // 平面 A C D_1 三角形（蓝色虚线，位于内部）
    ln(a_pt, c_pt, stroke: sd(blue, th: 1.0pt))
    ln(c_pt, d1_pt, stroke: sd(blue, th: 1.0pt))
    ln(d1_pt, a_pt, stroke: sd(blue, th: 1.0pt))

    // 平面 alpha: 三角形 B A_1 C_1（绿色半透明高亮，三边均在外露面上）
    ln(b_pt, a1_pt, c1_pt, close: true, fill: rgb(26, 122, 77, 14%), stroke: s(green, th: 1.5pt))

    // 体对角线 B_1 D（红色虚线，穿过球心与截面圆心）
    dashed(d_pt, b1_pt, color: red, th: 1.2pt)

    // 球心与圆心
    pt(o_3d, label: [$O$], r: 0.065, fill: orange, dx: -0.12, dy: 0.08, anchor: "south-east", tsize: 0.20)
    pt(op_3d, label: [$O'$], r: 0.07, fill: purple, dx: 0.10, dy: -0.10, anchor: "north-west", tsize: 0.21)

    // 顶点标记（清晰避让）
    pt(a_pt, label: [$A$], r: 0.065, fill: black, dx: -0.14, dy: -0.06, anchor: "north-east", tsize: 0.23)
    pt(b_pt, label: [$B$], r: 0.08, fill: red, dx: 0.14, dy: -0.06, anchor: "north-west", tsize: 0.25)
    // C 的 label 放到点的右上角，防止被线条挡住
    pt(c_pt, label: [$C$], r: 0.065, fill: black, dx: 0.14, dy: 0.12, anchor: "south-west", tsize: 0.23)
    pt(d_pt, label: [$D$], r: 0.06, fill: gray, dx: -0.14, dy: 0.12, anchor: "south-east", tsize: 0.22)

    pt(d1_pt, label: [$D_1$], r: 0.065, fill: black, dx: -0.14, dy: 0.08, anchor: "south-east", tsize: 0.23)
    pt(a1_pt, label: [$A_1$], r: 0.065, fill: black, dx: -0.14, dy: 0.04, anchor: "east", tsize: 0.23)
    // B1 的 label 放到点的上方
    pt(b1_pt, label: [$B_1$], r: 0.07, fill: black, dx: 0.0, dy: 0.14, anchor: "south", tsize: 0.24)
    pt(c1_pt, label: [$C_1$], r: 0.065, fill: black, dx: 0.14, dy: 0.08, anchor: "south-west", tsize: 0.23)

    // 截面与对角线文字注释
    txt((bx + 1.3, by + 5.3), anchor: "center", tsize: 0.20, text(fill: green, weight: "bold")[截面平面 $B A_1 C_1$])
    txt((bx + 0.3, by + 1.2), anchor: "center", tsize: 0.19, text(fill: blue, weight: "bold")[平面 $A C D_1$])
    txt((bx + 1.3, 0.0), anchor: "north", tsize: 0.18, text(fill: red, weight: "bold")[体对角线 $B_1 D ⊥$ 平面 $B A_1 C_1$])

    // ============ 右图：截面 BA1C1 内几何解析（放大并右移，留足中间距） ============
    let rx = 5.7
    let ry = 3.6
    let r_geom = 2.4    // 放大轨迹圆
    let b_rx = rx - 2.0 * r_geom
    let b_ry = ry

    // 轨迹圆（圆心 O'(rx, ry)，半径 r_geom）
    dot((rx, ry), radius: r_geom, stroke: s(purple, th: 1.5pt), fill: rgb("#f6effa"))
    pt((rx, ry), label: [$O'$], r: 0.075, fill: purple, dx: 0.10, dy: 0.10, anchor: "south-west", tsize: 0.23)

    // 点 B (离中间线距离达 0.9)
    pt((b_rx, b_ry), label: [$B$], r: 0.085, fill: red, dx: -0.14, dy: 0.0, anchor: "east", tsize: 0.24)

    // 线段 B O'
    ln((b_rx, b_ry), (rx, ry), stroke: s(black, th: 1.0pt))
    let p_min = (rx - r_geom, ry)
    pt(p_min, label: [$P_0$], r: 0.08, fill: red, dx: -0.12, dy: 0.16, anchor: "south-east", tsize: 0.23)

    // 标示 |B P|_min
    dashed((b_rx, b_ry), (b_rx, 2.2), color: gray, th: 0.6pt)
    dashed((p_min.at(0), b_ry), (p_min.at(0), 2.2), color: gray, th: 0.6pt)
    ln((b_rx, 2.35), (p_min.at(0), 2.35), stroke: s(black, th: 0.8pt))
    ln((b_rx, 2.23), (b_rx, 2.47), stroke: s(black, th: 0.8pt))
    ln((p_min.at(0), 2.23), (p_min.at(0), 2.47), stroke: s(black, th: 0.8pt))
    txt(((b_rx + p_min.at(0)) / 2.0, 2.05), anchor: "north", tsize: 0.20, [$|B P|_min = sqrt(6)/6$])

    // 标示 |B O'|（位于圆正下方，完全避开圆）
    dashed((b_rx, 2.2), (b_rx, 0.3), color: gray, th: 0.6pt)
    dashed((rx, ry - r_geom), (rx, 0.3), color: gray, th: 0.6pt)
    ln((b_rx, 0.4), (rx, 0.4), stroke: s(black, th: 0.8pt))
    ln((b_rx, 0.28), (b_rx, 0.52), stroke: s(black, th: 0.8pt))
    ln((rx, 0.28), (rx, 0.52), stroke: s(black, th: 0.8pt))
    txt(((b_rx + rx) / 2.0, 0.12), anchor: "north", tsize: 0.21, [$|B O'| = sqrt(6)/3$])

    // 向量 BC_1 方向（左上角基准向量）
    ln((1.5, 6.3), (4.2, 6.3), stroke: s(blue, th: 1.5pt), mark: (end: ">", fill: blue))
    txt((2.85, 6.55), anchor: "south", tsize: 0.20, text(fill: blue, weight: "bold")[$arrow(B C_1)$ 方向])

    // 动点 P 示例（取反方向点 P_0，点积取得最小）
    ln((rx, ry), (p_min.at(0), p_min.at(1)), stroke: s(red, th: 1.6pt), mark: (end: ">", fill: red))
    txt((4.2, ry + 0.18), anchor: "south", tsize: 0.20, text(fill: red, weight: "bold")[$arrow(O' P)$ 反向])
    txt((4.2, ry - 0.20), anchor: "north", tsize: 0.18, text(fill: red)[点积 $arrow(O' P) · arrow(B C_1)$ 取极小])

    // 轨迹圆标题（右上角避开向量与顶部标题）
    txt((6.0, 6.35), anchor: "south-west", tsize: 0.21, text(fill: purple, weight: "bold")[轨迹圆 $r = sqrt(6)/6$])
  },
)

#sol[
  以点 $D$ 为原点，$D A$、$D C$、$D D_1$ 所在直线分别为 $x$ 轴、$y$ 轴、$z$ 轴建立空间直角坐标系。
  正方体各顶点坐标为：
  $D(0, 0, 0)$，$A(1, 0, 0)$，$B(1, 1, 0)$，$C(0, 1, 0)$，
  $D_1(0, 0, 1)$，$A_1(1, 0, 1)$，$B_1(1, 1, 1)$，$C_1(0, 1, 1)$。

  正方体内切球的球心为 $O(1/2, 1/2, 1/2)$，半径 $R = 1/2$。
  球面方程为 $(x - 1/2)^2 + (y - 1/2)^2 + (z - 1/2)^2 = 1/4$。

  对于平面 $A C D_1$ #text(fill: blue)[（图中的蓝色虚线三角形平面）]：由 $A(1, 0, 0)$，$C(0, 1, 0)$，$D_1(0, 0, 1)$，其截距式方程为 $x + y + z = 1$。
  法向量为 $arrow(n) = (1, 1, 1)$。
  注意到 $arrow(B_1 D) = (0 - 1, 0 - 1, 0 - 1) = (-1, -1, -1) = -arrow(n)$，故体对角线 $B_1 D ⊥$ 平面 $A C D_1$。

  对于 A：因为 $B P parallel$ 平面 $A C D_1$，而 $B_1 D ⊥$ 平面 $A C D_1$，垂直于平面的垂线垂直于该平面的所有平行线，故必有 $B P ⊥ B_1 D$ 恒成立。故 A 正确。

  对于 B：经过点 $B$ 且平行于平面 $A C D_1$ 的平面，显然是平面 $B A_1 C_1$ #text(fill: green)[（图中的绿色边三角形平面）]（因 $B A_1 parallel C D_1$，$B C_1 parallel A D_1$）。

  #v(1.5pt)
  #rect(
    fill: rgb("#f4f8fd"),
    stroke: rgb("#4a90e2") + 0.8pt,
    radius: 4pt,
    inset: (x: 9pt, y: 5.5pt),
    width: 100%,
  )[
    #text(weight: "bold", fill: rgb("#1a4d8f"), size: 9.5pt)[💡 解析几何核心公式：平面的方程与点面距离] \
    #v(2pt)
    #text(size: 9pt)[
      *1. 平面的一般式方程*：空间中任意平面均可表示为 $A x + B y + C z + D = 0$（其法向量为 $arrow(n) = (A, B, C)$）。 \
      *2. 点法式展开得到一般式*：已知平面过点 $P_0(x_0, y_0, z_0)$，法向量为 $arrow(n) = (A, B, C)$，则点法式方程为
      $ A(x - x_0) + B(y - y_0) + C(z - z_0) = 0, $
      去括号展开整理即得一般式：$A x + B y + C z + D = 0$（其中常数项 $D = -(A x_0 + B y_0 + C z_0)$）。 \
      *3. 点到平面的距离公式*：空间任意一点 $P_0(x_0, y_0, z_0)$ 到平面 $A x + B y + C z + D = 0$ 的距离为
      $ d = frac(|A x_0 + B y_0 + C z_0 + D|, sqrt(A^2 + B^2 + C^2)) $
      #text(size: 8pt, fill: rgb("#666666"))[（注：分子为将点坐标代入平面一般式左端的绝对值，分母为法向量的模长）]
    ]
  ]
  #v(2pt)

  平面 $B A_1 C_1$ 过点 $B(1, 1, 0)$，法向量为 $arrow(n) = (1, 1, 1)$。由点法式方程展开整理为一般式方程：
  $ 1 times (x - 1) + 1 times (y - 1) + 1 times (z - 0) = 0 quad ==> quad x + y + z - 2 = 0 quad (text("一般式")). $
  由于 $B P parallel$ 平面 $A C D_1$，直线 $B P$ 落在平面 $B A_1 C_1$ 内，点 $P$ 又在内切球面上，故点 $P$ 的轨迹为平面 $B A_1 C_1$ 截内切球面所得的截面圆。

  #v(2pt)
  #grid(
    columns: (195pt, 1fr),
    gutter: 14pt,
    align: (center + horizon, left + horizon),
    [
      #cv(scale: 0.73, {
        let R = 1.95
        let d_coord = 0.57735 * R
        let r_coord = 0.81650 * R

        // 球的大圆截面（侧视轮廓圆）
        dot((0.0, 0.0), radius: R, stroke: s(black, th: 1.1pt), fill: rgb("#fafcff"))

        // 球心水平基准面
        ln((-R - 0.4, 0.0), (R + 0.4, 0.0), stroke: s(black, th: 0.85pt))
        txt((R + 0.5, 0.0), anchor: "west", tsize: 0.28, text(fill: gray)[球心基准面])

        // 直角三角形 OO'P 浅绿高亮填充
        ln((0.0, 0.0), (0.0, d_coord), (r_coord, d_coord), close: true, fill: rgb(26, 122, 77, 14%), stroke: none)

        // 截面平面割线 (侧视投影，绿色实线向两端延伸)
        ln((-R - 0.4, d_coord), (R + 0.4, d_coord), stroke: s(green, th: 1.3pt))
        txt((R + 0.5, d_coord), anchor: "west", tsize: 0.28, text(fill: green, weight: "bold")[截面平面 $B A_1 C_1$])

        // 垂线段 OO' (球心到平面距离 d)
        ln((0.0, 0.0), (0.0, d_coord), stroke: s(black, th: 1.0pt))

        // 直角符号 (红色)
        let w = 0.24
        ln((0.0, d_coord - w), (w, d_coord - w), (w, d_coord), stroke: s(red, th: 0.85pt))

        // 球半径 OP (斜边 R，红色)
        ln((0.0, 0.0), (r_coord, d_coord), stroke: s(red, th: 1.3pt))

        // 截面圆半径 O'P (紫色)
        ln((0.0, d_coord), (r_coord, d_coord), stroke: s(purple, th: 1.3pt))

        // 关键点
        pt((0.0, 0.0), label: [$O$], r: 0.06, fill: black, dx: -0.12, dy: -0.14, anchor: "north-east", tsize: 0.30)
        pt((0.0, d_coord), label: [$O'$], r: 0.06, fill: purple, dx: -0.12, dy: 0.14, anchor: "south-east", tsize: 0.30)
        pt((r_coord, d_coord), label: [$P$], r: 0.06, fill: red, dx: 0.12, dy: 0.12, anchor: "south-west", tsize: 0.30)

        // 尺寸与参数标注 (字体放大，与手绘图风格高度一致)
        txt((-0.20, d_coord / 2.0), anchor: "east", tsize: 0.34, text(fill: red, weight: "bold")[$d = frac(sqrt(3), 6)$])
        txt((r_coord / 2.0 + 0.18, d_coord / 2.0 - 0.14), anchor: "north-west", tsize: 0.34, text(fill: red, weight: "bold")[$R = frac(1, 2)$])
        txt((r_coord / 2.0, d_coord + 0.18), anchor: "south", tsize: 0.34, text(fill: purple, weight: "bold")[$r = frac(sqrt(6), 6)$])
      })
      #v(2pt)
      #text(size: 8.5pt, fill: rgb("#666666"))[相机平行于截面的侧视正投影]
    ],
    [
      由点到平面的距离公式，球心 $O(1/2, 1/2, 1/2)$ 到平面 $B A_1 C_1$ 的距离为
      $ d = (|1/2 + 1/2 + 1/2 - 2|) / sqrt(1^2 + 1^2 + 1^2) = (1/2) / sqrt(3) = sqrt(3) / 6. $
      由于 $d = sqrt(3)/6 < 1/2 = R$，由左侧直角三角形 $O O' P$（勾股定理）得截面圆半径为
      $ r = sqrt(R^2 - d^2) = sqrt((1/2)^2 - (sqrt(3)/6)^2) = sqrt(6) / 6. $
      截面圆完整位于球面上，点 $P$ 轨迹长度为周长：
      $ L = 2 π r = 2 π · sqrt(6) / 6 = (sqrt(6) π) / 3 != π, $
      故 B 错误。
    ],
  )
  #v(2pt)

  对于 C：截面圆圆心 $O'$ 即为球心 $O$ 在平面 $B A_1 C_1$ 上的正投影：
  $ O' = (1/2, 1/2, 1/2) + d · arrow(n) / (|arrow(n)|) = (1/2, 1/2, 1/2) + 1/(2 sqrt(3)) · (1, 1, 1)/sqrt(3) = (2/3, 2/3, 2/3). $
  点 $B(1, 1, 0)$ 位于平面 $B A_1 C_1$ 内，到圆心距离为 $|B O'| = sqrt((1 - 2/3)^2 + (1 - 2/3)^2 + (0 - 2/3)^2) = sqrt(6) / 3$。
  点 $P$ 在平面 $B A_1 C_1$ 内以 $O'$ 为圆心、半径 $r = sqrt(6)/6$ 的轨迹圆上运动，因此 $B P$ 长的最小值为
  $ |B P|_min = |B O'| - r = sqrt(6) / 3 - sqrt(6) / 6 = sqrt(6) / 6, $
  故 C 正确。

  对于 D：$B(1, 1, 0)$，$C_1(0, 1, 1)$，向量 $arrow(B C_1) = (-1, 0, 1)$，模长 $|arrow(B C_1)| = sqrt((-1)^2 + 0^2 + 1^2) = sqrt(2)$。
  由向量分解 $arrow(B P) = arrow(B O') + arrow(O' P)$，得 $arrow(B P) · arrow(B C_1) = arrow(B O') · arrow(B C_1) + arrow(O' P) · arrow(B C_1)$。
  其中 $arrow(B O') = (-1/3, -1/3, 2/3)$，常数项点积为 $arrow(B O') · arrow(B C_1) = (-1/3) times (-1) + (-1/3) times 0 + (2/3) times 1 = 1$。
  而向量 $arrow(O' P)$ 是平面 $B A_1 C_1$ 内模长恒为 $r = sqrt(6)/6$ 的任意方向向量。当 $arrow(O' P)$ 与 $arrow(B C_1)$ 反向时点积取得最小值：
  $ (arrow(O' P) · arrow(B C_1))_min = -r |arrow(B C_1)| = -sqrt(6)/6 · sqrt(2) = -sqrt(12)/6 = -sqrt(3) / 3. $
  因此 $arrow(B P) · arrow(B C_1)$ 的最小值为 $1 - sqrt(3) / 3$。故 D 正确。
]
#ans[选 #text(weight: "bold")[ACD]]
