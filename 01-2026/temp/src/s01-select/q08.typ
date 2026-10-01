// ============================================================
//  第 8 题 —— 一、选择题（第 1—8 题）
// ============================================================
#import "../_template.typ": *
#import "../_figs.typ": *

// ---------------- 第 8 题 ----------------
#qhead(8, pts: 5)
对于函数 $f(x)$，当 $x > 0$ 时 $f(x) > f'(x)$。在锐角 $triangle A B C$ 中，角 $A$、$B$、$C$ 所对的边
分别为 $a$、$b$、$c$，且 $b cos C + c cos B > a cos C + c cos A$。设
$x_1 = a/b$，$x_2 = sin A / sin B$，$x_3 = A/B$，则（本题角度采用弧度制计算）（    ）

#opts((
  [#text(size: 8.5pt)[$f(x_1)/e^{x_1} > f(x_2)/e^{x_2} > f(x_3)/e^{x_3}$]],
  [#text(size: 8.5pt)[$f(x_1)/e^{x_1} = f(x_2)/e^{x_2} > f(x_3)/e^{x_3}$]],
  [#text(size: 8.5pt)[$f(x_1)/e^{x_1} < f(x_2)/e^{x_2} < f(x_3)/e^{x_3}$]],
  [#text(size: 8.5pt)[$f(x_1)/e^{x_1} = f(x_2)/e^{x_2} < f(x_3)/e^{x_3}$]],
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

  由正弦定理 $x_2 = sin A / sin B = a / b = x_1$。

  又函数 $h(t) = sin t / t$ 在 $(0, pi)$ 上单调递减（因
  $h' (t) = (t cos t - sin t)/t^2 < 0$）。由 $A > B > 0$ 得
  $sin A / A < sin B / B$，即 $a/A < b/B$，即 $a B < A b$，即
  $
    x_1 = a/b < A/B = x_3,
  $
  于是 $0 < x_1 = x_2 < x_3$。

  *第三步：考察 $g(x) = f(x)/e^x$。*

  对 $x > 0$，
  $
    g' (x) = (f' (x) e^x - f(x) e^x) / e^{2x} = (f' (x) - f(x)) / e^x < 0,
  $
  由条件 $f(x) > f' (x)$ 知 $g$ 在 $(0, +oo)$ 上单调递减。

  由 $0 < x_1 = x_2 < x_3$ 得 $g(x_1) = g(x_2) > g(x_3)$，即
  $f(x_1)/e^{x_1} = f(x_2)/e^{x_2} > f(x_3)/e^{x_3}$。
]
#ans[$f(x_1)/e^{x_1} = f(x_2)/e^{x_2} > f(x_3)/e^{x_3}$，选 #text(weight: "bold")[B]]

#fcap(
  scale: 0.95,
  caption: [第 8 题  $x_1 = x_2 < x_3$，而 $g = f/e^x$ 在 $(0, +oo)$ 递减，故 $g(x_1) = g(x_2) > g(x_3)$],
  {
    let gy = u => 3.5 * calc.exp(0.42 * (1.2 - u))
    plot(gy, 0.02, 4.7, stroke: s(blue, th: 1.3pt))
    ln((-0.2, 0.0), (5.0, 0.0), stroke: s(black, th: 0.7pt))
    ln((0.0, -0.4), (0.0, 4.4), stroke: s(black, th: 0.7pt))
    txt((5.1, 0.0), anchor: "west", dx: 0.05, [$x$])
    txt((0.0, 4.5), anchor: "south", [$g$])

    pt((1.1, gy(1.1)), r: 0.07, fill: red)
    ln((1.1, 0.0), (1.1, gy(1.1)), stroke: sd(red, th: 0.6pt))
    txt((1.1, gy(1.1)), anchor: "south", dy: 0.1, tsize: 0.145, [$g(x_1)=g(x_2)$])
    txt((1.1, 0.0), anchor: "north", dy: -0.09, tsize: 0.145, [$x_1 = x_2$])

    pt((3.3, gy(3.3)), r: 0.07, fill: green)
    ln((3.3, 0.0), (3.3, gy(3.3)), stroke: sd(green, th: 0.6pt))
    txt((3.3, gy(3.3)), anchor: "south", dy: 0.1, tsize: 0.145, [$g(x_3)$])
    txt((3.3, 0.0), anchor: "north", dy: -0.09, tsize: 0.145, [$x_3$])
  },
)
