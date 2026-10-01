// ---------------- 第 13 题 ----------------
#import "../_template.typ": *
#import "../_figs.typ": *

#qhead(13, pts: 5)
设函数 $f(x) = sin(2x - pi/6)$（$x in (0, pi)$），若方程 $f(x) = 3/5$ 的解分别为 $alpha, beta$（$0 < alpha < beta < pi$），则 $alpha + beta =$ #blank()；$sin(alpha - beta) =$ #blank()。

#sol[
  由 $x in (0, pi)$，得 $2x in (0, 2pi)$，因此
  $ 2x - pi/6 in (-pi/6, (11pi)/6). $
  令 $theta = 2x - pi/6$，则方程转化为 $sin theta = 3/5$，其中 $theta in (-pi/6, (11pi)/6)$。

  因为 $0 < 3/5 < 1$，在区间 $(-pi/6, (11pi)/6)$ 内，正弦方程 $sin theta = 3/5$ 恰有两个相异实根：
  $ theta_1 = 2alpha - pi/6 in (0, pi/2), quad theta_2 = 2beta - pi/6 in (pi/2, pi). $
  由正弦函数在第二象限的诱导公式，此两根关于 $theta = pi/2$ 对称，满足
  $ theta_1 + theta_2 = pi. $

  #align(center)[
    #fcap(
      scale: 1.3,
      caption: [换元后标准正弦曲线 $y = sin theta$ 在 $(-frac(pi, 6), frac(11pi, 6))$ 上的图像，两交点关于 $theta = frac(pi, 2)$ 对称，故 $theta_1 + theta_2 = pi$],
      {
        let f(th) = calc.sin(th)
        let th_min = -calc.pi / 6.0
        let th_max = 11.0 * calc.pi / 6.0

        // 坐标轴
        axes(-0.8, 6.2, -1.25, 1.45, xl: [$theta$], yl: [$y$], arrow: 0.22, tsize: 0.32)
        txt((-0.12, 0.08), anchor: "south-east", tsize: 0.30, weight: "bold", [$O$])

        // y = sin(theta) 曲线
        plot(f, th_min, th_max, samples: 200, stroke: s(blue, th: 1.5pt))
        txt((calc.pi / 2.0, 1.16), anchor: "south", tsize: 0.30, text(fill: blue, weight: "bold")[$y = sin theta$])

        // 水平割线 y = 3/5 贯穿延伸
        let y_line = 3.0 / 5.0
        ln((-0.6, y_line), (6.0, y_line), stroke: s(orange, th: 1.2pt))
        txt((6.05, y_line), anchor: "west", tsize: 0.28, text(fill: orange, weight: "bold")[$y = frac(3, 5)$])

        // 对称轴 theta = pi/2 ≈ 1.5708
        let th_sym = calc.pi / 2.0
        dashed((th_sym, -1.15), (th_sym, 1.35), color: purple, th: 0.85pt)
        txt((th_sym, 1.38), anchor: "south", tsize: 0.28, text(fill: purple, weight: "bold")[对称轴 $theta = frac(pi, 2)$])
        txt((th_sym, 0.0), anchor: "north", dy: -0.06, tsize: 0.28, text(fill: purple, weight: "bold")[$frac(pi, 2)$])

        // 根 theta_1 ≈ 0.6435, theta_2 = pi - theta_1 ≈ 2.4981
        let th1 = 0.6435
        let th2 = calc.pi - th1

        // 点 theta_1
        pt((th1, y_line), r: 0.065, fill: red)
        dashed((th1, 0.0), (th1, y_line), color: red, th: 0.7pt)
        txt((th1, 0.0), anchor: "north", dy: -0.06, tsize: 0.30, text(fill: red, weight: "bold")[$theta_1$])
        txt((th1, y_line), anchor: "south-east", dx: -0.08, dy: 0.08, tsize: 0.28, text(fill: red, weight: "bold")[$(theta_1, 3/5)$])

        // 点 theta_2
        pt((th2, y_line), r: 0.065, fill: red)
        dashed((th2, 0.0), (th2, y_line), color: red, th: 0.7pt)
        txt((th2, 0.0), anchor: "north", dy: -0.06, tsize: 0.30, text(fill: red, weight: "bold")[$theta_2$])
        txt((th2, y_line), anchor: "south-west", dx: 0.08, dy: 0.08, tsize: 0.28, text(fill: red, weight: "bold")[$(theta_2, 3/5)$])

        // 零点 pi
        txt((calc.pi, 0.0), anchor: "north-west", dx: 0.05, dy: -0.06, tsize: 0.28, weight: "bold", [$pi$])

        // 定义域边界端点: -pi/6 与 11pi/6 (开区间用空心圆点)
        dashed((th_min, 0.0), (th_min, -0.5), color: gray, th: 0.6pt)
        dot((th_min, -0.5), radius: 0.05, stroke: s(blue, th: 0.9pt), fill: white)
        txt((th_min, 0.0), anchor: "south", dy: 0.08, tsize: 0.26, text(fill: gray)[$-frac(pi, 6)$])

        dashed((th_max, 0.0), (th_max, -0.5), color: gray, th: 0.6pt)
        dot((th_max, -0.5), radius: 0.05, stroke: s(blue, th: 0.9pt), fill: white)
        txt((th_max, 0.0), anchor: "south", dy: 0.08, tsize: 0.26, text(fill: gray)[$frac(11pi, 6)$])
      }
    )
  ]

  *第一问：求 $alpha + beta$。*

  将 $theta_1, theta_2$ 的表达式代入得：
  $ (2alpha - pi/6) + (2beta - pi/6) = 2(alpha + beta) - pi/3 = pi, $
  由此解得：
  $ 2(alpha + beta) = pi + pi/3 = (4pi)/3 ==> alpha + beta = (2pi)/3. $

  *第二问：求 $sin(alpha - beta)$。*

  由两式相减：
  $ (2beta - pi/6) - (2alpha - pi/6) = 2(beta - alpha) = theta_2 - theta_1. $
  由于 $theta_2 = pi - theta_1$，故
  $ theta_2 - theta_1 = pi - 2theta_1 ==> 2(beta - alpha) = pi - 2theta_1 ==> beta - alpha = pi/2 - theta_1. $
  从而
  $ alpha - beta = -(beta - alpha) = theta_1 - pi/2. $
  利用三角函数诱导公式：
  $ sin(alpha - beta) = sin(theta_1 - pi/2) = -cos theta_1. $
  因 $theta_1 in (0, pi/2)$ 且 $sin theta_1 = 3/5$，由同角三角函数基本关系：
  $ cos theta_1 = sqrt(1 - sin^2 theta_1) = sqrt(1 - (3/5)^2) = 4/5. $
  故
  $ sin(alpha - beta) = -4/5. $
]
#ans[$frac(2pi, 3)$ ； $-frac(4, 5)$]

