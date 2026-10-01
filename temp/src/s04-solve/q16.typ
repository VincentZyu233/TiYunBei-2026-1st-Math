// ---------------- 第 16 题 ----------------
#import "../_template.typ": *
#import "../_figs.typ": *

#qhead(16, pts: 15)
已知椭圆 $C: frac(x^2, a^2) + frac(y^2, b^2) = 1$（$a > b > 0$）的左、右焦点分别为 $F_1, F_2$，$B$ 为上顶点，且该椭圆长轴长为 $4$，$cos angle F_1 F_2 B = frac(sqrt(2), 2)$。 \
（1）求椭圆 $C$ 的标准方程； \
（2）设 $O$ 为坐标原点，过点 $B$ 作直线 $l$ 交 $C$ 于点 $A$，$A$ 在 $x$ 轴下方，当 $triangle O A B$ 的面积为 $1$ 时，求此时 $l$ 的方程。

#sol[
  *（1）求椭圆 $C$ 的标准方程。*

  已知椭圆长轴长为 $4$，即 $2 a = 4$，解得 $a = 2$。 \
  设左、右焦点坐标分别为 $F_1(-c, 0), F_2(c, 0)$，上顶点为 $B(0, b)$，其中 $b^2 = a^2 - c^2 = 4 - c^2$。 \
  在 $triangle F_1 F_2 B$ 中，因为点 $F_1, O, F_2$ 在 $x$ 轴上，$O B perp F_1 F_2$，所以 $triangle O B F_2$ 为直角三角形。 \
  因为 $cos angle F_1 F_2 B = frac(sqrt(2), 2)$ 且 $angle F_1 F_2 B in (0, pi)$，所以底角为特殊角：
  $ angle F_1 F_2 B = 45 degree. $
  因此 $text("Rt")triangle O B F_2$ 为等腰直角三角形，两直角边相等：
  $ |O B| = |O F_2| ==> b = c. $
  根据椭圆的基本几何关系 $a^2 = b^2 + c^2 = 2 b^2$，将 $a = 2$ 代入得：
  $ 2 b^2 = 2^2 = 4 ==> b^2 = 2, quad c^2 = 2. $
  所以，椭圆 $C$ 的标准方程为：
  $ frac(x^2, 4) + frac(y^2, 2) = 1. $
]

#v(2pt)

