// ============================================================
//  绘图辅助: 基于 cetz 0.5.2
//
//  三个必须遵守的约定 (均为实测踩坑):
//  1) `body` 若是参数, 必须放在参数列表最末。
//  2) 在自定义辅助函数内必须用 `cetz.draw.xxx` 限定名调用绘图函数。
//     文件顶层 `import cetz.draw: *` 不足以覆盖函数体内的裸 `line`
//     —— 它会解析到 Typst 内置的 line 元素, 报 "unexpected argument"。
//  3) 坐标元组长度须为 2/3 且元素为 int/float/length, 否则
//     panic "Failed to resolve coordinate"。
//
//  另外 Typst 不允许 `color + thickness + (dash: 3)` 这种写法:
//  color 与字典不能相加, 必须整体写成
//  (paint: .., thickness: .., dash: ..), 且 dash 要用具名样式
//  ("dashed") 或数组, 不能是裸整数。
// ============================================================
#import "@preview/cetz:0.5.2"
#import "_template.typ": figcap

// ---- 配色 ----
#let blue = rgb("#1a4d8f")
#let bluefill = rgb("#dbe7f5")
#let red = rgb("#c0392b")
#let redfill = rgb("#f6dcd8")
#let green = rgb("#1a7a4d")
#let greenfill = rgb("#dcf0e6")
#let orange = rgb("#d68910")
#let orangefill = rgb("#fbeed6")
#let purple = rgb("#6c3483")
#let black = rgb("#222222")
#let gray = rgb("#888888")
#let faint = rgb("#dddddd")

// ---- 描边构造 ----
#let s(color, th: 0.8pt) = (paint: color, thickness: th, cap: "round")
#let sd(color, th: 0.55pt, dash: "dashed") = (
  paint: color,
  thickness: th,
  dash: dash,
  cap: "round",
)

// ---- 画布 ----
// vb: 可选的锚定框 (w, h) 单位 cm。
// cetz.canvas 默认按内容 bounding box 定尺寸, 非等比坐标会被拉伸;
// 给一个锚定框可锁住画布长宽比。
#let cv(scale: 0.8, pad: 0.1, vb: none, body) = {
  let c = cetz.canvas(length: scale * 1cm, padding: pad * 1cm, body)
  if vb == none {
    c
  } else {
    let (w, h) = vb
    box(width: w * 1cm, height: h * 1cm, c)
  }
}

// ---- 基础图元 ----
#let ln(..a) = cetz.draw.line(..a)
#let dot(p, ..a) = cetz.draw.circle(p, ..a)
#let box2(a, b, ..style) = cetz.draw.rect(a, b, ..style)
#let seg(a, b, stroke: black + 0.8pt) = cetz.draw.line(a, b, stroke: stroke)

// 文本标签 (tsize 是图上单位数, 实际字号 = tsize * 画布比例)
#let txt(pos, anchor: "base", dx: 0.0, dy: 0.0, tsize: 0.15, body) = cetz.draw.content(
  (pos.at(0) + dx, pos.at(1) + dy),
  text(size: tsize * 1cm)[#body],
  anchor: anchor,
)

// 虚线辅助线
#let dashed(a, b, color: rgb("#999999"), th: 0.55pt) = cetz.draw.line(a, b, stroke: sd(color, th: th))

// 标记点并标注
#let pt(
  p,
  label: none,
  r: 0.055,
  fill: blue,
  dx: 0.0,
  dy: 0.0,
  anchor: "base",
  tsize: 0.15,
) = {
  dot(p, radius: r, fill: fill, stroke: none)
  if label != none { txt(p, anchor: anchor, dx: dx, dy: dy, tsize: tsize, label) }
}

// 坐标轴
#let axes(xmin, xmax, ymin, ymax, xl: none, yl: none) = {
  ln((xmin * 1.0, 0.0), (xmax * 1.0, 0.0), stroke: s(black, th: 0.7pt))
  ln((0.0, ymin * 1.0), (0.0, ymax * 1.0), stroke: s(black, th: 0.7pt))
  if xl != none { txt((xmax * 1.0, 0.0), anchor: "west", dx: 0.06, tsize: 0.16, xl) }
  if yl != none { txt((0.0, ymax * 1.0), anchor: "south", dy: 0.05, tsize: 0.16, yl) }
}

// ---- 曲线 ----
// y = f(x)
#let plot(f, t0, t1, samples: 140, stroke: none) = {
  let pts = range(samples + 1).map(i => {
    let t = t0 + (t1 - t0) * i / samples
    (t, f(t))
  })
  ln(..pts, stroke: stroke)
}

// 参数曲线 r(t) -> (x, y)
#let param(f, t0, t1, samples: 140, stroke: none) = {
  let pts = range(samples + 1).map(i => {
    let t = t0 + (t1 - t0) * i / samples
    f(t)
  })
  ln(..pts, stroke: stroke)
}

// ============================================================
//  三维轴测投影 —— 高中数学的标准画法
//
//            z ↑
//              |
//              |
//            O ├──────→ y
//           /
//          /
//         ↙
//        x
//
//  即: z 轴垂直向上, y 轴水平向右, x 轴斜向左下方 (指向观察者前方)。
//  这个方向约定与教材一致, 画立体几何图时不要用其他方向。
//
//  三个轴的像:
//      x -> (-k, -k)   斜向左下
//      y -> ( 1,  0)   水平向右
//      z -> ( 0,  1)   垂直向上
// ============================================================
#let proj3(p, k: 0.5) = (
  -k * p.at(0) + p.at(1),
  -k * p.at(0) + p.at(2),
)

