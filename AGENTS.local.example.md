# AGENTS.local.md (开发者本机环境配置模板)

此文件为开发者个人本地配置模板。
请复制此文件为 `AGENTS.local.md`（该文件已在 `.gitignore` 中，不会被 Git 追踪），并根据您的本地机器环境配置字体绝对路径等参数。

---

## 1. 字体目录 (Font Path)

用于 Typst 编译数学参考解答时挂载本地字体（推荐锁定 Mono 等宽变体 `LXGW WenKai Mono`）：

```ini
FONT_DIR=X:\字体\霞鹜文楷LXGW_WenKai\lxgw-wenkai-v1.520
```

> **说明**：
> - 脚本（`build_pdf.py`、`shoot_figs.py`、`build_svg.py`）会自动解析本文件中的 `FONT_DIR=` 行，并通过 `--font-path` 参数传给 Typst。
> - 若未配置 `AGENTS.local.md`，脚本会在终端输出高亮黄色/红色警示，提醒开发者按照此模板进行配置，并尝试在本机默认路径中探测字体。
