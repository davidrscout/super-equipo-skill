# Instala la skill super-equipo y sus 24 agentes en ~/.claude
$ErrorActionPreference = 'Stop'
$src  = $PSScriptRoot
$dest = Join-Path $env:USERPROFILE '.claude'

$skills = Join-Path $dest 'skills'
$agents = Join-Path $dest 'agents'
foreach ($d in @($skills, $agents)) {
  if (-not (Test-Path $d)) { New-Item -ItemType Directory -Force -Path $d | Out-Null }
}

Copy-Item (Join-Path $src 'skills\super-equipo') $skills -Recurse -Force
Copy-Item (Join-Path $src 'agents\equipo-*.md')  $agents -Force

$n = (Get-ChildItem (Join-Path $agents 'equipo-*.md')).Count
Write-Host "OK  Skill instalada en $skills\super-equipo" -ForegroundColor Green
Write-Host "OK  $n agentes equipo-* instalados en $agents" -ForegroundColor Green
Write-Host "Reinicia Claude Code y comprueba con /skills y /agents."
