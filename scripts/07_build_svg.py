#!/usr/bin/env python
"""
07_build_svg.py —— 编译全卷单题纯矢量 SVG 与发布清单

功能
----
1. 遍历全部章节 (s01-select ~ s04-solve)，逐题通过 Typst 编译为自适应高度的纯矢量 SVG。
2. 保持 SVG 内嵌矢量字符路径与 CeTZ 几何图形，保证在浏览器中无限放大绝对锐利无锯齿。
3. 同步分卷 PDF 到 site/pdf/ 目录供网页下载。
4. 生成 site/manifest.json 供前端单页应用自适应加载与题目索引。
"""

from __future__ import annotations

import json
import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
SRC_DIR = REPO_ROOT / "src"
OUT_DIR = REPO_ROOT / "out"
SITE_DIR = REPO_ROOT / "site"
SVG_DIR = SITE_DIR / "svg"
PDF_DIR = SITE_DIR / "pdf"

sys.path.insert(0, str(REPO_ROOT / "scripts"))
import _chapters as ch

# 单题扩展列表 (包含常规题号及附加探究题)
SPECIAL_QUESTIONS = {
    "s03-fill": [
        ("q14_bonus", "第 14 题 思考题 · 反比例切线构图深入探究", 14)
    ]
}


WORK_DIR = REPO_ROOT / "build"


def ensure_dirs() -> None:
    SVG_DIR.mkdir(parents=True, exist_ok=True)
    PDF_DIR.mkdir(parents=True, exist_ok=True)
    WORK_DIR.mkdir(parents=True, exist_ok=True)


def compile_question_svg(chap_key: str, q_name: str, target_svg: Path) -> bool:
    """使用自适应页面高度编译单题为纯矢量 SVG。"""
    wrapper_content = f'''#set page(paper: "a4", height: auto, margin: (x: 1.8cm, y: 1.2cm))
#include "/src/{chap_key}/{q_name}.typ"
'''
    temp_typ = WORK_DIR / f"_tmp_{chap_key}_{q_name}.typ"
    temp_typ.write_text(wrapper_content, encoding="utf-8")

    try:
        cmd = [
            "typst",
            "compile",
            "--root", str(REPO_ROOT),
        ]
        cmd.extend(ch.get_font_args(REPO_ROOT))
        cmd.extend([
            str(temp_typ),
            str(target_svg),
        ])

        res = subprocess.run(cmd, capture_output=True, text=True)
        if res.returncode != 0:
            print(f"[错误] 编译 {chap_key}/{q_name} 失败:\n{res.stderr}", file=sys.stderr)
            return False
        return True
    finally:
        if temp_typ.exists():
            temp_typ.unlink(missing_ok=True)


def build_all() -> None:
    ensure_dirs()
    start_time = time.perf_counter()
    manifest_data = {
        "title": "2026 年第一届“提云杯”线上联考 · 数学参考解答",
        "author": "VincentZyu",
        "build_time": time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()),
        "chapters": []
    }

    total_count = 0
    success_count = 0

    print(">>> 开始编译全卷纯矢量 SVG ...")

    for chap_key in ch.ORDER:
        info = ch.CHAPTERS[chap_key]
        chap_manifest = {
            "id": chap_key,
            "title": info["title"],
            "label": info["label"],
            "pdf": f"pdf/{chap_key}.pdf",
            "questions": []
        }

        # 复制章节 PDF 到 site/pdf/
        src_pdf = OUT_DIR / chap_key / f"{chap_key}.pdf"
        if src_pdf.exists():
            shutil.copy2(src_pdf, PDF_DIR / f"{chap_key}.pdf")

        # 遍历常规题目
        q_list = [f"q{qno:02d}" for qno in info["qnos"]]
        
        # 追加特殊题目
        specials = SPECIAL_QUESTIONS.get(chap_key, [])
        for sp_name, sp_title, _ in specials:
            q_list.append(sp_name)

        for q_name in q_list:
            total_count += 1
            svg_filename = f"{q_name}.svg"
            target_svg = SVG_DIR / svg_filename

            # 友好标题
            if q_name.startswith("q") and q_name[1:].isdigit():
                q_num = int(q_name[1:])
                q_title = f"第 {q_num} 题"
            else:
                q_title = dict((s[0], s[1]) for s in specials).get(q_name, q_name)

            ok = compile_question_svg(chap_key, q_name, target_svg)
            if ok:
                success_count += 1
                size_kb = target_svg.stat().st_size / 1024
                print(f"  [{success_count:02d}/{total_count:02d}] {chap_key}/{q_name} -> svg/{svg_filename} ({size_kb:.1f} KB)")
                chap_manifest["questions"].append({
                    "id": q_name,
                    "title": q_title,
                    "svg": f"svg/{svg_filename}",
                    "size_kb": round(size_kb, 1),
                })
            else:
                print(f"  [失败] {chap_key}/{q_name}")

        manifest_data["chapters"].append(chap_manifest)

    # 写入清单
    manifest_path = SITE_DIR / "manifest.json"
    manifest_path.write_text(json.dumps(manifest_data, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"\n[清单] 已写入 {manifest_path.relative_to(REPO_ROOT)}")

    elapsed = time.perf_counter() - start_time
    print(f"\n>>> 编译完成: 成功 {success_count}/{total_count} 个矢量题卡, 用时 {elapsed:.2f}s")


if __name__ == "__main__":
    build_all()