#fcap(
  scale: 1.35,
  caption: [第 16 题（1） 椭圆特征三角形：底角 $45 degree$ 导出 $text("Rt")triangle O B F_2$ 为等腰直角三角形（$b = c = sqrt(2)$）],
  {
    let a_val = 2.0
    let b_val = calc.sqrt(2.0)
    let c_val = calc.sqrt(2.0)

    // 坐标轴
    axes(-2.8, 2.8, -1.0, 2.1, xl: [$x$], yl: [$y$], arrow: 0.22, tsize: 0.28)
    txt((-0.14, -0.14), anchor: "north-east", tsize: 0.26, weight: "bold", [$O$])

    // 椭圆轮廓
    param(t => (a_val * calc.cos(t), b_val * calc.sin(t)), 0.0, 2.0 * calc.pi, stroke: s(blue, th: 1.4pt))
    txt((1.65, 1.35), anchor: "south-west", tsize: 0.25, text(fill: blue, weight: "bold")[$C: frac(x^2, 4) + frac(y^2, 2) = 1$])

    // 关键点
    let b_pt = (0.0, b_val)
    let f1_pt = (-c_val, 0.0)
    let f2_pt = (c_val, 0.0)
    let o_pt = (0.0, 0.0)

    // 特征三角形 F1 F2 B 浅蓝填充
    ln(f1_pt, b_pt, f2_pt, close: true, fill: rgb(26, 77, 143, 10%), stroke: none)

    // 边线绘制
    ln(f1_pt, b_pt, stroke: s(purple, th: 1.2pt))
    ln(f2_pt, b_pt, stroke: s(purple, th: 1.3pt))
    ln(f1_pt, f2_pt, stroke: s(red, th: 1.2pt))
    ln(o_pt, b_pt, stroke: s(blue, th: 1.3pt))

    // O 处直角符号
    let sq = 0.18
    ln((sq, 0.0), (sq, sq), (0.0, sq), stroke: s(blue, th: 0.8pt))

    // 角 F1 F2 B = 45° 弧线 (在 F2(c, 0) 处，方向从 135° 到 180°)
    let arc_r = 0.50
    let arc_pts = range(16).map(i => {
      let t = calc.pi * 3.0 / 4.0 + (calc.pi / 4.0) * i / 15.0
      (c_val + arc_r * calc.cos(t), arc_r * calc.sin(t))
    })
    ln(..arc_pts, stroke: s(purple, th: 1.0pt))
    txt((c_val - 0.68, 0.22), anchor: "south-east", tsize: 0.26, text(fill: purple, weight: "bold")[$45 degree$])

    // 顶点标注
    pt(b_pt, r: 0.07, fill: purple)
    pt(f1_pt, r: 0.065, fill: red)
    pt(f2_pt, r: 0.065, fill: red)
    txt(b_pt, anchor: "south-west", dx: 0.08, dy: 0.08, tsize: 0.26, text(fill: purple, weight: "bold")[$B(0, b)$])
    txt(f1_pt, anchor: "north-east", dx: -0.06, dy: -0.08, tsize: 0.25, text(fill: red, weight: "bold")[$F_1(-c, 0)$])
    txt(f2_pt, anchor: "north-west", dx: 0.06, dy: -0.08, tsize: 0.25, text(fill: red, weight: "bold")[$F_2(c, 0)$])

    // 几何边长对应量标注
    txt((c_val / 2.0 + 0.18, b_val / 2.0 + 0.15), anchor: "south-west", tsize: 0.26, text(fill: purple, weight: "bold")[$a = 2$])
    txt((c_val / 2.0, -0.22), anchor: "north", tsize: 0.26, text(fill: red, weight: "bold")[$c = sqrt(2)$])
    txt((-0.20, b_val / 2.0), anchor: "east", tsize: 0.26, text(fill: blue, weight: "bold")[$b = sqrt(2)$])
  }
)

#v(3pt)

#rect(
  fill: rgb("#f6f9fe"),
  stroke: rgb("#1a4d8f") + 0.8pt,
  radius: 5pt,
  inset: (x: 12pt, y: 8.5pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#1a4d8f"), size: 9.5pt)[💡 通法拓展：第一问方法二（向量数量积与离心率通法）] \
  #v(2pt)
  #text(size: 9pt)[
    *1. 向量数量积求底角余弦值*： \
    #h(1em) 设左焦点 $F_1(-c, 0)$、右焦点 $F_2(c, 0)$、上顶点 $B(0, b)$。构成两底角向量分别为：
    $ arrow(F_2 F_1) = (-2 c, 0), quad arrow(F_2 B) = (-c, b). $
    #h(1em) 对应的模长为 $|arrow(F_2 F_1)| = 2 c$，$|arrow(F_2 B)| = sqrt((-c)^2 + b^2) = sqrt(c^2 + b^2) = a$。 \
    #h(1em) 根据平面向量数量积的夹角定义：
    $ cos angle F_1 F_2 B = frac(arrow(F_2 F_1) cdot arrow(F_2 B), |arrow(F_2 F_1)| |arrow(F_2 B)|) = frac((-2 c) times (-c) + 0 times b, 2 c cdot a) = frac(2 c^2, 2 a c) = frac(c, a). $
    *2. 秒解离心率与椭圆参数*： \
    #h(1em) 由题意 $cos angle F_1 F_2 B = frac(sqrt(2), 2)$，立得离心率 $e = frac(c, a) = frac(sqrt(2), 2)$。 \
    #h(1em) 代入 $a = 2$ 得 $c = a times frac(sqrt(2), 2) = sqrt(2)$，从而 $b^2 = a^2 - c^2 = 2^2 - (sqrt(2))^2 = 2$。同样求得椭圆方程为 $frac(x^2, 4) + frac(y^2, 2) = 1$。 \
    *3. 评价与通法优势*： \
    #h(1em) 方法一利用 $45 degree$ 特殊角和等腰直角三角形直观秒杀；而方法二（向量数量积法）是*圆锥曲线求离心率的通用方法*——即使题目给出的余弦值不是特殊角（如 $cos angle F_1 F_2 B = frac(1, 3)$），该方法仍能一秒建立底角余弦值与离心率的恒等关系 $cos angle F_1 F_2 B = frac(c, a) = e$！
  ]
]