#fcap(
  scale: 1.5,
  caption: [第 13 题  $f(x) = sin(2x - pi/6)$ 在 $(0, pi)$ 上的图像与水平割线 $y = 3/5$ 相交于 $alpha, beta$，两点关于对称轴 $x = pi/3$ 对称],
  {
    let f(x) = calc.sin(2.0 * x - calc.pi / 6.0)

    // 坐标轴
    let x_max = 3.65
    let y_max = 1.55
    axes(-0.4, x_max, -1.25, y_max, xl: [$x$], yl: [$y$], arrow: 0.25, tsize: 0.32)
    txt((-0.16, -0.16), anchor: "north-east", tsize: 0.30, weight: "bold", [$O$])

    // f(x) 曲线 (0, pi)
    plot(f, 0.0, calc.pi, samples: 200, stroke: s(blue, th: 1.6pt))
    txt((calc.pi + 0.08, -0.65), anchor: "west", tsize: 0.28, text(fill: blue, weight: "bold")[$y = f(x)$])

    // 水平割线 y = 3/5 贯穿延伸
    let y_line = 3.0 / 5.0
    ln((-0.35, y_line), (3.55, y_line), stroke: s(orange, th: 1.3pt))
    txt((3.60, y_line), anchor: "west", tsize: 0.28, text(fill: orange, weight: "bold")[$y = frac(3, 5)$])

    // 对称轴 x = pi/3 ≈ 1.047
    let x_sym = calc.pi / 3.0
    dashed((x_sym, -1.15), (x_sym, 1.45), color: purple, th: 0.9pt)
    txt((x_sym, 1.48), anchor: "south", tsize: 0.28, text(fill: purple, weight: "bold")[对称轴 $x = frac(pi, 3)$])
    txt((x_sym, 0.0), anchor: "north", dy: -0.06, tsize: 0.26, text(fill: purple, weight: "bold")[$frac(pi, 3)$])

    // 根 alpha, beta 坐标值
    let val_a = 0.5835
    let val_b = 1.5108

    // 点 alpha
    pt((val_a, y_line), r: 0.07, fill: red)
    dashed((val_a, 0.0), (val_a, y_line), color: red, th: 0.75pt)
    txt((val_a, 0.0), anchor: "north", dy: -0.08, tsize: 0.32, text(fill: red, weight: "bold")[$alpha$])
    txt((val_a, y_line), anchor: "south-east", dx: -0.10, dy: 0.12, tsize: 0.28, text(fill: red, weight: "bold")[$(alpha, 3/5)$])

    // 点 beta
    pt((val_b, y_line), r: 0.07, fill: red)
    dashed((val_b, 0.0), (val_b, y_line), color: red, th: 0.75pt)
    txt((val_b, 0.0), anchor: "north", dy: -0.08, tsize: 0.32, text(fill: red, weight: "bold")[$beta$])
    txt((val_b, y_line), anchor: "south-west", dx: 0.10, dy: 0.12, tsize: 0.28, text(fill: red, weight: "bold")[$(beta, 3/5)$])

    // 边界点 pi
    dashed((calc.pi, -1.0), (calc.pi, 0.0), color: gray, th: 0.6pt)
    txt((calc.pi, 0.0), anchor: "north", dy: -0.08, tsize: 0.30, weight: "bold", [$pi$])
  },
)
