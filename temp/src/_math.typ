// ============================================================
//  数学简写
//
//  原理: Typst 的数学模式可以直接调用用户定义的函数与常量, 所以把
//  vec / oo / RR 这些写成顶层 #let, 数学里就能当内置符号用。
//
//  注意:
//  - `sym.oo` 在代码模式下写 (不带 #); 在数学模式里插值才需要 #。
//  - 数学里没有 math.scope, 也不需要它。
//  - 向量箭头用 math.accent(x, math.top); accent 不接受 tr: 参数,
//    要指定方向得用 math.accent(x, math.top) 后再手动加符号。
// ============================================================

// 向量 / 有向线段字母
#let vec(x) = math.accent(x, math.top)

// 数集 (直接用 unicode 双线体, 最稳)
#let RR = "ℝ"
#let NN = "ℕ"
#let ZZ = "ℤ"
#let QQ = "ℚ"
#let CC = "ℂ"

// 无穷
#let oo = sym.oo

// 常用逻辑与箭头
#let iff = sym.arrow.r.double
#let Longrightarrow = sym.arrow.r.long
#let implies = sym.arrow.r

// 常用三角/双曲函数名 (Typst 数学模式已内置 sin/cos/tan, 这里补双曲)
#let sinh = "sinh"
#let cosh = "cosh"
#let tanh = "tanh"