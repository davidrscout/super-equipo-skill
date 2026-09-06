# Instala la skill super-equipo y sus agentes en ~/.claude
#
#   .\install.ps1                          todo: 24 leads + 210 especialistas
#   .\install.ps1 -SoloLeads               solo los 24 leads
#   .\install.ps1 -Areas backend,qa        leads + especialistas de esas areas
#
# Motivo de las opciones: Claude Code carga la description de cada agente en el
# system prompt de TODAS las sesiones. 234 agentes son ~100 KB permanentes.
[CmdletBinding()]
param(
  [switch]$SoloLeads,
  [string[]]$Areas = @()
)
$ErrorActionPreference = 'Stop'

$src  = $PSScriptRoot
$dest = Join-Path $env:USERPROFILE '.claude'
$skills = Join-Path $dest 'skills'
$agents = Join-Path $dest 'agents'

foreach ($d in @($skills, $agents)) {
  if (-not (Test-Path $d)) { New-Item -ItemType Directory -Force -Path $d | Out-Null }
}

$destSkill = Join-Path $skills 'super-equipo'
if (Test-Path $destSkill) { Remove-Item $destSkill -Recurse -Force }
Copy-Item (Join-Path $src 'skills\super-equipo') $skills -Recurse -Force

$all = Get-ChildItem (Join-Path $src 'agents\equipo-*.md')

# Lista explicita de areas. No se puede deducir del nombre: "bases-de-datos" y
# "datos-ml" llevan guiones, asi que equipo-bases-de-datos.md es un LEAD aunque
# tenga varios guiones. Adivinarlo por la forma del nombre es un bug.
$ALL_AREAS = @(
  'accesibilidad','arquitecto','automatizacion','backend','bases-de-datos','datos-ml',
  'devops','diseno','documentacion','embebido','frontend','i18n','integraciones',
  'integrador','legal','movil','producto','qa','redes','rendimiento','revisor',
  'seguridad','seo','web3'
)
$leadNames = $ALL_AREAS | ForEach-Object { "equipo-$_" }

$leads = $all | Where-Object { $leadNames -contains $_.BaseName }
$esps  = $all | Where-Object { $leadNames -notcontains $_.BaseName }

$leads | ForEach-Object { Copy-Item $_.FullName $agents -Force }

$nEsp = 0
if (-not $SoloLeads) {
  $sel = $esps
  if ($Areas.Count -gt 0) {
    $sel = $esps | Where-Object {
      $name = $_.BaseName
      ($Areas | Where-Object { $name.StartsWith("equipo-$($_.Trim())-") }).Count -gt 0
    }
  }
  $sel | ForEach-Object { Copy-Item $_.FullName $agents -Force }
  $nEsp = @($sel).Count
}

Write-Host "OK  Skill instalada en $destSkill" -ForegroundColor Green
Write-Host "OK  $(@($leads).Count) leads y $nEsp especialistas instalados en $agents" -ForegroundColor Green
if ($SoloLeads)      { Write-Host "    (instalacion parcial: solo leads)" -ForegroundColor Yellow }
elseif ($Areas.Count){ Write-Host "    (instalacion parcial: areas $($Areas -join ', '))" -ForegroundColor Yellow }
Write-Host "Reinicia Claude Code y comprueba con /skills y /agents."
