// ============================================================
//  第 14 题 Bonus：椭圆焦点弦长公式的两种形态与严密推导
// ============================================================
#import "../_template.typ": *
#import "../_figs.typ": *

#set page(paper: "a4", height: auto, margin: (x: 2.0cm, top: 1.5cm, bottom: 1.5cm), footer: none)
#show figure.caption: it => text(size: 8.5pt, fill: rgb("#555555"))[#it.body]
#set figure(numbering: none)

#rect(
  fill: rgb("#f6f9fe"),
  stroke: rgb("#1a4d8f") + 1.2pt,
  radius: 6pt,
  inset: (x: 14pt, y: 12pt),
  width: 100%,
)[
  #align(center)[
    #text(weight: "bold", size: 13pt, fill: rgb("#1a4d8f"))[
      🌟【Bonus 专题拓展】椭圆焦点弦长公式：极角 $theta$ 与斜率 $k$ 两种形态的严密推导与应用
    ]
  ]
  #v(4pt)
  #text(size: 9pt, fill: rgb("#555555"))[
    在高中圆锥曲线综合题中，焦点弦是非常高频且具有极强几何对称性的经典模型。除常规联立方程结合韦达定理外，熟练掌握焦点弦长的 *极角 $theta$ 极坐标形态* 与 *斜率 $k$ 直角坐标形态* 及其严密推导，不仅能实现考场秒杀验算，更能从本质上洞悉焦点弦的深层几何对称性。
  ]
]

#v(6pt)