// 三维坐标轴: z 垂直向上, y 水平向右, x 斜向左下 (教材标准画法)
// 箭头画成两笔倒钩 (barb), 尖端在轴的末端; 轴标签贴在箭头旁边。
// 用法: axes3(xlen: 2, ylen: 2, zlen: 2, origin: (0,0,0))
// 负半轴按需画 (画负轴: xneg: true 等)
#let axes3(
  xlen: 1.0,
  ylen: 1.0,
  zlen: 1.0,
  xlab: [$x$],
  ylab: [$y$],
  zlab: [$z$],
  origin: (0.0, 0.0, 0.0),
  k: 0.5,
  tsize: 0.17,
  xneg: false,
  yneg: false,
  zneg: false,
  olabel: none,
  arrow: 0.22,
  barbs: 2,
) = {
  let o = proj3(origin, k: k)

  // 单条带箭头的轴: 从 o 指向 proj3(origin+axis), 末端画 barbs 倒钩
  let axis-arrow(from, to, color: black) = {
    ln(from, to, stroke: s(color, th: 0.8pt))
    let dx = to.at(0) - from.at(0)
    let dy = to.at(1) - from.at(1)
    let len = calc.sqrt(dx * dx + dy * dy)
    if len > 0 {
      let ux = dx / len
      let uy = dy / len
      // 倒钩方向: 与轴垂直
      let (px, py) = (-uy, ux)
      for i in range(barbs) {
        // 沿轴往回退得越多, 倒钩张得越开 -> 经典箭头形
        let back = arrow * (1 - i * 0.42)
        let side = if i == 0 { 1.0 } else { 0.62 }
        ln(
          to,
          (
            to.at(0) - ux * back + px * arrow * side,
            to.at(1) - uy * back + py * arrow * side,
          ),
          stroke: s(color, th: 0.8pt),
        )
      }
    }
  }

  let ex = proj3(origin + (xlen, 0.0, 0.0), k: k)
  let ey = proj3(origin + (0.0, ylen, 0.0), k: k)
  let ez = proj3(origin + (0.0, 0.0, zlen), k: k)
  axis-arrow(o, ex)
  axis-arrow(o, ey)
  axis-arrow(o, ez)

  // 轴标签: 贴住箭头尖端, 沿轴向外的法线一侧
  txt(ex, anchor: "north-west", dx: -0.12, dy: 0.08, tsize: tsize, xlab)
  txt(ey, anchor: "north", dy: 0.12, tsize: tsize, ylab)
  txt(ez, anchor: "north", dy: 0.12, tsize: tsize, zlab)

  // 负半轴 (虚线, 无箭头无标签)
  if xneg {
    dashed(o, proj3(origin - (xlen, 0.0, 0.0), k: k), color: gray, th: 0.5pt)
  }
  if yneg {
    dashed(o, proj3(origin - (0.0, ylen, 0.0), k: k), color: gray, th: 0.5pt)
  }
  if zneg {
    dashed(o, proj3(origin - (0.0, 0.0, zlen), k: k), color: gray, th: 0.5pt)
  }

  // 原点
  dot(o, radius: 0.05, fill: black, stroke: none)
  if olabel != none {
    txt(o, anchor: "north-east", dx: -0.07, dy: -0.06, tsize: tsize, olabel)
  }
}

// ---- 带图题的图 ----
// vb: 可选的锚定框 (w, h) 单位 cm, 用来锁定画布长宽比
#let fcap(body, scale: 0.8, pad: 0.1, vb: none, caption: none) = figure(
  cv(scale: scale, pad: pad, vb: vb, body),
  caption: if caption == none { none } else { figcap(caption) },
  gap: 4pt,
)

// 独立图 (src/figs/*.typ 的顶层内容): 无图题、无编号, 供导出 PNG
#let figframe(body, scale: 0.8, pad: 0.12, vb: none) = cv(
  scale: scale,
  pad: pad,
  vb: vb,
  body,
)

// 图内网格: 压暗背景 + 显式单位方框, 强制画布等比, 避免被 bbox 拉伸
// px/py 为绘图区尺寸 (cm), nx/ny 为单位格数, base 为基点 (绘图区左下角)
#let grid2d(base, px, py, nx: 10, ny: 10, color: rgb("#f2f4f7"), minor: true, ..body) = {
  let (bx, by) = base
  box2((bx, by), (bx + px, by + py), fill: white)
  // 浅色背景
  box2((bx, by), (bx + px, by + py), fill: rgb("#f7f9fc"))
  if minor {
    for i in range(nx + 1) {
      let gx = bx + px * i / nx
      ln((gx, by), (gx, by + py), stroke: s(rgb("#e3e8ef"), th: 0.35pt))
    }
    for i in range(ny + 1) {
      let gy2 = by + py * i / ny
      ln((bx, gy2), (bx + px, gy2), stroke: s(rgb("#e3e8ef"), th: 0.35pt))
    }
  }
  // 单位框
  for i in range(nx + 1) {
    let gx = bx + px * i / nx
    ln((gx, by), (gx, by + py), stroke: s(rgb("#c8d0da"), th: 0.5pt))
  }
  for i in range(ny + 1) {
    let gy2 = by + py * i / ny
    ln((bx, gy2), (bx + px, gy2), stroke: s(rgb("#c8d0da"), th: 0.5pt))
  }
  body
}