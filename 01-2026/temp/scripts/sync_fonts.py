#!/usr/bin/env python
"""
sync_fonts.py —— 把本机字体 (X:\\字体\\) 同步到 temp/fonts/

字体不进仓库, 编译时由 build_pdf.py 用 --font-path temp/fonts 注入。
Typst 读不到 --root 之外的路径, 所以必须先复制进来。

用法:
    uv run python temp/scripts/sync_fonts.py              # 同步默认字体
    uv run python temp/scripts/sync_fonts.py --list       # 只看有哪些可用
    uv run python temp/scripts/sync_fonts.py --all        # 全量同步 (较慢, 约 300MB)
"""

from __future__ import annotations

import argparse
import shutil
from pathlib import Path

TEMP_DIR = Path(__file__).resolve().parent.parent
FONT_DIR = TEMP_DIR / "fonts"

# 本机字体仓库 (仅 local 环境存在, 故写在这里而非 AGENTS.md)
FONT_ROOT = Path(r"X:\字体")

# 名称 -> (源目录, 要复制的文件 glob)
PRESETS: dict[str, tuple[Path, list[str]]] = {
    "lxgw": (
        FONT_ROOT / "霞鹜文楷LXGW_WenKai" / "lxgw-wenkai-v1.520",
        ["LXGWWenKai-*.ttf", "LXGWWenKaiMono-*.ttf"],
    ),
    "song": (
        FONT_ROOT / "思源宋体",
        ["SourceHanSerifSC-Regular.otf", "SourceHanSerifSC-Medium.otf", "SourceHanSerifSC-Bold.otf"],
    ),
    "puhuiti": (
        FONT_ROOT / "alibaba-puhuiti",
        ["Alibaba-PuHuiTi-Regular.otf", "Alibaba-PuHuiTi-Medium.otf", "Alibaba-PuHuiTi-Bold.otf"],
    ),
    "mi": (
        FONT_ROOT / "MiSans_L3" / "MiSans L3",
        ["MiSans L3.ttf"],
    ),
    "harmony": (
        FONT_ROOT / "HarmonyOSSans" / "HarmonyOS+Sans+字体" / "HarmonyOS_SansSC",
        ["HarmonyOS_SansSC-Regular.ttf", "HarmonyOS_SansSC-Medium.ttf", "HarmonyOS_SansSC-Bold.ttf"],
    ),
}


def sync(key: str) -> int:
    if key not in PRESETS:
        print(f"未知字体集: {key}")
        return 2
    src_dir, globs = PRESETS[key]

    if not src_dir.is_dir():
        print(f"[跳过] 源目录不存在: {src_dir}")
        return 1

    FONT_DIR.mkdir(parents=True, exist_ok=True)

    copied = skipped = 0
    total_mb = 0.0
    for g in globs:
        for f in sorted(src_dir.glob(g)):
            dst = FONT_DIR / f.name
            # 同名同大小则跳过, 避免无谓拷贝
            if dst.exists() and dst.stat().st_size == f.stat().st_size:
                skipped += 1
                continue
            shutil.copy2(f, dst)
            mb = f.stat().st_size / 1024 / 1024
            total_mb += mb
            print(f"  + {f.name}  ({mb:.1f} MB)")
            copied += 1

    print(f"{key}: 复制 {copied} 个, 跳过 {skipped} 个, 共 {total_mb:.1f} MB -> {FONT_DIR}")
    return 0


def show() -> int:
    if not FONT_ROOT.is_dir():
        print(f"本机字体目录不存在: {FONT_ROOT}")
        return 1
    for key, (src_dir, globs) in PRESETS.items():
        mark = "OK " if src_dir.is_dir() else "-- "
        print(f"[{mark}] {key:10s} {src_dir}")
        if src_dir.is_dir():
            for g in globs:
                for f in sorted(src_dir.glob(g)):
                    print(f"         {f.name}  ({f.stat().st_size / 1024 / 1024:.1f} MB)")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="同步本机字体到 temp/fonts")
    ap.add_argument("keys", nargs="*", default=["lxgw"], help=f"要同步的字体集, 可选 {list(PRESETS)}")
    ap.add_argument("--all", action="store_true", help="同步全部字体集")
    ap.add_argument("--list", action="store_true", help="列出可用字体后退出")
    args = ap.parse_args()

    if args.list:
        return show()

    keys = list(PRESETS) if args.all else (args.keys or ["lxgw"])
    rc = 0
    for k in keys:
        print(f"== {k} ==")
        rc |= sync(k)
    return rc


if __name__ == "__main__":
    raise SystemExit(main())