param (
    [string]$path = '.'
)

$ErrorActionPreference = "Stop"

$orig_path = pwd
$full_path = Resolve-Path $path

foreach ($module in ls $full_path) {
    cd $module.FullName
    npm dedupe
    cd ..
}

ls $full_path -inc README,LICENSE,LICENSE-MIT,AUTHORS,CONTRIBUTORS,CHANGELOG,*.md,*.markdown,*.html,*.txt,src,test,tst,tests,test.js,example,examples,images,benchmark,coverage,*.gemspec,*.nuspec,.travis.yml,.npmignore,.jshintrc,.editorconfig,*.sublime-project,*.sublime-workspace,Makefile,Gemfile,Gemfile.lock,Rakefile -r -fo | rm -r -fo

cd $orig_path