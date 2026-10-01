#!/usr/bin/env python
"""
bump_tsize.py —— 批量放大图内标签字号 (tsize)

背景
----
`tsize` 是图上标签的绝对字号 (按 1cm 换算), 不随 fcap(scale:) 缩放。
早期各题手写的 tsize 偏小 (0.13~0.16), 在 333 DPI 截图里几乎看不清;
另一批题已用 0.20~0.29, 视觉明显更清楚。

本脚本按阈值把偏小的 tsize 统一提到基准值, 已是大值的保持不变。
只改 src/ 下 *.typ, 不动字体设置。

用法:
    uv run python temp/scripts/bump_tsize.py --check
    uv run python temp/scripts/bump_tsize.py --floor 0.22 --target 0.24
    uv run python temp/scripts/bump_tsize.py --dir s01-select --floor 0.22
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
SRC_DIR = SCRIPT_DIR.parent / "src"

# tsize: 0.145  -> 0.24
PAT = re.compile(r"tsize:\s*([\d.]+)")

# 只处理这些调用里的 tsize (都是图内标签)
CALLS = ("txt(", "pt(", "axes(", "axes3(")


def bump(text: str, floor: float, target: float) -> tuple[str, int, list[tuple[str, str]]]:
    """把小于 floor 的 tsize 提到 target。返回 (新文本, 改动数, 明细)。"""
    lines = text.split("\n")
    changes: list[tuple[str, str]] = []
    n = 0
    out = []
    for line in lines:
        stripped = line.lstrip()
        # 注释行不动
        if stripped.startswith("//"):
            out.append(line)
            continue
        # 只动含图元调用的行
        if not any(c in line for c in CALLS):
            out.append(line)
            continue

        def repl(m: re.Match) -> str:
            nonlocal n
            old = float(m.group(1))
            if old >= floor:
                return m.group(0)
            n += 1
            new = f"tsize: {target:.3f}".rstrip("0").rstrip(".")
            changes.append((m.group(0), new))
            return new

        out.append(PAT.sub(repl, line))
    return "\n".join(out), n, changes


def main() -> int:
    ap = argparse.ArgumentParser(description="批量放大图内标签 tsize")
    ap.add_argument("--floor", type=float, default=0.22, help="小于此值才改")
    ap.add_argument("--target", type=float, default=0.24, help="改成的值")
    ap.add_argument("--dir", default="", help="只处理 src 下的某个子目录, 如 s01-select")
    ap.add_argument("--check", action="store_true", help="只报告不写入")
    args = ap.parse_args()

    base = SRC_DIR / args.dir if args.dir else SRC_DIR
    if not base.is_dir():
        print(f"目录不存在: {base}")
        return 2

    total = 0
    for path in sorted(base.rglob("*.typ")):
        original = path.read_text(encoding="utf-8")
        new, n, changes = bump(original, args.floor, args.target)
        if n == 0:
            continue
        rel = path.relative_to(SRC_DIR)
        print(f"{rel}: {n} 处")
        for a, b in changes[:3]:
            print(f"    {a}  ->  {b}")
        if len(changes) > 3:
            print(f"    ... 其余 {len(changes) - 3} 处")
        total += n
        if not args.check:
            path.write_text(new, encoding="utf-8")

    print(f"\n合计 {total} 处 (floor={args.floor} -> {args.target})")
    print("仅检查，未写入" if args.check else "已写入")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())