Param(
    [string]$Name = "app"
)

New-Item -ItemType Directory -Force -Path "src/$Name","tests" | Out-Null
New-Item -ItemType File -Force -Path "src/$Name/__init__.py" | Out-Null

@"
[project]
name = "$Name"
version = "0.1.0"
description = ""
readme = "README.md"
requires-python = ">=3.12"
dependencies = []

[build-system]
requires = ["setuptools>=68", "wheel"]
build-backend = "setuptools.build_meta"
"@ | Set-Content -NoNewline pyproject.toml

@"
# $Name
"@ | Set-Content -NoNewline README.md

@"
.venv/
__pycache__/
*.py[cod]
dist/
build/
*.egg-info/
.vscode/
.idea/
"@ | Set-Content -NoNewline .gitignore

Write-Host "Scaffolded $Name"
