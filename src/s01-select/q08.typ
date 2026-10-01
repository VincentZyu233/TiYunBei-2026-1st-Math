// ============================================================
//  第 8 题 —— 一、选择题（第 1—8 题）
// ============================================================
#import "../_template.typ": *
#import "../_figs.typ": *

// ---------------- 第 8 题 ----------------
#qhead(8, pts: 5)
对于函数 $f(x)$，当 $x > 0$ 时 $f(x) > f'(x)$。在锐角 $triangle A B C$ 中，角 $A$、$B$、$C$ 所对的边
分别为 $a$、$b$、$c$，且 $b cos C + c cos B > a cos C + c cos A$。设
$x_1 = a/b$，$x_2 = (sin A) / (sin B)$，$x_3 = A/B$，则（本题角度采用弧度制计算）（    ）

#opts((
  [#text(size: 8.5pt)[$f(x_1)/e^(x_1) > f(x_2)/e^(x_2) > f(x_3)/e^(x_3)$]],
  [#text(size: 8.5pt)[$f(x_1)/e^(x_1) = f(x_2)/e^(x_2) > f(x_3)/e^(x_3)$]],
  [#text(size: 8.5pt)[$f(x_1)/e^(x_1) < f(x_2)/e^(x_2) < f(x_3)/e^(x_3)$]],
  [#text(size: 8.5pt)[$f(x_1)/e^(x_1) = f(x_2)/e^(x_2) < f(x_3)/e^(x_3)$]],
), columns: 2)

#sol[
  *第一步：由条件得 $A > B$。*

  由正弦定理，$a : b : c = sin A : sin B : sin C$，故原不等式等价于
  $
    sin B cos C + sin C cos B > sin A cos C + sin C cos A,
  $
  左边 $= sin(B + C) = sin(pi - A) = sin A$；右边第二、三项之和
  $= sin A cos C + sin C cos A = sin(A + C) = sin(pi - B) = sin B$。
  于是条件等价于 $sin A > sin B$。

  又 $sin A - sin B = 2 cos((A + B)/2) sin((A - B)/2)$，其中 $A + B < pi$ 保证
  $cos((A + B)/2) > 0$，故 $sin((A - B)/2) > 0$，即 $A > B$。于是 $a > b > 0$。

  *第二步：比较 $x_1, x_2, x_3$。*

  由正弦定理 $x_2 = (sin A) / (sin B) = a / b = x_1$。

  又函数 $h(t) = (sin t) / t$ 在 $(0, pi)$ 上单调递减（因
  $h' (t) = (t cos t - sin t)/t^2 < 0$，严谨证明与函数图像直观见后文深度探究框）。由 $A > B > 0$ 得
  $(sin A) / A < (sin B) / B$，即 $a/A < b/B$，即 $a B < A b$，即
  $
    x_1 = a/b < A/B = x_3,
  $
  于是 $0 < x_1 = x_2 < x_3$。

  *第三步：考察 $g(x) = f(x)/e^x$。*

  对 $x > 0$，
  $
    g' (x) = (f' (x) e^x - f(x) e^x) / e^(2x) = (f' (x) - f(x)) / e^x < 0,
  $
  由条件 $f(x) > f' (x)$ 知 $g$ 在 $(0, +oo)$ 上单调递减。

  由 $0 < x_1 = x_2 < x_3$ 得 $g(x_1) = g(x_2) > g(x_3)$，即
  $f(x_1)/e^(x_1) = f(x_2)/e^(x_2) > f(x_3)/e^(x_3)$。
]
#ans[$f(x_1)/e^(x_1) = f(x_2)/e^(x_2) > f(x_3)/e^(x_3)$，选 #text(weight: "bold")[B]]

#v(4pt)
#block(
  breakable: false,
  stroke: 0.8pt + rgb("#2a6f97"),
  radius: 6pt,
  inset: (x: 10pt, y: 9pt),
  fill: rgb("#f4f9fd"),
  [
    #text(weight: "bold", fill: rgb("#1a4d8f"))[💡 深度探究：为什么 $h'(t) < 0$？—— 比较 $t$ 与 $tan t$ 的大小] \
    #v(2pt)
    导函数 $h'(t) = frac(t cos t - sin t, t^2)$ 的分母 $t^2 > 0$，其正负完全取决于分子 $u(t) = t cos t - sin t$：
    - 当 $t in [pi/2, pi)$ 时，因 $cos t <= 0$ 且 $sin t > 0$，有 $t cos t <= 0 < sin t$，故 $t cos t - sin t < 0$ 显然恒成立；
    - 当 $t in (0, pi/2)$ 时，$cos t > 0$，提取公因式得：
      $ t cos t - sin t = cos t (t - frac(sin t, cos t)) = cos t (t - tan t). $
      由于 $cos t > 0$，判断分子正负等价于比较 $t$ 与 $tan t$ 的大小。

    #v(2pt)
    #grid(
      columns: (1.25fr, 1fr),
      gutter: 10pt,
      align: (top + left, top + center),
      [
        *【方法一：求导严谨证明】* \
        构造辅助差函数 $phi(t) = tan t - t$（$t in [0, pi/2)$）。 \
        求导得：
        $ phi'(t) = sec^2 t - 1 = tan^2 t. $
        当 $t in (0, pi/2)$ 时，$tan t > 0$，故 $phi'(t) = tan^2 t > 0$ 恒成立，因此 $phi(t)$ 在 $[0, pi/2)$ 上严格单调递增。 \
        又 $phi(0) = tan 0 - 0 = 0$，故对任意 $t in (0, pi/2)$ 恒有：
        $ phi(t) > phi(0) = 0 implies tan t > t quad (t < tan t). $
        因此 $t - tan t < 0$，从而 $t cos t - sin t < 0$ 严格成立。 \
        #v(2pt)
        *【方法二：几何切线直观】* \
        在单位圆第一象限中，角 $t$ 对应的圆弧长为 $t$，而过切点的切线线段长为 $tan t$。由几何关系显然有 $t < tan t$。
      ],
      [
        #fcap(
          scale: 1.8,
          yscale: 0.72,
          caption: [$t in (0, pi/2)$ 时 $y = tan t$ 恒在 $y = t$ 上方],
          {
            let ftan = u => calc.tan(u)
            let fline = u => u
            plot(ftan, 0.0, 1.34, samples: 100, stroke: s(blue, th: 1.2pt))
            plot(fline, 0.0, 1.5, samples: 2, stroke: sd(rgb("#666666"), th: 0.8pt))
            axes(-0.15, 1.68, -0.2, 3.8, xl: [$t$], yl: [$y$], tsize: 0.22)
            txt((-0.12, -0.15), tsize: 0.20, weight: "bold", [$O$])
            
            let pi2 = calc.pi / 2.0
            dashed((pi2, 0.0), (pi2, 3.8), color: red, th: 0.6pt)
            txt((pi2, -0.13), anchor: "north", tsize: 0.19, text(fill: red)[$t = frac(pi, 2)$])
            
            txt((1.05, 2.9), anchor: "east", tsize: 0.22, weight: "bold", text(fill: blue)[$y = tan t$])
            txt((1.42, 1.25), anchor: "west", tsize: 0.22, weight: "bold", text(fill: rgb("#555555"))[$y = t$])

            pt((1.0, 1.0), r: 0.045, fill: gray)
            pt((1.0, calc.tan(1.0)), r: 0.045, fill: red)
            dashed((1.0, 0.0), (1.0, calc.tan(1.0)), color: gray, th: 0.5pt)
            txt((1.0, -0.13), anchor: "north", tsize: 0.19, [$t_0$])
            txt((1.06, calc.tan(1.0)), anchor: "west", tsize: 0.19, text(fill: red)[$tan t_0$])
            txt((1.06, 1.0), anchor: "west", tsize: 0.19, text(fill: rgb("#555555"))[$t_0$])
          },
        )
      ],
    )
  ]
)

