#!/usr/bin/env python
"""
_chapters.py —— 章节配置 (build_pdf.py 与 shoot_figs.py 共用)

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