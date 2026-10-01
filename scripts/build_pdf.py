#!/usr/bin/env python
"""
build_pdf.py —— 编译章节 Typst 源码 → out/<章节>/<章节>.pdf

2026 年第一届"提云杯"线上联考 数学。

用法:
    uv run python temp/scripts/build_pdf.py            编译全部
    uv run python temp/scripts/build_pdf.py --watch    监听改动自动重编译
    uv run python temp/scripts/build_pdf.py select     只编译某几份 (select/multi/fill/solve)

产物 (每个大题一个目录, 每题的 PNG 由 shoot_figs.py 另行生成):
    temp/out/select/select.pdf
    temp/out/multi/multi.pdf
    temp/out/fill/fill.pdf
    temp/out/solve/solve.pdf
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

import _chapters as ch

# 目录约定: <repo>/01-2026/temp/{scripts,src,out}
TEMP_DIR = Path(__file__).resolve().parent.parent
SRC_DIR = TEMP_DIR / "src"
OUT_DIR = TEMP_DIR / "out"
# 字体目录: 霞鹜文楷等放在 temp/fonts, 不进仓库, 编译时用 --font-path 传入
FONT_DIR = TEMP_DIR / "fonts"

WATCH_SUFFIXES = {".typ", ".png", ".svg", ".jpg", ".ttf", ".otf"}
IGNORE_PARTS = {"out", "__pycache__"}


class Style:
    RESET = "\033[0m"
    BOLD = "\033[1m"
    DIM = "\033[2m"
    RED = "\033[31m"
    GREEN = "\033[32m"
    YELLOW = "\033[33m"
    BLUE = "\033[34m"
    MAGENTA = "\033[35m"
    CYAN = "\033[36m"

    @classmethod
    def paint(cls, text: str, *codes: str) -> str:
        if not sys.stdout.isatty():
            return text
        return "".join(codes) + text + cls.RESET


def log(msg: str = "", *codes: str) -> None:
    print(Style.paint(msg, *codes), flush=True)


def find_typst() -> str | None:
    exe = shutil.which("typst")
    if exe:
        return exe
    for cand in (
        Path.home() / "scoop/shims/typst.exe",
        Path("C:/Program Files/Typst/typst.exe"),
    ):
        if cand.exists():
            return str(cand)
    return None


def snapshot() -> dict[str, int]:
    """源目录内容指纹, 用于 watch 模式检测改动。"""
    if not SRC_DIR.exists():
        return {}
    out: dict[str, int] = {}
    for p in sorted(SRC_DIR.rglob("*")):
        if any(part in IGNORE_PARTS for part in p.parts):
            continue
        if p.is_file() and p.suffix.lower() in WATCH_SUFFIXES:
            out[str(p)] = p.stat().st_mtime_ns
    return out


def base_cmd(typst: str, src: Path, dst: Path) -> list[str]:
    cmd = [typst, "compile"]
    cmd.extend(ch.get_font_args(TEMP_DIR))
    cmd += ["--root", str(TEMP_DIR), str(src), str(dst)]
    return cmd


def run(typst: str, cmd: list[str], label: str) -> bool:
    proc = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    noise = (proc.stdout or "") + (proc.stderr or "")
    for line in noise.splitlines():
        # typst 首次下载包时会往 stderr 写进度, 不算错误
        if line.strip() and "downloading" not in line:
            log("    " + line.strip(), Style.DIM)
    if proc.returncode != 0:
        log(f"[失败] {label}", Style.RED, Style.BOLD)
        return False
    return True


def count_pages(pdf: Path) -> int:
    """粗略数页数: 统计 /Type /Page (排除 /Pages)。"""
    try:
        data = pdf.read_bytes()
    except OSError:
        return 0
    return len(re.findall(rb"/Type\s*/Page[^s]", data))


def compile_one(typst: str, chapter: str) -> bool:
    meta = ch.CHAPTERS[chapter]
    src = SRC_DIR / meta["entry"]
    if not src.exists():
        log(f"[跳过] 缺少入口文件 {meta['entry']}", Style.YELLOW)
        return True

    out_dir = OUT_DIR / chapter
    out_dir.mkdir(parents=True, exist_ok=True)
    dst = out_dir / f"{chapter}.pdf"

    if not run(typst, base_cmd(typst, src, dst), f"{chapter}.pdf"):
        return False

    kb = dst.stat().st_size / 1024
    pages = count_pages(dst)
    log(f"[成功] {chapter}/{chapter}.pdf  {pages} 页 ({kb:.1f} KB)", Style.GREEN)
    return True


def build(names: list[str] | None) -> int:
    typst = find_typst()
    if typst is None:
        log("找不到 typst 可执行文件。请先安装 Typst 0.14+ 并加入 PATH。", Style.RED, Style.BOLD)
        return 2
    if not SRC_DIR.exists():
        log(f"找不到源目录: {SRC_DIR}", Style.RED)
        return 2

    OUT_DIR.mkdir(parents=True, exist_ok=True)

    targets = ch.all_targets(names)
    if not targets:
        log(
            f"没有匹配的章节: {', '.join(names or [])}  "
            f"(可用: {', '.join(ch.ORDER)} 或短名 {', '.join(ch.ALIASES)})",
            Style.RED,
        )
        return 2

    t0 = time.perf_counter()
    failed = [c for c in targets if not compile_one(typst, c)]
    dt = time.perf_counter() - t0

    log()
    if failed:
        log(f"编译失败 {len(failed)}/{len(targets)} 个, 用时 {dt:.1f}s", Style.RED, Style.BOLD)
        log("失败章节: " + ", ".join(failed), Style.RED)
        return 1
    log(f"全部完成, 用时 {dt:.1f}s -> {OUT_DIR}", Style.CYAN, Style.BOLD)
    return 0


def watch(names: list[str] | None) -> int:
    log(f"监听中: {SRC_DIR}   (Ctrl+C 退出)", Style.MAGENTA, Style.BOLD)
    build(names)
    try:
        while True:
            before = snapshot()
            time.sleep(0.6)
            if snapshot() != before:
                log("\n检测到改动, 重新编译 ...", Style.YELLOW)
                build(names)
    except KeyboardInterrupt:
        log("\n已退出监听。", Style.MAGENTA)
        return 0


def main() -> int:
    ap = argparse.ArgumentParser(
        description="build_pdf —— 编译 2026 提云杯数学解答",
        epilog=(
            f"章节: {', '.join(ch.ORDER)}\n"
            f"短别名: {', '.join(ch.ALIASES)}"
        ),
    )
    ap.add_argument(
        "targets",
        nargs="*",
        help="只编译指定章节, 用规范名 (s01-select) 或短名 (select)",
    )
    ap.add_argument("-w", "--watch", action="store_true", help="监听 src/ 变化自动重编译")
    args = ap.parse_args()

    return watch(args.targets) if args.watch else build(args.targets)


if __name__ == "__main__":
    raise SystemExit(main())