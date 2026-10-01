import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Data.Real.Basic

open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/--
2026年第一届“提云杯”线上联考 · 第 03 题
题面：设平面向量 a, b 满足 ‖a + b‖ = √3, ‖a - b‖ = 1，则 a · b = 1/2。
形式化证明：利用实内积空间的极化恒等式 (Polarization Identity)
4 ⟪a, b⟫_ℝ = ‖a + b‖² - ‖a - b‖² 求解。
-/
theorem q03_vector_inner_product (a b : E)
    (h1 : ‖a + b‖ ^ 2 = 3)
    (h2 : ‖a - b‖ ^ 2 = 1) :
    ⟪a, b⟫_ℝ = (1 : ℝ) / 2 := by
  -- 1. 展开极化恒等式
  have h_polar : 4 * ⟪a, b⟫_ℝ = ‖a + b‖ ^ 2 - ‖a - b‖ ^ 2 := by
    rw [norm_add_pow_two_real, norm_sub_pow_two_real]
    ring
  -- 2. 代入已知模长平方条件
  rw [h1, h2] at h_polar
  -- 3. 线性代数归约求解内积
  linarith