// ---------------- 核心配图并排展示 ----------------
#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  [
    #align(center)[#text(weight: "bold", size: 9.5pt, fill: rgb("#1a4d8f"))[形态一：极角 $theta$ 极坐标模型]]
    #v(1pt)
    #fcap(
      scale: 1.15,
      caption: [以右焦点 $F(c, 0)$ 为极点，$A, B$ 极角分别为 $theta$ 与 $theta + pi$],
      {
        let a = 2.5
        let b = 1.75
        let c = calc.sqrt(a * a - b * b) // ≈ 1.785
        let th = 52.0 * calc.pi / 180.0

        // 坐标轴
        axes(-2.8, 3.2, -2.1, 2.1, xl: [$x$], yl: [$y$], arrow: 0.22, tsize: 0.28)
        txt((-0.15, -0.15), anchor: "north-east", tsize: 0.26, weight: "bold", [$O$])

        // 椭圆
        param(t => (a * calc.cos(t), b * calc.sin(t)), 0.0, 2.0 * calc.pi, stroke: s(blue, th: 1.4pt))

        // 右焦点 F(c, 0)
        let f_pt = (c, 0.0)
        pt(f_pt, r: 0.07, fill: purple)
        txt((c - 0.05, -0.08), anchor: "north-east", tsize: 0.25, text(fill: purple, weight: "bold")[$F(c, 0)$])

        // 焦半径 (以右焦点为极点, r1 = b^2 / (a + c cos theta), r2 = b^2 / (a - c cos theta))
        let r1 = (b * b) / (a + c * calc.cos(th))
        let r2 = (b * b) / (a - c * calc.cos(th))

        let a_pt = (c + r1 * calc.cos(th), r1 * calc.sin(th))
        let b_pt = (c - r2 * calc.cos(th), -r2 * calc.sin(th))

        // 弦 AB
        ln(b_pt, a_pt, stroke: s(green, th: 1.5pt))
        pt(a_pt, r: 0.07, fill: green)
        pt(b_pt, r: 0.07, fill: green)
        txt(a_pt, anchor: "south-west", dx: 0.06, dy: 0.06, tsize: 0.28, text(fill: green, weight: "bold")[$A$])
        txt(b_pt, anchor: "north-east", dx: -0.06, dy: -0.06, tsize: 0.28, text(fill: green, weight: "bold")[$B$])

        // 焦半径标注 r1, r2
        txt(((c + a_pt.at(0)) / 2.0 - 0.08, a_pt.at(1) / 2.0 + 0.08), anchor: "south-east", tsize: 0.26, text(fill: green, weight: "bold")[$r_1$])
        txt(((c + b_pt.at(0)) / 2.0 + 0.08, b_pt.at(1) / 2.0 - 0.08), anchor: "north-west", tsize: 0.26, text(fill: green, weight: "bold")[$r_2$])

        // 角度弧线 theta (极轴沿 x 轴正向)
        let arc_r = 0.42
        let arc_pts = range(16).map(i => {
          let t = th * i / 15.0
          (c + arc_r * calc.cos(t), arc_r * calc.sin(t))
        })
        ln(..arc_pts, stroke: s(orange, th: 1.0pt))
        txt((c + 0.52 * calc.cos(th / 2.0), 0.52 * calc.sin(th / 2.0)), anchor: "south-west", tsize: 0.26, text(fill: orange, weight: "bold")[$theta$])

        // 标注弦长关系
        txt((-2.6, 1.7), anchor: "north-west", tsize: 0.24, text(fill: purple, weight: "bold")[$|A B| = r_1 + r_2$])
      }
    )
  ],
  [
    #align(center)[#text(weight: "bold", size: 9.5pt, fill: rgb("#1a7a4d"))[形态二：斜率 $k$ 直角坐标模型]]
    #v(1pt)
    #fcap(
      scale: 1.15,
      caption: [过焦点且斜率为 $k$ 的直线割线与投影弦长关系],
      {
        let a = 2.5
        let b = 1.75
        let c = calc.sqrt(a * a - b * b)
        let th = 52.0 * calc.pi / 180.0

        // 坐标轴
        axes(-2.8, 3.2, -2.1, 2.1, xl: [$x$], yl: [$y$], arrow: 0.22, tsize: 0.28)
        txt((-0.15, -0.15), anchor: "north-east", tsize: 0.26, weight: "bold", [$O$])

        // 椭圆
        param(t => (a * calc.cos(t), b * calc.sin(t)), 0.0, 2.0 * calc.pi, stroke: s(blue, th: 1.4pt))

        let r1 = (b * b) / (a + c * calc.cos(th))
        let r2 = (b * b) / (a - c * calc.cos(th))
        let a_pt = (c + r1 * calc.cos(th), r1 * calc.sin(th))
        let b_pt = (c - r2 * calc.cos(th), -r2 * calc.sin(th))

        // 割线延伸
        let l_ext1 = (b_pt.at(0) - 0.25 * calc.cos(th), b_pt.at(1) - 0.25 * calc.sin(th))
        let l_ext2 = (a_pt.at(0) + 0.25 * calc.cos(th), a_pt.at(1) + 0.25 * calc.sin(th))
        ln(l_ext1, l_ext2, stroke: s(green, th: 1.5pt))

        // 右焦点 F(c, 0)
        let f_pt = (c, 0.0)
        pt(f_pt, r: 0.07, fill: purple)
        txt((c - 0.05, -0.08), anchor: "north-east", tsize: 0.25, text(fill: purple, weight: "bold")[$F(c, 0)$])

        // 交点 A(x1, y1), B(x2, y2)
        pt(a_pt, r: 0.07, fill: green)
        pt(b_pt, r: 0.07, fill: green)
        txt(a_pt, anchor: "south-west", dx: 0.05, dy: 0.05, tsize: 0.26, text(fill: green, weight: "bold")[$A(x_1, y_1)$])
        txt(b_pt, anchor: "north-east", dx: -0.05, dy: -0.05, tsize: 0.26, text(fill: green, weight: "bold")[$B(x_2, y_2)$])

        // 垂线投影到 x 轴
        dashed(a_pt, (a_pt.at(0), 0.0), color: red, th: 0.75pt)
        dashed(b_pt, (b_pt.at(0), 0.0), color: red, th: 0.75pt)
        txt((a_pt.at(0), 0.0), anchor: "north", dy: -0.05, tsize: 0.25, text(fill: red, weight: "bold")[$x_1$])
        txt((b_pt.at(0), 0.0), anchor: "north", dy: -0.05, tsize: 0.25, text(fill: red, weight: "bold")[$x_2$])

        // 直线方程标注
        txt((0.15, 1.45), anchor: "center", tsize: 0.26, text(fill: green, weight: "bold")[$y = k(x - c)$])
        txt((0.15, 1.15), anchor: "center", tsize: 0.23, text(fill: orange)[($k = tan theta$ != 0)])

        // 弦长公式标注
        txt((-2.6, 1.7), anchor: "north-west", tsize: 0.24, text(fill: blue, weight: "bold")[$|A B| = sqrt(1+k^2)|x_1 - x_2|$])
      }
    )
  ]
)

