# WARN not working correctly: it's too optimistic (`npm ls` shows errors)

param([string]$pkg_dir)

$orig_dir = pwd
$pkg_dir = rvpa $pkg_dir
cd $pkg_dir

$target_pkg_name = [IO.Path]::GetFileName($pkg_dir)
$pkg_paths = npm ls -parseable | sort length -descending

foreach ($path in $pkg_paths) {
  $pkg_name = [IO.Path]::GetFileName($path)

  if ($pkg_name -eq $target_pkg_name) {
    continue
  }

  $flat_path = Join-Path "$pkg_dir\node_modules" $pkg_name
  $rel_pkg_path = $path.Replace("$pkg_dir\node_modules", "")

  if (-not (Test-Path $flat_path)) {
    mv $path $flat_path    
    echo "Flatten $rel_pkg_path"
  } else {
    echo "Skipped $rel_pkg_path"
  }
}


cd $orig_dir