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
// scale: 1 个坐标单位对应的物理长度 (cm)。图要放大就调它。
// pad:   画布四周留白 (cm), 防止标签贴边。
// vb:    可选外框 (w, h) 单位 cm。
//
// 注意: cetz.canvas 按内容 bounding box 定尺寸, 但【不做非等比拉伸】——
// 坐标比例失真不会让图形变形 (已实测: x/y 比例 4.3:1 时圆仍是圆)。
// 所以 vb 只影响外框留白, 不是"锁比例"的手段, 多数情况不需要传。
// 若图形看起来不对, 先查 padding 与标签是否溢出, 而不是加 vb。
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

// ============================================================
//  坐标轴箭头 arrowhead
//
//  dirx / diry 是轴的方向向量 (不必是单位向量, 内部会归一化)。
//  关键: 倒钩必须沿轴法向的【两侧】对称展开, 否则箭头只有半边。
//    ux, uy  = 轴方向单位向量 (指向箭头尖端)
//    px, py  = 法向单位向量 = (-uy, ux)
//  倒钩终点 = 尖端 - u*back + p*side, side 取 ±spread*back。
//
//  spread 控制翼的张开角: 0.38 约 ±21°, 高中教材常见值。
//  barbs = 每侧倒钩条数, 1 = 简洁的 >, 2 = 加粗翼。
//  filled = true 画实心三角形 (教材插图常用)。
// ============================================================
#let arrowhead(
  tip,
  dirx,
  diry,
  size: 0.2,
  color: black,
  th: 0.8pt,
  barbs: 2,
  spread: 0.38,
  filled: false,
) = {
  let len = calc.sqrt(dirx * dirx + diry * diry)
  if len == 0 {
    return
  }
  let ux = dirx / len
  let uy = diry / len
  let (px, py) = (-uy, ux) // 法向

  if filled {
    // 实心箭头: 尖端 + 两条翼的终点构成三角形
    let back = size
    let wing = spread * back
    ln(
      tip,
      (tip.at(0) - ux * back + px * wing, tip.at(1) - uy * back + py * wing),
      (tip.at(0) - ux * back - px * wing, tip.at(1) - uy * back - py * wing),
      close: true,
      fill: color,
      stroke: s(color, th: th),
    )
  } else {
    // 线条箭头: 两侧对称各画 barbs 条
    for sgn in (1.0, -1.0) {
      for i in range(barbs) {
        let back = size * (1 - i * 0.42)
        let side = spread * back * sgn
        ln(
          tip,
          (tip.at(0) - ux * back + px * side, tip.at(1) - uy * back + py * side),
          stroke: s(color, th: th),
        )
      }
    }
  }
}

// ============================================================
//  平面坐标轴 (强制规范: 必须带箭头 + 轴名)
//
//  xl / yl 为轴名, 省略时留空箭头不标名; 但箭头始终画。
//  若轴表示复平面, 传 xl: [$"Re"$], yl: [$"Im"$] 之类。
// ============================================================
#let axes(
  xmin,
  xmax,
  ymin,
  ymax,
  xl: none,
  yl: none,
  arrow: 0.2,
  tsize: 0.16,
  filled: true,
) = {
  // 正半轴画到边界, 箭头再往前伸一点, 保证箭头完整可见
  let ex = (xmax * 1.0 + arrow * 0.9, 0.0)
  let ey = (0.0, ymax * 1.0 + arrow * 0.9)
  ln((xmin * 1.0, 0.0), ex, stroke: s(black, th: 0.7pt))
  ln((0.0, ymin * 1.0), ey, stroke: s(black, th: 0.7pt))
  // 实心箭头: 高中教材插图的常见画法
  arrowhead(ex, 1.0, 0.0, size: arrow, th: 0.7pt, filled: filled)
  arrowhead(ey, 0.0, 1.0, size: arrow, th: 0.7pt, filled: filled)

  if xl != none { txt(ex, anchor: "west", dx: 0.04, tsize: tsize, xl) }
  if yl != none { txt(ey, anchor: "south", dy: 0.04, tsize: tsize, yl) }
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


  let ex = proj3(origin + (xlen, 0.0, 0.0), k: k)
  let ey = proj3(origin + (0.0, ylen, 0.0), k: k)
  let ez = proj3(origin + (0.0, 0.0, zlen), k: k)

  // 三条轴 + 末端箭头 (箭头方向即该轴的投影方向, 故自动朝外)
  ln(o, ex, stroke: s(black, th: 0.8pt))
  ln(o, ey, stroke: s(black, th: 0.8pt))
  ln(o, ez, stroke: s(black, th: 0.8pt))
  arrowhead(ex, ex.at(0) - o.at(0), ex.at(1) - o.at(1), size: arrow, barbs: barbs)
  arrowhead(ey, ey.at(0) - o.at(0), ey.at(1) - o.at(1), size: arrow, barbs: barbs)
  arrowhead(ez, ez.at(0) - o.at(0), ez.at(1) - o.at(1), size: arrow, barbs: barbs)

  // 轴标签: 贴住箭头尖端
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
// vb: 可选外框 (w, h) 单位 cm, 仅影响留白, 详见 cv() 的说明
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

// 图内网格: 浅色背景 + 显式单位方框, 让画布边界与比例一目了然
// px/py 为绘图区尺寸 (cm), nx/ny 为单位格数, base 为基点 (绘图区左下角)
// color: 背景色; major: 单位框线色; minor: 更密的次级网格 (mx/my 为其格数)
#let grid2d(
  base,
  px,
  py,
  nx: 10,
  ny: 10,
  color: rgb("#f7f9fc"),
  major: rgb("#c8d0da"),
  mx: 0,
  my: 0,
  ..body,
) = {
  let (bx, by) = base
  box2((bx, by), (bx + px, by + py), fill: color)

  // 次级网格: 仅当 mx/my 比分格更密时才画, 避免与单位框重叠
  if mx > nx {
    for i in range(mx + 1) {
      let gx = bx + px * i / mx
      ln((gx, by), (gx, by + py), stroke: s(major, th: 0.25pt))
    }
  }
  if my > ny {
    for i in range(my + 1) {
      let gy2 = by + py * i / my
      ln((bx, gy2), (bx + px, gy2), stroke: s(major, th: 0.25pt))
    }
  }

  // 单位框
  for i in range(nx + 1) {
    let gx = bx + px * i / nx
    ln((gx, by), (gx, by + py), stroke: s(major, th: 0.5pt))
  }
  for i in range(ny + 1) {
    let gy2 = by + py * i / ny
    ln((bx, gy2), (bx + px, gy2), stroke: s(major, th: 0.5pt))
  }
  body
}