#v(8pt)

// ---------------- 公式推导一：极角 theta 形态 ----------------
#rect(
  fill: rgb("#ffffff"),
  stroke: rgb("#4a90e2") + 0.8pt,
  radius: 5pt,
  inset: (x: 12pt, y: 10pt),
  width: 100%,
)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1a4d8f"))[一、形态一：极角 / 倾斜角 $theta$ 焦点弦长公式及严密推导] \
  #v(4pt)
  设椭圆标准方程为 $frac(x^2, a^2) + frac(y^2, b^2) = 1$（$a > b > 0$），半焦距为 $c = sqrt(a^2 - b^2)$，右焦点为 $F(c, 0)$。

  *方法 1：直线的标准几何参数方程法（解析几何通法，计算最为优雅）* \
  设过焦点 $F(c, 0)$、倾斜角为 $theta$ 的直线的标准几何参数方程为：
  $ cases(x = c + t cos theta, y = t sin theta) $
  其中参数 $t$ 具有明确的几何意义：表示直线上动点到焦点 $F(c, 0)$ 的*有向距离*。因此直线与椭圆的两交点 $A, B$ 所对应的弦长即为 $|A B| = |t_1 - t_2|$。 \
  将参数方程代入椭圆标准方程 $frac(x^2, a^2) + frac(y^2, b^2) = 1$ 并两边同乘以 $a^2 b^2$：
  $
    b^2 (c + t cos theta)^2 + a^2 (t sin theta)^2 = a^2 b^2.
  $
  展开并按 $t$ 的降幂整理：
  $
    (b^2 cos^2 theta + a^2 sin^2 theta) t^2 + 2 b^2 c cos theta dot t + (b^2 c^2 - a^2 b^2) = 0.
  $
  注意到常数项 $b^2 c^2 - a^2 b^2 = -b^2(a^2 - c^2) = -b^4$。记二次项系数为 $D = b^2 cos^2 theta + a^2 sin^2 theta$，方程简写为：
  $ D t^2 + 2 b^2 c cos theta dot t - b^4 = 0. $
  由韦达定理：
  $ t_1 + t_2 = -frac(2 b^2 c cos theta, D), quad t_1 t_2 = -frac(b^4, D). $
  由弦长公式：
  $
    |A B| = |t_1 - t_2| &= sqrt((t_1 + t_2)^2 - 4 t_1 t_2) \
    &= sqrt(frac(4 b^4 c^2 cos^2 theta, D^2) + frac(4 b^4 D, D^2)) = frac(sqrt(4 b^4 (c^2 cos^2 theta + D)), D).
  $
  化简根号内的核心项：
  $
    c^2 cos^2 theta + D &= c^2 cos^2 theta + (b^2 cos^2 theta + a^2 sin^2 theta) \
    &= (c^2 + b^2) cos^2 theta + a^2 sin^2 theta = a^2 cos^2 theta + a^2 sin^2 theta = a^2.
  $
  故根号内为 $4 a^2 b^4$，开方得 $2 a b^2$。因此：
  $ |A B| = frac(2 a b^2, D). $
  最后化简分母 $D$：
  $
    D = b^2 cos^2 theta + a^2 (1 - cos^2 theta) = a^2 - (a^2 - b^2) cos^2 theta = a^2 - c^2 cos^2 theta.
  $
  由此直接证得：
  $ |A B| = frac(2 a b^2, a^2 - c^2 cos^2 theta). $

  #v(2pt)
  *方法 2：焦半径公式与极坐标通分法（几何直观性强）* \
  对椭圆上任意点 $P(x_0, y_0)$，其到右焦点的焦半径满足 $|P F| = a - e x_0$（其中 $e = frac(c, a)$）： \
  #h(1em) _证明_：$|P F|^2 = (x_0 - c)^2 + y_0^2 = (x_0 - c)^2 + b^2 (1 - frac(x_0^2, a^2)) = frac(c^2, a^2) x_0^2 - 2 c x_0 + a^2 = (a - e x_0)^2$。 \
  设过焦点 $F(c, 0)$ 的弦上动点与 $F$ 的距离为 $r$，方向角为 $theta$，则动点横坐标为 $x_0 = c + r cos theta$。代入焦半径公式：
  $ r = a - e(c + r cos theta) ==> r(1 + e cos theta) = a - e c = a - frac(c^2, a) = frac(b^2, a) ==> r = frac(b^2, a + c cos theta). $
  两交点分别对应方向角 $theta$ 与 $theta + pi$，对应的焦半径分别为 $r_1 = frac(b^2, a + c cos theta)$ 和 $r_2 = frac(b^2, a - c cos theta)$。两式相加通分：
  $
    |A B| = r_1 + r_2 = frac(b^2, a + c cos theta) + frac(b^2, a - c cos theta) = frac(2 a b^2, a^2 - c^2 cos^2 theta).
  $

  #text(weight: "bold", fill: rgb("#c0392b"))[
    ★ 核心结论（极角形态）：$|A B| = frac(2 a b^2, a^2 - c^2 cos^2 theta)$。
  ]
  #h(1em) #text(size: 8.5pt, fill: gray)[（注：无论以左焦点还是右焦点为基准，由于分母含 $cos^2 theta$，公式完全对称统一）]
]

