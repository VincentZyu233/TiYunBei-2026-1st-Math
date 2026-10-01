// ---------------- 第 17 题 ----------------
#import "../_template.typ": *
#import "../_figs.typ": *

#qhead(17, pts: 15)
某商品的包装纸如图 1 所示，四边形 $A B C D$ 是边长为 $3$ 的菱形，且 $angle A B C = 60 degree$，$A E = A F = sqrt(3)$，$B E = D F = 2 sqrt(3)$。将包装纸各三角形沿菱形的边进行翻折后，点 $E, F, M, N$ 重合，记为点 $P$，恰好形成如图 2 所示的四棱锥形的包装盒。 \
（1）证明：$P A perp text("平面") A B C D$； \
（2）设 $T$ 为 $B C$ 边上的一点，且二面角 $B - P A - T$ 的正弦值为 $frac(sqrt(21), 14)$，求 $P B$ 与平面 $P A T$ 所成角的正弦值。

#v(4pt)

// 原题并排双图：图 1 展开图 + 图 2 四棱锥立体图
#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  align: center + top,
  [
    #fcap(
      scale: 0.85,
      caption: [（图 1） 包装纸平面展开图],
      {
        let s3 = calc.sqrt(3.0)
        // 菱形 ABCD 顶点 (边长为 3, 对角线 AC=3 竖直, BD=3*sqrt(3) 水平)
        let A = (0.0, 1.5)
        let C = (0.0, -1.5)
        let B = (-1.5 * s3, 0.0)
        let D = (1.5 * s3, 0.0)

        // 翻折顶点 E, F (在上方, AE=AF=sqrt(3), BE=DF=2*sqrt(3))
        let E = (-0.5 * s3, 3.0)
        let F = (0.5 * s3, 3.0)

        // 翻折顶点 M, N (在下方)
        let M = (-1.35 * s3, -2.6)
        let N = (1.35 * s3, -2.6)

        // 菱形 ABCD 内部边框 (折痕虚线)
        dashed(A, B, color: blue, th: 1.0pt)
        dashed(B, C, color: blue, th: 1.0pt)
        dashed(C, D, color: blue, th: 1.0pt)
        dashed(D, A, color: blue, th: 1.0pt)

        // 包装纸外围实线轮廓
        ln(B, E, A, F, D, N, C, M, B, stroke: s(black, th: 1.2pt))

        // 直角符号在 A 处 (角 BAE = 90° 与角 DAF = 90°)
        let u_ab = ((B.at(0) - A.at(0)) / 3.0, (B.at(1) - A.at(1)) / 3.0)
        let u_ae = ((E.at(0) - A.at(0)) / s3, (E.at(1) - A.at(1)) / s3)
        let sq = 0.28
        let p1 = (A.at(0) + u_ab.at(0) * sq, A.at(1) + u_ab.at(1) * sq)
        let p2 = (p1.at(0) + u_ae.at(0) * sq, p1.at(1) + u_ae.at(1) * sq)
        let p3 = (A.at(0) + u_ae.at(0) * sq, A.at(1) + u_ae.at(1) * sq)
        ln(p1, p2, p3, stroke: s(orange, th: 0.8pt))

        let u_ad = ((D.at(0) - A.at(0)) / 3.0, (D.at(1) - A.at(1)) / 3.0)
        let u_af = ((F.at(0) - A.at(0)) / s3, (F.at(1) - A.at(1)) / s3)
        let q1 = (A.at(0) + u_ad.at(0) * sq, A.at(1) + u_ad.at(1) * sq)
        let q2 = (q1.at(0) + u_af.at(0) * sq, q1.at(1) + u_af.at(1) * sq)
        let q3 = (A.at(0) + u_af.at(0) * sq, A.at(1) + u_af.at(1) * sq)
        ln(q1, q2, q3, stroke: s(orange, th: 0.8pt))

        // 顶点标注
        pt(A, label: [$A$], r: 0.065, fill: blue, dx: 0.0, dy: -0.22, anchor: "north", tsize: 0.30, weight: "bold")
        pt(B, label: [$B$], r: 0.065, fill: blue, dx: -0.15, dy: 0.05, anchor: "east", tsize: 0.30, weight: "bold")
        pt(C, label: [$C$], r: 0.065, fill: blue, dx: 0.0, dy: 0.15, anchor: "south", tsize: 0.30, weight: "bold")
        pt(D, label: [$D$], r: 0.065, fill: blue, dx: 0.15, dy: 0.05, anchor: "west", tsize: 0.30, weight: "bold")
        pt(E, label: [$E$], r: 0.06, fill: purple, dx: 0.0, dy: 0.12, anchor: "south", tsize: 0.30, weight: "bold")
        pt(F, label: [$F$], r: 0.06, fill: purple, dx: 0.0, dy: 0.12, anchor: "south", tsize: 0.30, weight: "bold")
        pt(M, label: [$M$], r: 0.06, fill: purple, dx: 0.0, dy: -0.14, anchor: "north", tsize: 0.30, weight: "bold")
        pt(N, label: [$N$], r: 0.06, fill: purple, dx: 0.0, dy: -0.14, anchor: "north", tsize: 0.30, weight: "bold")

        // 尺寸与边长标注 (带白底保护盒)
        txt(((-0.5 * s3) / 2.0 - 0.22, 2.25), anchor: "south-east", tsize: 0.24, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: purple, weight: "bold")[$A E = sqrt(3)$]])
        txt(((0.5 * s3) / 2.0 + 0.22, 2.25), anchor: "south-west", tsize: 0.24, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: purple, weight: "bold")[$A F = sqrt(3)$]])
        txt(((-1.5 * s3 - 0.5 * s3) / 2.0 - 0.32, 1.55), anchor: "east", tsize: 0.24, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: purple, weight: "bold")[$B E = 2 sqrt(3)$]])
        txt(((1.5 * s3 + 0.5 * s3) / 2.0 + 0.32, 1.55), anchor: "west", tsize: 0.24, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: purple, weight: "bold")[$D F = 2 sqrt(3)$]])
        txt(((-1.5 * s3) / 2.0 + 0.20, 0.95), anchor: "center", tsize: 0.24, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: blue, weight: "bold")[$3$]])
        txt(((1.5 * s3) / 2.0 - 0.20, 0.95), anchor: "center", tsize: 0.24, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: blue, weight: "bold")[$3$]])

        // 角度弧线与标注
        // 菱形内角 B 处 60° (从 -30° 到 30°)
        let arc_r_b = 0.55
        let arc_b = range(13).map(i => {
          let t = -calc.pi / 6.0 + (calc.pi / 3.0) * i / 12.0
          (B.at(0) + arc_r_b * calc.cos(t), B.at(1) + arc_r_b * calc.sin(t))
        })
        ln(..arc_b, stroke: s(blue, th: 0.85pt))
        txt((B.at(0) + 0.85, 0.0), anchor: "west", tsize: 0.22, text(fill: blue, weight: "bold")[$60 degree$])

        // 菱形内角 A 处 120° (从 -150° 到 -30°)
        let arc_r_a = 0.45
        let arc_a = range(13).map(i => {
          let t = -calc.pi * 5.0 / 6.0 + (calc.pi * 2.0 / 3.0) * i / 12.0
          (A.at(0) + arc_r_a * calc.cos(t), A.at(1) + arc_r_a * calc.sin(t))
        })
        ln(..arc_a, stroke: s(blue, th: 0.85pt))
        txt((0.0, A.at(1) - 0.65), anchor: "north", tsize: 0.22, text(fill: blue, weight: "bold")[$120 degree$])
      }
    )
  ],
  [
    #fcap(
      scale: 1.05,
      caption: [（图 2） 四棱锥 $P-A B C D$ 结构图（$P A perp text("底面")，B H perp A T$）],
      {
        // 空间轴测投影 (放大展开，充分利用左右和底部空间)
        // A 为底面后顶点 (0, 0), P 为顶点 (0, 3.2) 竖直正上方
        let A = (0.0, 0.0)
        let P = (0.0, 3.2)
        let B = (-2.85, -0.85)
        let D = (2.35, -0.70)
        let C = (B.at(0) + D.at(0) - A.at(0), B.at(1) + D.at(1) - A.at(1)) // (-0.50, -1.55)

        // T 为 BC 边上一点 (靠近 B 处, BT = 1/3 BC)
        let T = (B.at(0) + (C.at(0) - B.at(0)) / 3.0, B.at(1) + (C.at(1) - B.at(1)) / 3.0)

        // H 为 B 向 AT 所作垂足
        let H = (A.at(0) + (T.at(0) - A.at(0)) * 0.72, A.at(1) + (T.at(1) - A.at(1)) * 0.72)

        // 不可见轮廓线 (虚线)
        dashed(P, A, color: red, th: 1.2pt)
        dashed(A, B, color: blue, th: 1.1pt)
        dashed(A, D, color: blue, th: 1.1pt)
        dashed(A, T, color: orange, th: 1.1pt)
        dashed(B, H, color: rgb("#27ae60"), th: 1.1pt)
        dashed(P, H, color: purple, th: 0.95pt)

        // 可见轮廓线 (实线)
        ln(P, B, stroke: s(black, th: 1.3pt))
        ln(P, C, stroke: s(black, th: 1.3pt))
        ln(P, D, stroke: s(black, th: 1.3pt))
        ln(B, C, stroke: s(blue, th: 1.2pt))
        ln(C, D, stroke: s(blue, th: 1.2pt))
        ln(P, T, stroke: s(orange, th: 1.2pt))

        // PA 垂直底面直角标记在 A 处
        ln((0.0, 0.25), (-0.22, 0.18), (-0.22, -0.07), stroke: s(red, th: 0.85pt))

        // BH 垂直 AT 直角标记在 H 处
        let u_at = ((T.at(0) - A.at(0)) / calc.sqrt((T.at(0)-A.at(0))*(T.at(0)-A.at(0)) + (T.at(1)-A.at(1))*(T.at(1)-A.at(1))),
                    (T.at(1) - A.at(1)) / calc.sqrt((T.at(0)-A.at(0))*(T.at(0)-A.at(0)) + (T.at(1)-A.at(1))*(T.at(1)-A.at(1))))
        let u_hb = ((B.at(0) - H.at(0)) / calc.sqrt((B.at(0)-H.at(0))*(B.at(0)-H.at(0)) + (B.at(1)-H.at(1))*(B.at(1)-H.at(1))),
                    (B.at(1) - H.at(1)) / calc.sqrt((B.at(0)-H.at(0))*(B.at(0)-H.at(0)) + (B.at(1)-H.at(1))*(B.at(1)-H.at(1))))
        let sq_h = 0.18
        let hp1 = (H.at(0) + u_at.at(0) * sq_h, H.at(1) + u_at.at(1) * sq_h)
        let hp2 = (hp1.at(0) + u_hb.at(0) * sq_h, hp1.at(1) + u_hb.at(1) * sq_h)
        let hp3 = (H.at(0) + u_hb.at(0) * sq_h, H.at(1) + u_hb.at(1) * sq_h)
        ln(hp1, hp2, hp3, stroke: s(rgb("#27ae60"), th: 0.85pt))

        // 边长与尺寸标注
        txt((0.18, 1.6), anchor: "west", tsize: 0.25, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: red, weight: "bold")[$sqrt(3)$]])
        txt(((P.at(0) + B.at(0)) / 2.0 - 0.25, (P.at(1) + B.at(1)) / 2.0 + 0.1), anchor: "south-east", tsize: 0.25, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: black, weight: "bold")[$2 sqrt(3)$]])
        txt(((A.at(0) + B.at(0)) / 2.0, (A.at(1) + B.at(1)) / 2.0 - 0.18), anchor: "north", tsize: 0.24, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: blue, weight: "bold")[$3$]])

        // 顶点标注
        pt(P, label: [$P$], r: 0.07, fill: purple, dx: 0.0, dy: 0.14, anchor: "south", tsize: 0.32, weight: "bold")
        pt(A, label: [$A$], r: 0.065, fill: red, dx: 0.16, dy: 0.09, anchor: "south-west", tsize: 0.28, weight: "bold")
        pt(B, label: [$B$], r: 0.065, fill: blue, dx: -0.16, dy: 0.0, anchor: "east", tsize: 0.30, weight: "bold")
        pt(C, label: [$C$], r: 0.065, fill: blue, dx: 0.0, dy: -0.16, anchor: "north", tsize: 0.30, weight: "bold")
        pt(D, label: [$D$], r: 0.065, fill: blue, dx: 0.16, dy: 0.0, anchor: "west", tsize: 0.30, weight: "bold")
        pt(T, label: [$T$], r: 0.06, fill: orange, dx: -0.12, dy: -0.14, anchor: "north-east", tsize: 0.28, weight: "bold")
        pt(H, label: [$H$], r: 0.055, fill: rgb("#27ae60"), dx: 0.14, dy: -0.06, anchor: "north-west", tsize: 0.26, weight: "bold")
      }
    )
  ]
)

