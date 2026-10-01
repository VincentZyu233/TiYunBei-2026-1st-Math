// ---------------- 第 15 题 ----------------
#import "../_template.typ": *
#import "../_figs.typ": *

#qhead(15, pts: 13)
在 $triangle A B C$ 中，角 $A, B, C$ 所对的边分别为 $a, b, c$，已知 $b^2 + a^2 - c^2 = a b$。 \
（1）求角 $C$； \
（2）点 $D$ 在边 $A C$ 上，$A D = D B$，$a = sqrt(10)$，$c = 2 sqrt(3)$，求 $A D$ 的长度。

#sol[
  *（1）求角 $C$。*

  由余弦定理可知：
  $ cos C = frac(a^2 + b^2 - c^2, 2 a b). $
  将已知条件 $b^2 + a^2 - c^2 = a b$ 代入上式，得：
  $ cos C = frac(a b, 2 a b) = frac(1, 2). $
  因为在 $triangle A B C$ 中，$C in (0, pi)$，所以
  $ C = frac(pi, 3). $

  *（2）求 $A D$ 的长度。*

  在 $triangle A B D$ 中，因为 $A D = D B$，所以 $triangle A B D$ 为以 $D$ 为顶点的等腰三角形。 \
  取线段 $A B$ 的中点记为 $M$，连接 $D M$，根据等腰三角形三线合一性质，$D M perp A B$。 \
  因此：
  $ A M = frac(c, 2) = frac(2 sqrt(3), 2) = sqrt(3). $
  在 $text("Rt")triangle A D M$ 中，由锐角三角函数定义可得：
  $ A D = frac(A M, cos A) = frac(sqrt(3), cos A). $

  在 $triangle A B C$ 中，由正弦定理 $frac(a, sin A) = frac(c, sin C)$，得：
  $ sin A = frac(a sin C, c) = frac(sqrt(10) times sin frac(pi, 3), 2 sqrt(3)) = frac(sqrt(10) times frac(sqrt(3), 2), 2 sqrt(3)) = frac(sqrt(10), 4). $

  因为 $a = sqrt(10) approx 3.16$，且 $c = 2 sqrt(3) = sqrt(12) approx 3.46$，所以 $a < c$。 \
  由三角形中“大边对大角”定理，边长 $a < c ==> A < C = frac(pi, 3) < frac(pi, 2)$。 \
  因此，角 $A$ 必为锐角！从而 $cos A > 0$：
  $ cos A = sqrt(1 - sin^2 A) = sqrt(1 - (frac(sqrt(10), 4))^2) = sqrt(1 - frac(10, 16)) = frac(sqrt(6), 4). $

  故 $A D$ 的长度为：
  $ A D = frac(A M, cos A) = frac(sqrt(3), frac(sqrt(6), 4)) = frac(4 sqrt(3), sqrt(6)) = 2 sqrt(2). $
]
#ans[（1）$C = frac(pi, 3)$ ；（2）$A D = 2 sqrt(2)$]

#v(4pt)

