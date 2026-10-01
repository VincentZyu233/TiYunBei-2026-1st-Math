#!/usr/bin/env python
"""
shoot_figs.py —— 按题切图, 只输出图片 (不再输出 PDF)

思路
----
不依赖 PDF 中间产物: 直接把每道题单独编译成一张 PNG。
`src/split/` 下按题存放单题 Typst 源码 (或由章节源码 import 拼装),
用 typst 编译时指定 `-p <题号>` 之类的开关只渲染该题。

但更稳妥、可控的做法是:
  1. 用 typst 把章节源码编译成 PDF (仅作为中间产物, 放 temp 目录);
  2. 用 pymupdf 扫出每个题号行的坐标, 精确圈定每题的版面区域;
  3. 裁剪渲染成 PNG —— **横向只裁一次**(统一左右边界),
     纵向逐段裁掉纯白, 拼接时各段左对齐, 不留色块。

为何只纵向裁: 左右边界来自同一套排版参数, 各页必然一致;
横向逐段裁会因某段恰好没有贴边内容而多裁, 造成错位。

用法
----
    uv pip install pymupdf
    uv run python temp/scripts/shoot_figs.py            # 全部章节
    uv run python temp/scripts/shoot_figs.py select     # 指定章节
    uv run python temp/scripts/shoot_figs.py select --keep-pdf
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
from pathlib import Path

import _chapters as ch

TEMP_DIR = Path(__file__).resolve().parent.parent
SRC_DIR = TEMP_DIR / "src"
OUT_DIR = TEMP_DIR / "out"
WORK_DIR = TEMP_DIR / "build"  # 中间产物, 可随时删
FONT_DIR = TEMP_DIR / "fonts"

DPI = 150
# A4 595.28 x 841.89 pt
PAGE_W, PAGE_H = 595.28, 841.89
MARGIN_L = 56.7
MARGIN_R = PAGE_W - 56.7
BODY_TOP = 60.0
FOOTER_TOP = 800.0

PAD_X = 10.0
PAD_TOP = 8.0
PAD_BOTTOM = 6.0
# 纵向裁剪后额外保留的呼吸空间 (pt)。
# 不留的话, 大标题字形(如章节标题的"数学")会被切掉上半截,
# 题号"2."也会紧贴上边缘, 看起来像被削了一刀。
KEEP_TOP_PT = 22.0
KEEP_BOT_PT = 8.0
# 段间细缝
SEAM = 2
SEAM_GREY = 210
# 纯白判定阈值 (小于该灰度视为有内容)
WHITE_TH = 250


def log(msg: str = "") -> None:
    print(msg, flush=True)


# ---------------------------------------------------------------- 编译


def find_typst() -> str | None:
    return shutil.which("typst")


def build_pdf(typst: str, chapter: str, src_name: str) -> Path | None:
    """把章节源码编译成 PDF (中间产物, 放 temp/build/)。"""
    src = SRC_DIR / src_name
    if not src.exists():
        log(f"[跳过] {chapter}: 缺少 {src_name}")
        return None

    WORK_DIR.mkdir(parents=True, exist_ok=True)
    pdf = WORK_DIR / f"{chapter}.pdf"

    cmd = [typst, "compile"]
    if FONT_DIR.is_dir():
        cmd += ["--font-path", str(FONT_DIR)]
    cmd += ["--root", str(TEMP_DIR), str(src), str(pdf)]

    proc = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    if proc.returncode != 0:
        log(f"[失败] {chapter} 编译出错:")
        for line in ((proc.stdout or "") + (proc.stderr or "")).splitlines():
            if line.strip():
                log("    " + line)
        return None
    return pdf


# ---------------------------------------------------------------- 定位题目

# 题号行: " 1. 5 分" / " 9. 6 分" / " 15." —— 前导空白可有, 分值可省
_QHEAD = re.compile(r"\s*(\d{1,2})\.\s*\d*\s*分?")


def question_tops(page) -> dict[int, float]:
    """扫描一页, 返回 {题号: 题号行顶部 y}。"""
    found: dict[int, float] = {}
    for blk in page.get_text("dict")["blocks"]:
        if blk.get("type") != 0:
            continue
        for ln in blk["lines"]:
            text = "".join(sp["text"] for sp in ln["spans"])
            m = _QHEAD.fullmatch(text)
            if m is None:
                continue
            # 题号行必须贴正文左边界 (实测 x0 = 70.87)。
            # 阈值 MARGIN_L+24 = 80.7, 可排除图内 x>80 的数字。
            if ln["bbox"][0] < MARGIN_L + 24:
                found.setdefault(int(m.group(1)), ln["bbox"][1])
    return found


def title_top(page) -> float | None:
    """章节大标题的顶部 y (用于确定首题截图的上边界)。"""
    for blk in page.get_text("dict")["blocks"]:
        if blk.get("type") != 0:
            continue
        for ln in blk["lines"]:
            text = "".join(sp["text"] for sp in ln["spans"])
            if "提云杯" in text:
                return ln["bbox"][1]
    return None


def subtitle_bottom(page) -> float | None:
    """章节副标题行的底部 y (用来把标题块纳入首题截图)。"""
    for blk in page.get_text("dict")["blocks"]:
        if blk.get("type") != 0:
            continue
        for ln in blk["lines"]:
            text = "".join(sp["text"] for sp in ln["spans"])
            if "参考解答" in text:
                return ln["bbox"][3]
    return None


# ---------------------------------------------------------------- 像素裁剪


def trim_vertical(pm):
    """只裁上下纯白边, 保持左右不变 (各页左右边界一致, 横向不能各段单独裁)。

    裁到内容边缘后, 上下各再留 KEEP_TOP_PT / KEEP_BOT_PT 的呼吸空间。
    否则大号字形 (如章节标题) 会被切掉上半截, 题号也会紧贴上边缘。
    """
    w, h, n, stride = pm.width, pm.height, pm.n, pm.stride
    if n < 3:
        return pm
    buf = pm.samples

    top = 0
    while top < h:
        off = top * stride
        if min(buf[off : off + w * n]) < WHITE_TH:
            break
        top += 1

    bot = h - 1
    while bot > top:
        off = bot * stride
        if min(buf[off : off + w * n]) < WHITE_TH:
            break
        bot -= 1

    if bot <= top:  # 整段空白, 原样返回
        return pm

    # 回退一点, 保留字形上下的自然留白
    pad = round(KEEP_TOP_PT * DPI / 150)
    top = max(0, top - pad)
    bot = min(h - 1, bot + round(KEEP_BOT_PT * DPI / 150))

    if top == 0 and bot == h - 1:
        return pm
    return _crop(pm, 0, top, w - 1, bot)


def _crop(pm, left: int, top: int, right: int, bottom: int):
    """按像素裁剪 (pymupdf 的 samples 是 bytes, 需转 bytearray 才能写)。"""
    import pymupdf

    width = right - left + 1
    height = bottom - top + 1
    n, stride = pm.n, pm.stride
    src = pm.samples

    dst = bytearray(b"\xff" * (width * height * n))
    dstride = width * n
    for y in range(height):
        s0 = (top + y) * stride + left * n
        d0 = y * dstride
        dst[d0 : d0 + dstride] = src[s0 : s0 + dstride]

    return pymupdf.Pixmap(pymupdf.csRGB, width, height, bytes(dst), False)


def vstack(shots):
    """纵向拼接。左对齐、统一宽度, 段间留细缝。"""
    import pymupdf

    if len(shots) == 1:
        return shots[0]

    w = max(p.width for p in shots)
    seam_px = max(1, round(SEAM * DPI / 150))
    h = sum(p.height for p in shots) + seam_px * (len(shots) - 1)

    canvas = pymupdf.Pixmap(pymupdf.csRGB, pymupdf.IRect(0, 0, w, h), False)
    canvas.clear_with(WHITE_TH)

    yoff = 0
    for p in shots:
        p.set_origin(0, yoff)
        canvas.copy(p, p.irect)
        yoff += p.height + seam_px
    return canvas


# ---------------------------------------------------------------- 主流程


def shoot_chapter(chapter: str, src_name: str, keep_pdf: bool) -> int:
    import pymupdf

    typst = find_typst()
    if not typst:
        log("找不到 typst")
        return 2

    pdf = build_pdf(typst, chapter, src_name)
    if pdf is None:
        return 1

    doc = pymupdf.open(pdf)

    # 收集题目起点
    starts: list[tuple[int, int, float]] = []
    head_bottom: float | None = None
    head_top: float | None = None
    for pno in range(doc.page_count):
        page = doc[pno]
        for qno, y in sorted(question_tops(page).items()):
            starts.append((qno, pno, y))
        if pno == 0:
            head_bottom = subtitle_bottom(page)
            head_top = title_top(page)

    if not starts:
        log(f"[失败] {chapter}: 未定位到题号")
        doc.close()
        return 1

    # 本题下边界 = 下一题起点; 末题取最后一页正文底
    bounds: dict[int, tuple[int, float | None]] = {}
    for i, (qno, pno, _y) in enumerate(starts):
        if i + 1 < len(starts):
            bounds[qno] = (starts[i + 1][1], starts[i + 1][2])
        else:
            bounds[qno] = (doc.page_count - 1, None)

    out_dir = OUT_DIR / chapter
    out_dir.mkdir(parents=True, exist_ok=True)

    first_qno = starts[0][0]
    written = 0
    for qno, pno, y_top in starts:
        end_page, y_end = bounds[qno]

        # 首题向上把章节标题块整块包进来。
        # 用 title_top() 定位大标题顶, 而不是从副标题往上猜,
        # 否则会把 16pt 大标题的字形上沿切掉。
        y0 = y_top
        if qno == first_qno and head_top is not None and pno == 0:
            y0 = max(BODY_TOP, head_top - 10.0)
        elif head_bottom is not None and pno == 0:
            # 章节内非首题: 从副标题下方起 (兼容无大标题的情形)
            y0 = max(BODY_TOP, y_top)

        clips: list[tuple] = []
        for k in range(pno, end_page + 1):
            top = (y0 - PAD_TOP) if k == pno else BODY_TOP
            bot = (y_end - PAD_BOTTOM) if (k == end_page and y_end is not None) else FOOTER_TOP
            if bot - top < 6:
                continue
            # 左右统一: 只加固定留白, 不做内容感知裁剪
            clips.append((k, top, bot))

        if not clips:
            continue

        # 横向按全局并集裁一次, 保证各段左对齐、右侧不留色块
        shots = []
        for k, top, bot in clips:
            pm = doc[k].get_pixmap(
                dpi=DPI, clip=pymupdf.Rect(MARGIN_L - PAD_X, top, MARGIN_R + PAD_X, bot)
            )
            shots.append(trim_vertical(pm))

        img = vstack(shots)
        dst = out_dir / f"{chapter}-q{qno:02d}.png"
        img.save(dst)

        kb = dst.stat().st_size / 1024
        span = f"p{pno + 1}" if end_page == pno else f"p{pno + 1}-{end_page + 1}"
        log(f"  q{qno:02d}  {span:<8} {img.width}x{img.height}  {kb:.0f} KB")
        written += 1

    doc.close()
    log(f"{chapter}: 输出 {written} 张 -> {out_dir}")

    if not keep_pdf:
        pdf.unlink(missing_ok=True)
    return 0


def main() -> int:
    global DPI

    ap = argparse.ArgumentParser(
        description="shoot_figs —— 按题输出 PNG (不产 PDF)",
        epilog=(
            f"章节: {', '.join(ch.ORDER)}\n"
            f"短别名: {', '.join(ch.ALIASES)}"
        ),
    )
    ap.add_argument(
        "chapters",
        nargs="*",
        help="只处理指定章节, 用规范名 (s01-select) 或短名 (select)",
    )
    ap.add_argument("--keep-pdf", action="store_true", help="保留中间 PDF 到 temp/build/")
    ap.add_argument("--dpi", type=int, default=DPI)
    args = ap.parse_args()

    try:
        import pymupdf  # noqa: F401
    except ImportError:
        log("需要 pymupdf: uv pip install pymupdf")
        return 2

    DPI = args.dpi

    targets = ch.all_targets(args.chapters)
    if not targets:
        log(
            f"没有匹配的章节: {', '.join(args.chapters)}  "
            f"(可用: {', '.join(ch.ORDER)} 或短名 {', '.join(ch.ALIASES)})"
        )
        return 2

    rc = 0
    for chapter in ch.ORDER:
        if chapter in targets:
            rc |= shoot_chapter(chapter, ch.CHAPTERS[chapter]["entry"], args.keep_pdf)
    return rc


if __name__ == "__main__":
    raise SystemExit(main())