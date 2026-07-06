#!/usr/bin/env bash
# Build a ZIP snapshot for users without git.
# Output: share/out/medkarute-share-YYYY-MM-DD.zip

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DATE_TAG="$(date +%Y-%m-%d)"
STAGING="$(mktemp -d)"
OUT_DIR="$ROOT/share/out"
ZIP_NAME="medkarute-share-${DATE_TAG}.zip"
ZIP_PATH="$OUT_DIR/$ZIP_NAME"

cleanup() { rm -rf "$STAGING"; }
trap cleanup EXIT

mkdir -p "$OUT_DIR"

rsync -a \
  --exclude '.git/' \
  --exclude 'research/' \
  --exclude '.local/' \
  --exclude 'share/out/' \
  --exclude '.mcp.json' \
  --exclude 'docs/raws/' \
  --exclude '__pycache__/' \
  --exclude '*.py[cod]' \
  --exclude '.agents/skills/**/.venv/' \
  --exclude '.agents/skills/md-to-docx copilot/' \
  --exclude '.claude/settings.local.json' \
  "$ROOT/" "$STAGING/medkarute/"

# ZIP on Windows often breaks symlinks — copy skills from staged .agents (no .venv).
for agent_dir in .claude/skills .codex/skills .grok/skills; do
  rm -rf "$STAGING/medkarute/$agent_dir"
  mkdir -p "$STAGING/medkarute/$agent_dir"
  if [ -d "$STAGING/medkarute/.agents/skills" ]; then
    for skill in "$STAGING/medkarute/.agents/skills/"*/; do
      [ -d "$skill" ] || continue
      cp -a "$skill" "$STAGING/medkarute/$agent_dir/$(basename "$skill")"
    done
  fi
done

COMMIT="$(git -C "$ROOT" rev-parse --short HEAD 2>/dev/null || echo unknown)"
cat > "$STAGING/medkarute/SHARE-README.txt" <<EOF
MedKarute — share ZIP (no git required)
=======================================

Built: ${DATE_TAG}
Source commit: ${COMMIT}

1. Unzip this folder anywhere (e.g. D:\\medkarute).
2. Install uv once: see docs/guides/huong-dan-su-dung.md section 2.
3. Open the folder in Claude Code, Grok, or Cursor.
4. In chat, type: bắt đầu

Notes:
- .local/ and research/ are created on your machine during onboarding (not in this ZIP).
- Copy .mcp.json.tpl to .mcp.json after the agent helps configure MCP for your OS.
- Agent skills live under .agents/skills/ (md-to-docx included).

Human guide (Vietnamese): docs/guides/huong-dan-su-dung.md
EOF

python3 - "$STAGING/medkarute" "$ZIP_PATH" <<'PY'
import sys
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile

src = Path(sys.argv[1])
out = Path(sys.argv[2])
with ZipFile(out, "w", ZIP_DEFLATED) as zf:
    for path in sorted(src.rglob("*")):
        if path.is_file():
            zf.write(path, path.relative_to(src.parent))
PY

ls -lh "$ZIP_PATH"
echo "Created: $ZIP_PATH"