#fcap(
  scale: 1.35,
  caption: [第 15 题  $triangle A B C$ 几何结构示意图：$A D = D B$，$D M perp A B$ 于中点 $M$],
  {
    let a_val = calc.sqrt(10.0)
    let c_val = 2.0 * calc.sqrt(3.0)
    let C_rad = calc.pi / 3.0
    let b_val = (calc.sqrt(10.0) + 3.0 * calc.sqrt(2.0)) / 2.0
    let AD_val = 2.0 * calc.sqrt(2.0)
    let CD_val = b_val - AD_val

    // 水平对称：使点 B 在左下角 (0, 0)，点 C 在右下角 (a, 0)
    let B = (0.0, 0.0)
    let C = (a_val, 0.0)
    let A = (a_val - b_val * calc.cos(C_rad), b_val * calc.sin(C_rad))
    let D = (a_val - CD_val * calc.cos(C_rad), CD_val * calc.sin(C_rad))
    let M = ((A.at(0) + B.at(0)) / 2.0, (A.at(1) + B.at(1)) / 2.0)

    // 三角形 ABC
    ln(B, C, A, close: true, stroke: s(blue, th: 1.4pt))

    // 线段 DB 与垂线 DM
    ln(D, B, stroke: s(green, th: 1.2pt))
    dashed(D, M, color: orange, th: 1.1pt)

    // 顶点与标注
    pt(A, label: [$A$], r: 0.065, fill: blue, dx: 0.0, dy: 0.12, anchor: "south", tsize: 0.28, weight: "bold")
    pt(B, label: [$B$], r: 0.065, fill: blue, dx: -0.12, dy: -0.08, anchor: "north-east", tsize: 0.28, weight: "bold")
    pt(C, label: [$C$], r: 0.065, fill: blue, dx: 0.12, dy: -0.08, anchor: "north-west", tsize: 0.28, weight: "bold")
    pt(D, label: [$D$], r: 0.065, fill: green, dx: 0.14, dy: 0.06, anchor: "south-west", tsize: 0.28, weight: "bold")
    pt(M, label: [$M$], r: 0.06, fill: orange, dx: -0.12, dy: 0.08, anchor: "south-east", tsize: 0.26, weight: "bold")

    // 角 C 弧线 (在右下角 C 处, 边 CB 沿 180°, 边 CA 沿 120°)
    let arc_r = 0.48
    let arc_pts = range(16).map(i => {
      let t = calc.pi - C_rad + C_rad * i / 15.0
      (C.at(0) + arc_r * calc.cos(t), arc_r * calc.sin(t))
    })
    ln(..arc_pts, stroke: s(purple, th: 0.9pt))
    txt((C.at(0) - 0.70 * calc.cos(C_rad / 2.0), 0.70 * calc.sin(C_rad / 2.0)), anchor: "south-east", tsize: 0.26, text(fill: purple, weight: "bold")[$60 degree$])

    // 直角符号在 M 处
    let u_ba = ((A.at(0) - B.at(0)) / c_val, (A.at(1) - B.at(1)) / c_val)
    let len_md = calc.sqrt((D.at(0) - M.at(0))*(D.at(0) - M.at(0)) + (D.at(1) - M.at(1))*(D.at(1) - M.at(1)))
    let u_md = ((D.at(0) - M.at(0)) / len_md, (D.at(1) - M.at(1)) / len_md)
    let sq_s = 0.18
    let sq1 = (M.at(0) + u_ba.at(0) * sq_s, M.at(1) + u_ba.at(1) * sq_s)
    let sq2 = (sq1.at(0) + u_md.at(0) * sq_s, sq1.at(1) + u_md.at(1) * sq_s)
    let sq3 = (M.at(0) + u_md.at(0) * sq_s, M.at(1) + u_md.at(1) * sq_s)
    ln(sq1, sq2, sq3, stroke: s(orange, th: 0.8pt))

    // 边长与几何关系标注
    txt((a_val / 2.0, -0.16), anchor: "north", tsize: 0.26, text(fill: blue, weight: "bold")[$a = sqrt(10)$])
    txt((M.at(0) - 0.18, M.at(1) + 0.15), anchor: "south-east", tsize: 0.26, text(fill: blue, weight: "bold")[$c = 2 sqrt(3)$])
    txt(((A.at(0) + D.at(0)) / 2.0 + 0.18, (A.at(1) + D.at(1)) / 2.0), anchor: "south-west", tsize: 0.26, text(fill: green, weight: "bold")[$A D$])
    txt(((B.at(0) + D.at(0)) / 2.0, (B.at(1) + D.at(1)) / 2.0 - 0.16), anchor: "north", tsize: 0.26, text(fill: green, weight: "bold")[$D B$])
  }
)

#v(4pt)

