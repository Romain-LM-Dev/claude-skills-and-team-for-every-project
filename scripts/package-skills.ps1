# Produit un ZIP par skill dans dist/ pour l'import dans claude.ai (Customize > Skills > Upload).
# La racine de chaque ZIP contient le dossier de la skill.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$dist = Join-Path $root 'dist'
New-Item -ItemType Directory -Force $dist | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem

foreach ($dir in Get-ChildItem (Join-Path $root 'skills') -Directory) {
    $md = Join-Path $dir.FullName 'SKILL.md'
    if (-not (Test-Path $md)) { Write-Warning "$($dir.Name) : pas de SKILL.md, ignorée"; continue }
    $text = Get-Content $md -Raw -Encoding UTF8
    $name = if ($text -match '(?m)^name:\s*(.+?)\s*$') { $Matches[1] } else { '' }
    $desc = if ($text -match '(?m)^description:\s*(.+?)\s*$') { $Matches[1] } else { '' }
    if ($name -ne $dir.Name -or $name.Length -gt 64 -or $desc.Length -eq 0 -or $desc.Length -gt 200) {
        Write-Warning "$($dir.Name) : name différent du dossier, ou name > 64, ou description absente ou > 200 ($($desc.Length)), ignorée"
        continue
    }
    $zip = Join-Path $dist "$($dir.Name).zip"
    if (Test-Path $zip) { Remove-Item $zip }
    # includeBaseDirectory = $true : le ZIP contient <skill>/SKILL.md
    [IO.Compression.ZipFile]::CreateFromDirectory($dir.FullName, $zip, [IO.Compression.CompressionLevel]::Optimal, $true)
    Write-Host "OK $zip"
}