#v(8pt)

// ---------------- 公式推导二：斜率 k 形态 ----------------
#rect(
  fill: rgb("#ffffff"),
  stroke: rgb("#1a7a4d") + 0.8pt,
  radius: 5pt,
  inset: (x: 12pt, y: 10pt),
  width: 100%,
)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1a7a4d"))[二、形态二：斜率 $k$ 焦点弦长公式及两种推导途径] \
  #v(4pt)
  当焦点弦不垂直于 $x$ 轴时，设直线的斜率为 $k$（倾斜角为 $theta$），则 $k = tan theta$。

  *途径 1：由极角形态利用三角恒等式直接代换（最为简捷）* \
  由同角三角函数平方关系可知：
  $ cos^2 theta = frac(1, 1 + tan^2 theta) = frac(1, 1 + k^2). $
  将 $cos^2 theta$ 代入形态一的分母中：
  $
    a^2 - c^2 cos^2 theta &= a^2 - frac(c^2, 1 + k^2) = frac(a^2 (1 + k^2) - c^2, 1 + k^2) \
    &= frac(a^2 k^2 + (a^2 - c^2), 1 + k^2).
  $
  因为椭圆中恒有 $a^2 - c^2 = b^2$，所以分母化为：
  $ a^2 - c^2 cos^2 theta = frac(a^2 k^2 + b^2, 1 + k^2). $
  将其代入弦长公式分子倒转，立得：
  $ |A B| = frac(2 a b^2, frac(a^2 k^2 + b^2, 1 + k^2)) = frac(2 a b^2 (1 + k^2), a^2 k^2 + b^2). $

  *途径 2：联立直线方程结合韦达定理（代数经典法）* \
  设过右焦点 $F(c, 0)$ 的直线方程为 $y = k(x - c)$，代入椭圆方程 $b^2 x^2 + a^2 y^2 = a^2 b^2$：
  $
    (a^2 k^2 + b^2) x^2 - 2 a^2 c k^2 x + a^2 (c^2 k^2 - b^2) = 0.
  $
  由韦达定理计算判别式及两根差平方，再乘以 $sqrt(1 + k^2)$：
  $
    |A B| = sqrt(1 + k^2) |x_1 - x_2| = sqrt(1 + k^2) frac(sqrt((2a^2 c k^2)^2 - 4(a^2 k^2 + b^2) a^2 (c^2 k^2 - b^2)), a^2 k^2 + b^2).
  $
  根号内提取 $4 a^2 b^2$ 并化简得 $b^2 (1 + k^2)$，开方同样可得上述公式。

  #text(weight: "bold", fill: rgb("#c0392b"))[
    ★ 核心结论（斜率形态）：$|A B| = frac(2 a b^2 (1 + k^2), a^2 k^2 + b^2)$。
  ]
]