#v(4pt)

#sol[
  *（2）求直线 $l$ 的方程。*

  由（1）可知，椭圆上顶点坐标为 $B(0, sqrt(2))$，因此线段 $|O B| = sqrt(2)$。 \
  设直线 $l$ 与椭圆交点 $A$ 的坐标为 $(x_0, y_0)$。 \
  因为顶点 $B$ 在 $y$ 轴上，若以线段 $O B$ 为底边，则 $triangle O A B$ 的高即为点 $A$ 到 $y$ 轴的水平距离 $|x_0|$。 \
  根据三角形面积公式：
  $ S_(triangle O A B) = frac(1, 2) |O B| cdot |x_0| = frac(1, 2) times sqrt(2) times |x_0| = 1. $
  由此解得：
  $ |x_0| = frac(2, sqrt(2)) = sqrt(2) ==> x_0 = plus.minus sqrt(2). $

  因为点 $A(x_0, y_0)$ 在椭圆 $C: frac(x^2, 4) + frac(y^2, 2) = 1$ 上，将 $x_0^2 = 2$ 代入椭圆方程：
  $ frac(2, 4) + frac(y_0^2, 2) = 1 ==> frac(1, 2) + frac(y_0^2, 2) = 1 ==> frac(y_0^2, 2) = frac(1, 2) ==> y_0^2 = 1. $
  又题干明确要求 *点 $A$ 在 $x$ 轴下方*，即 $y_0 < 0$，因此
  $ y_0 = -1. $
  由此确定点 $A$ 的坐标为 $A_1(sqrt(2), -1)$ 或 $A_2(-sqrt(2), -1)$。

  过已知点 $B(0, sqrt(2))$ 与点 $A$ 分两种情况求直线 $l$ 的方程：
  - *情形 1：当点 $A$ 坐标为 $(sqrt(2), -1)$ 时*，直线 $l$ 的斜率为：
    $ k = frac(-1 - sqrt(2), sqrt(2) - 0) = -frac(1 + sqrt(2), sqrt(2)) = -(1 + frac(sqrt(2), 2)) = -frac(2 + sqrt(2), 2). $
    此时直线 $l$ 的方程为：
    $ y = -(1 + frac(sqrt(2), 2)) x + sqrt(2) quad text("（即") (2 + sqrt(2)) x + 2 y - 2 sqrt(2) = 0 text("）"). $

  - *情形 2：当点 $A$ 坐标为 $(-sqrt(2), -1)$ 时*，直线 $l$ 的斜率为：
    $ k = frac(-1 - sqrt(2), -sqrt(2) - 0) = frac(1 + sqrt(2), sqrt(2)) = 1 + frac(sqrt(2), 2) = frac(2 + sqrt(2), 2). $
    此时直线 $l$ 的方程为：
    $ y = (1 + frac(sqrt(2), 2)) x + sqrt(2) quad text("（即") (2 + sqrt(2)) x - 2 y + 2 sqrt(2) = 0 text("）"). $

  综上所述，直线 $l$ 的方程为：
  $ (2 + sqrt(2)) x + 2 y - 2 sqrt(2) = 0 quad text("或") quad (2 + sqrt(2)) x - 2 y + 2 sqrt(2) = 0. $
]

#v(2pt)

