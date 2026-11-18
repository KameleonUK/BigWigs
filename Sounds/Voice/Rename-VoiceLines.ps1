<#
Renames the MP3s that elevenbatch made into the file names BigWigs uses.

elevenbatch names each file after its spoken text ("Skull is vulnerable to fire." becomes
Skull_is_vulnerable_to_fire.mp3). This script reads VoiceLines-elevenbatch.csv, works out each
generated name with the same rule elevenbatch uses, and renames it to the File column
(Vuln_Skull_Fire.mp3).

Usage, from this folder:
    .\Rename-VoiceLines.ps1                    # renames MP3s in this folder
    .\Rename-VoiceLines.ps1 -Path C:\TTS\out   # renames MP3s in another folder
    .\Rename-VoiceLines.ps1 -WhatIf            # shows what would be renamed, changes nothing
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$Path = $PSScriptRoot,
    [string]$CsvFile = (Join-Path $PSScriptRoot 'VoiceLines-elevenbatch.csv')
)

# Same rule as Get-SafeFileName in elevenbatch.ps1
function Get-SafeFileName([string]$InputValue) {
    $safe = ($InputValue -replace '\s', '_') -replace '[^\p{L}\p{Nd}_-]', ''
    if ([string]::IsNullOrWhiteSpace($safe)) { return 'output' }
    if ($safe.Length -gt 60) { $safe = $safe.Substring(0, 60) }
    if ($safe -match '^(CON|PRN|AUX|NUL|COM[1-9]|LPT[1-9])$') { $safe = "_$safe" }
    return $safe
}

$rows = Import-Csv -LiteralPath $CsvFile -Delimiter ';' -Encoding UTF8
$renamed = 0; $missing = @(); $skipped = @()

foreach ($row in $rows) {
    $generated = Join-Path $Path ((Get-SafeFileName $row.Text) + '.mp3')
    $target = Join-Path $Path $row.File

    # One-word lines ("Decurse.") already come out with the right name
    if ($generated -eq $target) {
        if (-not (Test-Path -LiteralPath $target)) { $missing += $row.File }
        continue
    }
    if (-not (Test-Path -LiteralPath $generated)) {
        if (-not (Test-Path -LiteralPath $target)) { $missing += $row.File }
        continue
    }
    if (Test-Path -LiteralPath $target) {
        $skipped += $row.File
        continue
    }
    if ($PSCmdlet.ShouldProcess($generated, "Rename to $($row.File)")) {
        Rename-Item -LiteralPath $generated -NewName $row.File
        $renamed++
    }
}

Write-Host "Renamed $renamed file(s)."
if ($skipped.Count) {
    Write-Host "Kept existing $($skipped.Count) file(s) and left the new copy unrenamed: $($skipped -join ', ')"
}
if ($missing.Count -gt 10) {
    Write-Host "Not generated yet: $($missing.Count) file(s)."
} elseif ($missing.Count) {
    Write-Host "Not generated yet ($($missing.Count)): $($missing -join ', ')"
}
