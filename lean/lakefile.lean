import Lake
open Lake DSL

package "TiYunBei" where
  version := v!"0.2.0"
  keywords := #["math", "competition", "formalization", "proof", "tiyunbei"]

require "leanprover-community" / "mathlib" @ git "v4.16.0"

@[default_target]
lean_lib "TiYunBei" where
  srcDir := "."
