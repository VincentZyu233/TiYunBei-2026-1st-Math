// 第 6 题配图: 三棱锥补成长方体, PM 为外接球直径
// 坐标轴按教材标准画法: z 垂直向上, y 水平向右, x 斜向左下
#import "../_figs.typ": *

#figframe(
  scale: 0.9,
  {
    // 顶点: 以 P 为原点, A/B/C 沿三个坐标轴
    let pa = (1.5, 0.0, 0.0) // A 在 x 轴正方向
    let pb = (0.0, 1.3, 0.0) // B 在 y 轴正方向
    let pc = (0.0, 0.0, 1.7) // C 在 z 轴正方向
    let pm = (1.5, 1.3, 1.7) // 体对角顶点 M

    // 长方体其余三条棱 (虚线)
    dashed(proj3((1.5, 1.3, 0.0)), proj3(pm))
    dashed(proj3((1.5, 0.0, 1.7)), proj3(pm))
    dashed(proj3((0.0, 1.3, 1.7)), proj3(pm))

    // 底面三角形 ABC
    ln(proj3(pa), proj3(pb), stroke: s(black, th: 1.1pt))
    ln(proj3(pb), proj3(pc), stroke: s(black, th: 1.1pt))
    ln(proj3(pc), proj3(pa), stroke: s(black, th: 1.1pt))
    // 三条侧棱 (沿坐标轴, 醒目)
    ln(proj3((0, 0, 0)), proj3(pa), stroke: s(red, th: 1.4pt))
    ln(proj3((0, 0, 0)), proj3(pb), stroke: s(blue, th: 1.4pt))
    ln(proj3((0, 0, 0)), proj3(pc), stroke: s(green, th: 1.4pt))
    // 外接球直径 PM
    ln(proj3((0, 0, 0)), proj3(pm), stroke: sd(red, th: 1.1pt))

    // 顶点标记
    dot(proj3((0, 0, 0)), radius: 0.06, fill: red, stroke: none)
    txt(proj3((0, 0, 0)), anchor: "south-east", dx: -0.06, dy: -0.06, [$P$])
    dot(proj3(pa), radius: 0.055, fill: black, stroke: none)
    txt(proj3(pa), anchor: "north-west", dx: -0.05, dy: 0.05, [$A$])
    dot(proj3(pb), radius: 0.055, fill: black, stroke: none)
    txt(proj3(pb), anchor: "north-west", dx: -0.05, dy: 0.05, [$B$])
    dot(proj3(pc), radius: 0.055, fill: black, stroke: none)
    txt(proj3(pc), anchor: "south", dy: -0.08, [$C$])
    dot(proj3(pm), radius: 0.05, fill: gray, stroke: none)
    txt(proj3(pm), anchor: "north-east", dx: 0.06, tsize: 0.14, [$M$])

    // 坐标轴
    axes3(
      xlen: 2.1,
      ylen: 1.9,
      zlen: 2.4,
      xlab: [$x$],
      ylab: [$y$],
      zlab: [$z$],
      origin: (0, 0, 0),
    )

    // 直径标注
    let mid = proj3((0.75, 0.65, 0.85))
    txt(mid, anchor: "south", dy: -0.1, tsize: 0.145, [$2R = sqrt(8)$])
  },
)