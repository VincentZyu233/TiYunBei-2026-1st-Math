#!/usr/bin/env python
"""
02_fix_punct.py —— 标点规范化: 句末西文句点 → 中文句号

背景
----
数学块 `$ ... $` 内的 ASCII 句点是数学句子结束符, 渲染成西文句点。
它夹在中文正文里时, Typst 按 CJK 断行规则会把它当作可换行点, 于是
"……对任意 $u,v$ 有 $|u+v|^2 = … + 2u·v$。" 的句号被甩到下一行行首。
中文句号 U+3002 不断行, 也不会与西文句点混淆。

本脚本只改「数学块内的行末句点」和「中文之后的句点」两种确切情况,
其余一律不动, 以免误伤代码与小数。

明确跳过:
  - 注释行 (// 或 * 开头)
  - 含链式调用 (.at / .first / .map / .len / .push …) 的行
  - 含小数 (前后都是数字) 的句点
  - 省略号、缩写 (e.g. / etc.)
  - 反引号包裹的行内代码
  - import / let / set / show 等代码行

同类的姊妹脚本: 01_norm_math.py (LaTeX → Typst 数学写法)。

用法
----
    uv run python scripts/02_fix_punct.py --check    # 只报告
    uv run python scripts/02_fix_punct.py            # 写入
    uv run python scripts/02_fix_punct.py select.typ # 只处理某文件
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

SRC_DIR = Path(__file__).resolve().parent.parent / "src"

# 中文与全角标点
CJK_RANGE = "\u4e00-\u9fff"
CN_PUNCT = "。．，、；：？！“”‘’（）《》〈〉【】—…"
MATH_SENTENCE = re.compile(r"[=<>]\s*[-\d]*\.?(\$)?\s*$")


def is_code_line(line: str) -> bool:
    """判断是否应整行跳过 (注释 / 代码)。

    注意: 数学公式行 "$ … = 1.$" 不算代码, 要参与转换。
    """
    s = line.strip()
    if not s:
        return False
    if s.startswith("//") or s.startswith("/*") or s.startswith("*") or s.startswith("#!"):
        return True
    # Typst 代码行: 顶格 #let / #import / #set / #show / let / import 等
    if re.match(r"^#\s*(let|set|show|import|include)\b", s) or re.match(
        r"^(let|set|show|import|include)\b", s
    ):
        return True
    return False


# 链式方法调用, 这类行里的点不能动
CODE_DOT = re.compile(
    r"\.(at|first|last|map|filter|len|push|pop|insert|get|keys|values"
    r"|str|int|float|find|join|split|lower|upper|strip|replace|append|repr)\s*\("
)


def fix_line(line: str) -> tuple[str, int]:
    """处理单个自然行。"""
    if is_code_line(line):
        return line, 0
    # 链式调用只在非数学行上排除; 数学行里的 . 仍需处理
    if CODE_DOT.search(line) and "$" not in line:
        return line, 0
    if "`" in line:
        return line, 0

    n = 0
    stripped = line.rstrip()
    tail = stripped[len(stripped.rstrip()):]
    body = stripped.rstrip() if False else stripped

    # 情形 1: 纯数学行的行末 ASCII 句点
    #   例: "$ |vec(a) - vec(b)|^2 = … = 1.$" -> "$ … = 1$ 。" (句点移出数学块)
    s = body
    # 该行必须整体是数学块 (以 $ 开头), 否则不动, 避免误伤代码
    if s.startswith("$") and s.count("$") == 2 and s.rstrip().endswith("$"):
        m = MATH_SENTENCE.search(s.rstrip())
        if m:
            t2 = s.rstrip()
            # 从 $ 之前往回找那个句点
            j = len(t2) - 1  # 指向末尾的 $
            while j > 0 and t2[j - 1] in " ":
                j -= 1
            if j > 0 and t2[j - 1] == ".":
                # 把 "…… = 1.$" 改成 "…… = 1$。"
                s = t2[: j - 1] + "$ \u3002" + tail
                n += 1
                return s, n

    # 情形 2: 中文/全角标点之后紧跟的 ASCII 句点
    chars = list(s)
    for i, ch in enumerate(chars):
        if ch != ".":
            continue
        prev = chars[i - 1] if i > 0 else ""
        nxt = chars[i + 1] if i + 1 < len(chars) else ""
        # 小数点
        if prev.isdigit() and nxt.isdigit():
            continue
        # 省略号 / 已有句点
        if prev == "." or nxt == ".":
            continue
        if prev and (prev in CN_PUNCT or CJK_RANGE[0] <= prev <= CJK_RANGE[-1]):
            chars[i] = "\u3002"
            n += 1
    return "".join(chars) + tail, n


def process(text: str) -> tuple[str, int]:
    total = 0
    out = []
    for line in text.split("\n"):
        fixed, k = fix_line(line)
        total += k
        out.append(fixed)
    return "\n".join(out), total


def main() -> int:
    ap = argparse.ArgumentParser(description="句末 ASCII 句点 -> 中文句号")
    ap.add_argument("files", nargs="*", help="只处理指定文件, 默认 src 下全部 .typ")
    ap.add_argument("--check", action="store_true", help="只报告不写入")
    args = ap.parse_args()

    targets = [SRC_DIR / f for f in args.files] if args.files else sorted(SRC_DIR.glob("*.typ"))
    if not targets:
        print("找不到 .typ 文件", file=sys.stderr)
        return 2

    total = 0
    for path in targets:
        if not path.exists():
            print(f"[跳过] {path.name}")
            continue
        original = path.read_text(encoding="utf-8")
        new, cnt = process(original)
        if cnt == 0 or new == original:
            continue
        print(f"{path.name}: {cnt} 处")
        shown = 0
        for a, b in zip(original.split("\n"), new.split("\n")):
            if a != b and shown < 4:
                print(f"    - {a.strip()[:86]}")
                print(f"    + {b.strip()[:86]}")
                shown += 1
        total += cnt
        if not args.check:
            path.write_text(new, encoding="utf-8")

    print(f"\n合计 {total} 处" + ("（仅检查）" if args.check else ""))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())