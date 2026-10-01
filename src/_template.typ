// ============================================================
//  共用模板: 字体、页面、题目骨架、答案标注
//  被 select.typ / multi.typ / fill.typ / solve.typ 引用
// ============================================================

#import "@preview/cetz:0.5.2"
#import "_math.typ": vec, RR, NN, ZZ, QQ, CC, oo, iff, Longrightarrow, implies, cdot

// ---------- 字体 ----------
// 霞鹜文楷等宽变体 (LXGW WenKai Mono), 本地编译时由 --font-path 注入, 不进仓库; 系统字体作为兜底。
#let kai = "LXGW WenKai Mono"
#let song = "Source Han Serif SC"

#set text(
  font: (
    kai,          // 锁定单一 mono 变体: 霞鹜文楷等宽
    song,         // 兜底
    "SimSun",
  ),
  size: 10.5pt,
  lang: "zh",
)

// 图题不显示 "Figure N:" 这类默认编号, 只保留中文图注。
#show figure.caption: it => text(size: 8.5pt, fill: rgb("#666666"))[#it.body]
#set figure(numbering: none, supplement: [图], gap: 4pt)

// ---------- 页面 ----------
#set page(
  paper: "a4",
  margin: (top: 2.0cm, bottom: 1.9cm, left: 2.0cm, right: 2.0cm),
  footer: context [
    #set text(size: 8pt, fill: rgb("#999999"))
    #grid(
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      [2026 提云杯 · 数学 · 参考解答],
      [第 #counter(page).display() 页],
      [],
    )
  ],
)

// ---------- 标题 ----------
#let title-block(title: "", subtitle: "") = block[
  #set align(center)
  #text(size: 16pt, weight: "bold")[#title]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#666666"))[#subtitle]
  #v(8pt)
]

// ---------- 题目骨架 ----------
// qhead 顺带插入一个零尺寸锚点标记 (用 metadata 携带题号),
// build.py --shots 会 typst query 出这些标记的位置, 再按题号切图。
#let qhead(n, pts: none) = block[
  #box(width: 0pt, height: 0pt)[#metadata((qno: n)) <qm>]
  #text(weight: "bold", size: 11pt)[#n.]
  #if pts != none [
    #h(0.3em)
    #text(size: 8pt, fill: rgb("#aaaaaa"))[#pts 分]
  ]
  #h(0.5em)
]

// 选项
#let opts(items, columns: 4) = block[
  #grid(
    columns: if columns == 4 { (1fr,) * 4 } else { (1fr, 1fr) },
    gutter: 8pt,
    ..items,
  )
]

#let sol(body) = block[
  #v(2pt)
  #text(weight: "bold", fill: rgb("#1a4d8f"))[解] #h(0.4em)
  #body
]

#let ans(body) = block[
  #v(3pt)
  #rect(
    inset: (x: 7pt, y: 3.5pt),
    radius: 2pt,
    fill: rgb("#eef4fb"),
    stroke: rgb("#1a4d8f") + 0.6pt,
  )[
    #text(weight: "bold", fill: rgb("#1a4d8f"))[答案] #h(0.5em) #body
  ]
  #v(3pt)
]

#let note(body) = block[
  #v(1pt)
  #text(size: 8.5pt, fill: rgb("#888888"), body)
]

#let figcap(body) = block[
  #v(1pt)
  #align(center)[#text(size: 8.5pt, fill: rgb("#777777"), body)]
  #v(5pt)
]

// 填空题横线 (标准试卷下划线)
#let blank(w: 4.5em) = box(width: w, stroke: (bottom: 0.75pt + black), baseline: 0.12em)[]

// 题目之间分隔
#let qsep = block[
  #v(6pt)
  #line(length: 100%, stroke: rgb("#eeeeee") + 0.5pt)
  #v(6pt)
]