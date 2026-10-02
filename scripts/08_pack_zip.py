#!/usr/bin/env python
"""
08_pack_zip.py —— 调用 7z CLI 打包全套离线题解资源包

功能:
1. 自动从根目录 VERSION 文件读取版本号（支持 CLI --version 覆盖）；
2. 自动清理根目录散落的遗留 zip 包（如 TiYunBei_*.zip）；
3. 在根目录创建 archive/ 归档文件夹；
4. 内部包裹统一顶层文件夹 TiYunBei_2026_Math_Solution_v<版本号>/，避免解压散落；
5. 调用 7z CLI 极致压缩 (-tzip -mx=9) 生成 ZIP 压缩包；
6. 自动计算文件大小与 SHA-256 校验码。

用法:
    uv run python scripts/08_pack_zip.py
    uv run python scripts/08_pack_zip.py --version 0.2.0
    uv run python scripts/08_pack_zip.py --no-clean-root
"""

from __future__ import annotations

import argparse
import hashlib
import os
import shutil
import subprocess
import sys
from pathlib import Path

# 仓库根目录
REPO_ROOT = Path(__file__).resolve().parent.parent
ARCHIVE_DIR = REPO_ROOT / "archive"
TEMP_BASE = Path(os.environ.get("TEMP", "D:/temp/windowstemp")) / "tiyunbei_pack"


def find_7z() -> str:
    """定位本机 7z 可执行程序路径。"""
    which_7z = shutil.which("7z")
    if which_7z:
        return which_7z

    candidates = [
        Path(r"D:\SSoftwareFiles\7z\7-Zip\7z.exe"),
        Path(r"D:\SSoftwareFiles\scoop\shims\7z.exe"),
        Path(r"C:\Program Files\7-Zip\7z.exe"),
        Path(r"C:\Program Files (x86)\7-Zip\7z.exe"),
    ]
    for c in candidates:
        if c.is_file():
            return str(c)

    print("[错误] 未找到 7z 可执行文件，请确保 7-Zip 已安装并加入 PATH。", file=sys.stderr)
    sys.exit(1)


def read_version(cli_version: str | None = None) -> str:
    """读取并规范化版本号（如 '0.2.0'）。"""
    if cli_version:
        v = cli_version.strip()
    else:
        version_file = REPO_ROOT / "VERSION"
        if version_file.is_file():
            v = version_file.read_text(encoding="utf-8").strip()
        else:
            v = "0.2.0"

    # 去除可能自带的 'v' 前缀以获取纯数字版本
    return v.lstrip("v")


def clean_root_zips() -> list[Path]:
    """清理仓库根目录下散落的旧 zip 压缩包。"""
    cleaned: list[Path] = []
    for item in REPO_ROOT.glob("*.zip"):
        if item.is_file():
            try:
                item.unlink()
                cleaned.append(item)
            except OSError as err:
                print(f"[警告] 删除旧 zip 失败 {item.name}: {err}", file=sys.stderr)
    return cleaned


def compute_sha256(file_path: Path) -> str:
    """计算文件的 SHA-256 校验码。"""
    h = hashlib.sha256()
    with open(file_path, "rb") as f:
        while chunk := f.read(1024 * 1024):
            h.update(chunk)
    return h.hexdigest()


def main() -> int:
    parser = argparse.ArgumentParser(description="调用 7z CLI 打包 2026 提云杯离线题解资源")
    parser.add_argument("--version", "-v", help="指定版本号（覆盖根目录 VERSION 文件）")
    parser.add_argument("--output-dir", "-o", default=str(ARCHIVE_DIR), help="输出目录（默认 archive/）")
    parser.add_argument("--no-clean-root", action="store_true", help="不删除根目录下的散落 zip 包")
    args = parser.parse_args()

    version = read_version(args.version)
    tag_name = f"v{version}"
    package_name = f"TiYunBei_2026_Math_Solution_{tag_name}"
    zip_name = f"{package_name}.zip"

    out_dir = Path(args.output_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    target_zip = out_dir / zip_name

    exe_7z = find_7z()

    print(f"📦 开始打包: {package_name}")
    print(f"   版本号: {tag_name} (源自 VERSION: {REPO_ROOT / 'VERSION'})")
    print(f"   7z 工具: {exe_7z}")
    print(f"   目标输出: {target_zip}")

    # 1. 清理根目录散落 zip
    if not args.no_clean_root:
        cleaned_zips = clean_root_zips()
        if cleaned_zips:
            print(f"🧹 已清理根目录下 {len(cleaned_zips)} 个散落 zip 文件:")
            for z in cleaned_zips:
                print(f"   - {z.name}")

    # 2. 临时打包暂存区（套一层顶层文件夹，解压时不散乱）
    stage_root = TEMP_BASE / "stage"
    pkg_stage = stage_root / package_name
    if stage_root.exists():
        shutil.rmtree(stage_root, ignore_errors=True)
    pkg_stage.mkdir(parents=True, exist_ok=True)

    print("📁 正在装配归档内容...")

    # 复制 out/
    out_src = REPO_ROOT / "out"
    if out_src.exists():
        shutil.copytree(out_src, pkg_stage / "out", dirs_exist_ok=True)

    # 复制 problem/
    prob_src = REPO_ROOT / "problem"
    if prob_src.exists():
        shutil.copytree(prob_src, pkg_stage / "problem", dirs_exist_ok=True)

    # 复制 lean/
    lean_src = REPO_ROOT / "lean"
    if lean_src.exists():
        shutil.copytree(
            lean_src,
            pkg_stage / "lean",
            ignore=shutil.ignore_patterns(".lake", ".lake/*", "build", "build/*"),
            dirs_exist_ok=True,
        )

    # 复制根目录文档与元信息
    for doc_name in ["README.md", "VERSION"]:
        doc_path = REPO_ROOT / doc_name
        if doc_path.is_file():
            shutil.copy2(doc_path, pkg_stage / doc_name)

    # 3. 如果目标 zip 已存在则先移除
    if target_zip.exists():
        target_zip.unlink()

    # 4. 调用 7z 命令行压缩
    # a: 添加到压缩包
    # -tzip: 输出 zip 格式
    # -mx=9: 极致压缩级别
    # -mtc=on: 保留时间戳
    cmd = [
        exe_7z,
        "a",
        "-tzip",
        "-mx=9",
        "-mtc=on",
        str(target_zip.resolve()),
        package_name,
    ]

    print("⚡ 正在执行 7z 极致压缩...")
    proc = subprocess.run(
        cmd,
        cwd=str(stage_root),
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
    )

    # 5. 清理暂存区
    shutil.rmtree(stage_root, ignore_errors=True)

    if proc.returncode != 0:
        print("[错误] 7z 执行失败:", file=sys.stderr)
        print(proc.stderr or proc.stdout, file=sys.stderr)
        return proc.returncode

    # 6. 计算产物信息
    size_mb = target_zip.stat().st_size / (1024 * 1024)
    sha256_hash = compute_sha256(target_zip)

    print()
    print("✨ 打包圆满完成！")
    print(f"   产物路径: {target_zip}")
    print(f"   文件体积: {size_mb:.2f} MB ({target_zip.stat().st_size:,} 字节)")
    print(f"   SHA-256 : {sha256_hash}")
    print(f"   顶层目录: {package_name}/ (内含 out/, problem/, lean/, README.md, VERSION)")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
