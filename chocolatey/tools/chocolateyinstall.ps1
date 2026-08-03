$ErrorActionPreference = 'Stop'

$version = '1.46.14'
$base    = "https://dl.hoptodesk.com/releases/$version"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = "$base/HopToDesk.exe"
  checksum       = '83db68d21ad73e66b0df33b05d037fca56a8477b45771b79ade9c798df28c7ab'
  checksumType   = 'sha256'
  url64bit       = "$base/HopToDesk64.exe"
  checksum64     = '3df7ab27399b8b8b07dcb114cc5f9a862a4a36d4491e5deb77634ccc19cfca10'
  checksumType64 = 'sha256'
  softwareName   = 'HopToDesk'
  silentArgs     = '--silent-install-noshortcuts'
  validExitCodes = @(0, 3010, 1641)
}

if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64' -or $env:PROCESSOR_ARCHITEW6432 -eq 'ARM64') {
  $packageArgs.url64bit   = "$base/hoptodesk-arm64.exe"
  $packageArgs.checksum64 = '81c333e071fe1b4e8eb9c04b698dcfcb8ee4df4d52b173fcf37157a9fe95240e'
}

Install-ChocolateyPackage @packageArgs
