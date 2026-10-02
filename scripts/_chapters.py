#!/usr/bin/env python
"""
_chapters.py —— 章节配置 (05_build_pdf.py、06_shoot_figs.py 与 07_build_svg.py 共用)

命名规范
--------
目录与入口文件统一用 `sNN-<slug>` 形式, NN 是试卷上的大题序号,
保证 VS Code / 文件管理器里按目录名直接排出试卷顺序:

    s01-select/          一、选择题
    s01-select.typ       该章节的装配入口
    s02-multi/           二、选择题 (多选)
    s02-multi.typ
    s03-fill/            三、填空题
    s04-solve/           四、解答题

单题文件用 `qNN.typ`, NN 是试卷上的题号, 与章节前缀无关,
这样 q01-q08 / q09-q11 / q12-q14 / q15-q19 在各自目录里连续排开。

命令别名
--------
为免每次敲长名字, 保留 `select` / `multi` / `fill` / `solve`
四个短别名, 内部解析到规范名。
"""

from __future__ import annotations

import sys
from pathlib import Path

# 章节规范名 -> 元信息
CHAPTERS: dict[str, dict] = {
    "s01-select": {
        "entry": "s01-select.typ",
        "title": "一、选择题（第 1—8 题，每小题 5 分，共 40 分）",
        "label": "一、选择题 (1-8)",
        "qnos": range(1, 9),
    },
    "s02-multi": {
        "entry": "s02-multi.typ",
        "title": "二、选择题（第 9—11 题，每小题 6 分，共 18 分）",
        "label": "二、选择题 (9-11, 多选)",
        "qnos": range(9, 12),
    },
    "s03-fill": {
        "entry": "s03-fill.typ",
        "title": "三、填空题（第 12—14 题，每小题 5 分，共 15 分）",
        "label": "三、填空题 (12-14)",
        "qnos": range(12, 15),
    },
    "s04-solve": {
        "entry": "s04-solve.typ",
        "title": "四、解答题（第 15—19 题，共 77 分）",
        "label": "四、解答题 (15-19)",
        "qnos": range(15, 20),
    },
}

# 短别名 -> 规范名
ALIASES: dict[str, str] = {
    "select": "s01-select",
    "multi": "s02-multi",
    "fill": "s03-fill",
    "solve": "s04-solve",
}

# 规范名列表 (按试卷顺序)
ORDER: list[str] = list(CHAPTERS)

_WARNED_MISSING_LOCAL_MD = False


def resolve(name: str) -> str | None:
    """把用户给的章节名 (规范名或别名) 解析成规范名。"""
    if name in CHAPTERS:
        return name
    return ALIASES.get(name)


def all_targets(names: list[str] | None) -> dict[str, dict]:
    """按命令行参数筛选章节; 传空则返回全部。"""
    if not names:
        return CHAPTERS
    picked: dict[str, dict] = {}
    for n in names:
        key = resolve(n)
        if key:
            picked[key] = CHAPTERS[key]
    return picked


def src_dir(temp_dir: Path) -> Path:
    return temp_dir / "src"


def out_dir(temp_dir: Path, chapter: str) -> Path:
    return temp_dir / "out" / chapter


def get_font_dirs(repo_root: Path | None = None) -> list[Path]:
    """
    解析本地字体目录:
    1. 优先读取 AGENTS.local.md 中的 FONT_DIR 配置
    2. 若未找到 AGENTS.local.md，在终端输出醒目提示告知开发者复制 AGENTS.local.example.md
    3. 尝试已知的缺省路径 (如 X:\\字体\\霞鹜文楷LXGW_WenKai\\lxgw-wenkai-v1.520)
    """
    if repo_root is None:
        repo_root = Path(__file__).resolve().parent.parent

    local_md = repo_root / "AGENTS.local.md"
    configured_dirs: list[Path] = []

    if local_md.is_file():
        try:
            content = local_md.read_text(encoding="utf-8")
            for line in content.splitlines():
                line = line.strip()
                if line.startswith("FONT_DIR=") or line.startswith("FONT_DIR:"):
                    raw_val = line.split("=", 1)[-1] if "=" in line else line.split(":", 1)[-1]
                    p = Path(raw_val.strip().strip('"').strip("'"))
                    if p.is_dir():
                        configured_dirs.append(p)
        except Exception:
            pass

    if configured_dirs:
        return configured_dirs

    global _WARNED_MISSING_LOCAL_MD
    # 未在 AGENTS.local.md 中配置有效字体
    fallback_default = Path(r"X:\字体\霞鹜文楷LXGW_WenKai\lxgw-wenkai-v1.520")
    if not local_md.exists() and not _WARNED_MISSING_LOCAL_MD:
        _WARNED_MISSING_LOCAL_MD = True
        sys.stderr.write(
            "\033[33m\033[1m[提示] 未检测到 AGENTS.local.md！\033[0m\n"
            "  为保证数学公式与解答排版一致呈现「霞鹜文楷」，请参考 \033[36mAGENTS.local.example.md\033[0m\n"
            "  在仓库根目录新建 \033[36mAGENTS.local.md\033[0m 并配置 FONT_DIR，例如:\n"
            "    \033[32mFONT_DIR=X:\\字体\\霞鹜文楷LXGW_WenKai\\lxgw-wenkai-v1.520\033[0m\n\n"
        )
    if fallback_default.is_dir():
        return [fallback_default]

    return []


def get_font_args(repo_root: Path | None = None) -> list[str]:
    """生成传给 Typst 的 --font-path 参数列表。"""
    dirs = get_font_dirs(repo_root)
    args: list[str] = []
    for d in dirs:
        args.extend(["--font-path", str(d)])
    return args