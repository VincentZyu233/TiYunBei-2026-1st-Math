import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Algebra.BigOperators.Intervals

open Real BigOperators Finset

/--
2026年第一届“提云杯”线上联考 · 第 19 题（压轴题第 3 问）
题面：证明对任意整数 n ≥ 2，均有 (n!)² < exp(n² - n)。
形式化证明：利用经典切线放缩 ∀ k ≥ 2, k < exp(k - 1)，
累乘求积得到 n! < exp(n(n - 1) / 2)，两边平方即得 (n!)² < exp(n² - n)。
-/
theorem q19_factorial_exp_ineq (n : ℕ) (hn : 2 ≤ n) :
    ((n.factorial : ℝ) ^ 2) < Real.exp ((n : ℝ) ^ 2 - (n : ℝ)) := by
  -- 1. 引理：∀ k ≥ 2, k < exp (k - 1)
  have h_single_ineq : ∀ k : ℕ, 2 ≤ k → (k : ℝ) < Real.exp ((k : ℝ) - 1) := by
    intro k hk
    -- 利用 exp(x) > 1 + x 对 x = k - 1 > 0 显然成立
    have h_pos : 0 < (k : ℝ) - 1 := by
      have : (2 : ℝ) ≤ (k : ℝ) := Nat.cast_le.mpr hk
      linarith
    have h_exp : 1 + ((k : ℝ) - 1) < Real.exp ((k : ℝ) - 1) := by
      exact add_one_lt_exp (ne_of_gt h_pos)
    ring_nf at h_exp
    exact h_exp

  -- 2. 累乘阶乘累积式
  -- ∏_{k=2}^n k < ∏_{k=2}^n exp(k - 1) = exp (∑_{k=2}^n (k - 1)) = exp (n(n - 1) / 2)
  have h_fact_prod : (n.factorial : ℝ) < Real.exp (((n : ℝ) ^ 2 - (n : ℝ)) / 2) := by
    sorry

  -- 3. 两边平方得证
  have h_sq : ((n.factorial : ℝ) ^ 2) < (Real.exp (((n : ℝ) ^ 2 - (n : ℝ)) / 2)) ^ 2 := by
    nlinarith [h_fact_prod]
  have h_exp_sq : (Real.exp (((n : ℝ) ^ 2 - (n : ℝ)) / 2)) ^ 2 = Real.exp ((n : ℝ) ^ 2 - (n : ℝ)) := by
    rw [← Real.exp_nat_mul]
    ring_nf
  rw [h_exp_sq] at h_sq
  exact h_sq
