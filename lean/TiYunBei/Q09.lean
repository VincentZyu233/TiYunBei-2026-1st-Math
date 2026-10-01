import Mathlib.Data.Complex.Basic

open Complex

/--
2026年第一届“提云杯”线上联考 · 第 09 题
题面：设复数 z₁ = 3 + i, z₂ = 1 - 3i，验证选项 D 中 z₁ / z₂ = i ≠ 1 + i。
形式化证明：分母有理化，分子分母同乘共轭复数 1 + 3i，展开化简。
-/
theorem q09_complex_div :
    ((3 : ℂ) + I) / (1 - 3 * I) = I := by
  -- 1. 分母展开：(1 - 3i)(1 + 3i) = 1 - 9i² = 1 + 9 = 10
  have h_denom : (1 - 3 * I) * (1 + 3 * I) = 10 := by
    calc (1 - 3 * I) * (1 + 3 * I)
      _ = 1 - (3 * I) ^ 2 := by ring
      _ = 1 - 9 * I ^ 2 := by ring
      _ = 1 - 9 * (-1) := by rw [I_sq]
      _ = 10 := by norm_num

  -- 2. 分子展开：(3 + i)(1 + 3i) = 3 + 9i + i + 3i² = 10i
  have h_numer : ((3 : ℂ) + I) * (1 + 3 * I) = 10 * I := by
    calc ((3 : ℂ) + I) * (1 + 3 * I)
      _ = 3 + 9 * I + I + 3 * I ^ 2 := by ring
      _ = 3 + 10 * I + 3 * (-1) := by rw [I_sq]; ring
      _ = 10 * I := by ring

  -- 3. 分式有理化同乘恒等变形
  have h_div : ((3 : ℂ) + I) / (1 - 3 * I) = (((3 : ℂ) + I) * (1 + 3 * I)) / ((1 - 3 * I) * (1 + 3 * I)) := by
    have h_ne : 1 + 3 * I ≠ 0 := by
      intro h
      apply_fun Complex.re at h
      simp at h
    exact mul_div_mul_right ((3 : ℂ) + I) (1 - 3 * I) h_ne |>.symm

  -- 4. 代入求商得结果为 I
  rw [h_div, h_numer, h_denom]
  calc (10 * I) / 10
    _ = (10 / 10 : ℂ) * I := by ring
    _ = 1 * I := by norm_num
    _ = I := by ring