#v(8pt)

// ---------------- 极限特值与任意直线弦长对比 ----------------
#rect(
  fill: rgb("#fefcf8"),
  stroke: rgb("#e67e22") + 0.8pt,
  radius: 5pt,
  inset: (x: 12pt, y: 10pt),
  width: 100%,
)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#b95e00"))[三、极限特值、几何性质与一般不过焦点弦长对比] \
  #v(3pt)
  #text(size: 9pt)[
    *1. 垂直于长轴（通径，极小值）*：当 $k -> oo$（或 $theta = 90 degree$）时，弦垂直于长轴，此时弦长为通径：
    $ |A B|_(min) = lim_(k -> oo) frac(2 a b^2 (1 + k^2), a^2 k^2 + b^2) = frac(2 a b^2, a^2) = frac(2 b^2, a). $
    *2. 与长轴重合（最大值）*：当 $k = 0$（或 $theta = 0 degree$）时，弦长达极大值长轴长：
    $ |A B|_(max) = frac(2 a b^2 (1 + 0), 0 + b^2) = 2 a. $
    *3. 任意不过焦点弦长公式对比*：若直线方程为一般式 $y = k x + m$，其与椭圆相交的弦长公式为：
    $ |A B| = frac(2 a b sqrt(1 + k^2) sqrt(a^2 k^2 + b^2 - m^2), a^2 k^2 + b^2). $
    当直线过右焦点 $(c, 0)$ 时，$m = -k c$，根号内为 $a^2 k^2 + b^2 - k^2 c^2 = (a^2 - c^2) k^2 + b^2 = b^2 (1 + k^2)$，开方提取 $b sqrt(1 + k^2)$ 后与外侧相乘，立即自然退化为上述焦点弦长公式！ \
    *4. 焦点在 $y$ 轴时的调整*：若椭圆焦点在 $y$ 轴上（即 $frac(y^2, a^2) + frac(x^2, b^2) = 1$），则长轴沿 $y$ 轴，公式中 $a, b$ 位置需严格对调，或改用直线与 $y$ 轴的夹角计算。
  ]
]

#v(8pt)

// ---------------- 本题（第 14 题）数值双向代入验算 ----------------
#rect(
  fill: rgb("#f4f9f4"),
  stroke: rgb("#27ae60") + 1.0pt,
  radius: 5pt,
  inset: (x: 12pt, y: 10pt),
  width: 100%,
)[
  #text(weight: "bold", size: 10.5pt, fill: rgb("#1e8449"))[四、代入本题（第 14 题）参数进行双向精准验算] \
  #v(4pt)
  #text(size: 9.5pt)[
    在第 14 题中，椭圆方程为 $frac(x^2, 4) + frac(y^2, 3) = 1$，直线过右焦点且斜率为 $k = sqrt(3)$：
    $ a^2 = 4 ==> a = 2, quad b^2 = 3, quad c^2 = a^2 - b^2 = 1. $
    因为斜率 $k = sqrt(3)$，所以倾斜角为 $theta = 60 degree$。

    - *验算法 1（代入极角 $theta$ 公式）：*
      因 $cos 60 degree = frac(1, 2) ==> cos^2 60 degree = frac(1, 4)$，直接代入：
      $
        |A B| = frac(2 a b^2, a^2 - c^2 cos^2 theta) = frac(2 times 2 times 3, 4 - 1^2 times frac(1, 4)) = frac(12, 4 - frac(1, 4)) = frac(12, frac(15, 4)) = frac(48, 15) = frac(16, 5).
      $

    - *验算法 2（代入斜率 $k$ 公式）：*
      因 $k = sqrt(3) ==> k^2 = 3$，直接代入：
      $
        |A B| = frac(2 a b^2 (1 + k^2), a^2 k^2 + b^2) = frac(2 times 2 times 3 times (1 + 3), 4 times 3 + 3) = frac(12 times 4, 12 + 3) = frac(48, 15) = frac(16, 5).
      $

    *结论*：两种公式计算结果均为 $frac(16, 5)$（即 $3.2$），与题解中联立方程求交点横坐标代入弦长公式的结果*完全一致、分毫不差*！
  ]
]
