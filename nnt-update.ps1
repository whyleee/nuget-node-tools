param([string]$pkg_name)

# make sure we are at home
cd $PSScriptRoot

# init vars
$pkg_dir = Join-Path 'packages' $pkg_name
$nuspec = Join-Path $pkg_dir "$pkg_name.nuspec"
$nuspec_xml = [xml](gc $nuspec)
$pkg_ver = $nuspec_xml.package.metadata.version
$tools_dir = 'tools'
$work_dir = 'work'

# prepare work dir
if (Test-Path $work_dir) {
  rm -r -fo $work_dir
}

# copy files
cp -r -fo $pkg_dir $work_dir
cp -r -fo $tools_dir $work_dir

# replace tokens
ls -r -file $work_dir | %{
  (gc $_.FullName) | %{
    $_ -replace '{%PACKAGE_NAME%}', $pkg_name `
       -replace '{%PACKAGE_NAME_LOW%}', $pkg_name.ToLower() `
       -replace '{%PACKAGE_VERSION%}', $pkg_ver
  } | sc $_.FullName
}

# install and clean new pkg
npm install --prefix $work_dir $pkg_name.ToLower()
$work_node_modules = Join-Path $work_dir 'node_modules'
.\npm-clean.ps1 $work_node_modules

# make a package
$work_nuspec = Join-Path $work_dir "$pkg_name.nuspec"
nuget pack $work_nuspec

# test the package and run 'nuget push $pkg' to make it public