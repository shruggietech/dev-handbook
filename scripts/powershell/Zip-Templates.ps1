<#
.SYNOPSIS
    Packages all template folders in /templates into ZIP archives.

.DESCRIPTION
    Iterates over each directory in /templates (excluding .keep files),
    compresses its contents, and saves ZIPs into /dist/templates.
#>

param (
    [string]$Source = "templates",
    [string]$OutDir = "dist/templates"
)

Write-Host "Packing template zips..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

Get-ChildItem $Source -Directory | ForEach-Object {
    $base = $_.Name
    $zip  = Join-Path $OutDir "$base.zip"

    if (Test-Path $zip) { Remove-Item $zip -Force }

    Compress-Archive -Path "$($_.FullName)\*" -DestinationPath $zip
    Write-Host "✔ Packed $zip"
}

Write-Host "All templates packaged successfully." -ForegroundColor Green
