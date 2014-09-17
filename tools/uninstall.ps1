param($installPath, $toolsPath, $package, $project)

. (Join-Path $toolsPath 'bin_tools.ps1')

$cmd = '.bin\{%PACKAGE_NAME_LOW%}.cmd'
Delete-Bin $cmd