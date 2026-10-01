#!/usr/bin/env python
"""
norm_math.py —— LaTeX → Typst 数学写法规范化

背景: Typst 的数学模式与 LaTeX 有几处不兼容, 直接照抄 LaTeX 会报
"unknown variable"。本脚本在 src/*.typ 上做幂等的批量替换:

  - \\sqrt{3}      → sqrt(3)
  - \\pi \\alpha … → pi / alpha …
  - \\leqslant     → <=
  - \\cap \\cup    → ∩ / ∪
  - \\vec{x}       → vec(x)
  - 多字母几何记号 ABC → A B C   (Typst 会把 ABC 当成 A·B·C)

同类的姊妹脚本: fix_punct.py (标点规范化)。

用法:
    uv run python temp/scripts/norm_math.py            # 处理 src 下所有 .typ
    uv run python temp/scripts/norm_math.py --check    # 只报告, 不写入
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
SRC_DIR = SCRIPT_DIR.parent / "src"

# LaTeX 命令 -> Typst
COMMANDS: list[tuple[str, str]] = [
    # 根号: \sqrt3 -> sqrt(3), \sqrt{3} -> sqrt(3)
    (r"\\sqrt\s*\{([^{}]+)\}", r"sqrt(\1)"),
    (r"\\sqrt\s*(\d+)", r"sqrt(\1)"),
    # 希腊字母
    (r"\\alpha", "alpha"),
    (r"\\beta", "beta"),
    (r"\\gamma", "gamma"),
    (r"\\delta", "delta"),
    (r"\\theta", "theta"),
    (r"\\lambda", "lambda"),
    (r"\\mu", "mu"),
    (r"\\nu", "nu"),
    (r"\\sigma", "sigma"),
    (r"\\varphi", "varphi"),
    (r"\\phi", "phi"),
    (r"\\omega", "omega"),
    (r"\\pi", "pi"),
    # 常用符号
    (r"\\leqslant", "<="),
    (r"\\geqslant", ">="),
    (r"\\le\b", "<="),
    (r"\\ge\b", ">="),
    (r"\\neq", "!="),
    (r"\\ne\b", "!="),
    (r"\\cup", "union"),
    (r"\\cap", "intersect"),
    (r"\\in\b", "in"),
    (r"\\cdot", "dot"),
    (r"\\triangle", "triangle"),
    (r"\\angle", "angle"),
    (r"\\parallel", "parallel"),
    (r"\\perp", "perp"),
    (r"\\cdots", "dots"),
    (r"\\ldots", "dots"),
    (r"\\dots", "dots"),
    (r"\\sim\b", "~"),
    (r"\\approx", "approx"),
    (r"\\to\b", "->"),
    (r"\\rightarrow", "->"),
    (r"\\left", ""),
    (r"\\right", ""),
    (r"\\displaystyle", ""),
    # 自定义简写 (本项目约定: 直接写标识符)
    (r"\\vec\(", "vec("),
    (r"\\vec\{([^{}]+)\}", r"vec(\1)"),
    (r"\\mathbb\{R\}", "RR"),
    (r"\\infty", "oo"),
]

# Typst 源码里的 unicode 转义要保留原样, 替换表里用 lambda 避免被当模板解析
ESCAPES: list[tuple[str, str]] = [
    (r"\\u\{201C\}", "“"),
    (r"\\u\{201D\}", "”"),
]

# 数学模式里的多字母标识符: Typst 视为变量连乘, 需显式拆开
# 例: $ABC$ -> $A B C$, $P-ABC$ -> $P-ABC$ 也一样要拆
MULTI_LETTER = re.compile(r"(?<![A-Za-z])([A-Z])([A-Z]{1,})(?![A-Za-z])")
# 已知的"整体标识符"黑名单, 不能拆开
KEEP_WHOLE = {"RR", "ABC", "TBD"}

# 简写定义: 直接在源码里写成 Typst 可用的形式, 不再靠多字母拆分
SHORTHANDS: dict[str, str] = {
    "RR": "RR",
    "vec": "vec",
}


def split_multi(text: str) -> tuple[str, int]:
    """把数学段里的多字母几何标识符拆成逐字母形式。

    Typst 会把 ABC 当成 A·B·C 三个变量连乘, 而几何里 ABC 是一个顶点名,
    故需写成 A B C (Typst 会渲染成紧排)。已在 KEEP_WHOLE 里的不拆。
    """
    count = 0
    out = []
    i = 0
    n = len(text)
    while i < n:
        m = re.match(r"[A-Z]{2,}", text[i:])
        if m and (i == 0 or not text[i - 1].isalpha()) and (i + len(m.group(0)) >= n or not text[i + len(m.group(0))].isalpha()):
            word = m.group(0)
            if word in KEEP_WHOLE:
                out.append(word)
            else:
                out.append(" ".join(word))
                count += 1
            i += len(word)
        else:
            out.append(text[i])
            i += 1
    return "".join(out), count


def convert(text: str) -> tuple[str, int]:
    """返回 (转换后文本, 修改次数)。只替换出现在 $...$ 内的部分。"""
    changes = 0

    # 先按 $...$ 切分, 只处理数学段
    parts = re.split(r"(\$[^$]*\$)", text)
    out: list[str] = []
    for part in parts:
        if part.startswith("$") and part.endswith("$") and len(part) >= 2:
            body = part[1:-1]
            new = body
            for pat, rep in COMMANDS + ESCAPES:
                new, n = re.subn(pat, rep.replace("\\", "\\\\"), new)
                changes += n
            new, n = split_multi(new)
            changes += n
            out.append("$" + new + "$")
        else:
            out.append(part)
    return "".join(out), changes


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true", help="只报告不写入")
    args = ap.parse_args()

    total = 0
    for path in sorted(SRC_DIR.glob("*.typ")):
        original = path.read_text(encoding="utf-8")
        fixed, n = convert(original)
        if n == 0:
            continue
        print(f"{path.name}: {n} 处修改")
        total += n
        if not args.check:
            path.write_text(fixed, encoding="utf-8")

    print(f"\n合计 {total} 处" + ("（仅检查，未写入）" if args.check else ""))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())