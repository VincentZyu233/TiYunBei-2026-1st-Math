#!/usr/bin/env python
"""
bold_labels.py —— 给图内关键标注加粗

背景
----
`txt()` / `pt()` 新增了 weight 参数 (regular / bold)。图内的
坐标轴名由 axes()/axes3() 默认加粗, 但各题手写的标注
(原点 O、刻度值、曲线名、准线、关键点标签等) 还是常规字重,
在 333 DPI 下偏弱。

本脚本给这些标注包一层 text(weight: "bold"), 只改显示字重,
不动坐标、字号与数学内容。

匹配范围: src/**/*.typ 里 txt(...) 与 pt(...) 的 label/text 参数中
形如 [$...$]、[...]、[text(...)[...]] 的标签, 但跳过:
  - 注释行
  - 已含 weight 的调用
  - 图注 caption(由 fcap 处理)

用法:
    uv run python temp/scripts/bold_labels.py --check
    uv run python temp/scripts/bold_labels.py --dir s01-select
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
SRC_DIR = SCRIPT_DIR.parent / "src"

# 一行里同时出现这些键才处理 (即图内标签, 而非正文)
KEY = re.compile(r"\b(tsize|anchor|dx|dy)\s*:")
# 已加粗的不再处理
HAS_WEIGHT = re.compile(r"\bweight\s*:")


def process_line(line: str) -> tuple[str, int]:
    stripped = line.lstrip()
    if stripped.startswith("//"):
        return line, 0
    if not KEY.search(line):
        return line, 0
    if HAS_WEIGHT.search(line):
        return line, 0
    # caption 是图注, 不在图内
    if "caption:" in line:
        return line, 0
    # axes()/axes3() 的轴名已由 axisweight 默认加粗, 不重复包
    if "axes(" in line or "axes3(" in line:
        return line, 0
    # 已有 text(...) 包裹的标签不再嵌套
    if "text(" in line:
        return line, 0

    n = 0

    # 形态: label: [$...$]  或  tsize: 0.24, [$...$]  或  anchor: "..", [$...$]
    def wrap_math(m: re.Match) -> str:
        nonlocal n
        n += 1
        return f'{m.group(1)}text(weight: "bold")[{m.group(2)}]'

    new = re.sub(r"([\[,]\s*)(\$[^$]*\$)", wrap_math, line)
    return new, n


def main() -> int:
    ap = argparse.ArgumentParser(description="给图内关键标注加粗")
    ap.add_argument("--dir", default="", help="只处理 src 下某子目录")
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()

    base = SRC_DIR / args.dir if args.dir else SRC_DIR
    if not base.is_dir():
        print(f"目录不存在: {base}")
        return 2

    total = 0
    for path in sorted(base.rglob("*.typ")):
        original = path.read_text(encoding="utf-8")
        out_lines = []
        cnt = 0
        for line in original.split("\n"):
            new, n = process_line(line)
            out_lines.append(new)
            cnt += n
        if cnt == 0:
            continue
        rel = path.relative_to(SRC_DIR)
        print(f"{rel}: {cnt} 处")
        for a, b in zip(original.split("\n"), out_lines):
            if a != b:
                print(f"    - {a.strip()[:80]}")
                print(f"    + {b.strip()[:80]}")
                break
        total += cnt
        if not args.check:
            path.write_text("\n".join(out_lines), encoding="utf-8")

    print(f"\n合计 {total} 处" + ("（仅检查）" if args.check else ""))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())