#rect(
  fill: rgb("#f4f8fd"),
  stroke: rgb("#4a90e2") + 0.8pt,
  radius: 5pt,
  inset: (x: 12pt, y: 9pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#1a4d8f"), size: 9.5pt)[💡 知识溯源：三角函数“和差化积公式”的严密代数推导（换元法）] \
  #v(2pt)
  #text(size: 9pt)[
    *1. 基础出发点（两角和与差的正弦展开式）*： \
    #h(1em) 任意实数 $x, y$ 满足最基本的和差角公式：
    $ cases(
      sin(x + y) = sin x cos y + cos x sin y & quad text("（①）"),
      sin(x - y) = sin x cos y - cos x sin y & quad text("（②）")
    ) $
    #h(1em) 将两式相加得积化和差：$sin(x + y) + sin(x - y) = 2 sin x cos y$； \
    #h(1em) 将两式相减得积化和差：$sin(x + y) - sin(x - y) = 2 cos x sin y$。 \
    *2. 经典代数换元（将角和与角差整体化为单角）*： \
    #h(1em) 设 $cases(alpha = x + y, beta = x - y)$。解此关于 $x, y$ 的线性方程组（两式相加除以 $2$、相减除以 $2$）：
    $ x = frac(alpha + beta, 2), quad y = frac(alpha - beta, 2). $
    *3. 回代即得正弦和差化积公式*： \
    #h(1em) 将 $x, y$ 代入上述相加与相减的结果中，立得：
    $
      sin alpha + sin beta &= 2 sin frac(alpha + beta, 2) cos frac(alpha - beta, 2), \
      bold(sin alpha - sin beta) &= bold(2 cos frac(alpha + beta, 2) sin frac(alpha - beta, 2) quad text("（★ 本题下方所用核心工具）")).
    $
    #h(1em) _（附：同理对余弦和差角公式 $cos(x plus.minus y)$ 作加减与换元，可得 $cos alpha + cos beta = 2 cos frac(alpha + beta, 2) cos frac(alpha - beta, 2)$ 与 $cos alpha - cos beta = -2 sin frac(alpha + beta, 2) sin frac(alpha - beta, 2)$）_
  ]
]

#v(4pt)

#rect(
  fill: rgb("#fef9f3"),
  stroke: rgb("#e67e22") + 0.8pt,
  radius: 5pt,
  inset: (x: 12pt, y: 9pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#b95e00"), size: 9.5pt)[💡 核心拓展：三角形中“大边对大角”定理的严谨代数推导（和差化积法）] \
  #v(2pt)
  #text(size: 9pt)[
    *1. 命题内容*：在任意 $triangle A B C$ 中，边角大小顺序严格一致，即 $a > c <==> A > C$（同理 $a < c <==> A < C$）。 \
    *2. 代数证明（正弦定理结合和差化积）*： \
    #h(1em) 由正弦定理 $a = 2 R sin A$，$c = 2 R sin C$（$R$ 为外接圆半径，$R > 0$），两式作差：
    $ a - c = 2 R (sin A - sin C). $
    #h(1em) 利用三角函数和差化积公式 $sin A - sin C = 2 cos frac(A + C, 2) sin frac(A - C, 2)$，整理得：
    $ a - c = 4 R cos frac(A + C, 2) sin frac(A - C, 2). $
    #h(1em) 考察各项符号：
    - 因 $A + B + C = pi$ 且 $B > 0$，必有 $0 < A + C < pi ==> 0 < frac(A + C, 2) < frac(pi, 2)$，故 $cos frac(A + C, 2) > 0$ 恒正；
    - 因此，$a - c$ 的正负符号完全由 $sin frac(A - C, 2)$ 决定！
    - 若 $A > C$，则 $0 < frac(A - C, 2) < frac(pi, 2) ==> sin frac(A - C, 2) > 0 ==> a - c > 0 ==> a > c$；
    - 反之若 $a > c$，由因式符号必有 $sin frac(A - C, 2) > 0 ==> A > C$。充要等价成立。 \
    *3. 另解视角（利用三角形内角和排除钝角）*： \
    #h(1em) 算得 $sin A = frac(sqrt(10), 4) approx 0.7906$。若 $A$ 是钝角，则 $A > 90 degree$，结合已知 $C = 60 degree$，内角和 $A + C > 150 degree$。通过精确反三角函数计算 $A = pi - arcsin(frac(sqrt(10), 4)) approx 127.76 degree$，此时 $A + C approx 187.76 degree > 180 degree$，与三角形内角和为 $180 degree$ 矛盾。因此角 $A$ 只能是锐角。
  ]
]
