#!/usr/bin/env bash
# Launch endnote-mcp: read xml_export_path from .local/mcp/endnote.md,
# write runtime config, set ENDNOTE_MCP_CONFIG, exec serve.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
ENDNOTE_MD="$REPO_ROOT/.local/mcp/endnote.md"
RUNTIME_CONFIG="$REPO_ROOT/.local/mcp/endnote-mcp-config.yaml"

parse_field() {
  local key="$1"
  local file="$2"
  grep -E "^${key}:" "$file" 2>/dev/null | head -1 | sed -E "s/^${key}:[[:space:]]*//" | sed 's/[[:space:]]*$//' || true
}

expand_home() {
  local p="$1"
  if [[ "$p" == ~/* ]]; then
    echo "${HOME}/${p:2}"
  elif [[ "$p" == "~" ]]; then
    echo "${HOME}"
  else
    echo "$p"
  fi
}

if [[ ! -f "$ENDNOTE_MD" ]]; then
  echo "endnote-mcp wrapper: thiếu .local/mcp/endnote.md — agent ghi xml_export_path lúc onboarding." >&2
  exit 1
fi

XML_PATH="$(parse_field xml_export_path "$ENDNOTE_MD")"
if [[ -z "$XML_PATH" ]]; then
  echo "endnote-mcp wrapper: xml_export_path trống trong .local/mcp/endnote.md — điền path file XML EndNote." >&2
  exit 1
fi

XML_PATH="$(expand_home "$XML_PATH")"
SQLITE_PATH="$(parse_field sqlite_index_path "$ENDNOTE_MD")"
PDF_DIR="$(parse_field pdf_dir "$ENDNOTE_MD")"

if [[ -z "$PDF_DIR" ]]; then
  XML_DIR="$(dirname "$XML_PATH")"
  BASE="$(basename "$XML_PATH" .xml)"
  if [[ -d "$XML_DIR/${BASE}.Data/PDF" ]]; then
    PDF_DIR="$XML_DIR/${BASE}.Data/PDF"
  else
    PDF_DIR="$XML_DIR/.Data/PDF"
  fi
fi

PDF_DIR="$(expand_home "$PDF_DIR")"
DB_PATH="${SQLITE_PATH:-$REPO_ROOT/.local/mcp/library.db}"
DB_PATH="$(expand_home "$DB_PATH")"

mkdir -p "$(dirname "$RUNTIME_CONFIG")"
cat > "$RUNTIME_CONFIG" <<EOF
endnote_xml: ${XML_PATH}
pdf_dir: ${PDF_DIR}
db_path: ${DB_PATH}
max_pdf_pages: 30
EOF

export ENDNOTE_MCP_CONFIG="$RUNTIME_CONFIG"
exec uvx endnote-mcp serve