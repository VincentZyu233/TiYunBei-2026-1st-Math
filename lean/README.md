# 2026年第一届“提云杯”线上联考 · Lean 4 形式化数学验证

本目录包含精选 5 道代表性试题在 **Lean 4** 交互式定理证明系统下的形式化数学建模与严格推演：

- `TiYunBei/Q03.lean`: 第 03 题 · 实内积空间极化恒等式与内积求解
- `TiYunBei/Q07.lean`: 第 07 题 · 奇函数单调性、对称零点与区间不等式
- `TiYunBei/Q08.lean`: 第 08 题 · 差函数正切导数正定性与切线放缩 $t < \tan t$
- `TiYunBei/Q09.lean`: 第 09 题 · 复数除法分母有理化与代数共轭化简
- `TiYunBei/Q19.lean`: 第 19 题 · 压轴数列指数切线放缩与阶乘平方不等式 $(n!)^2 < e^{n^2 - n}$

## 本地编译与验证

需安装 [Lean 4 (elan)](https://github.com/leanprover/elan)：

```bash
cd lean
lake update
lake build
```
