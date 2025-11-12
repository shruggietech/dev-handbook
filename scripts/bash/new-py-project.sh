#!/usr/bin/env bash

set -euo pipefail
name="${1:-app}"
mkdir -p "src/$name" tests
: > "src/$name/__init__.py"

cat > pyproject.toml <<EOF
[project]
name = "$name"
version = "0.1.0"
description = ""
readme = "README.md"
requires-python = ">=3.12"
dependencies = []

[build-system]
requires = ["setuptools>=68", "wheel"]
build-backend = "setuptools.build_meta"
EOF
echo "# $name" > README.md
cat > .gitignore <<'EOF'
.venv/
__pycache__/
*.py[cod]
dist/
build/
*.egg-info/
.vscode/
.idea/
EOF

echo "Scaffolded $name"