#v(2pt)

#sol[
  *（1）证明：$P A perp text("平面") A B C D$。*

  在翻折前的平面展开图（图 1）中： \
  在 $triangle A B E$ 中，已知 $A B = 3$（菱形边长），$A E = sqrt(3)$，$B E = 2 sqrt(3)$。 \
  计算三边平方关系：
  $ A E^2 + A B^2 = (sqrt(3))^2 + 3^2 = 3 + 9 = 12 = (2 sqrt(3))^2 = B E^2. $
  由勾股定理逆定理可知，$triangle A B E$ 为以 $angle B A E$ 为直角的直角三角形，即 $A E perp A B$。 \
  同理，在 $triangle A D F$ 中，已知 $A D = 3$，$A F = sqrt(3)$，$D F = 2 sqrt(3)$，满足
  $ A F^2 + A D^2 = (sqrt(3))^2 + 3^2 = 12 = (2 sqrt(3))^2 = D F^2, $
  故 $triangle A D F$ 亦为直角三角形，即 $A F perp A D$。

  沿菱形各边将包装纸翻折后，点 $E, F, M, N$ 重合为四棱锥的顶点 $P$。 \
  因为翻折运动不改变各三角形内部线段长与垂直关系，所以
  $ P A perp A B, quad P A perp A D. $
  又因为 $A B subset text("平面") A B C D$，$A D subset text("平面") A B C D$，且 $A B inter A D = A$（菱形相邻相交边）， \
  由直线与平面垂直的判定定理，即证：
  $ P A perp text("平面") A B C D. $

  *（2）求 $P B$ 与平面 $P A T$ 所成角的正弦值。*

  *解法一：建立空间直角坐标系法（通法）*

  由（1）知 $P A perp text("平面") A B C D$，$P A = A E = sqrt(3)$。 \
  在菱形 $A B C D$ 中，边长为 $3$，$angle A B C = 60 degree$。 \
  以点 $A$ 为坐标原点建立空间直角坐标系（如图 3 所示）：
  - 设射线 $A B$ 为 $x$ 轴正方向，则点 $B$ 的坐标为 $(3, 0, 0)$；
  - 在底面平面 $A B C D$ 内，过点 $A$ 作垂直于 $A B$ 的射线为 $y$ 轴正方向；
  - 沿射线 $A P$ 向上为 $z$ 轴正方向，则顶点 $P$ 的坐标为 $(0, 0, sqrt(3))$。 \
  底面菱形各顶点及空间顶点坐标为：
  $ A(0, 0, 0), quad B(3, 0, 0), quad C(frac(3, 2), frac(3 sqrt(3), 2), 0), quad D(-frac(3, 2), frac(3 sqrt(3), 2), 0), quad P(0, 0, sqrt(3)). $

  #v(2pt)

  #fcap(
    scale: 1.15,
    caption: [（图 3） 空间直角坐标系（$x$ 轴沿 $A B$，$y$ 轴在底面内垂直于 $x$ 轴）、顶点坐标与法向量示意图],
    {
      // 严格空间几何投影
      // A(0,0,0) 为原点, P(0,0,sqrt(3)) 为顶点
      let A = (0.0, 0.0)
      let P = (0.0, 2.7)
      let B = (-2.5, -0.8)
      let D = (2.2, -0.6)
      let C = (B.at(0) + D.at(0) - A.at(0), B.at(1) + D.at(1) - A.at(1)) // (-0.3, -1.4)

      // 点 T 在 BC 边上 (BT = 1/3 BC)
      let T = (B.at(0) + (C.at(0) - B.at(0)) / 3.0, B.at(1) + (C.at(1) - B.at(1)) / 3.0)

      // 坐标轴端点延伸
      // x 轴: 从 A 沿 AB 向左下方延伸, 穿过 B 后伸出
      let x_end = (B.at(0) * 1.32, B.at(1) * 1.32)
      // z 轴: 从 A 沿 AP 向上延伸, 穿过 P 后伸出
      let z_end = (0.0, P.at(1) + 0.65)
      // y 轴: 底面内垂直于 x 轴 (AB), 朝右前下方伸展穿出底面边 CD
      let u_y_dir = (1.1, -1.25)
      let y_end = (u_y_dir.at(0) * 1.45, u_y_dir.at(1) * 1.45)

      // 底面内 x 与 y 轴的垂直直角标记 (在 A 处)
      let u_x = (B.at(0) / calc.sqrt(B.at(0)*B.at(0) + B.at(1)*B.at(1)), B.at(1) / calc.sqrt(B.at(0)*B.at(0) + B.at(1)*B.at(1)))
      let u_y = (u_y_dir.at(0) / calc.sqrt(u_y_dir.at(0)*u_y_dir.at(0) + u_y_dir.at(1)*u_y_dir.at(1)), u_y_dir.at(1) / calc.sqrt(u_y_dir.at(0)*u_y_dir.at(0) + u_y_dir.at(1)*u_y_dir.at(1)))
      let sq_a = 0.22
      let sa1 = (A.at(0) + u_x.at(0) * sq_a, A.at(1) + u_x.at(1) * sq_a)
      let sa2 = (sa1.at(0) + u_y.at(0) * sq_a, sa1.at(1) + u_y.at(1) * sq_a)
      let sa3 = (A.at(0) + u_y.at(0) * sq_a, A.at(1) + u_y.at(1) * sq_a)
      ln(sa1, sa2, sa3, stroke: s(rgb("#777777"), th: 0.75pt))

      // 坐标轴线绘制
      // z 轴延伸实线
      ln(P, z_end, stroke: s(rgb("#444444"), th: 1.1pt))
      arrowhead(z_end, 0.0, 1.0, size: 0.18, color: rgb("#444444"), filled: true)
      txt((0.15, z_end.at(1) - 0.05), anchor: "south-west", tsize: 0.28, text(fill: rgb("#444444"), weight: "bold")[$z$])

      // x 轴延伸实线 (从 B 往外延伸)
      ln(B, x_end, stroke: s(rgb("#444444"), th: 1.1pt))
      arrowhead(x_end, B.at(0), B.at(1), size: 0.18, color: rgb("#444444"), filled: true)
      txt((x_end.at(0) - 0.12, x_end.at(1) - 0.08), anchor: "north-east", tsize: 0.28, text(fill: rgb("#444444"), weight: "bold")[$x$])

      // y 轴: 底面内部为虚线, 穿出 CD 后为实线延伸
      let y_cross = (u_y_dir.at(0), u_y_dir.at(1))
      dashed(A, y_cross, color: rgb("#777777"), th: 0.9pt)
      ln(y_cross, y_end, stroke: s(rgb("#444444"), th: 1.1pt))
      arrowhead(y_end, u_y_dir.at(0), u_y_dir.at(1), size: 0.18, color: rgb("#444444"), filled: true)
      txt((y_end.at(0) + 0.12, y_end.at(1) - 0.05), anchor: "north-west", tsize: 0.28, text(fill: rgb("#444444"), weight: "bold")[$y$])

      // 四棱锥不可见棱 (虚线)
      dashed(P, A, color: red, th: 1.2pt)
      dashed(A, B, color: blue, th: 1.1pt)
      dashed(A, D, color: blue, th: 1.1pt)
      dashed(A, T, color: orange, th: 1.1pt)

      // 平面 PAT 半透明浅橙色填充
      ln(P, A, T, close: true, fill: rgb(214, 137, 16, 12%), stroke: none)

      // 四棱锥可见棱 (实线)
      ln(P, B, stroke: s(black, th: 1.3pt))
      ln(P, C, stroke: s(black, th: 1.3pt))
      ln(P, D, stroke: s(black, th: 1.3pt))
      ln(B, C, stroke: s(blue, th: 1.2pt))
      ln(C, D, stroke: s(blue, th: 1.2pt))
      ln(P, T, stroke: s(orange, th: 1.2pt))

      // 向量 PB 粗实线高亮与箭头
      arrowhead(B, B.at(0) - P.at(0), B.at(1) - P.at(1), size: 0.22, color: red, filled: true)
      let pb_mid = ((P.at(0) + B.at(0)) / 2.0, (P.at(1) + B.at(1)) / 2.0)
      txt((pb_mid.at(0) - 0.28, pb_mid.at(1) + 0.12), anchor: "south-east", tsize: 0.26, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: red, weight: "bold")[$arrow(P B)$]])

      // 平面 PAT 法向量 n 箭头 (从 A 沿垂直于 AT 方向垂直引出)
      let n_dir = (-(T.at(1) - A.at(1)), T.at(0) - A.at(0))
      let n_len = calc.sqrt(n_dir.at(0)*n_dir.at(0) + n_dir.at(1)*n_dir.at(1))
      let n_vec = (A.at(0) + (n_dir.at(0) / n_len) * 0.95, A.at(1) + (n_dir.at(1) / n_len) * 0.95)
      ln(A, n_vec, stroke: s(rgb("#27ae60"), th: 1.4pt))
      arrowhead(n_vec, n_dir.at(0), n_dir.at(1), size: 0.18, color: rgb("#27ae60"), filled: true)
      txt((n_vec.at(0) + 0.12, n_vec.at(1) - 0.10), anchor: "north-west", tsize: 0.24, box(fill: rgb(255, 255, 255, 80%), inset: 1pt, radius: 2pt)[#text(fill: rgb("#27ae60"), weight: "bold")[$arrow(n)$]])

      // 顶点标注与坐标卡片 (全部置顶绘制，A点红圆点绝对露出来)
      pt(P, r: 0.07, fill: purple)
      txt(P, dx: 0.16, dy: 0.08, anchor: "south-west", tsize: 0.26, box(fill: rgb(255, 255, 255, 85%), inset: 1.2pt, radius: 2pt)[#text(fill: purple, weight: "bold")[$P(0, 0, sqrt(3))$]])

      pt(B, r: 0.065, fill: blue)
      txt(B, dx: -0.16, dy: -0.18, anchor: "north-east", tsize: 0.26, box(fill: rgb(255, 255, 255, 85%), inset: 1.2pt, radius: 2pt)[#text(fill: blue, weight: "bold")[$B(3, 0, 0)$]])

      pt(C, r: 0.065, fill: blue)
      txt(C, dx: 0.0, dy: -0.18, anchor: "north", tsize: 0.24, box(fill: rgb(255, 255, 255, 85%), inset: 1.2pt, radius: 2pt)[#text(fill: blue, weight: "bold")[$C(frac(3, 2), frac(3 sqrt(3), 2), 0)$]])

      pt(D, r: 0.065, fill: blue)
      txt(D, dx: 0.16, dy: 0.06, anchor: "south-west", tsize: 0.24, box(fill: rgb(255, 255, 255, 85%), inset: 1.2pt, radius: 2pt)[#text(fill: blue, weight: "bold")[$D(-frac(3, 2), frac(3 sqrt(3), 2), 0)$]])

      pt(T, r: 0.06, fill: orange)
      txt(T, dx: -0.12, dy: -0.12, anchor: "north-east", tsize: 0.25, box(fill: rgb(255, 255, 255, 85%), inset: 1.2pt, radius: 2pt)[#text(fill: orange, weight: "bold")[$T$]])

      // 原点 A 置于最顶层：红色实心圆点 + 偏移避开圆点的坐标卡片
      pt(A, r: 0.07, fill: red)
      txt(A, dx: -0.22, dy: 0.25, anchor: "south-east", tsize: 0.26, box(fill: rgb(255, 255, 255, 88%), inset: 1.2pt, radius: 2pt)[#text(fill: red, weight: "bold")[$A(0, 0, 0)$]])
    }
  )

  #v(2pt)

  *1. 二面角转化为平面角*： \
  因为 $P A perp text("底面") A B C D$，且 $A B subset text("底面") A B C D$，$A T subset text("底面") A B C D$， \
  所以 $P A perp A B$ 且 $P A perp A T$。 \
  根据二面角平面角的定义，*角 $angle B A T$ 即为二面角 $B - P A - T$ 的平面角*！ \
  设 $theta = angle B A T$，由已知条件可得：
  $ sin theta = frac(sqrt(21), 14). $

  *2. 确定平面 $P A T$ 的法向量（无需解出点 $T$ 的具体坐标）*： \
  因为棱 $P A$ 即为 $z$ 轴，直线 $A T$ 落在 $x O y$ 平面上且与 $x$ 轴（射线 $A B$）夹角为 $theta$， \
  所以平面 $P A T$ 是一个“过 $z$ 轴且垂直于底面”的竖直平面，其法向量必平行于 $x O y$ 平面（$z$ 分量为 $0$）。 \
  在底面内，与射线 $A T$ 垂直的方向向量即为平面 $P A T$ 的法向量，可直接取单位法向量：
  $ arrow(n) = (-sin theta, cos theta, 0). $

  *3. 计算线面角的正弦值*： \
  由点 $B(3, 0, 0)$ 与顶点 $P(0, 0, sqrt(3))$，得向量：
  $ arrow(P B) = B - P = (3, 0, -sqrt(3)), quad |arrow(P B)| = sqrt(3^2 + 0^2 + (-sqrt(3))^2) = sqrt(12) = 2 sqrt(3). $
  设直线 $P B$ 与平面 $P A T$ 所成的角为 $alpha$（$alpha in [0, frac(pi, 2)]$），由线面角的向量计算公式：
  $ sin alpha = frac(|arrow(P B) cdot arrow(n)|, |arrow(P B)| |arrow(n)|). $
  代入数量积计算：
  $ arrow(P B) cdot arrow(n) = 3 times (-sin theta) + 0 times cos theta + (-sqrt(3)) times 0 = -3 sin theta. $
  取绝对值并代入模长：
  $ sin alpha = frac(|-3 sin theta|, 2 sqrt(3) times 1) = frac(3 sin theta, 2 sqrt(3)) = frac(sqrt(3), 2) sin theta. $
  将已知 $sin theta = frac(sqrt(21), 14)$ 代入，立得：
  $ sin alpha = frac(sqrt(3), 2) times frac(sqrt(21), 14) = frac(sqrt(63), 28) = frac(3 sqrt(7), 28). $
]

#v(2pt)

#ans[
  （1）证明见解析； \
  （2）$P B$ 与平面 $P A T$ 所成角的正弦值为 $frac(3 sqrt(7), 28)$
]

#v(3pt)

#rect(
  fill: rgb("#f6f9fe"),
  stroke: rgb("#1a4d8f") + 0.8pt,
  radius: 5pt,
  inset: (x: 12pt, y: 8.5pt),
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#1a4d8f"), size: 9.5pt)[💡 巧思拓展：第二问方法二（面面垂直与射影降维秒杀）] \
  #v(2pt)
  #text(size: 9pt)[
    *1. 面面垂直与垂线落地（将立体点面距降维为平面高线）*： \
    #h(1em) 因为 $P A perp text("平面") A B C D$，且 $P A subset text("平面") P A T$，所以 *平面 $P A T perp text("平面") A B C D$*。 \
    #h(1em) 两垂直平面的交线为 $A T$。在底面平面 $A B C D$ 内，过点 $B$ 作 $B H perp A T$，垂足为 $H$。 \
    #h(1em) 由面面垂直性质定理（“两平面垂直，在一平面内垂直于交线的直线必垂直于另一平面”），立得：* $B H perp text("平面") P A T$*！ \
    #h(1em) 因此，点 $H$ 即为点 $B$ 在平面 $P A T$ 上的正射影，线段 $B H$ 的长即为点 $B$ 到平面 $P A T$ 的距离。

    *2. 两个直角三角形秒出线面角*： \
    #h(1em) - 在底面 $text("Rt")triangle A B H$ 中，角 $angle B A H$ 即为二面角的平面角 $theta$，斜边 $A B = 3$：
    $ B H = A B sin theta = 3 sin theta. $
    #h(1em) - 在空间 $text("Rt")triangle P A B$ 中，斜高为：
    $ P B = sqrt(P A^2 + A B^2) = sqrt((sqrt(3))^2 + 3^2) = sqrt(12) = 2 sqrt(3). $
    #h(1em) - 连结 $P H$，根据线面角定义，线段 $P H$ 为 $P B$ 在平面 $P A T$ 上的射影，故 $angle B P H$ 即为直线 $P B$ 与平面 $P A T$ 所成的角 $alpha$。 \
    #h(1em) 在 $text("Rt")triangle P H B$ 中，直接利用对边比斜边：
    $ sin alpha = frac(B H, P B) = frac(3 sin theta, 2 sqrt(3)) = frac(sqrt(3), 2) sin theta. $

    *3. 代入计算*：
    $ sin alpha = frac(sqrt(3), 2) times frac(sqrt(21), 14) = frac(3 sqrt(7), 28). $

    *4. 巧法评价*： \
    #h(1em) 该方法充分抓住“$P A perp$ 底面”导致的面面垂直本质，只需作一条底面垂线 $B H perp A T$，三维点面距即刻转化为初中平面直角三角形的边长 $3 sin theta$。全程免设坐标、免解二元方程、无需计算点 $T$ 的具体位置，仅用两条初等几何公式便三步封顶！
  ]
]
