param($installPath, $toolsPath, $package, $project)

. (Join-Path $toolsPath 'bin_tools.ps1')

$cmd = '.bin\{%PACKAGE_NAME_LOW%}.cmd'
Set-BuildAction $cmd 'None'
Update-BinPaths $cmd
Add-BinToPath $cmd