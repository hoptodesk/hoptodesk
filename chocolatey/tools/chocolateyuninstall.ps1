$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'HopToDesk*'
  fileType       = 'exe'
  silentArgs     = '--uninstall'
  validExitCodes = @(0, 3010, 1641)
}

[array]$keys = Get-UninstallRegistryKey @packageArgs

if ($keys.Count -eq 0) {
  Write-Host 'HopToDesk is not installed, nothing to uninstall.'
  return
}

if ($keys.Count -gt 1) {
  Write-Warning "$($keys.Count) matching installations found. Uninstall them manually:"
  $keys | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
  return
}

$packageArgs.file = ($keys[0].UninstallString -replace '(?i)\s*--uninstall\s*$', '').Trim('"')

Uninstall-ChocolateyPackage @packageArgs
