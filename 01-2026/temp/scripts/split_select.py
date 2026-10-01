#!/usr/bin/env python
"""
split_select.py —— 把单题合并的 select.typ 拆成 8 个单题文件 (一次性迁移脚本)

迁移后 src/select/qNN.typ 每题独立, src/select.typ 只作装配入口,
与既有的 src/multi/ 保持一致。

用法:
    uv run python temp/scripts/split_select.py            # 执行拆分
    uv run python temp/scripts/split_select.py --dry-run  # 只报告
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path

TEMP_DIR = Path(__file__).resolve().parent.parent
SRC = TEMP_DIR / "src" / "select.typ"
DST_DIR = TEMP_DIR / "src" / "select"

# 题目分界: 行首的 "// ---------------- 第 N 题 ----------------"
MARK = re.compile(r"^//\s*-+\s*第\s*(\d+)\s*题\s*-+\s*$")

HEADER = (
    "// ============================================================\n"
    "//  第 {n} 题 —— {chapter}\n"
    "// ============================================================\n"
    '#import "../_template.typ": *\n'
    '#import "../_figs.typ": *\n'
)

TITLE = "一、选择题（第 1—8 题）"


def split(text: str) -> dict[int, str]:
    lines = text.split("\n")
    starts: list[tuple[int, int]] = []  # (题号, 行号)
    for i, ln in enumerate(lines):
        m = MARK.match(ln)
        if m:
            starts.append((int(m.group(1)), i))
    if not starts:
        raise SystemExit("找不到题目分界标记")

    out: dict[int, str] = {}
    for idx, (qno, start) in enumerate(starts):
        end = starts[idx + 1][1] if idx + 1 < len(starts) else len(lines)
        # 去掉尾部连续的 #qsep 与空行, 它们由装配入口统一提供
        chunk = lines[start:end]
        while chunk and (chunk[-1].strip() in ("", "#qsep")):
            chunk.pop()
        body = "\n".join(chunk).strip("\n")
        out[qno] = HEADER.format(n=qno, chapter=TITLE) + "\n" + body + "\n"
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    text = SRC.read_text(encoding="utf-8")
    parts = split(text)
    print(f"解析出 {len(parts)} 题: {sorted(parts)}")

    if args.dry_run:
        for qno in sorted(parts):
            body = parts[qno]
            print(f"  q{qno:02d}.typ  {len(body.splitlines())} 行")
        return 0

    DST_DIR.mkdir(parents=True, exist_ok=True)
    for qno, body in parts.items():
        dst = DST_DIR / f"q{qno:02d}.typ"
        dst.write_text(body, encoding="utf-8")
        print(f"  写入 {dst.relative_to(TEMP_DIR)}  ({len(body.splitlines())} 行)")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())