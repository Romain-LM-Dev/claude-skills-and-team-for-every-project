# Produit un ZIP par skill dans dist/ pour l'import dans claude.ai (Customize > Skills > Upload).
# La racine de chaque ZIP contient le dossier de la skill. Échoue si une skill est ignorée (utilisé par la CI).
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$dist = Join-Path $root 'dist'
New-Item -ItemType Directory -Force $dist | Out-Null
Get-ChildItem $dist -Filter *.zip | Remove-Item
Add-Type -AssemblyName System.IO.Compression.FileSystem
$ignored = 0

foreach ($dir in Get-ChildItem (Join-Path $root 'skills') -Directory) {
    $md = Join-Path $dir.FullName 'SKILL.md'
    if (-not (Test-Path $md)) { Write-Warning "$($dir.Name) : pas de SKILL.md, ignorée"; $ignored++; continue }
    $text = Get-Content $md -Raw -Encoding UTF8
    $name = if ($text -match '(?m)^name:\s*(.+?)\s*$') { $Matches[1] } else { '' }
    $desc = if ($text -match '(?m)^description:\s*(.+?)\s*$') { $Matches[1] } else { '' }
    # claude.ai refuse toute autre clé de frontmatter à l'import
    $front = if ($text -match '(?s)^﻿?---\r?\n(.*?)\r?\n---') { $Matches[1] } else { '' }
    if ($front -match '(?m)^disable-model-invocation:\s*true\s*$') { Write-Host "-- $($dir.Name) : Claude Code seulement, pas de ZIP"; continue }
    $badKeys = [regex]::Matches($front, '(?m)^([A-Za-z][\w-]*):') | ForEach-Object { $_.Groups[1].Value } |
        Where-Object { $_ -notin 'name', 'description', 'license', 'compatibility', 'metadata', 'allowed-tools' }
    if ($name -ne $dir.Name -or $name.Length -gt 64 -or $desc.Length -eq 0 -or $desc.Length -gt 200 -or $badKeys) {
        Write-Warning "$($dir.Name) : name différent du dossier, ou name > 64, ou description absente ou > 200 ($($desc.Length)), ou clés refusées par claude.ai ($($badKeys -join ', ')), ignorée"
        $ignored++
        continue
    }
    $zip = Join-Path $dist "$($dir.Name).zip"
    # includeBaseDirectory = $true : le ZIP contient <skill>/SKILL.md
    [IO.Compression.ZipFile]::CreateFromDirectory($dir.FullName, $zip, [IO.Compression.CompressionLevel]::Optimal, $true)
    Write-Host "OK $zip"
}
if ($ignored) { throw "$ignored skill(s) ignorée(s)" }
