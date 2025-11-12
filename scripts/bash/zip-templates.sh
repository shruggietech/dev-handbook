#!/usr/bin/env bash
# -------------------------------------------------------------
# Packages all template directories in /templates into ZIPs.
# Output saved in /dist/templates.
# -------------------------------------------------------------
set -euo pipefail

src="${1:-templates}"
out="dist/templates"

echo "Packing template zips..."
mkdir -p "$out"

for d in "$src"/*/; do
  base="$(basename "$d")"
  zip_path="$out/${base}.zip"
  echo "→ ${zip_path}"
  rm -f "$zip_path"
  (cd "$d" && zip -r "../../${zip_path}" . -x "*/.venv/*" >/dev/null)
done

echo "All templates packaged successfully."