#fcap(
  scale: 0.95,
  caption: [第 8 题  $x_1 = x_2 < x_3$，而 $g(x) = f(x)/e^x$ 在 $(0, +oo)$ 递减，故 $g(x_1) = g(x_2) > g(x_3)$],
  {
    let gy = u => 3.5 * calc.exp(0.42 * (1.2 - u))
    plot(gy, 0.02, 4.7, stroke: s(blue, th: 1.3pt))
    axes(-0.2, 5.0, -0.4, 4.4, xl: [$x$], yl: [$g$], tsize: 0.28)
    txt((-0.18, -0.22), tsize: 0.24, weight: "bold", [$O$])

    pt((1.1, gy(1.1)), r: 0.07, fill: red)
    ln((1.1, 0.0), (1.1, gy(1.1)), stroke: sd(red, th: 0.6pt))
    txt((1.1, gy(1.1)), anchor: "south-west", dx: 0.04, dy: 0.08, tsize: 0.27, [$g(x_1)=g(x_2)$])
    txt((1.1, 0.0), anchor: "north", dy: -0.09, tsize: 0.27, [$x_1 = x_2$])

    pt((3.3, gy(3.3)), r: 0.07, fill: green)
    ln((3.3, 0.0), (3.3, gy(3.3)), stroke: sd(green, th: 0.6pt))
    txt((3.3, gy(3.3)), anchor: "south-west", dx: 0.04, dy: 0.08, tsize: 0.27, [$g(x_3)$])
    txt((3.3, 0.0), anchor: "north", dy: -0.09, tsize: 0.27, [$x_3$])
  },
)