#fcap(
  scale: 1.35,
  caption: [第 16 题（2） 直线与面积图：以 $O B$ 为底边、高为 $|x_0| = sqrt(2)$ 的对称割线 $l_1, l_2$ 与 $triangle O A_1 B$ 面积区域],
  {
    let a_val = 2.0
    let b_val = calc.sqrt(2.0)
    let c_val = calc.sqrt(2.0)

    // 坐标轴
    axes(-2.8, 2.9, -2.1, 2.2, xl: [$x$], yl: [$y$], arrow: 0.22, tsize: 0.28)
    txt((-0.14, -0.14), anchor: "north-east", tsize: 0.26, weight: "bold", [$O$])

    // 椭圆
    param(t => (a_val * calc.cos(t), b_val * calc.sin(t)), 0.0, 2.0 * calc.pi, stroke: s(blue, th: 1.5pt))
    txt((1.65, 1.45), anchor: "south-west", tsize: 0.26, text(fill: blue, weight: "bold")[$C: frac(x^2, 4) + frac(y^2, 2) = 1$])

    // 顶点 B 坐标
    let b_pt = (0.0, b_val)

    // 左右焦点 F1, F2
    let f1_pt = (-c_val, 0.0)
    let f2_pt = (c_val, 0.0)
    pt(f1_pt, r: 0.065, fill: red)
    pt(f2_pt, r: 0.065, fill: red)
    txt(f1_pt, anchor: "north-east", dx: -0.06, dy: -0.08, tsize: 0.25, text(fill: red, weight: "bold")[$F_1$])
    txt(f2_pt, anchor: "north-west", dx: 0.06, dy: -0.08, tsize: 0.25, text(fill: red, weight: "bold")[$F_2$])

    // 交点 A1(sqrt(2), -1), A2(-sqrt(2), -1)
    let a1_pt = (c_val, -1.0)
    let a2_pt = (-c_val, -1.0)

    // 三角形 OA1B 区域填充 (浅橙色)
    ln((0.0, 0.0), b_pt, a1_pt, close: true, fill: rgb(214, 137, 16, 14%), stroke: none)

    // 直线 l1 贯穿延伸 (过 B 和 A1)
    let k1 = -(1.0 + calc.sqrt(2.0) / 2.0)
    let l1_p1 = (-0.35, b_val - 0.35 * k1)
    let l1_p2 = (1.75, b_val + 1.75 * k1)
    ln(l1_p1, l1_p2, stroke: s(green, th: 1.4pt))
    txt((l1_p2.at(0) + 0.06, l1_p2.at(1)), anchor: "west", tsize: 0.25, text(fill: green, weight: "bold")[$l_1$])

    // 直线 l2 贯穿延伸 (过 B 和 A2)
    let k2 = 1.0 + calc.sqrt(2.0) / 2.0
    let l2_p1 = (0.35, b_val + 0.35 * k2)
    let l2_p2 = (-1.75, b_val - 1.75 * k2)
    ln(l2_p1, l2_p2, stroke: s(rgb("#27ae60"), th: 1.2pt))
    txt((l2_p2.at(0) - 0.06, l2_p2.at(1)), anchor: "east", tsize: 0.25, text(fill: rgb("#27ae60"), weight: "bold")[$l_2$])

    // 交点标注
    pt(a1_pt, r: 0.07, fill: green)
    pt(a2_pt, r: 0.07, fill: rgb("#27ae60"))
    txt(a1_pt, anchor: "north-west", dx: 0.08, dy: -0.06, tsize: 0.26, text(fill: green, weight: "bold")[$A_1(sqrt(2), -1)$])
    txt(a2_pt, anchor: "north-east", dx: -0.08, dy: -0.06, tsize: 0.26, text(fill: rgb("#27ae60"), weight: "bold")[$A_2(-sqrt(2), -1)$])

    // 垂线到 y 轴 (高 |x0|)
    dashed(a1_pt, (0.0, -1.0), color: orange, th: 0.8pt)
    txt((c_val / 2.0, -0.85), anchor: "south", tsize: 0.24, text(fill: orange, weight: "bold")[高 $= sqrt(2)$])

    // 面积标注
    txt((0.45, 0.45), anchor: "center", tsize: 0.26, text(fill: orange, weight: "bold")[$S = 1$])

    // 顶点 B(0, sqrt(2)) —— 置于顶层绘制并微调右移，避免被直线 l2 遮挡
    pt(b_pt, r: 0.07, fill: purple)
    txt(b_pt, anchor: "south-west", dx: 0.14, dy: 0.07, tsize: 0.26, box(fill: rgb(255, 255, 255, 82%), inset: 1.2pt, radius: 2pt)[#text(fill: purple, weight: "bold")[$B(0, sqrt(2))$]])
  }
)

#v(2pt)

#ans[
  （1）$frac(x^2, 4) + frac(y^2, 2) = 1$； \
  （2）$y = plus.minus (1 + frac(sqrt(2), 2)) x + sqrt(2)$（或 $(2 + sqrt(2)) x plus.minus 2 y minus.plus 2 sqrt(2) = 0$）
]
