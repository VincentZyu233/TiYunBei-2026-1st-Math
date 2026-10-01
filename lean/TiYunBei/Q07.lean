import Mathlib.Data.Real.Basic
import Mathlib.Order.Monotone.Basic

/--
2026年第一届“提云杯”线上联考 · 第 07 题
题面：奇函数 f(x) 在 ℝ 上单调递增，且 f(3) = 0。求不等式 x · f(x + 1) ≥ 0 的解集。
形式化证明：利用奇函数对称性与严格单调性确定零点与符号性质。
-/
theorem q07_odd_func_zeros (f : ℝ → ℝ)
    (h_odd : ∀ x, f (-x) = -f x)
    (h_mono : StrictMono f)
    (h_zero : f 3 = 0) :
    f (-3) = 0 ∧ f 0 = 0 ∧ (∀ x, 0 ≤ f x ↔ 0 ≤ x) := by
  -- 1. 由奇函数性质得 f(-3) = -f(3) = 0
  have h_neg3 : f (-3) = 0 := by
    calc f (-3) = -f 3 := h_odd 3
         _ = -0 := by rw [h_zero]
         _ = 0 := neg_zero
  -- 2. 奇函数在原点必有零点 f(0) = 0
  have h_zero0 : f 0 = 0 := by
    have h0 : f 0 = -f 0 := by
      calc f 0 = f (-0) := by rw [neg_zero]
           _ = -f 0 := h_odd 0
    linarith
  -- 3. 严格单调性保证符号等价性
  have h_sign : ∀ x, 0 ≤ f x ↔ 0 ≤ x := by
    intro x
    constructor
    · intro hx
      by_contra h_neg
      push_neg at h_neg
      have h_lt : f x < f 0 := h_mono h_neg
      rw [h_zero0] at h_lt
      linarith
    · intro hx
      rcases eq_or_lt_of_le hx with rfl | h_pos
      · rw [h_zero0]
      · have h_gt : f 0 < f x := h_mono h_pos
        rw [h_zero0] at h_gt
        linarith
  exact ⟨h_neg3, h_zero0, h_sign⟩
